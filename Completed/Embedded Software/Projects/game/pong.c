/*
 * pong.c
 *
 *  Created on: Mar 22, 2019
 *      Author: Tim hollabaugh
 */
////////////////////////////MMmmbbbb

#include "project_settings.h"
#include "random_int.h"
#include "stddef.h"
#include "strings.h"
#include "game.h"
#include "timing.h"
#include "task.h"
#include "terminal.h"
#include "random_int.h"

#define MAP_WIDTH 100
#define MAP_HEIGHT 29
#define PADDLE_HEIGHT 3
#define PADDLE_OFFSET 2
#define PADDLE_CHAR '|'
#define PADDLE_DY 1
#define BALL_CHAR '+'
#define BALL_START_DX 1
#define BALL_START_DY 1
#define DOWN_CHAR 'j'
#define UP_CHAR 'k'
// times in ms

/// game structure
struct pong_t {
    int8_t left_paddle_pos;
    int8_t right_paddle_pos;
    int8_t ball_x;
    int8_t ball_y;
    int8_t ball_dx;
    int8_t ball_dy;
    uint8_t id; ///< ID of game=
};

static struct pong_t pong;

// note the user doesn't need to access these functions directly so they are
// defined here instead of in the .h file
// further they are made static so that no other files can access them
// ALSO OTHER MODULES CAN USE THESE SAME NAMES SINCE THEY ARE STATIC
static void Callback(int argc, char * argv[]);
static void Receiver(uint8_t c);

static void Play(void);
static void Help(void);

static void MoveBall(void);
static void MoveLeftPaddle(int8_t dy);
static void MoveRightPaddle();

void Pong_Init(void) {
    // Register the module with the game system and give it the name "MUH3"
    pong.id = Game_Register("Pong", "The classic pong", Play, Help);
    // Register a callback with the game system.
    // this is only needed if your game supports more than "play", "help" and "highscores"
    Game_RegisterCallback(pong.id, Callback);
}

void Help(void) {
    Game_Printf("%c and %c to move your paddle up and down\r\n", UP_CHAR, DOWN_CHAR);
}

void Callback(int argc, char * argv[]) {
    // "play" and "help" are called automatically so just process "reset" here
    if(argc == 0) Game_Log(pong.id, "too few args");
    if(strcasecmp(argv[0],"reset") == 0) {
        Game_Log(pong.id, "Scores reset");
    }else Game_Log(pong.id, "command not supported");
}

void Play(void) {
    volatile uint8_t i;
    // clear the screen
    Game_ClearScreen();

    pong.left_paddle_pos = MAP_HEIGHT/2 - PADDLE_HEIGHT/2;
    pong.right_paddle_pos = MAP_HEIGHT/2 - PADDLE_HEIGHT/2;

    pong.ball_x = MAP_WIDTH/2;
    pong.ball_y = MAP_HEIGHT/2;
    pong.ball_dx = BALL_START_DX;
    pong.ball_dy = BALL_START_DY;

    Game_CharXY(BALL_CHAR, pong.ball_x, pong.ball_y);

    Game_FillRect(
        PADDLE_CHAR,
        PADDLE_OFFSET,
        pong.left_paddle_pos,
        PADDLE_OFFSET,
        pong.left_paddle_pos+PADDLE_HEIGHT
    );

    Game_FillRect(
        PADDLE_CHAR,
        MAP_WIDTH-PADDLE_OFFSET,
        pong.right_paddle_pos,
        MAP_WIDTH-PADDLE_OFFSET,
        pong.right_paddle_pos+PADDLE_HEIGHT
    );

    // initialize game variables
    //for(i = 0; i < MUH_MAX_SHOTS; i++) shots[i].status = 0;
    //for(i = 0; i < MUH_MAX_ENEMIES; i++) enemies[i].status = 0;
    //game.x = MAP_WIDTH / 2;
    //game.c = '^';
    //game.score = 0;
    //game.shots_fired = 0;
    // draw the "gun" at the bottom center of the map
    //Game_CharXY(game.c, game.x, MAP_HEIGHT - 1);
    Game_RegisterPlayer1Receiver(Receiver);
    // hide cursor
    Game_HideCursor();
    // send first enemy in 10 seconds
    // period is 0 because the task is rescheduled new each time at random intervals
    Task_Schedule(MoveBall, 0, 100, 100);
    Task_Schedule(MoveRightPaddle, 0, 100, 100);
}

void Receiver(uint8_t c) {
    switch (c) {
        case UP_CHAR:
            MoveLeftPaddle(-PADDLE_DY);
            break;
        case DOWN_CHAR:
            MoveLeftPaddle(PADDLE_DY);
            break;
        case '\r':
            //GameOver();
            break;
        default:
            break;
    }
}

void MoveLeftPaddle(int8_t dy) {
    if (
        dy != 0 &&
        pong.left_paddle_pos + dy >= 0 &&
        pong.left_paddle_pos + dy <= MAP_HEIGHT - PADDLE_HEIGHT
    ) {
        Game_FillRect(
            ' ',
            PADDLE_OFFSET,
            pong.left_paddle_pos,
            PADDLE_OFFSET,
            pong.left_paddle_pos+PADDLE_HEIGHT
        );

        pong.left_paddle_pos += dy;

        Game_FillRect(
            PADDLE_CHAR,
            PADDLE_OFFSET,
            pong.left_paddle_pos,
            PADDLE_OFFSET,
            pong.left_paddle_pos+PADDLE_HEIGHT
        );
    }
}

void MoveBall(void) {
    if (
        (pong.ball_y <= 0 && pong.ball_dy < 0) ||
        (pong.ball_y >= MAP_HEIGHT-1 && pong.ball_dy > 0)
    ) {
        pong.ball_dy = -pong.ball_dy;
    }

    if (pong.ball_x <= PADDLE_OFFSET+1 && pong.ball_dx < 0) {
        if (pong.ball_y >= pong.left_paddle_pos && pong.ball_y <= pong.left_paddle_pos + PADDLE_HEIGHT) {
            pong.ball_dx = - pong.ball_dx;
        } else {
            GameOver();
        }
    }

    if (pong.ball_x >= MAP_WIDTH - PADDLE_OFFSET && pong.ball_dx > 0) {
        if (pong.ball_y >= pong.right_paddle_pos && pong.ball_y <= pong.right_paddle_pos + PADDLE_HEIGHT) {
            pong.ball_dx = - pong.ball_dx;
        } else {
            pong.ball_x = MAP_WIDTH/2;
            pong.ball_y = MAP_HEIGHT/2;
            pong.ball_dx = BALL_START_DX;
            pong.ball_dy = BALL_START_DY;
        }
    }

    Game_CharXY(' ', pong.ball_x, pong.ball_y);
    pong.ball_x += pong.ball_dx;
    pong.ball_y += pong.ball_dy;
    Game_CharXY(BALL_CHAR, pong.ball_x, pong.ball_y);
}

void MoveRightPaddle(void) {
    int8_t dy = 0;

    if (pong.ball_x > MAP_WIDTH/2 && pong.ball_dx > 0) {
        if (pong.ball_y > pong.right_paddle_pos + PADDLE_HEIGHT) {
            dy = PADDLE_DY;
        }

        if (pong.ball_y < pong.right_paddle_pos) {
            dy = -PADDLE_DY;
        }
    }

    if (
        dy != 0 &&
        pong.right_paddle_pos + dy >= 0 &&
        pong.right_paddle_pos + dy <= MAP_HEIGHT - PADDLE_HEIGHT
    ) {
        Game_FillRect(
            ' ',
            MAP_WIDTH - PADDLE_OFFSET,
            pong.right_paddle_pos,
            MAP_WIDTH - PADDLE_OFFSET,
            pong.right_paddle_pos+PADDLE_HEIGHT
        );

        pong.right_paddle_pos += dy;

        Game_FillRect(
            PADDLE_CHAR,
            MAP_WIDTH - PADDLE_OFFSET,
            pong.right_paddle_pos,
            MAP_WIDTH - PADDLE_OFFSET,
            pong.right_paddle_pos+PADDLE_HEIGHT
        );
    }
}

void GameOver(void) {
    Task_Remove(MoveBall, 0);
    // set cursor below bottom of map
    Game_CharXY('\r', 0, MAP_HEIGHT + 1);
    // show score
    Game_Printf("Game Over!");
    // unregister the receiver used to run the game
    Game_UnregisterPlayer1Receiver(Receiver);
    // show cursor (it was hidden at the beginning
    Game_ShowCursor();
    Game_GameOver();
}

/*
void Fire(void) {
    static uint32_t last_fired;
    volatile uint8_t i;
    // pointer to bullet to use
    char_object_t * shot = 0;
    // make sure a shot was not just fired
    if (TimeSince(last_fired) <= FIRE_SPEED) return;

    // find and unused bullet
    for(i = 0; i < MUH_MAX_SHOTS; i++) if(shots[i].status == 0) shot = &shots[i];
    if(shot) {
        // schedule MoveUpShot1 to run every FIRE_SPEED ms, this is what makes the '^' move
        Task_Schedule((task_t)MoveUpShot, shot, FIRE_SPEED, FIRE_SPEED);
    }else { // if no shots are left
        // indicate out of ammo by changing the pointer
        if (game.c == '^') {
            game.c = 'o';
            Game_CharXY(game.c, game.x, MAP_HEIGHT - 1);
        }
        return;
    }
    // change the status of the shot to indicate that it is used
    shot->status = 1;
    // start the shot at the bottom just above the gun
    shot->y = MAP_HEIGHT - 2;
    shot->x = game.x;
    shot->c = '^';
    Game_CharXY('^', game.x, MAP_HEIGHT - 2);
    // track the time the last shot was fired so you can't have two on top of each other
    last_fired = TimeNow();
    game.shots_fired++;
}

void SendEnemy(void) {
    char x;
    volatile uint8_t i;
    char_object_t * enemy = 0;
    uint16_t down_period, right_period;
    // get random starting x location
    x = random_int(1, MAP_WIDTH / 2);
    // get random time for moving down
    down_period = random_int(MIN_ENEMY_TIME, MAX_ENEMY_TIME);
    // get random time for moving right such that we don't go out of bounds
    // min value is t*(MAP_HEIGHT-1) / (MAP_WIDTH - 1 - x)
    right_period = down_period * (MAP_HEIGHT - 1) / (MAP_WIDTH - 1 - x);
    // get value between the min and 4x min
    right_period = random_int(right_period, right_period * 4);
    // find unused enemy object
    for(i = 0; i < MUH_MAX_ENEMIES; i++) if(enemies[i].status == 0) enemy = &enemies[i];
    if(enemy) {
        enemy->status = 1;
        enemy->x = x;
        enemy->c = 'x';
        enemy->y = 1;
        // use the task scheduler to move the char down and right at the calculated
        // period
        Task_Schedule((task_t)MoveDownEnemy, enemy, down_period, down_period);
        Task_Schedule((task_t)MoveRightEnemy, enemy, right_period, right_period);
        Game_CharXY('x', x, 1);
    }
    // schedule next enemy to come between min and max enemy rate
    // since a random time is desired the period is 0 so the task will be done when it us run
    // and a new task will be created at a different random time
    Task_Schedule(SendEnemy, 0, random_int(MIN_ENEMY_RATE, MAX_ENEMY_RATE), 0);
}

void MoveRight(void) {
    // make sure we can move right
    if (game.x < MAP_WIDTH - 1) {
        // clear location
        Game_CharXY(' ', game.x, MAP_HEIGHT - 1);
        game.x++;
        // update
        Game_CharXY(game.c, game.x, MAP_HEIGHT - 1);
    }
}

void MoveLeft(void) {
    // make sure we can move right
    if (game.x > 1) {
        // clear location
        Game_CharXY(' ', game.x, MAP_HEIGHT - 1);
        game.x--;
        // update
        Game_CharXY(game.c, game.x, MAP_HEIGHT - 1);
    }
}

void MoveDownEnemy(char_object_t * o) {
    // first make sure we can move down
    if (o->y < MAP_HEIGHT - 1) {
        // clear location
        Game_CharXY(' ', o->x, o->y);
        // update y position
        o->y++;
        // re-print
        Game_CharXY(o->c, o->x, o->y);
        CheckCollisionEnemy(o);
    } else {
        GameOver();
    }
}

void MoveRightEnemy(char_object_t * o) {
    // first make sure we can move right
    if (o->x < MAP_WIDTH - 1) {
        // clear location
        Game_CharXY(' ', o->x, o->y);
        // update x position
        o->x++;
        // re-print
        Game_CharXY(o->c, o->x, o->y);
        CheckCollisionEnemy(o);
    } else {
        GameOver();
    }
}

void MoveUpShot(char_object_t * o) {
    // first make sure we can move up
    if (o->y > 1) {
        // clear location
        Game_CharXY(' ', o->x, o->y);
        // update y position
        o->y--;
        // re-print
        Game_CharXY(o->c, o->x, o->y);
        CheckCollisionShot(o);
    } else {
        // clear the shot
        Game_CharXY(' ', o->x, o->y);
        DeleteShot(o);
    }
}

void CheckCollisionEnemy(char_object_t * enemy) {
    volatile uint8_t i;
    char_object_t * shot;
    for(i = 0; i < MUH_MAX_SHOTS; i++) {
        shot = &shots[i];
        if(shot->status) {
            if (enemy->x == shot->x && enemy->y == shot->y) {
                DeleteEnemy(enemy);
                DeleteShot(shot);
                // put a * where the collision happened
                Game_CharXY('*', enemy->x, enemy->y);
                ScorePoint();
            }
        }
    }
}

void CheckCollisionShot(char_object_t * shot) {
    volatile uint8_t i;
    char_object_t * enemy;
    for(i = 0; i < MUH_MAX_ENEMIES; i++) {
        enemy = &enemies[i];
        if(enemy->status) {
            if (enemy->x == shot->x && enemy->y == shot->y) {
                DeleteEnemy(enemy);
                DeleteShot(shot);
                // put a * where the collision happened
                Game_CharXY('*', enemy->x, enemy->y);
                ScorePoint();
            }
        }
    }
}

void ScorePoint(void) {
    game.score++;
    // sound the alarm
    Game_Bell();
}

// if o is 0 then delete all enemies
void DeleteEnemy(char_object_t * o) {
    // set status to 0
    if(o) o->status = 0;
    // remove the tasks used to move the enemy
    Task_Remove((task_t)MoveDownEnemy, o);
    Task_Remove((task_t)MoveRightEnemy, o);
}

// if o is 0 then delete all shots
void DeleteShot(char_object_t * o) {
    // set status to 0
    if(o) o->status = 0;
    // remove the tasks used to move the shot
    Task_Remove((task_t)MoveUpShot, o);

    // if there were no shots left then change the pointer back to ^
    if (game.c != '^') {
        game.c = '^';
        Game_CharXY(game.c, game.x, MAP_HEIGHT - 1);
    }
}

void GameOver(void) {
    // clean up all scheduled tasks
    DeleteShot(0);
    DeleteEnemy(0);
    Task_Remove(SendEnemy, 0);
    // if a controller was used then remove the callbacks
#ifdef USE_MODULE_GAME_CONTROLLER
    GameControllerHost_RemoveCallback(A_ButtonPressed, 0);
    GameControllerHost_RemoveCallback(RightPressed, 0);
    GameControllerHost_RemoveCallback(LeftPressed, 0);
#endif
    // set cursor below bottom of map
    Game_CharXY('\r', 0, MAP_HEIGHT + 1);
    // show score
    Game_Printf("Game Over! Final score: %d\r\nTotal shots fired: %d", game.score, game.shots_fired);
    // unregister the receiver used to run the game
    Game_UnregisterPlayer1Receiver(Receiver);
    // show cursor (it was hidden at the beginning
    Game_ShowCursor();
    Game_GameOver();
}
*/

int *screen;
int *key_w;
int *key_a;
int *key_s;
int *key_d;

int *snake_x;
int *snake_y;

int main() {
    int length;
    int dir;       
    int next_dir;  
    int apple_x;
    int apple_y;
    int game_over;
    int i;
    int head_x;
    int head_y;
    int tail_x;
    int tail_y;
    int pos;
    int delay_counter;
    int input_locked;
    int ate_apple;

    /* Initialize Pointers */
    screen  = (int *)15000;
    key_w   = (int *)16024;
    key_w   = (int *)16024;
    key_a   = (int *)16025;
    key_s   = (int *)16026;
    key_d   = (int *)16027;
    
    snake_x = (int *)10000;
    snake_y = (int *)11000;

    /* Clear screen */
    for (i = 0; i < 1024; i = i + 1) {
        screen[i] = 0;
    }

    /* Set up initial snake */
    length = 3;
    snake_x[0] = 15; snake_y[0] = 15; 
    snake_x[1] = 14; snake_y[1] = 15; 
    snake_x[2] = 13; snake_y[2] = 15; 

    dir = 1;      
    next_dir = 1; 

    /* Draw the initial snake */
    for (i = 0; i < length; i = i + 1) {
        pos = snake_y[i] * 32 + snake_x[i];
        screen[pos] = 1;
    }

    /* Initial apple position */
    apple_x = 22;
    apple_y = 15;
    pos = apple_y * 32 + apple_x;
    screen[pos] = 1;

    game_over = 0;

    /* --- MAIN GAME LOOP --- */
    while (game_over == 0) {
        
        input_locked = 0; 
        for (delay_counter = 0; delay_counter < 150; delay_counter = delay_counter + 1) {
            
            /* HARDWARE FIX: Process key, then immediately write '1' to clear it! */
            if (*key_d == 0) { 
                if (input_locked == 0) { if (dir != 3) { next_dir = 1; input_locked = 1; } }
                *key_d = 1; /* Acknowledge and clear */
            }
            if (*key_s == 0) { 
                if (input_locked == 0) { if (dir != 0) { next_dir = 2; input_locked = 1; } }
                *key_s = 1; /* Acknowledge and clear */
            }
            if (*key_a == 0) { 
                if (input_locked == 0) { if (dir != 1) { next_dir = 3; input_locked = 1; } }
                *key_a = 1; /* Acknowledge and clear */
            }
            if (*key_w == 0) { 
                if (input_locked == 0) { if (dir != 2) { next_dir = 0; input_locked = 1; } }
                *key_w = 1; /* Acknowledge and clear */
            }
        }
        dir = next_dir;

        /* Save tail position */
        tail_x = snake_x[length - 1];
        tail_y = snake_y[length - 1];

        /* Shift body down the array */
        for (i = length - 1; i > 0; i = i - 1) {
            snake_x[i] = snake_x[i - 1];
            snake_y[i] = snake_y[i - 1];
        }

        /* Calculate new head */
        head_x = snake_x[0];
        head_y = snake_y[0];

        if (dir == 0) head_y = head_y - 1;
        if (dir == 1) head_x = head_x + 1;
        if (dir == 2) head_y = head_y + 1;
        if (dir == 3) head_x = head_x - 1;

        snake_x[0] = head_x;
        snake_y[0] = head_y;

        /* Check Wall Collisions */
        if (head_x < 0)  game_over = 1;
        if (head_x > 31) game_over = 1;
        if (head_y < 0)  game_over = 1;
        if (head_y > 31) game_over = 1;

        /* Check Self Collisions */
        for (i = 1; i < length; i = i + 1) {
            if (head_x == snake_x[i]) {
                if (head_y == snake_y[i]) {
                    game_over = 1;
                }
            }
        }

        if (game_over == 1) {
            break; 
        }

        /* Check Apple Collision & Growth */
        ate_apple = 0;
        if (head_x == apple_x) {
            if (head_y == apple_y) {
                ate_apple = 1;
                length = length + 1;
                
                snake_x[length - 1] = tail_x;
                snake_y[length - 1] = tail_y;

                apple_x = apple_x + 11;
                while (apple_x >= 32) { apple_x = apple_x - 32; }

                apple_y = apple_y + 7;
                while (apple_y >= 32) { apple_y = apple_y - 32; }
                
                pos = apple_y * 32 + apple_x;
                screen[pos] = 1;
            }
        }

        /* Update Graphics */
        if (ate_apple == 0) {
            pos = tail_y * 32 + tail_x;
            screen[pos] = 0;
        }

        pos = head_y * 32 + head_x;
        screen[pos] = 1;
    }

    /* GAME OVER - Fill screen */
    for (i = 0; i < 1024; i = i + 1) {
        screen[i] = 1;
    }

    while (1) { }

    return 0;
}

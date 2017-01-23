from collections import defaultdict
import math

import numpy as np
import gym


class QLearner:

    def __init__(self, env):
        self.env = env
        self.epsilon = 0
        self.Q = {}
        self.gamma = 0.95
        self.max_episodes = 5000
        self.max_step = 1000

    def encode_state(self, state):
        """
        Converts raw continuous state into one of discreate states (see https://webdocs.cs.ualberta.ca/~sutton/book/code/pole.c)

        Args:
            state (list): A raw state, i.e. list of x, x_dot, theta and theta_dot.

        Returns:
            box (int): A discrete state.
        """
        x, x_dot, theta, theta_dot = state
        env = self.env
        x_limit, theta_limit = env.x_threshold, env.theta_threshold_radians

        half_theta_limit = theta_limit/2
        one_twelveth_theta_limit = theta_limit/12
        cart_in_limits = -x_limit < x < x_limit
        pole_in_limits = -theta_limit < theta < theta_limit

        if not cart_in_limits or not pole_in_limits:
            return 0

        box = (1 if x < -0.8 else
               2 if x < 0.8 else
               3)

        if x_dot < -0.5:
            pass
        elif x_dot < 0.5:
            box += 3
        else:
            box += 6

        if theta < -half_theta_limit:
            pass
        elif theta < -one_twelveth_theta_limit:
            box += 9
        elif theta < 0:
            box += 18
        elif theta < one_twelveth_theta_limit:
            box += 27
        elif theta < half_theta_limit:
            box += 36
        else:
            box += 45

        if theta_dot < -FIFTY_DEGREES_IN_RADIANS:
            pass
        elif theta_dot < FIFTY_DEGREES_IN_RADIANS:
            box += 54
        else:
            box += 108

        return box

    def epsilon_greedy(state, q_values, eps):
        a = np.argmax(q_values[state, :])
        if np.random.rand() < eps:
            a = np.random.randint(q_values.shape[1])
        return a

    def learn(self):


def main():
    env = gym.make('CartPole-v0')
    #learner = QLearner(env)
    print(env.action_space.n)

if __name__ == "__main__":
    main()

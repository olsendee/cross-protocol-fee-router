# Cross-Protocol Fee Router

A Clarity smart contract for the Stacks blockchain that enables splitting and distributing incoming fees across multiple recipients based on weighted ratios.

## Overview

This contract provides a flexible fee distribution mechanism where:
- **Admin** (contract deployer) manages recipient registration
- **Recipients** are assigned weight ratios for proportional fee splits
- **Distribution** logic routes STX fees according to configured weights

## Features

- ✅ Add/update fee recipients with custom weight allocations
- ✅ Remove recipients from distribution
- ✅ Query recipient weights and list all recipients
- ✅ Admin-controlled access with authorization checks
- ⚠️ Fee distribution logic (in progress)

## Project Structure

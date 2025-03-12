# Birdwood Database Schema

## Overview

This repository contains the Birdwood Database Migration Scripts

## Known Issues

  - Given the time constraints and other challenges, the Birdwood database setup is somewhat basic. Ideally, we should use an ORM to make it easier for developers to update schemas, perform rollbacks, and manage changes more efficiently

  - Upon reviewing, we found that the API keys were added to the fixtures. This isn't ideal and should be refactored to use environment variables instead

## 🔍 Pending Decision

  - This has been running well in the `Development` environment, but it hasn't been deployed to `Production` due to time constraints and other challenges. Please check with Assem for further guidance.
    

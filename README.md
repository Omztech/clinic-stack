# Clinic AI Front Desk

An AI front desk for clinics and appointment based businesses in Nigeria. It answers customer enquiries on the clinic's website any time of the day, saves every lead in a database and alerts the staff on Telegram within about a minute, so no customer is left waiting or forgotten.

## The problem it solves

Many clinics lose customers because messages come in at night, on weekends or when the front desk is busy. By the time someone replies, the customer has already gone to another clinic. This system replies in seconds and makes sure the staff know about every new enquiry.

## How it works

1. A customer opens the clinic website and chats with the AI front desk.
2. The AI answers questions using only the clinic's own information (treatments, prices, opening hours). It does not make up answers.
3. When the customer is ready, the AI collects their name, phone number, the treatment they want and their preferred time, and saves it in the database.
4. Medical questions are not answered by the AI. They are marked for a staff member to handle.
5. Every minute, a second workflow checks for new leads and sends the staff a Telegram alert with the customer's details.
6. Each lead is alerted only once, so the staff never get the same alert twice.

## Tools used

| Part | Tool |
|---|---|
| Automation | n8n (self hosted) |
| AI model | Google Gemini |
| Database | PostgreSQL 16 |
| Running everything | Docker Compose on Ubuntu (WSL) |
| Staff alerts | Telegram Bot API |
| Public access | Cloudflare Tunnel |
| Demo website | Netlify |

## Files in this repo

| File | What it is |
|---|---|
| `docker-compose.yml` | Starts n8n and PostgreSQL together |
| `ai-front-desk.json` | The n8n workflow for the AI chat |
| `staff-alert.json` | The n8n workflow that sends Telegram alerts |
| `index.html` | The demo clinic website with the chat bubble |
| `notes.md` | My learning notes |

Passwords and keys are kept in a `.env` file that is never uploaded to GitHub.

## Leads table

| Column | Meaning |
|---|---|
| name, phone | Customer details |
| treatment, preferred_time | What they want and when |
| channel | Where the enquiry came from |
| status | new, or handoff when a staff member must reply |
| alerted | Whether the staff have been notified |
| followed_up | Whether the staff have called the customer |

## What is next

1. Stricter AI rules, so it only saves treatments the clinic actually offers.
2. Move from my laptop to a small cloud server, so it runs all day without my computer.
3. A WhatsApp channel, since that is where most Nigerian customers are.

## Built by

Thompson Nduke Dominic, Duke and Demand Studios
[dukeanddemandstudios.com](https://dukeanddemandstudios.com)

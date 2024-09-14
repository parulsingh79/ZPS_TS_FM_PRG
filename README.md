# ZPS_TS_FM_PRG

## **Recently I got the requirement to create  a text in SO10 and create a FM and then pass values in it dynamically.**
## Standard FMs used inside**
* READ_TEXT
* SET_TEXTSYMBOL_PROGRAM
* REPLACE_TEXTSYMBOL

## Text I have created in SO10 is 
* Dear &Z_NAME&, You have a missed call from &Z_PHN&. The last missed call
* was at &Z_TIME& on &Z_DATE& .
* Thankyou, Team Jio.

## Debugging Screenshot-
 * READ TEXT - Got the required text in Internal table
 * <img width="668" alt="image" src="https://github.com/user-attachments/assets/f8a5df65-8ca4-48d3-b8bc-d3569b671348">

 * Here we are checking how many text symbola are found by using counter variable as **lt_count** and to replace it in **lt_text_replace**.

    The SEARCH statement looks through the **lt_text table** to find the string **lv_concat**. If found, it sets a **mark (sy-subrc = 0)**.

   The below line performs the actual replacement of the placeholder in the lt_text_replace table. RESPECTING CASE ensures that the replacement is case-sensitive.

**REPLACE ALL OCCURRENCES OF lv_concat
     IN TABLE lt_text_replace[] WITH ' '
     RESPECTING CASE.**
   
   
   ![image](https://github.com/user-attachments/assets/0b863e33-7cc6-4204-ac4e-e29ee7b883c3)

   <img width="730" alt="image" src="https://github.com/user-attachments/assets/3c442ffe-929b-4263-af5a-6e54d0e12826">


* **SET_TEXTSYMBOL_PROGRAM** - Prepares the program specified by prog_name to handle text symbols during form processing. The event parameter specifies the event (in this case, 'OPEN_fORM') during which the text symbols should be processed.
<img width="859" alt="image" src="https://github.com/user-attachments/assets/27760b6f-2258-4f55-ad69-f40e49290467">



* **REPLACE_TEXTSYMBOL** - Perform the actual replacement of text symbols in the specified text.
 ![image](https://github.com/user-attachments/assets/13fef723-14c5-473a-8de2-ef7129b05c58)
 <img width="735" alt="image" src="https://github.com/user-attachments/assets/9d19b0ee-9c26-4fd2-90c4-5e4b07f531fa">


## **Here's the final Output**
* 
* <img width="587" alt="image" src="https://github.com/user-attachments/assets/6294c428-0836-4c0b-9bf9-fff7fb1e42bb">





  

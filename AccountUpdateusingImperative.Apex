public with sharing class AccountUpdateusingImperative {
    @AuraEnabled
    public static String AccountMeth(String name,String Phone){
       try{
            Account acc=[SELECT id,Name,Phone FROM Account WHERE Name =:name LIMIT 1];
            if(acc.Name!=null && acc.Phone!=null){
                acc.Phone=Phone;
                acc.Name=Name;
                update acc;
            }
            
            return 'Account Phone Updated';
        }
       catch(Exception ex){
           return 'Error While Updating';
       }        
    }
}
HTML Code:-
<template>
    <lightning-layout>
        <lightning-layout-item size="4">

        </lightning-layout-item>
        <lightning-layout-item size="4">
          <lightning-layout multiple-rows>
            <lightning-layout-item size="12">
               <lightning-input placeholder="Name" onchange={handleName}></lightning-input>
            </lightning-layout-item>
            <lightning-layout-item size="12">
                <lightning-input placeholder="Phone" onchange={handlePhone}></lightning-input>
            </lightning-layout-item>
             <lightning-layout-item class="slds-p-top_medium">
               <lightning-button label="Update Button" onclick={handleSubmit}></lightning-button>
            </lightning-layout-item>
            </lightning-layout>
        </lightning-layout-item>
        <lightning-layout-item size="4">

        </lightning-layout-item>
    </lightning-layout>
</template>

JS Code:-
import { LightningElement} from 'lwc';
import updateAccount from '@salesforce/apex/AccountUpdateusingImperative.AccountMeth';
export default class AccountImperativeUpdateCode extends LightningElement {
     name;
     Phone;
     resposne;
     error;
     handleName(event){
      this.name=event.target.value;
    }

    handlePhone(event){
        this.Phone=event.target.value;
    }

    handleSubmit(){
        updateAccount({name:this.name,Phone:this.Phone})
        .then(response=>{
            this.result=response;
            this.error=undefined;
        })
        .catch(error=>{
            this.result=undefined;
            this.error=error;
        })
    }
}

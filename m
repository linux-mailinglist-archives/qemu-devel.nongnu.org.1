Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D6C7D4B84
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 11:07:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvDMD-0002IG-OX; Tue, 24 Oct 2023 05:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qvDM8-0002Hl-AO
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 05:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qvDM2-00017E-Iy
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 05:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698138334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=O6Zrdup/OCoJHMLCuVPdazCxckOU76RlkrVV61xOkbA=;
 b=Gx28Z0cVlM5/aeqwtr/Bz9UEwX52dPeKaamyJiYqnjq3dg72e16c81nbgczB+65a1auuiA
 THlLV1RLLXTRSaF4dBNSY3ICgAuuA4xnsmElXWEiHcmyCYuQ8/0IJYZ4RenNsyfugd2JDn
 bsobCLj11f69mGwC+vimXgxb6pW9ttI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-8mFbFzByNCKenGeCZ1bbDw-1; Tue, 24 Oct 2023 05:05:17 -0400
X-MC-Unique: 8mFbFzByNCKenGeCZ1bbDw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66d03b02d16so96718026d6.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 02:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698138316; x=1698743116;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O6Zrdup/OCoJHMLCuVPdazCxckOU76RlkrVV61xOkbA=;
 b=wMEOk5+6FF3jnBppF59tbav9YDOkL0YlIQjmLuhM0/uKN1UPO7a6X3Sr2kyXyXMBxZ
 dN62DK5tjlHacEYScfMsTsjH8VF2hv+gjGoAsRZ0/YQCt6nDpIREZKXF/l7FB5eyxzez
 QTmczYksV/J9wTM7FZZPdPrSPxIx2pPiGGPcU1ESgBvysAjgMHRCItAn/6OpgicCKxXQ
 Jk5WKx6fHEdQathFAzn+KPh31+g1Kx9usdytbKBWBNESAWpRfVd+ZDyyLCoP0qngT3y4
 3iXUVlBKF504CWbKTfonTu7Febcg2pQU1EvJ9zFm5NtX5prUpfdBwiPCuhyu2Ur9HpB6
 IWLw==
X-Gm-Message-State: AOJu0Yw5kyxTBKaJlJWfmx7IiVdesnMELE1WOhodPmj85Unq3Xmlq3E6
 XJN64ac9jfJVIVjkL5pf0qH7VIxKXV7fkwjjLgI80mKdxrkF+rM2Pj7xCl8I/N49w7HPY+H0gX7
 fLZNfLeuLQg5QQ8w=
X-Received: by 2002:ad4:5966:0:b0:66d:593f:9a4c with SMTP id
 eq6-20020ad45966000000b0066d593f9a4cmr17392899qvb.2.1698138316660; 
 Tue, 24 Oct 2023 02:05:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/hwGMyklBf1EboeZOahN9JSai8b8J4SaQ5vpAgRCrykT9tLIrTflSWkZjZgrS3q+yK5Yk4g==
X-Received: by 2002:ad4:5966:0:b0:66d:593f:9a4c with SMTP id
 eq6-20020ad45966000000b0066d593f9a4cmr17392884qvb.2.1698138316407; 
 Tue, 24 Oct 2023 02:05:16 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 l15-20020ad4452f000000b0066cf2423c79sm3505212qvu.139.2023.10.24.02.05.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 02:05:16 -0700 (PDT)
Message-ID: <d41c8909-25e7-40a6-8dcc-2c0094a56f13@redhat.com>
Date: Tue, 24 Oct 2023 11:05:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ram_save_complete() is fishy
To: Peter Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>
References: <20231023145044.104866-1-thuth@redhat.com> <ZTaX00kf3UcQG/AF@x1n>
 <a326eafb-955b-4867-94f5-052672f93138@redhat.com>
 <75a76824-9b8e-45d3-a2ae-718295223715@redhat.com> <ZTbBuhMOUCwCs8Km@x1n>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZTbBuhMOUCwCs8Km@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 23/10/2023 20.55, Peter Xu wrote:
> On Mon, Oct 23, 2023 at 07:30:04PM +0200, Thomas Huth wrote:
>> On 23/10/2023 19.11, Thomas Huth wrote:
>>> On 23/10/2023 17.57, Peter Xu wrote:
>>>> On Mon, Oct 23, 2023 at 04:50:44PM +0200, Thomas Huth wrote:
>>>>> No need for a new variable here, especially not for one that shadows
>>>>> a variable from the beginning of the function scope. With this change
>>>>> the code now successfully compiles with -Wshadow=local.
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>    migration/ram.c | 3 +--
>>>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/migration/ram.c b/migration/ram.c
>>>>> index 92769902bb..9de9e54fa9 100644
>>>>> --- a/migration/ram.c
>>>>> +++ b/migration/ram.c
>>>>> @@ -3238,8 +3238,7 @@ static int ram_save_complete(QEMUFile *f,
>>>>> void *opaque)
>>>>>            ram_flush_compressed_data(rs);
>>>>> -        int ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
>>>>> -        if (ret < 0) {
>>>>> +        if (rdma_registration_stop(f, RAM_CONTROL_FINISH) < 0) {
>>>>
>>>> We may need to rename "ret" to something else?  qemu_file_set_error(),
>>>> right below, will reference the error returned.
>>>>
>>>>>                qemu_file_set_error(f, ret);   <-----------------
>>>
>>> Oh, drat, right ... that's exactly one of the reasons why shadowing
>>> variables is a bad idea ;-)
>>>
>>> I'll redo a v2.
>>
>> Actually, there is more fishy stuff in this function:
>>
>> static int ram_save_complete(QEMUFile *f, void *opaque)
>> {
>>      ...
>>      int ret = 0;
>>      ...
>>      WITH_RCU_READ_LOCK_GUARD() {
>>          ...
>>          ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
>>          if (ret < 0) {
>>              qemu_file_set_error(f, ret);
>> ### here we use the outer "ret" variable         ###
> 
> [1]
> 
>>          }
>>          ...
>>          while (true) {
>>              int pages;
>>
>>              pages = ram_find_and_save_block(rs);
>>              /* no more blocks to sent */
>>              if (pages == 0) {
>> ### here we break without touching "ret" (preserving the previous error) ###
>>                  break;
>>              }
>>              if (pages < 0) {
>>                  ret = pages;
>> ###  we only replace the outer "ret" in this break-case here
>>                  break;
>>              }
>>          }
>>          ...
>>          int ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
>> ### so while ret from rdma_registration_start() might be propageted
>> ### below, the ret from rdma_registration_stop() is only local here?
>>          if (ret < 0) {
>>              qemu_file_set_error(f, ret);
> 
> [2]
> 
>>          }
>>      }
>>
>>      if (ret < 0) {
>> ### this might trigger by the "ret" from rdma_registration_start() but
>> ### not by the one from rdma_registration_stop()? ... very weird...
>>          return ret;
>>      }
>>
>> Looks like commit 48408174a7ec7 messed up with the return types pretty badly
>> ... any suggestions what's the right way forward here? Should the return
>> value of rdma_registration_start() only be used for the
>> qemu_file_set_error(), too? Or should the return value of
>> rdma_registration_stop() be allowed to be used for the "return ret" at the
>> end, too?
> 
> Right that's indeed confusing, but it seems confusing too even before that
> commit.  AFAICT, we should "break" for both [1][2] above for any error
> occured..

Oh well, looking at the whole file, it seems like most spots that call a 
rdma_* function just do qemu_file_set_error() afterwards, but then continue 
with the normal workflow... that looks really confusing to me - if this 
needs fixing, it should be done by somebody who knows that code better than 
me, so I'll keep my hands of this and let somebody else fix it if necessary. 
I'll just respin my original patch to fix the -Wshadow issue.

  Thomas



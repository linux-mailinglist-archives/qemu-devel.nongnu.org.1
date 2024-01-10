Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3422F829A3C
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 13:11:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNXOu-0005xM-J6; Wed, 10 Jan 2024 07:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNXOa-0005wW-2M
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 07:09:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNXOW-0007b9-3g
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 07:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704888554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gxb8id3yaTe3V0Ybxd39ObfTPh+qbF8H6JFaSOgexvQ=;
 b=Ze9u1vTlpjTxrHG5k3pysAMvh62kd/Yt/NOFHzhCZRDN8uxlemT+zEYjRu8T+a/Kd20taK
 0QX22w+dpR/4S113XZLEoHx89m1FZ1fTYkjeBnYZFx275nRXG7PeHNBjC/nWUK9mK0gai0
 yK9OLZE0lD1JoEIp86XEMMsef9ddhBo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-I-HynjmUMHyxhuyKUMTDsw-1; Wed, 10 Jan 2024 07:09:13 -0500
X-MC-Unique: I-HynjmUMHyxhuyKUMTDsw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-680139b1990so79539976d6.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 04:09:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704888553; x=1705493353;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gxb8id3yaTe3V0Ybxd39ObfTPh+qbF8H6JFaSOgexvQ=;
 b=T9jTmQyk4hHh006TeHuhwyXBrYX5OrMqCdyCk0pNsKWLJ1iql2IHnL67/2wj3rRZqS
 XNRCeztrBwgKpdVBkgy9g8KVet8tfgBqmI8BFMjWlPx3pCBTiHknYuCGsbc80MtjpFru
 wFws4KkavaC/ZuaT15oxDXcoIQ/8x6S6fvCs3m1d23nKR29/jAdVFI/QFNK2UyHKYJFi
 nrEN3FFvcroJqeKH1SsD8tAesaX1ySm1+KB4FB3m9DyeKGp0YAmEpq6223O6sI1mbzlU
 oiROHGO3z1HQ3Og89Pjblcc7MxLVV3XFh7DOu/xz21TnD7/uEzH1IVsb39custqWwiFS
 mW1w==
X-Gm-Message-State: AOJu0YyR5X1pCAB0Ni33nud06dDt1mgqbQRUAw+zLC/tYneSJS89fB+/
 bgR/4joiR2nu5bsQAPbJ/5E6qJbmZYKT0sYhGt0PESGoAbf8q4ziDrTrwXU4z68A8GFviqx+qZ4
 6MOe7wPtn+3vRWTOnEF2ofv8=
X-Received: by 2002:ad4:4eac:0:b0:67a:970a:c003 with SMTP id
 ed12-20020ad44eac000000b0067a970ac003mr1288748qvb.12.1704888553322; 
 Wed, 10 Jan 2024 04:09:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoVwi0PzTzbGv3ToJZ2oQVLorqtubSs07Z0f7+aaihKLFAbOrY8va1nC57Ew3Fbj6lu1KRFg==
X-Received: by 2002:ad4:4eac:0:b0:67a:970a:c003 with SMTP id
 ed12-20020ad44eac000000b0067a970ac003mr1288732qvb.12.1704888553061; 
 Wed, 10 Jan 2024 04:09:13 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-232.web.vodafone.de.
 [109.43.176.232]) by smtp.gmail.com with ESMTPSA id
 n18-20020a0cbe92000000b0067f859a8ef5sm1627790qvi.105.2024.01.10.04.09.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 04:09:12 -0800 (PST)
Message-ID: <4deac04e-3006-4aca-bdf7-d2e1fd790690@redhat.com>
Date: Wed, 10 Jan 2024 13:09:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x/kvm/pv: Provide some more useful information
 if decryption fails
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>,
 qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>
References: <20240109143038.155512-1-thuth@redhat.com>
 <9296cdea-3144-4f4c-af7a-d7cadf8ea107@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <9296cdea-3144-4f4c-af7a-d7cadf8ea107@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 09/01/2024 17.51, Cédric Le Goater wrote:
> 
> 
> On 1/9/24 15:30, Thomas Huth wrote:
>> It's a common scenario to copy guest images from one host to another
>> to run the guest on the other machine. This (of course) does not work
>> with "secure exection" guests since they are encrypted with one certain
>> host key. However, if you still (accidentally) do it, you only get a
>> very user-unfriendly error message that looks like this:
>>
>>   qemu-system-s390x: KVM PV command 2 (KVM_PV_SET_SEC_PARMS) failed:
>>    header rc 108 rrc 5 IOCTL rc: -22
>>
>> Let's provide at least a somewhat nicer hint to the users so that they
>> are able to figure out what might have gone wrong.
>>
>> Buglink: https://issues.redhat.com/browse/RHEL-18212
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   target/s390x/kvm/pv.c | 20 ++++++++++++++++----
>>   1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
>> index 6a69be7e5c..2833a255fa 100644
>> --- a/target/s390x/kvm/pv.c
>> +++ b/target/s390x/kvm/pv.c
>> @@ -29,7 +29,8 @@ static bool info_valid;
>>   static struct kvm_s390_pv_info_vm info_vm;
>>   static struct kvm_s390_pv_info_dump info_dump;
>> -static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data)
>> +static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data,
>> +                         int *pvrc)
>>   {
>>       struct kvm_pv_cmd pv_cmd = {
>>           .cmd = cmd,
>> @@ -46,6 +47,9 @@ static int __s390_pv_cmd(uint32_t cmd, const char 
>> *cmdname, void *data)
>>                        "IOCTL rc: %d", cmd, cmdname, pv_cmd.rc, pv_cmd.rrc,
>>                        rc);
>>       }
>> +    if (pvrc) {
>> +        *pvrc = pv_cmd.rc;
>> +    }
>>       return rc;
>>   }
>> @@ -53,12 +57,13 @@ static int __s390_pv_cmd(uint32_t cmd, const char 
>> *cmdname, void *data)
>>    * This macro lets us pass the command as a string to the function so
>>    * we can print it on an error.
>>    */
>> -#define s390_pv_cmd(cmd, data) __s390_pv_cmd(cmd, #cmd, data)
>> +#define s390_pv_cmd(cmd, data) __s390_pv_cmd(cmd, #cmd, data, NULL)
>> +#define s390_pv_cmd_pvrc(cmd, data, pvrc) __s390_pv_cmd(cmd, #cmd, data, 
>> pvrc)
>>   #define s390_pv_cmd_exit(cmd, data)    \
>>   {                                      \
>>       int rc;                            \
>>                                          \
>> -    rc = __s390_pv_cmd(cmd, #cmd, data);\
>> +    rc = __s390_pv_cmd(cmd, #cmd, data, NULL); \
>>       if (rc) {                          \
>>           exit(1);                       \
>>       }                                  \
>> @@ -144,12 +149,19 @@ bool 
>> s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
>>   int s390_pv_set_sec_parms(uint64_t origin, uint64_t length)
>>   {
>> +    int ret, pvrc;
>>       struct kvm_s390_pv_sec_parm args = {
>>           .origin = origin,
>>           .length = length,
>>       };
>> -    return s390_pv_cmd(KVM_PV_SET_SEC_PARMS, &args);
>> +    ret = s390_pv_cmd_pvrc(KVM_PV_SET_SEC_PARMS, &args, &pvrc);
>> +    if (ret && pvrc == 0x108) {
> 
> why do we need to test for 0x108 also ? if this sub error code is important,
> adding a define would be a plus.

As far as I understood, other codes here could indicate a different failure, 
so I wanted to make sure to limit the text to this scenario only.
And AFAIK the error codes are something internal to the ultravisor, not 
documented publicly, so coming up with a #define here sounds hard to me.

>> +        error_report("Can't set secure parameters, please check whether "
>> +                     "the image is correctly encrypted for this host");
> The error reporting in s390x_machine_protect() could be improved.
> 
> I would add a 'Error *' argument to the routines called by
> s390x_machine_protect() and report the error in s390x_machine_protect()
> or above. s390_machine_protect() return value is ignored also, could be
> replaced by a bool.

Ok, I'll give it a try and send a v2.

  Thomas



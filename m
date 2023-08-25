Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9700D78832C
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 11:13:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZSsT-0004t2-NB; Fri, 25 Aug 2023 05:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qZSsR-0004se-Sq
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 05:13:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qZSsP-0007rw-Fo
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 05:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692954788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HXIyPBqe/TQaZxw9ynvqxc32rIgnmmo1azugvrFsGlQ=;
 b=BKyg79HMobzZiCya/d8kypPnfQPT3RgL0xgLMjX/bzbTdLzf7FahEWLraUA16Vkh81InKc
 pvUliXKi8bpocwUtgRg9GNgnI1WQwZCyKD1cZsz2EDvhkkyM+F0K4/okjWyN1LNkyzm21L
 +KU9V0CdStTfOs+5fTMZ+3s6Ly25yr4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-Rt_jl0PSMaq-1MXjPH0bVQ-1; Fri, 25 Aug 2023 05:13:06 -0400
X-MC-Unique: Rt_jl0PSMaq-1MXjPH0bVQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2bcda0aa7ffso8086041fa.1
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 02:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692954784; x=1693559584;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HXIyPBqe/TQaZxw9ynvqxc32rIgnmmo1azugvrFsGlQ=;
 b=f5NMGzGDVKIR862XDd/ihsz/e4ONDm+U0AflTdt/pBRdppfOHaLoFMdfkddJFU9jAF
 dPNAsJAT+y2bFUVLkDB2mSEzKMGKMyzfmoBc2J+0ot1JPAhk+U1WAMrJvVEIuI4kYJmO
 cc6kQYJFg8jjjOvMU/snP7mJABKRgoIyspEKYyO2qMDjhiGAzOyK64YKSZcU9qrnmz3n
 VGkQa9AIiwOW8STudhFV7hSyW2BnDM4ESwCrz9a7kbxDHFob5E6LfLRdiyDQChoCrF2Z
 ZAr1mrPLoYjbZ1HS54+3HJtt1rJcacPULORnvDxkDi+qD+bHdc7iRqSuOSL55IK9xPXc
 nHVw==
X-Gm-Message-State: AOJu0Yy3Wx6TtPqKLQsqapZWGkqpEzwCG0xvQrlQ9qymfTdPvVxzZChy
 W/Ytumxz+Wgvq4jkNurMbsK2IP4IM+NjBmf2X+sewmaTgU8DOM7RU1KfVuqcy7bkQ3rUwDDq8U6
 hhjiQ5dHqkQqRdQA=
X-Received: by 2002:a2e:8747:0:b0:2bc:f118:7821 with SMTP id
 q7-20020a2e8747000000b002bcf1187821mr1776124ljj.29.1692954784654; 
 Fri, 25 Aug 2023 02:13:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBnYB7M+eswySY0Es0rdDJ7LEqQja1QTWrJLQxhAtTMstcFXtBVtNWKFGEIevRzDts24QNCw==
X-Received: by 2002:a2e:8747:0:b0:2bc:f118:7821 with SMTP id
 q7-20020a2e8747000000b002bcf1187821mr1776110ljj.29.1692954784148; 
 Fri, 25 Aug 2023 02:13:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:9200:ce93:b5e6:8aa9:65d4?
 (p200300cbc70e9200ce93b5e68aa965d4.dip0.t-ipconnect.de.
 [2003:cb:c70e:9200:ce93:b5e6:8aa9:65d4])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a1c750a000000b003fe29dc0ff2sm1672547wmc.21.2023.08.25.02.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 02:13:03 -0700 (PDT)
Message-ID: <bd8f7f13-b982-6cf6-1ef7-16b4738b94ac@redhat.com>
Date: Fri, 25 Aug 2023 11:13:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 11/11] machine: Improve error message when using
 default RAM backend id
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: ThinerLogoer <logoerthiner1@163.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2eBerrang=c3=a9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20230823153412.832081-1-david@redhat.com>
 <20230823153412.832081-12-david@redhat.com>
 <209b4b8c.54bc.18a2b7b6f53.Coremail.logoerthiner1@163.com>
 <e81b5069-e49a-cfb4-bea9-3c7ab6a358ca@redhat.com>
 <87msyfo5b0.fsf@pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <87msyfo5b0.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.919, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 25.08.23 11:10, Markus Armbruster wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 25.08.23 08:57, ThinerLogoer wrote:
>>> Hello,
>>>
>>> At 2023-08-23 23:34:11, "David Hildenbrand" <david@redhat.com> wrote:
>>>> For migration purposes, users might want to reuse the default RAM
>>>> backend id, but specify a different memory backend.
>>>>
>>>> For example, to reuse "pc.ram" on q35, one has to set
>>>>      -machine q35,memory-backend=pc.ram
>>>> Only then, can a memory backend with the id "pc.ram" be created
>>>> manually.
>>>>
>>>> Let's improve the error message.
>>>>
>>>> Unfortuantely, we cannot use error_append_hint(), because the caller
>>>> passes &error_fatal.
>>>>
>>>> Suggested-by: ThinerLogoer <logoerthiner1@163.com>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>> hw/core/machine.c | 4 +++-
>>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>> index f0d35c6401..dbcd124d45 100644
>>>> --- a/hw/core/machine.c
>>>> +++ b/hw/core/machine.c
>>>> @@ -1382,7 +1382,9 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>>>>                                    machine_class->default_ram_id)) {
>>>>               error_setg(errp, "object name '%s' is reserved for the default"
>>>>                   " RAM backend, it can't be used for any other purposes."
>>>> -                " Change the object's 'id' to something else",
>>>> +                " Change the object's 'id' to something else or disable"
>>>> +                " automatic creation of the default RAM backend by setting"
>>>> +                " the 'memory-backend' machine property",
>>>>                   machine_class->default_ram_id);
>>>>               return;
>>>>           }
>>>
>>> I'd suggest a more explicit version:
>>>
>>>                   " Change the object's 'id' to something else or disable"
>>>                   " automatic creation of the default RAM backend by appending"
>>>                   "  'memory-backend={machine_class->default_ram_id}' in '-machine' arguments",
>>
>>
>> Thanks, I'll do:
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index f0d35c6401..cd0fd6cdd1 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -1382,8 +1382,10 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>>                                     machine_class->default_ram_id)) {
>>                error_setg(errp, "object name '%s' is reserved for the default"
>>                    " RAM backend, it can't be used for any other purposes."
>> -                " Change the object's 'id' to something else",
>> -                machine_class->default_ram_id);
>> +                " Change the object's 'id' to something else or disable"
>> +                " automatic creation of the default RAM backend by appending"
>> +                " 'memory-backend=%s' in '-machine' arguments",
>> +                machine_class->default_ram_id, machine_class->default_ram_id);
>>                return;
>>            }
>>            if (!create_default_memdev(current_machine, mem_path, errp)) {
> 

Hi Markus,

> error_setg()'s function comment specifies:
> 
>   * The resulting message should be a single phrase, with no newline or
>   * trailing punctuation.
> 
> Please use error_append_hint(), like so

Please see the patch description: "Unfortunately, we cannot use 
error_append_hint(), because the caller passes &error_fatal."

How should I deal with that?

> 
>               error_setg(errp, "object name '%s' is reserved for the default"
>                   " RAM backend, it can't be used for any other purposes",
>                   machine_class->default_ram_id);
>               error_append_hint(errp,
>                   "Change the object's 'id' to something else or disable"
>                   " automatic creation of the default RAM backend by appending"
>                   " 'memory-backend=%s' in '-machine' arguments\n",
>                   machine_class->default_ram_id);
> 
> Moreover:
> 
> * "object name" feels off, we're talking about IDs, aren't we?

Yes, I think so.

> 
> * "appending X in Y" should be "appending X to Y".  Consider "setting
>    'memory-backend=%s' with -machine".
> 

Can do, thanks.

-- 
Cheers,

David / dhildenb



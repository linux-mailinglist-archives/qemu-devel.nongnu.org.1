Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D573788431
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 12:01:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZTbm-0007Ut-I2; Fri, 25 Aug 2023 06:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qZTbc-0007T1-Sn
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 05:59:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qZTba-00008v-Fr
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 05:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692957589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7s2uu6qkJwqjoZ93u83NS6Ra6OnBfgT2d9LgZPGcHo0=;
 b=bwaysNy9k978f/Se/LawEwUdVdSHaXKhhC9CLQ/SmdEdOdwxOLRP7uUaisLuiSKNjKLdvO
 FDTWQxF36xb21hAOg7pMNEDsLkS8M8FGSuNy33XAXUgchqUa6e76gsb/jJBH8SolDBojvI
 oj1dFuzqNXhKVSa76uPOIlV/gTJlTKE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-2AkXLjhLMBiNOWp69lMI-w-1; Fri, 25 Aug 2023 05:59:47 -0400
X-MC-Unique: 2AkXLjhLMBiNOWp69lMI-w-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50084bf5da1so814922e87.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 02:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692957586; x=1693562386;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7s2uu6qkJwqjoZ93u83NS6Ra6OnBfgT2d9LgZPGcHo0=;
 b=SflPgzhBWK/+wAx+yhQFPRadqEZTcwieuzzgKeTCDG5sXNFKF60ATky2NMJxtMnrTI
 R7jmtRKDHT9glNI6CcMDUZZshalPQsl46YOkFwedOW4gdpKmbd79Ba99sWMWoX57B/+R
 GmLz35kB7KefMwOS/NkJ7eHBqLcQNvvi+6zqS+C1TodOueZqM9/KXwSrAHIJFENUd8VH
 nKaPOPiYTfMU7+6Kbvzx+HshT+ybXrA3OMQvIFzwcOgTNYlpLVq4ljYVuXxlicciTLPq
 iNGTe6K/PvrdbgGqMjpyrsqq8QyEuUMiEA8BstlyUJX8kptJYXYSwnQrz6ui1ujdcmyW
 kBYA==
X-Gm-Message-State: AOJu0YzOZQJs+EXBwF0ysIlshzb7ulNJIVBmhfCnz4AY/6KC66nLmqCc
 zXrljSU/ZFGGMtfWAKeZCvRTeYlAvVL22BtS+zaLKZt5bxS98yu0BFs6Goog6Ukf5mQhCLSloDx
 Rhknq5tYOtM+Yfl0=
X-Received: by 2002:a05:6512:33c5:b0:4fe:3a57:7c98 with SMTP id
 d5-20020a05651233c500b004fe3a577c98mr16109306lfg.32.1692957585867; 
 Fri, 25 Aug 2023 02:59:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTHen+K6YaHZWDPiom1IxR4C43/pmVVZRr8YONKtRwAhiFQcfVsqLRylY1MlOZyiPk2ooXjQ==
X-Received: by 2002:a05:6512:33c5:b0:4fe:3a57:7c98 with SMTP id
 d5-20020a05651233c500b004fe3a577c98mr16109285lfg.32.1692957585458; 
 Fri, 25 Aug 2023 02:59:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:9200:ce93:b5e6:8aa9:65d4?
 (p200300cbc70e9200ce93b5e68aa965d4.dip0.t-ipconnect.de.
 [2003:cb:c70e:9200:ce93:b5e6:8aa9:65d4])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a05600c298100b003fe2b6d64c8sm4950634wmd.21.2023.08.25.02.59.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 02:59:45 -0700 (PDT)
Message-ID: <d87ac218-0051-ad91-5867-d1bec9f4fda4@redhat.com>
Date: Fri, 25 Aug 2023 11:59:43 +0200
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
 <bd8f7f13-b982-6cf6-1ef7-16b4738b94ac@redhat.com>
 <87sf87momv.fsf@pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <87sf87momv.fsf@pond.sub.org>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25.08.23 11:56, Markus Armbruster wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 25.08.23 11:10, Markus Armbruster wrote:
>>> David Hildenbrand <david@redhat.com> writes:
>>>
>>>> On 25.08.23 08:57, ThinerLogoer wrote:
>>>>> Hello,
>>>>>
>>>>> At 2023-08-23 23:34:11, "David Hildenbrand" <david@redhat.com> wrote:
>>>>>> For migration purposes, users might want to reuse the default RAM
>>>>>> backend id, but specify a different memory backend.
>>>>>>
>>>>>> For example, to reuse "pc.ram" on q35, one has to set
>>>>>>       -machine q35,memory-backend=pc.ram
>>>>>> Only then, can a memory backend with the id "pc.ram" be created
>>>>>> manually.
>>>>>>
>>>>>> Let's improve the error message.
>>>>>>
>>>>>> Unfortuantely, we cannot use error_append_hint(), because the caller
>>>>>> passes &error_fatal.
>>>>>>
>>>>>> Suggested-by: ThinerLogoer <logoerthiner1@163.com>
>>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>>> ---
>>>>>> hw/core/machine.c | 4 +++-
>>>>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>>>> index f0d35c6401..dbcd124d45 100644
>>>>>> --- a/hw/core/machine.c
>>>>>> +++ b/hw/core/machine.c
>>>>>> @@ -1382,7 +1382,9 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>>>>>>                                     machine_class->default_ram_id)) {
>>>>>>                error_setg(errp, "object name '%s' is reserved for the default"
>>>>>>                    " RAM backend, it can't be used for any other purposes."
>>>>>> -                " Change the object's 'id' to something else",
>>>>>> +                " Change the object's 'id' to something else or disable"
>>>>>> +                " automatic creation of the default RAM backend by setting"
>>>>>> +                " the 'memory-backend' machine property",
>>>>>>                    machine_class->default_ram_id);
>>>>>>                return;
>>>>>>            }
>>>>>
>>>>> I'd suggest a more explicit version:
>>>>>
>>>>>                    " Change the object's 'id' to something else or disable"
>>>>>                    " automatic creation of the default RAM backend by appending"
>>>>>                    "  'memory-backend={machine_class->default_ram_id}' in '-machine' arguments",
>>>>
>>>>
>>>> Thanks, I'll do:
>>>>
>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>> index f0d35c6401..cd0fd6cdd1 100644
>>>> --- a/hw/core/machine.c
>>>> +++ b/hw/core/machine.c
>>>> @@ -1382,8 +1382,10 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>>>>                                      machine_class->default_ram_id)) {
>>>>                 error_setg(errp, "object name '%s' is reserved for the default"
>>>>                     " RAM backend, it can't be used for any other purposes."
>>>> -                " Change the object's 'id' to something else",
>>>> -                machine_class->default_ram_id);
>>>> +                " Change the object's 'id' to something else or disable"
>>>> +                " automatic creation of the default RAM backend by appending"
>>>> +                " 'memory-backend=%s' in '-machine' arguments",
>>>> +                machine_class->default_ram_id, machine_class->default_ram_id);
>>>>                 return;
>>>>             }
>>>>             if (!create_default_memdev(current_machine, mem_path, errp)) {
>>>
>>
>> Hi Markus,
>>
>>> error_setg()'s function comment specifies:
>>>    * The resulting message should be a single phrase, with no newline or
>>>    * trailing punctuation.
>>> Please use error_append_hint(), like so
>>
>> Please see the patch description: "Unfortunately, we cannot use error_append_hint(), because the caller passes &error_fatal."
>>
>> How should I deal with that?
> 
> qapi/error.h tells you :)
> 
>   * = Creating errors =
>   [...]
>   * Create an error and add additional explanation:
>   *     error_setg(errp, "invalid quark");
>   *     error_append_hint(errp, "Valid quarks are up, down, strange, "
>   *                       "charm, top, bottom.\n");
>   * This may require use of ERRP_GUARD(); more on that below.
>   [...]
>   * = Why, when and how to use ERRP_GUARD() =
>   *
>   * Without ERRP_GUARD(), use of the @errp parameter is restricted:
>   * - It must not be dereferenced, because it may be null.
>   * - It should not be passed to error_prepend() or
>   *   error_append_hint(), because that doesn't work with &error_fatal.
>   * ERRP_GUARD() lifts these restrictions.
>   *
>   * To use ERRP_GUARD(), add it right at the beginning of the function.
>   * @errp can then be used without worrying about the argument being
>   * NULL or &error_fatal.
>   *
>   * Using it when it's not needed is safe, but please avoid cluttering
>   * the source with useless code.
>   *
>   * = Converting to ERRP_GUARD() =
>   *
>   * To convert a function to use ERRP_GUARD():
>   *
>   * 0. If the Error ** parameter is not named @errp, rename it to
>   *    @errp.
>   *
>   * 1. Add an ERRP_GUARD() invocation, by convention right at the
>   *    beginning of the function.  This makes @errp safe to use.
>   *
>   * 2. Replace &err by errp, and err by *errp.  Delete local variable
>   *    @err.
>   *
>   * 3. Delete error_propagate(errp, *errp), replace
>   *    error_propagate_prepend(errp, *errp, ...) by error_prepend(errp, ...)
>   *
>   * 4. Ensure @errp is valid at return: when you destroy *errp, set
>   *    *errp = NULL.
>   *
>   * Example:
>   *
>   *     bool fn(..., Error **errp)
>   *     {
>   *         Error *err = NULL;
>   *
>   *         foo(arg, &err);
>   *         if (err) {
>   *             handle the error...
>   *             error_propagate(errp, err);
>   *             return false;
>   *         }
>   *         ...
>   *     }
>   *
>   * becomes
>   *
>   *     bool fn(..., Error **errp)
>   *     {
>   *         ERRP_GUARD();
>   *
>   *         foo(arg, errp);
>   *         if (*errp) {
>   *             handle the error...
>   *             return false;
>   *         }
>   *         ...
>   *     }
>   *
>   * For mass-conversion, use scripts/coccinelle/errp-guard.cocci.
> 
> Questions?

Thanks for the pointer!

... hopefully I'm done with that error-handling pain in QEMU soon and 
can continue focusing on things that make me feel more productive :P

-- 
Cheers,

David / dhildenb



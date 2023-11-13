Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4327EA1EB
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:34:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2aos-0003wV-Rl; Mon, 13 Nov 2023 12:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1r2aon-0003ka-Pf
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:33:50 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1r2aok-00011r-Pq
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:33:49 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1cc316ccc38so34935175ad.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699896823; x=1700501623; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P2pbBfuHl8Mgc6tTPox6vqtd8vhh5dlOqaQwKBT+aBY=;
 b=nXz6iBpQ+zWBoN4ZMDhazAPUSlhNLB7DC1a+72j1uIS+zlOhPppcJMxM+gGmGNSwEa
 D/G8ePBglVwilS1xrgpjrgxyttOF7AxktpSOpPTCW+QLljzTLedaaKmibUidRE8xNoAP
 srXJFzgyu1YDTSfQPpGDRmSLvme5xnwi3TG45IOmSMEbLMVzk4TyhtyY25qlOVaDpdZc
 6oYh5zJrN/887TRirWLOpXXFFzJbUGKrf4vRHLd3xAFX8pDc2JMBO7l97asYqMGcmC81
 xkQro21v4CQA32inuu5GtT9EtI3yhNy6GFRWrGy11Q4KbaTzSjwVCuF6g9elwg9CiHsG
 mXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699896823; x=1700501623;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P2pbBfuHl8Mgc6tTPox6vqtd8vhh5dlOqaQwKBT+aBY=;
 b=LKdIS6bFZsDUBRCG200tT4vdBDVIuavKYGwD7afdMJu4c4XPJg+X/MN5caSSj4d5ix
 JVqBX6X34UPD0xhl1eMygdN9yG/5OVmESmwQv5LJbvwIHO4HDVAAcGVQOcOnMiaD0xHn
 SPz2N9P8EJ9c9VeAygQnHCIlTF6e/BGrBhl8lJwmNEK+53zTcTxHWIVunUXy0Qim4UyY
 KX69Hao0q7MtsCSDHAaQlwbXirbziqY6aHO9gKUJMxUllLwZDYtO71HMPJbIzvkCV/uk
 ITJ9jZvAuBUVRDXu3OhY5qGgITA6wa1slf3n7zAYiiSFmxK9ASCcjENTgAlHDXl00OTg
 IqlA==
X-Gm-Message-State: AOJu0YyUUbMqqYC8bqBEDdrPK6nIQpY2iDg/MvtiEPRiu4UpTRu3I8dU
 Nvd7sl9Rth+W4xbHU7k5XwD9NQ==
X-Google-Smtp-Source: AGHT+IHRjYCB1sps1Myxp213dCgXkFBHl/qDW2SzlSwuazOxQP1q+7tHtFQabU86r464pXF/cXSARA==
X-Received: by 2002:a17:902:dac6:b0:1cc:56a9:e8d5 with SMTP id
 q6-20020a170902dac600b001cc56a9e8d5mr248023plx.15.1699896823456; 
 Mon, 13 Nov 2023 09:33:43 -0800 (PST)
Received: from ?IPv6:2804:7f0:b401:308c:fa40:2f92:19ee:4ba?
 ([2804:7f0:b401:308c:fa40:2f92:19ee:4ba])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a170902d34900b001b9d335223csm4290748plk.26.2023.11.13.09.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 09:33:42 -0800 (PST)
Subject: Re: [PATCH] test/qtest: Add an API function to capture IRQ toggling
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, pbonzini@redhat.com
References: <20231112013801.293970-1-gustavo.romero@linaro.org>
 <ddb3f1c5-28d1-472d-b491-703a3e1c6711@redhat.com>
 <d79587a5-ae52-4832-9859-aad3e8b7182d@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <048454b2-86c3-4bda-5197-bfe44e864586@linaro.org>
Date: Mon, 13 Nov 2023 14:33:39 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <d79587a5-ae52-4832-9859-aad3e8b7182d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.971,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Thomas and Phil,


On 11/13/23 7:14 AM, Philippe Mathieu-Daudé wrote:
> On 13/11/23 07:59, Thomas Huth wrote:
>> On 12/11/2023 02.38, Gustavo Romero wrote:
>>> Currently the QTest API does not provide a function to allow capturing
>>> when an IRQ line is toggled (raised then lowered). Functions like
>>> qtest_get_irq() read the current state of the intercepted IRQ lines,
>>> which is already low when the function is called, since the line is
>>> toggled.
>>>
>>> This commit introduces a new function, qtest_get_irq_trigger_counter(),
>>> which returns the number of times a given intercepted IRQ line was
>>> triggered (raised), hence allowing to capture when an IRQ line was
>>> toggled.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> ---
>>>   tests/qtest/libqtest.c | 12 ++++++++++++
>>>   tests/qtest/libqtest.h |  9 +++++++++
>>>   2 files changed, 21 insertions(+)
>>>
>>> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
>>> index f33a210861..21891b52f1 100644
>>> --- a/tests/qtest/libqtest.c
>>> +++ b/tests/qtest/libqtest.c
>>> @@ -82,6 +82,7 @@ struct QTestState
>>>       int expected_status;
>>>       bool big_endian;
>>>       bool irq_level[MAX_IRQ];
>>> +    uint64_t irq_trigger_counter[MAX_IRQ];
>>>       GString *rx;
>>>       QTestTransportOps ops;
>>>       GList *pending_events;
>>> @@ -498,6 +499,7 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
>>>       s->rx = g_string_new("");
>>>       for (i = 0; i < MAX_IRQ; i++) {
>>>           s->irq_level[i] = false;
>>> +        s->irq_trigger_counter[i] = 0;
>>>       }
>>>       /*
>>> @@ -690,6 +692,7 @@ redo:
>>>           if (strcmp(words[1], "raise") == 0) {
>>>               s->irq_level[irq] = true;
>>> +            s->irq_trigger_counter[irq]++;
> 
> This is 'irq_raised_counter',
> 
>> Not sure whether you can get some "raise" events in a row without some "lower" events in between ... but just in case, I wonder whether it would make sense to check whether it is really a rising edge, i.e.:
>>
>>             if (strcmp(words[1], "raise") == 0) {
>>                 if (!s->irq_level[irq]) {
>>                     s->irq_trigger_counter[irq]++;
>>                 }
>>                 s->irq_level[irq] = true;
>>
>> What do you think?
> 
> This is 'irq_pulsed_counter'. 'irq_lowered_counter' could also be
> useful (at least for completeness).

I understand that the code provided by Thomas actually has the exactly same
effect as my code. This happens because a "raise" (or "low) message is
not sent by the "server" side unless a transition state low -> high happens,
so the check 'if (!s->irq_level[irq]) { ... }' is always true. So it's still
capturing the raising state transition (as a side note, when one intercepts
an IRQ the current state of the IRQ line is saved -- so the old IRQ state is
always valid). Therefore, also as a consequence, like Thomas said, it's not
possible to get a 'raise' event in a row without a 'lower' event in between.

Based on your comments, I gave a second thought on 'trigger' meaning. I think
'trigger' refers to an event or action that automatically initiates a
procedure. Since raising an IRQ line does not always mean to generate an IRQ,
since the like can be active low in a device, maybe I should avoid using
trigger and synonymous for raising.

I think since 'toggle' means to switch back and forth between two modes or
states, yep, it seems ok to me to use it as a synonymous for 'pulse'.

Hence, I removed the word 'trigger' from the API function name and elsewhere.

Right, I think having a qtest_get_irq_lowered_counter() is better and also,
when used together with qtest_get_irq_raised_counter(), it's possible for a
test to check pulses on the IRQ lines.


> Per Gustavo's description, he indeed wants irq_pulsed_counter (or
> irq_toggled_counter'.
> 

That's a good point. So far I was testing just the high -> low transition,
but in fact the most correct way to test the device is also check for
a high -> low transition (so, yeah, indeed test a pulse).

In the device I have:

[...]
     /*
      * Toggle device's output line, which is connected to interrupt controller,
      * generating an interrupt request to the CPU.
      */
     qemu_set_irq(s->irq, true);
     qemu_set_irq(s->irq, false);
}

Thus having both qtest_get_irq_{lowered,raised}_counter() allows capturing
an IRQ toggle, for instance, as the following, where exactly 1 pulse is tested:

     uint64_t num_raises;
     uint64_t num_lows;

     while (1) {
         if ((num_raises = qtest_get_irq_raised_counter(qts, 0))) {
             num_lows = qtest_get_irq_lowered_counter(qts, 0);
             if (num_raises == num_lows && num_lows == 1) {
                 printf("Detected correct number of pulses.\n");
                 return 0;
             } else {
                 printf("Detected incorrect number of pulses.\n");
                 return 1;
             }
         }
     }

>>
>>>           } else {
>>>               s->irq_level[irq] = false;
>>>           }
>>
>> Anyway:
>> Acked-by: Thomas Huth <thuth@redhat.com>
I'm sending a v2 with qtest_get_irq_lowered_counter().

Thanks!


Cheers,
Gustavo


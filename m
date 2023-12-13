Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45551810D25
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 10:15:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDLLB-0003i9-P7; Wed, 13 Dec 2023 04:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDLKo-0003hu-0w
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 04:15:18 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDLKg-0006tP-SI
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 04:15:15 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40c48d7a7a7so25991695e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 01:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702458909; x=1703063709; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2/+Q7LlVz5gKFUOxg5jgYasfzSi/zp1fBABDohCwkkE=;
 b=wBfdH8Pd8zMPm14sLmuz+sAZj4e+c0iRUdRXJkQS0wYTl1pR2QCDcjsaNq1a9w8qBk
 zQCzimjCxwtCDGj5JmPbcyPXfLgaEPfRXiGIN0jdDMexsBp0evZqvRjO1GtITH/fnYOb
 NVVhr1vzAPhLAE3jZOchfHPPg6/KyunufouE8oJOCRAemghtD2xOfm+UkvjN7ISPeiSb
 9Usm3xzzegogaWqPqT09lUcJzx19qO9fjtAjkJQK5nigU/mEnaMDTKEP4MxDuOT0SDkF
 Y8TyVn5DV5ah9SLi544ohW6qbzFfGb11avWgi154WjjxB+fGLjYxQjZX0wMWmt+uqPDM
 /oHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702458909; x=1703063709;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2/+Q7LlVz5gKFUOxg5jgYasfzSi/zp1fBABDohCwkkE=;
 b=ePwOgrzc/PQCx4C4Ou0Q1aW/e0BCvLGXBRIVm5l6YyabCY3TfmY5/NU1ky9z0ywlz6
 tx2HZcO3cScLTMHN+HMD6ZOvBd4ierFqC4msDqvwcxDue1E0RpR+a0iq72VcA6FDEBcc
 866iV6UpjT2/a994JrcFYJjwpNJuDGp5Ik/ImeKvXsDPezSSna5rbX/rywjrTkj3iu0N
 pyPi+VGKEiFHlI6yZp4RTsEFd3zlfVDZ2p4CqmIMV0QsA7bvvuhqaNWLZpjfv89rlkOB
 VveiZ1iTrLzsAEHoihqJVFheHV12fciUgm6miz8s4Svfk0Vw0ZA/trcqcYWzn90P/83S
 z/oA==
X-Gm-Message-State: AOJu0YyVBHQibAHg5n9XQS2iKkTBSE+ntSntIj00m+Uk89DZPGtLLg8i
 zdCXH0tbxGtkTmFYXXSuhlUtYw==
X-Google-Smtp-Source: AGHT+IHcR+666XYGBob/qS4SsQfwwxtKUn0ImJ2vn5S5bsoeGzaQOBfiRPX+Ob5IFg6Edga0W2kLBw==
X-Received: by 2002:a05:600c:4d98:b0:40c:2715:b10f with SMTP id
 v24-20020a05600c4d9800b0040c2715b10fmr4383532wmp.119.1702458909029; 
 Wed, 13 Dec 2023 01:15:09 -0800 (PST)
Received: from [192.168.50.175] (109.red-88-28-22.dynamicip.rima-tde.net.
 [88.28.22.109]) by smtp.gmail.com with ESMTPSA id
 d12-20020a05600c3acc00b0040836519dd9sm19495873wms.25.2023.12.13.01.15.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 01:15:08 -0800 (PST)
Message-ID: <2ebd589c-f25c-4751-823c-10d7ddcb2a02@linaro.org>
Date: Wed, 13 Dec 2023 10:15:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/qtest: Add an API function to capture IRQ toggling
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, Thomas Huth
 <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, pbonzini@redhat.com
References: <20231112013801.293970-1-gustavo.romero@linaro.org>
 <ddb3f1c5-28d1-472d-b491-703a3e1c6711@redhat.com>
 <d79587a5-ae52-4832-9859-aad3e8b7182d@linaro.org>
 <048454b2-86c3-4bda-5197-bfe44e864586@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <048454b2-86c3-4bda-5197-bfe44e864586@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 13/11/23 18:33, Gustavo Romero wrote:
>>>> Currently the QTest API does not provide a function to allow capturing
>>>> when an IRQ line is toggled (raised then lowered). Functions like
>>>> qtest_get_irq() read the current state of the intercepted IRQ lines,
>>>> which is already low when the function is called, since the line is
>>>> toggled.
>>>>
>>>> This commit introduces a new function, qtest_get_irq_trigger_counter(),
>>>> which returns the number of times a given intercepted IRQ line was
>>>> triggered (raised), hence allowing to capture when an IRQ line was
>>>> toggled.
>>>>
>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>> ---
>>>>   tests/qtest/libqtest.c | 12 ++++++++++++
>>>>   tests/qtest/libqtest.h |  9 +++++++++
>>>>   2 files changed, 21 insertions(+)
>>>>
>>>> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
>>>> index f33a210861..21891b52f1 100644
>>>> --- a/tests/qtest/libqtest.c
>>>> +++ b/tests/qtest/libqtest.c
>>>> @@ -82,6 +82,7 @@ struct QTestState
>>>>       int expected_status;
>>>>       bool big_endian;
>>>>       bool irq_level[MAX_IRQ];
>>>> +    uint64_t irq_trigger_counter[MAX_IRQ];
>>>>       GString *rx;
>>>>       QTestTransportOps ops;
>>>>       GList *pending_events;
>>>> @@ -498,6 +499,7 @@ static QTestState *qtest_init_internal(const 
>>>> char *qemu_bin,
>>>>       s->rx = g_string_new("");
>>>>       for (i = 0; i < MAX_IRQ; i++) {
>>>>           s->irq_level[i] = false;
>>>> +        s->irq_trigger_counter[i] = 0;
>>>>       }
>>>>       /*
>>>> @@ -690,6 +692,7 @@ redo:
>>>>           if (strcmp(words[1], "raise") == 0) {
>>>>               s->irq_level[irq] = true;
>>>> +            s->irq_trigger_counter[irq]++;
>>
>> This is 'irq_raised_counter',
>>
>>> Not sure whether you can get some "raise" events in a row without 
>>> some "lower" events in between ... but just in case, I wonder whether 
>>> it would make sense to check whether it is really a rising edge, i.e.:
>>>
>>>             if (strcmp(words[1], "raise") == 0) {
>>>                 if (!s->irq_level[irq]) {
>>>                     s->irq_trigger_counter[irq]++;
>>>                 }
>>>                 s->irq_level[irq] = true;
>>>
>>> What do you think?
>>
>> This is 'irq_pulsed_counter'. 'irq_lowered_counter' could also be
>> useful (at least for completeness).
> 
> I understand that the code provided by Thomas actually has the exactly same
> effect as my code. This happens because a "raise" (or "low) message is
> not sent by the "server" side unless a transition state low -> high 
> happens,
> so the check 'if (!s->irq_level[irq]) { ... }' is always true. So it's 
> still
> capturing the raising state transition (as a side note, when one intercepts
> an IRQ the current state of the IRQ line is saved -- so the old IRQ 
> state is
> always valid). Therefore, also as a consequence, like Thomas said, it's not
> possible to get a 'raise' event in a row without a 'lower' event in 
> between.
> 
> Based on your comments, I gave a second thought on 'trigger' meaning. I 
> think
> 'trigger' refers to an event or action that automatically initiates a
> procedure. Since raising an IRQ line does not always mean to generate an 
> IRQ,
> since the like can be active low in a device, maybe I should avoid using
> trigger and synonymous for raising.
> 
> I think since 'toggle' means to switch back and forth between two modes or
> states, yep, it seems ok to me to use it as a synonymous for 'pulse'.

One definition of "to toggle" is:
'''
switch from one effect, feature, or state to another by using a toggle.
'''

"pulsate":
'''
expand and contract with strong regular movements.
'''

Maybe 'pulse' is simpler to understand?

> Hence, I removed the word 'trigger' from the API function name and 
> elsewhere.
> 
> Right, I think having a qtest_get_irq_lowered_counter() is better and also,
> when used together with qtest_get_irq_raised_counter(), it's possible for a
> test to check pulses on the IRQ lines.
> 
> 
>> Per Gustavo's description, he indeed wants irq_pulsed_counter (or
>> irq_toggled_counter'.
>>
> 
> That's a good point. So far I was testing just the high -> low transition,
> but in fact the most correct way to test the device is also check for
> a high -> low transition (so, yeah, indeed test a pulse).
> 
> In the device I have:
> 
> [...]
>      /*
>       * Toggle device's output line, which is connected to interrupt 
> controller,
>       * generating an interrupt request to the CPU.
>       */
>      qemu_set_irq(s->irq, true);
>      qemu_set_irq(s->irq, false);

This is qemu_irq_pulse() from include/hw/irq.h.

> }
> 
> Thus having both qtest_get_irq_{lowered,raised}_counter() allows capturing
> an IRQ toggle, for instance, as the following, where exactly 1 pulse is 
> tested:
> 
>      uint64_t num_raises;
>      uint64_t num_lows;
> 
>      while (1) {
>          if ((num_raises = qtest_get_irq_raised_counter(qts, 0))) {
>              num_lows = qtest_get_irq_lowered_counter(qts, 0);
>              if (num_raises == num_lows && num_lows == 1) {
>                  printf("Detected correct number of pulses.\n");
>                  return 0;
>              } else {
>                  printf("Detected incorrect number of pulses.\n");
>                  return 1;
>              }
>          }
>      }
> 
>>>
>>>>           } else {
>>>>               s->irq_level[irq] = false;
>>>>           }
>>>
>>> Anyway:
>>> Acked-by: Thomas Huth <thuth@redhat.com>
> I'm sending a v2 with qtest_get_irq_lowered_counter().
> 
> Thanks!
> 
> 
> Cheers,
> Gustavo



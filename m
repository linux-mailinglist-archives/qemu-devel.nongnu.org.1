Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 873087DC805
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 09:17:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxjvV-0004mc-TG; Tue, 31 Oct 2023 04:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxjvG-0004k8-3x
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 04:16:30 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxjvC-0006oY-BZ
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 04:16:25 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c503dbe50dso77879591fa.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 01:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698740179; x=1699344979; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mv3GVk43stYjLxFoQSJTrPzcOwtPp/8rPocpPFC8JVM=;
 b=dAW/j8/2jLusdBZvJTygNFhp3wEOyVLmMouq+LmqVjyg8L8mXFRKPM3Xrbu4mSFHM7
 F7kAIt1k+3xHX2+Tx8Ct5lpgrJoG8FrAOZUsvppMJh6NWTAcbRRphNOLb+8EZa6LcoNO
 D7q0KiH+y5cqiWCuCpIiD0DWlpkyPAyDvifVVXTcyuyWrM/B+RrHBwx3WODZqfKymI7/
 LaxN8uYFG4I+/MySiwwpV+lXbOw9Eku3lBhofkckJKCqpKOND2L3YKAxmY2I0d22cpyQ
 D6H2TfiEMO+0Mixw+K3v6vWrUmplanyHq3J0tZaplBsHnPlqAXMZNostIFfNYfKZ5HXe
 9pTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698740179; x=1699344979;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mv3GVk43stYjLxFoQSJTrPzcOwtPp/8rPocpPFC8JVM=;
 b=VvbMzQvEz4IFnvLg7DVez3XCRE2ft2TYYzKBo0XbppK8TI1ogj8+a98zQBXY/4zO+s
 TIi92CHR4899HgdKqSJw5sU+cFDpYDp5KGp3oERoz1qmReYjN+U6hx62apAen1GcT1J6
 GWvNAkJobbIA0BGNoJKL14JK05J1acGxRSVe9No/PaSUNEU66swMnp28kJSxKCQwaV9o
 3s2iomeaD4C2O3xNroxKzC2EM3hoKjbzLa1ShJPQNf1v4cLg7L5AAT01FgMdgcCswV0u
 PNb7ZqDkQE/yZzn1wyUKxbLW+ME7R0a+8990lGCdmm/sQerEf/Yedh1rmUOySK1MTvMf
 0zYg==
X-Gm-Message-State: AOJu0YzgO7GGewAhtMqq9QuKUyh8zj77/OMYwUoSpqy8TcHry+Wgrg7C
 ke4MPK/fafBmZRo4zLP92zWvrg==
X-Google-Smtp-Source: AGHT+IG4i9gvFB1Kb39//ncUErSXxJS6DQAL5uAQD9+5KHQW6uiN621IMQizvxJ3ZkCy2vmwklGJXQ==
X-Received: by 2002:a2e:860b:0:b0:2c5:2445:36af with SMTP id
 a11-20020a2e860b000000b002c5244536afmr9279166lji.50.1698740178600; 
 Tue, 31 Oct 2023 01:16:18 -0700 (PDT)
Received: from [192.168.69.115] (gjh33-h01-176-171-208-14.dsl.sta.abo.bbox.fr.
 [176.171.208.14]) by smtp.gmail.com with ESMTPSA id
 w2-20020a05600c098200b004063d8b43e7sm995876wmp.48.2023.10.31.01.16.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 01:16:18 -0700 (PDT)
Message-ID: <9a82b139-cfd7-ca1c-a651-8626775702b7@linaro.org>
Date: Tue, 31 Oct 2023 09:16:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 5/6] hw/input/stellaris_input: Convert to qdev
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20231030114802.3671871-1-peter.maydell@linaro.org>
 <20231030114802.3671871-6-peter.maydell@linaro.org>
 <edf24aec-59cf-d594-7bda-cef3c268a835@linaro.org>
 <87jzr4p4qp.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <87jzr4p4qp.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.441,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 30/10/23 15:25, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Hi Peter,
>>
>> Cc'ing Markus for QObject.
>>
>> On 30/10/23 12:48, Peter Maydell wrote:
>>> Convert the hw/input/stellaris_input device to qdev.
>>> The interface uses an array property for the board to specify the
>>> keycodes to use, so the s->keycodes memory is now allocated by the
>>> array-property machinery.
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> v1->v2: drop private/public comment lines
>>> ---
>>>    include/hw/input/stellaris_gamepad.h | 22 ++++++++-
>>>    hw/arm/stellaris.c                   | 26 +++++++---
>>>    hw/input/stellaris_gamepad.c         | 73 +++++++++++++++++++---------
>>>    3 files changed, 89 insertions(+), 32 deletions(-)
>>
>>
>>> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
>>> index 96585dd7106..707b0dae375 100644
>>> --- a/hw/arm/stellaris.c
>>> +++ b/hw/arm/stellaris.c
>>> @@ -31,6 +31,7 @@
>>>    #include "hw/timer/stellaris-gptm.h"
>>>    #include "hw/qdev-clock.h"
>>>    #include "qom/object.h"
>>> +#include "qapi/qmp/qlist.h"
>>>      #define GPIO_A 0
>>>    #define GPIO_B 1
>>> @@ -1274,16 +1275,27 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
>>>            sysbus_connect_irq(SYS_BUS_DEVICE(enet), 0, qdev_get_gpio_in(nvic, 42));
>>>        }
>>>        if (board->peripherals & BP_GAMEPAD) {
>>> -        qemu_irq gpad_irq[5];
>>> +        QList *gpad_keycode_list = qlist_new();
>>
>> I'm trying to understand better qlist_new(), but unfortunately there
>> is not much documentation. Looking at how the allocated list was
>> released, I found use of g_autoptr in tests/unit/check-qobject.c,
>> so I tried:
>>
>>             g_autoptr(QList) gpad_keycode_list = qlist_new();
> 
> QObject and its subtypes QDict, QList, QString, ... are reference
> counted.  qFOO_new() ist to be paired with qFOO_unref() or
> qobject_unref().
> 
> Your use of g_autoptr(QList) should work.

Peter figured qdev_prop_set_array() takes the ownership, so using
g_autoptr triggers a double-free:

https://lore.kernel.org/qemu-devel/CAFEAcA_GC8ypM2Y94KCU9Q_dntF6Na+igu-+0JZJ+MvPFE_HcA@mail.gmail.com/


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A047DBFDE
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 19:29:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxWzr-0006h6-24; Mon, 30 Oct 2023 14:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxWzm-0006gZ-1I
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 14:28:14 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxWzj-0001NX-0q
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 14:28:13 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-53f9af41444so8173173a12.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698690487; x=1699295287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZbVJptA73rinQ3TnnRVHH3B/3kz/6nIhTodR+OpCe/8=;
 b=sYNhYAfHasO9r0bdTvHvD+lU2uPWr4SOCmmafwfbq5A1CvFy7fGiZf84w78mTUdV6s
 A4THaRiSkEdAiHR7DRZLtL4mUbvjqr0P08fhDGenBgbSRb6PK29AIx7NKrss6f0eEh2/
 1f4AOP8gzzs340vn6ZYDctMkNX6ZCruf+C50xvwuyzqqa+VWkA7GnqeW0qjWCCT+BGXs
 bHQ2dz6fq6jvbxa64Fu4yU7V7+U2a0L6yjyNcF5VW2eyB6qcbuOtS/T3G1lO873yg3Ct
 QRx/+Nojq3joo28vDvl3POTPzgnB0h+dtmVH/xXyUiu8UJiw0pKz5hEhFqeCJgKMW7rB
 +POw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698690487; x=1699295287;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZbVJptA73rinQ3TnnRVHH3B/3kz/6nIhTodR+OpCe/8=;
 b=DxcJlnzoIZik5iPtJb1OiJANjaUegHz6zBE0V//BJVK6eBkU5yzgVgeyKnwJHnna5s
 VLQ81S86j1KfZRUqSVpzVunvfmSPyzbSdQLItvwB2o4UYU7JTqjFt2z+efIn+VXZ4PTV
 W/8pLMIesi8NeU2v82fKDLcHLPuPgUTQbZYJebJ7/2/ByUa6DJBzkBbXHCoCpG8GrTTU
 Elo7Trl+NwLRmVUvkSA/uLjJ1iTfmuEG7w3h5v0S6ybTtgZzuwY5/Yyo+UfmlcI1a5IA
 gE+4VVAYKy2qHXAEge7tMHmNzFTNf1EDPNmNlsEXa+Yj2cJfE7SvSs74SmkUJhgzIfDE
 Zoyw==
X-Gm-Message-State: AOJu0YwDb2tDDj4jG3COqClcRk9RLk54qisRCfXA7a45Ghtr5sHjxi+5
 2bc+fMogYQ4HnF02WRGUaDj2dQ==
X-Google-Smtp-Source: AGHT+IH1FqrCdmxnHz0p5K9LHvkHvORHgF4MtFUjf11N9b21r0/CXzvPs+OwKqvHtS+Tcqxr2XFbXQ==
X-Received: by 2002:a50:cdc2:0:b0:543:57a8:a470 with SMTP id
 h2-20020a50cdc2000000b0054357a8a470mr992428edj.19.1698690487231; 
 Mon, 30 Oct 2023 11:28:07 -0700 (PDT)
Received: from [192.168.69.115] ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 t25-20020a50d719000000b0052ffc2e82f1sm6666910edi.4.2023.10.30.11.28.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 11:28:06 -0700 (PDT)
Message-ID: <6b8b7608-208e-722b-97a3-8ee346fe7c76@linaro.org>
Date: Mon, 30 Oct 2023 19:28:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 5/6] hw/input/stellaris_input: Convert to qdev
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20231030114802.3671871-1-peter.maydell@linaro.org>
 <20231030114802.3671871-6-peter.maydell@linaro.org>
 <edf24aec-59cf-d594-7bda-cef3c268a835@linaro.org>
 <CAFEAcA_GC8ypM2Y94KCU9Q_dntF6Na+igu-+0JZJ+MvPFE_HcA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_GC8ypM2Y94KCU9Q_dntF6Na+igu-+0JZJ+MvPFE_HcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.441,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 30/10/23 15:41, Peter Maydell wrote:
> On Mon, 30 Oct 2023 at 13:52, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Peter,
>>
>> Cc'ing Markus for QObject.
>>
>> On 30/10/23 12:48, Peter Maydell wrote:
>>> Convert the hw/input/stellaris_input device to qdev.
>>>
>>> The interface uses an array property for the board to specify the
>>> keycodes to use, so the s->keycodes memory is now allocated by the
>>> array-property machinery.
>>>
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
>>>
>>>    #define GPIO_A 0
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
>>              g_autoptr(QList) gpad_keycode_list = qlist_new();
> 
> The API for qdev_prop_set_array() documents that it takes ownership
> of the list you pass it (and it ends up calling qobject_unref() on it).
> So I think adding g_autoptr() here will result in the memory being
> double-freed (once inside qobject_unref() when the refcount
> goes to 0, and once when g_autoptr frees it as it goes out of scope)...

Ah, I missed how qdev_prop_set_array() is involved.

>> * thread #2, stop reason = signal SIGABRT
>>     * frame #0: 0x8b1eb11c libsystem_kernel.dylib`__pthread_kill + 8
>>       frame #1: 0x8b222cc0 libsystem_pthread.dylib`pthread_kill + 288
>>       frame #2: 0x8b132a50 libsystem_c.dylib`abort + 180
>>       frame #3: 0x8b049b08 libsystem_malloc.dylib`malloc_vreport + 908
>>       frame #4: 0x8b06924c libsystem_malloc.dylib`malloc_zone_error + 104
>>       frame #5: 0x8b05b094
>> libsystem_malloc.dylib`nanov2_guard_corruption_detected + 44
>>       frame #6: 0x8b05a2a8
>> libsystem_malloc.dylib`nanov2_allocate_outlined + 404
>>       frame #7: 0x0201fdc0 libglib-2.0.0.dylib`g_malloc0 + 36
>>       frame #8: 0x02007718 libglib-2.0.0.dylib`g_hash_table_setup_storage
>> + 76
>>       frame #9: 0x020076b0 libglib-2.0.0.dylib`g_hash_table_new_full + 96
> 
> ...which is probably why a later memory operation runs into a
> malloc data corruption assertion.

Yes, this is certainly the reason. Thanks for the explanation!

Phil.



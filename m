Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C042717872
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 09:40:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4GQo-0005fq-62; Wed, 31 May 2023 03:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4GQk-0005fO-Tm
 for qemu-devel@nongnu.org; Wed, 31 May 2023 03:39:39 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4GQj-0008B7-49
 for qemu-devel@nongnu.org; Wed, 31 May 2023 03:39:38 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f6d3f83d0cso57344875e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 00:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685518774; x=1688110774;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VfI7uFPwssBLXE12qhBQRZBisDlkfu+WyG0nQatXIG0=;
 b=J9murRE94kkAB9nnCI0n0Yh6Jr3zV6w+0czSzJ+Cwz/6nKnpzT9KIKx3+70Kb0veAk
 4eDwHheI7HEuQHEn6EZwuZ7A8RDPbIdC/yS4Zr5ju4kA5dsSkVg5Ju7CeDPipStX4p+y
 c0ekL6oayxAbAkZQLwj00fJ/e6599lDEAJrzQi3IQh9cYSh/Wv+ls8vYRMBFo+h+w+Mr
 pgqDG8UR2U4+QX6vYYeykEo5ZNK59PPEex7N8EPxvGBGRmz3k4lqc5wXVd/ZBO2WqRJf
 /7ROBaROD0Whk3LzZKy95TGlEU+Xk3Qn06W+9w/aTsj0jwRMm63hviSf2olW+03W2f4Z
 rSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685518774; x=1688110774;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VfI7uFPwssBLXE12qhBQRZBisDlkfu+WyG0nQatXIG0=;
 b=QyKe6kRkQ7H1/WMmsVQnzsgZYLD0zKqOr6gh9iS96z0JzBfnnvpAEGsj1Pk1JNtUh9
 VSXr2HNxlyKIgkm9LvYJag9w/PTFFr+uJK9GEy8HVEdm78gswvQbzexhvig7vl7wUfWf
 eP44WNQULT+h3ULiLpUgWyK3mFdyQtdBdjzeYSl3BgLAWpcMP5B+rzmRO9b+enfxS9CD
 kMHuPufwS0ClgRO8PQUAtk92kI77iwmdaBxpmaNM834Sk1Pejjm+Jyr+1jKFVaGtYZvh
 ui6HpWryiw/rcPMxJSM1Jz35AZTRk/4njDkNbWV/eFCrJZx/DVMqh0EoRKLDplShp7R8
 UVeA==
X-Gm-Message-State: AC+VfDyqeVE0H9ENnR4YimS1CjMhjilBT5AthwYAZP1E/WTuDb/g7pWy
 3MRLIHFU8Qnl2V6Xlq0qf2sgog==
X-Google-Smtp-Source: ACHHUZ6oOpdO1Us94RqdBIsr8u2+UvGeFCYxuGGI0rLLnSuVDTE471XGtaLgxjpOkqrDegGJoUvxsw==
X-Received: by 2002:a7b:c442:0:b0:3f6:4c4:d0ce with SMTP id
 l2-20020a7bc442000000b003f604c4d0cemr3543940wmi.8.1685518774421; 
 Wed, 31 May 2023 00:39:34 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 x4-20020a05600c21c400b003f0aefcc457sm23466290wmj.45.2023.05.31.00.39.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 00:39:34 -0700 (PDT)
Message-ID: <36c9bda8-3af2-ebf5-f8b9-599cafea0735@linaro.org>
Date: Wed, 31 May 2023 09:39:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 05/12] hw/ssi: Introduce a ssi_get_cs() helper
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20230508075859.3326566-1-clg@kaod.org>
 <20230508075859.3326566-6-clg@kaod.org>
 <40c8647d-201e-3ceb-97ca-ec98bdc84e88@linaro.org>
 <0d11b78e-56f7-553a-3e85-0edef9b649ac@linaro.org>
 <523179dd-7842-7f03-14d6-678ed680a017@kaod.org>
 <6bfba08e-ce3e-539b-952d-697c8791fab2@linaro.org>
 <54d781f8-35d0-9e68-c2ec-743dd8f6a88e@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <54d781f8-35d0-9e68-c2ec-743dd8f6a88e@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 31/5/23 08:36, Cédric Le Goater wrote:
> On 5/31/23 08:17, Philippe Mathieu-Daudé wrote:
>> +QOM tinkerers
>>
>> On 31/5/23 07:59, Cédric Le Goater wrote:
>>> On 5/30/23 23:15, Philippe Mathieu-Daudé wrote:
>>>> On 30/5/23 22:34, Philippe Mathieu-Daudé wrote:
>>>>> On 8/5/23 09:58, Cédric Le Goater wrote:
>>>>>> Simple routine to retrieve a DeviceState object on a SPI bus using 
>>>>>> its
>>>>>> address/cs. It will be useful for the board to wire the CS lines.
>>>>>>
>>>>>> Cc: Alistair Francis <alistair@alistair23.me>
>>>>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>>>>> ---
>>>>>>   include/hw/ssi/ssi.h |  2 ++
>>>>>>   hw/ssi/ssi.c         | 15 +++++++++++++++
>>>>>>   2 files changed, 17 insertions(+)
>>>>>>
>>>>>> diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
>>>>>> index ffd3a34ba4..c7beabdb09 100644
>>>>>> --- a/include/hw/ssi/ssi.h
>>>>>> +++ b/include/hw/ssi/ssi.h
>>>>>> @@ -112,4 +112,6 @@ SSIBus *ssi_create_bus(DeviceState *parent, 
>>>>>> const char *name);
>>>>>>   uint32_t ssi_transfer(SSIBus *bus, uint32_t val);
>>>>>> +DeviceState *ssi_get_cs(SSIBus *bus, int addr);
>>>>
>>>> Also, this helper should (preferably) return a SSIPeripheral type.
>>>
>>> Well, having a DeviceState is handy for the callers (today) and
>>> ssi_create_peripheral() returns a DeviceState. Let's keep it that
>>> way.
>>
>> Yes I know it is handy :) I'm not against your patch; besides other
>> APIs do that. I'm wondering about QOM design here. Having Foo device,
>> should FOO API return the common qdev abstract type (DeviceState) or
>> a Foo type? Either ways we keep QOM-casting around, but I still tend
>> to consider FOO API returning Foo pointer provides some type check
>> safety, and also provides the API user hints about what is used.
>> Need more coffee.
> 
> It is used in two code paths today:
> 
>      ...
>          DeviceState *dev = ssi_get_cs(bmc->soc.fmc.spi, 0);
>          BlockBackend *fmc0 = dev ? m25p80_get_blk(dev) : NULL;
>      ...
> and
>      ...
>          DeviceState *dev = ssi_get_cs(s->spi, i);
>          if (dev) {
>              qemu_irq cs_line = qdev_get_gpio_in_named(dev, SSI_GPIO_CS, 
> 0);
>      ...
> 
> 
> Changing the interface is not a radical change, it will add two QOM-casts.
> I can give it a try in v2.

Hold on, lets see what others think first.


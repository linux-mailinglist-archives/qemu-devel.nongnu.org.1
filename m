Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 951BB7199E9
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 12:35:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4fdY-0007L2-7n; Thu, 01 Jun 2023 06:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4fdV-0007KA-Nm
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 06:34:29 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4fdT-0006RX-5A
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 06:34:29 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f6a6b9c079so6734125e9.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 03:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685615663; x=1688207663;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IzSdooUfPpfNOZEPCgWdZLTS54PXAKR1AaFq3KhI2/A=;
 b=c0MgPJbxwqbpDAcwgFTUsvr8VRX2vyiw2yZi3A/Qd1YJ2SQ3mr2gEXIhuHWOsHy3/m
 ukD/3HOpc0DJZAGMOneGawc6rGvQRkv6FnO8RjiOLYEsxCNpbGhdO88o9qV62bkYDdso
 IrAoA/SME2nk89wvDZu3hyjLud2nDTk9vmzjuokvBH229wds5fGREoKkVVD/ZDfsBt7w
 Gt6daoJhAnNkZXGRymPgJRZKoJ+aRQzzTDndh5i2M1sC3VRDNd++o5vLOoRoyzMDQHRf
 OAXP6wz7HNh+KBf3UiCdjdnmNgzjifALHpqlpS1Yp0e3+ZoIyne1f1/UzaNzVPElHsVZ
 XnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685615663; x=1688207663;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IzSdooUfPpfNOZEPCgWdZLTS54PXAKR1AaFq3KhI2/A=;
 b=cQoE/Ww7RKi1XgGzk6BbLOaUZCP8TC/+MogskLxgTf5sfCA17SDwKQacYjBM6DElCY
 Pa6xd++OAkVwWQ66lj9mEGHzLdqZzM+0SRW/+w9vetSQwmmAV+jQovFBhOx7sM9usb2u
 Rj34FbyJjAB0Rw4pGhoeKbt0kz3HsLIIO22fkXlmgri5QiirjABiETDHU+lM0L2lpEEz
 /Ibz+GDjjMqNHiQQjVbVAHni7JRKXPrv/0GAcBXas6G/TTsO4FKQ3LGk0lXbZg3PL5wE
 OJkDwU0GjEBzvSUphNOZxpDCyiqrKG1JRJk/X52co3WdmQ6kEz8oNOpkr5ICPz4ep9Hz
 nKmA==
X-Gm-Message-State: AC+VfDzJBcIEGjE9RLakLReKSnu5iLhGnk9j13vI9O8BvAbNJMtfYv1e
 RbjLr5Omiofw0SVjLxJolkEvxg==
X-Google-Smtp-Source: ACHHUZ5pmxVPQNDRaFzyGnwwIGFU3WUGvZfq2SDdpjV4YwIgujWivHTOGoMFHbfrpFfNOit9rqw+Xw==
X-Received: by 2002:a05:600c:22d4:b0:3f6:552:8722 with SMTP id
 20-20020a05600c22d400b003f605528722mr1621956wmg.18.1685615663265; 
 Thu, 01 Jun 2023 03:34:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.141.224])
 by smtp.gmail.com with ESMTPSA id
 s16-20020adfeb10000000b0030630120e56sm9825231wrn.57.2023.06.01.03.34.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 03:34:22 -0700 (PDT)
Message-ID: <de455326-5fee-db23-07c5-40941c1ccc8a@linaro.org>
Date: Thu, 1 Jun 2023 12:34:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 7/7] hw: Simplify using sysbus_init_irqs() [manual]
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20230601094625.39569-1-philmd@linaro.org>
 <20230601094625.39569-8-philmd@linaro.org>
 <CAFEAcA8wgaEJd03G8gNtFOUFT0jpm=KLfaZSjeYcOgvTYdvhJQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8wgaEJd03G8gNtFOUFT0jpm=KLfaZSjeYcOgvTYdvhJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/6/23 12:19, Peter Maydell wrote:
> On Thu, 1 Jun 2023 at 10:48, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Audit the sysbus_init_irq() calls and manually convert
>> to sysbus_init_irqs() when a loop is involved.
>>
>> In omap2_intc_init(), the parent_intr[] array contains
>> 2 elements: use ARRAY_SIZE() to iterate over.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
>> index c15f654738..dd2929d6e7 100644
>> --- a/hw/timer/renesas_tmr.c
>> +++ b/hw/timer/renesas_tmr.c
>> @@ -428,17 +428,14 @@ static void rtmr_init(Object *obj)
>>   {
>>       SysBusDevice *d = SYS_BUS_DEVICE(obj);
>>       RTMRState *tmr = RTMR(obj);
>> -    int i;
>>
>>       memory_region_init_io(&tmr->memory, OBJECT(tmr), &tmr_ops,
>>                             tmr, "renesas-tmr", 0x10);
>>       sysbus_init_mmio(d, &tmr->memory);
>>
>> -    for (i = 0; i < ARRAY_SIZE(tmr->ovi); i++) {
>> -        sysbus_init_irq(d, &tmr->cmia[i]);
>> -        sysbus_init_irq(d, &tmr->cmib[i]);
>> -        sysbus_init_irq(d, &tmr->ovi[i]);
>> -    }
>> +    sysbus_init_irqs(d, tmr->cmia, ARRAY_SIZE(tmr->cmia));
>> +    sysbus_init_irqs(d, tmr->cmib, ARRAY_SIZE(tmr->cmib));
>> +    sysbus_init_irqs(d, tmr->ovi, ARRAY_SIZE(tmr->ovi));
> 
> Doesn't this change the order of the IRQs? Previously
> we had channel 0 CMIA, channel 0 CMIA, channel 0 OVI,
> channel 1 CMIA, channel 1 CMIB, channel 1 OVI. Now
> we have channel 0 CMIA, channel 1 CMIA, channel 0 CMIB,
> channel 1 CMIB, channel 0 OVI, channel 1 OVI. So they'll
> get miswired in the board code now...

Oops, good catch. Good case to show the sysbus_init_irq() is
fragile. At least named_gpio are clearer.

I'm surprised because v1 series passed CI, but looking closer
the RX tests isn't run. And now I see commit e5d402b28f
("tests/acceptance: disable machine_rx_gdbsim on GitLab").

"Hopefully we can re-enable both
     once the serial timing patches have been added."

Alex, are these patches in the tree now?


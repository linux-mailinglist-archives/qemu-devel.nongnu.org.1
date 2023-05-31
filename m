Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEAA7178E1
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 09:51:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Gbf-0001uK-4a; Wed, 31 May 2023 03:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4Gbc-0001tw-6V
 for qemu-devel@nongnu.org; Wed, 31 May 2023 03:50:52 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4GbZ-0002Rp-Dq
 for qemu-devel@nongnu.org; Wed, 31 May 2023 03:50:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f60e730bf2so55917355e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 00:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685519447; x=1688111447;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XUdmigm9FpSN975aUBDxDCqv4/IzfntJba5UWOk/FLk=;
 b=I+DMpKDmSpEw7vby8mQz/93/ePaxEUGtvePWnNn8PduN78MDfQ0t7KTpVF6zf3p5CC
 g3X8wr7xbUjNBWuKTv4pDVYgTeptiQ05Izna0OgpQyg6rjbeS3DkGoiSt2Toi0PRj6R9
 R0LPJ0pwhpYzy44uC6ERjM6qZqag663gy5CTfGauz0E3bIA3/mQ9ho5CBpUMmMSkj3OI
 J6KzeQg+UYyKwrS94JpCDUMRCmuHfonpdO6HuxF933Eqgjqxzdarr+1ZyHyMAMMPvU9m
 7KC8oE8rmbMB76dE4HzmvTYzHRCvmwq9u0DodkuDtQVAjgWSC+0Eb02T8DhfrUU2EhW5
 ph2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685519447; x=1688111447;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XUdmigm9FpSN975aUBDxDCqv4/IzfntJba5UWOk/FLk=;
 b=PE91ZDBR3q5AVmaMF/Kg3X2KgtaoSro0KJte/FZk40DjytcMi+fpng8SHkFJKFiWE9
 L2wtLaM49KMkp+AtaoRGgk/OcVqTEok6oR6Eb/RaLCTkGQKTX27HxmEzm28p0W8EQ3xf
 q0NKalYMB9XP3ijEc8TmF4kzU8vFDLuihzp8aK7ra08bqRS6+27se+XoVaTnJ/4awQp/
 62wL9ZW4Jjy5GQWcZ7e8HVPBCDBIUplaqW6OGOsbsP5yAwgTuBiFeWBHJjxDsCCqDKsK
 p6lHI7FPkQQql6AdOX4LkBApPfcPkLKhrwbf57Va5agMc+0hYv6npYMN8p+6f7xU2k4H
 BM0g==
X-Gm-Message-State: AC+VfDwZ0UZ/O1j6YXizE2YEkpFnSNKRekhgAAaWffrxcauDjpDr47Y2
 ugAuAD1DsN+amfIU4MwMbaibTQ==
X-Google-Smtp-Source: ACHHUZ5MnXfSUW7k+10AnmM4lWi5rgndLzX4ekOXpLFq8CoQXxnNCrwpHXrpt/Qeun+EahO1gpDw6A==
X-Received: by 2002:a7b:ca54:0:b0:3f1:72ec:4009 with SMTP id
 m20-20020a7bca54000000b003f172ec4009mr4696564wml.9.1685519447539; 
 Wed, 31 May 2023 00:50:47 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a05600c219500b003f4fffccd73sm19900781wme.9.2023.05.31.00.50.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 00:50:47 -0700 (PDT)
Message-ID: <ab96deaf-ca3f-fd28-254e-1797eb69b88d@linaro.org>
Date: Wed, 31 May 2023 09:50:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 11/12] aspeed: Introduce a "uart" machine option
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Abhishek Singh Dagur <abhishek@drut.io>
References: <20230508075859.3326566-1-clg@kaod.org>
 <20230508075859.3326566-12-clg@kaod.org>
 <d0dedd1a-e2b7-5db9-d710-595e94b084a0@linaro.org>
 <aeb9f6a3-30e4-ce5d-c041-600a5097b27e@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <aeb9f6a3-30e4-ce5d-c041-600a5097b27e@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 31/5/23 08:28, Cédric Le Goater wrote:
> On 5/30/23 23:22, Philippe Mathieu-Daudé wrote:
>> On 8/5/23 09:58, Cédric Le Goater wrote:
>>> Most of the Aspeed machines use the UART5 device for the boot console,
>>> and QEMU connects the first serial Chardev to this SoC device for this
>>> purpose. See routine connect_serial_hds_to_uarts().
>>>
>>> Nevertheless, some machines use another boot console, such as the fuji,
>>> and commit 5d63d0c76c ("hw/arm/aspeed: Allow machine to set UART
>>> default") introduced a SoC class attribute 'uart_default' and property
>>> to be able to change the boot console device. It was later changed by
>>> commit d2b3eaefb4 ("aspeed: Refactor UART init for multi-SoC machines").
>>>
>>> The "uart" machine option goes a step further and lets the user define
>>> the UART device from the QEMU command line without introducing a new
>>> machine definition. For instance, to use device UART3 (mapped on
>>> /dev/ttyS2 under Linux) instead of the default UART5, one would use :
>>>
>>>    -M ast2500-evb,uart=uart3
>>>
>>> Cc: Abhishek Singh Dagur <abhishek@drut.io>
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> ---
>>>   docs/system/arm/aspeed.rst | 10 ++++++++++
>>>   hw/arm/aspeed.c            | 39 ++++++++++++++++++++++++++++++++++++--
>>>   2 files changed, 47 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
>>> index d4e293e7f9..e70f0aeea3 100644
>>> --- a/docs/system/arm/aspeed.rst
>>> +++ b/docs/system/arm/aspeed.rst
>>> @@ -122,6 +122,10 @@ Options specific to Aspeed machines are :
>>>    * ``spi-model`` to change the SPI Flash model.
>>> + * ``uart`` to change the default console device. Most of the machines
>>> +   use the ``UART5`` device for a boot console, which is mapped on
>>> +   ``/dev/ttyS4`` under Linux, but it is not always the case.
>>
>> This comment ...
>>
>>>   For instance, to start the ``ast2500-evb`` machine with a different
>>>   FMC chip and a bigger (64M) SPI chip, use :
>>> @@ -129,6 +133,12 @@ FMC chip and a bigger (64M) SPI chip, use :
>>>     -M ast2500-evb,fmc-model=mx25l25635e,spi-model=mx66u51235f
>>> +To change the boot console and use device ``UART3`` (``/dev/ttyS2``
>>> +under Linux), use :
>>
>> ... and this one suggest 'boot-console' could be a better name.
>>
>> Or 'boot-console-index'.
> 
> you might be right. people expect to find the console messages on
> this device. I will think about it.
> 
>>
>>> +.. code-block:: bash
>>> +
>>> +  -M ast2500-evb,uart=uart3
>>>   Aspeed minibmc family boards (``ast1030-evb``)
>>>   ==================================================================
>>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>>> index 3d5488faf7..6c32f674b9 100644
>>> --- a/hw/arm/aspeed.c
>>> +++ b/hw/arm/aspeed.c
>>> @@ -43,6 +43,7 @@ struct AspeedMachineState {
>>>       AspeedSoCState soc;
>>>       MemoryRegion boot_rom;
>>>       bool mmio_exec;
>>> +    uint32_t uart_chosen;
>>>       char *fmc_model;
>>>       char *spi_model;
>>>   };
>>> @@ -331,10 +332,11 @@ static void 
>>> connect_serial_hds_to_uarts(AspeedMachineState *bmc)
>>>       AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(bmc);
>>>       AspeedSoCState *s = &bmc->soc;
>>>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>>> +    int uart_chosen = bmc->uart_chosen ? bmc->uart_chosen : 
>>> amc->uart_default;
>>> -    aspeed_soc_uart_set_chr(s, amc->uart_default, serial_hd(0));
>>> +    aspeed_soc_uart_set_chr(s, uart_chosen, serial_hd(0));
>>>       for (int i = 1, uart = ASPEED_DEV_UART1; i < sc->uarts_num; 
>>> i++, uart++) {
>>> -        if (uart == amc->uart_default) {
>>> +        if (uart == uart_chosen) {
>>>               continue;
>>>           }
>>>           aspeed_soc_uart_set_chr(s, uart, serial_hd(i));
>>> @@ -1077,6 +1079,35 @@ static void aspeed_set_spi_model(Object *obj, 
>>> const char *value, Error **errp)
>>>       bmc->spi_model = g_strdup(value);
>>>   }
>>> +static char *aspeed_get_uart(Object *obj, Error **errp)
>>> +{
>>> +    AspeedMachineState *bmc = ASPEED_MACHINE(obj);
>>> +    AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(bmc);
>>> +    int uart_chosen = bmc->uart_chosen ? bmc->uart_chosen : 
>>> amc->uart_default;
>>> +
>>> +    return g_strdup_printf("uart%d", uart_chosen - ASPEED_DEV_UART1 
>>> + 1);
>>> +}
>>> +
>>> +static void aspeed_set_uart(Object *obj, const char *value, Error 
>>> **errp)
>>> +{
>>> +    AspeedMachineState *bmc = ASPEED_MACHINE(obj);
>>> +    AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(bmc);
>>> +    AspeedSoCClass *sc = 
>>> ASPEED_SOC_CLASS(object_class_by_name(amc->soc_name));
>>> +    int val;
>>> +
>>> +    if (sscanf(value, "uart%u", &val) != 1) {
>>> +        error_setg(errp, "Bad value for \"uart\" property");
>>
>> Why are you asking for a string and not an index?
> 
> because the literal name is what people find in the DT. See files
> arch/arm/boot/dts/aspeed-bmc-* under Linux.

OK. After looking at this file, I suppose people would expect
a "bmc-console" property name:

   -M ast2500-evb,bmc-console=uart3



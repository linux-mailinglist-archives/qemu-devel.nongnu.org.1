Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C6D7424CC
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 13:10:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEpWz-00017A-W1; Thu, 29 Jun 2023 07:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEpWv-00016m-1k
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 07:09:41 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEpWt-0004eU-8i
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 07:09:40 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4f8775126d3so834223e87.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 04:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688036976; x=1690628976;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gRcv+ZzcoX26ZXS1E7GP0WZ4GsluHrifbtcvwEDB2Bk=;
 b=FmPVsRoxwKrxGpGBekRXCuybm+A4HgBkaJ8VFU8I+h4zYtCNMLd058JcJGzgYGgT72
 jI6Oo17/Xo7QUJxZzmxlCzloKlKFhgFeRHP1jgbGE0XvLil2YI8NmgNL7Rf2DFPVoRmK
 ikR7g0XlgBWSqnpmsz9DbGDco0m0fSwdHW3aNhwNrqoq6tp9s4tOq+qWTCur9rCPq0td
 Qn9Yxkh9R/+sFdwk0Fqqo/nbnG+HInxRNGwndkM3aZtOTagmLyZVI4y7GL86f350N9b6
 BzWad+0Ham54juYynqpGvgJ6ZAfcG+7Rc7WJ6yWHPxko7vW/qoahQM83TWVZul5px/EZ
 +8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688036976; x=1690628976;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gRcv+ZzcoX26ZXS1E7GP0WZ4GsluHrifbtcvwEDB2Bk=;
 b=SBKMfBUvYbe82l38mO+clo8fXzJATmea0tRal6BaqfwZKJ7t2GxkEn5NE7yHzFbvSI
 VpT5ZozBcLI6tZn6m0wWP/VjgbLDGvZHOrRAdIVAQxPW1w54CldeUJUVn83wCpHtaFDI
 m4SjvP3wc+bTCoe3shg1KvnyzTDAyjzTfy+iMMaIv1EZ5mvvSNwW6a5olx49ST3RBbR/
 F9IJi/8sJJNO1vz+B3HiHqObOljyuR/0yubfKzhac4IjHF65zQy9hh2wJL4Xz6Yxz2l+
 rLSDBIG4Zaao0JGkiNwRjTlFkJHqhZI7QmwkE7YJZlrUoqgyijEXStMYS/9vlLBE0sZF
 Xqvg==
X-Gm-Message-State: AC+VfDwT71TipVdJp/gD7hjR1ti8bHZJJO1WBCRYSHMaKEiSEAkWumwg
 MzOCVRK4NTkyaHf0AZOXfCUjHw==
X-Google-Smtp-Source: ACHHUZ6dvqfogeirCUCRuPbMxS8+oUOhazMUTvJ0N/vQ3BquC19H7VnmJqSmxmv75NqSv8Ofcx6Q4g==
X-Received: by 2002:a05:6512:1094:b0:4f9:6965:4d61 with SMTP id
 j20-20020a056512109400b004f969654d61mr16072375lfg.42.1688036976341; 
 Thu, 29 Jun 2023 04:09:36 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 k10-20020a05600c1c8a00b003f9b3829269sm8976790wms.2.2023.06.29.04.09.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 04:09:35 -0700 (PDT)
Message-ID: <03d52281-22fb-5786-e321-71a47a198e19@linaro.org>
Date: Thu, 29 Jun 2023 13:09:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 05/12] hw/ssi: Introduce a ssi_get_cs() helper
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>
References: <20230607043943.1837186-1-clg@kaod.org>
 <20230607043943.1837186-6-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230607043943.1837186-6-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 7/6/23 06:39, Cédric Le Goater wrote:
> Simple routine to retrieve a DeviceState object on a SPI bus using its
> address/cs. It will be useful for the board to wire the CS lines.
> 
> Cc: Alistair Francis <alistair@alistair23.me>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   include/hw/ssi/ssi.h |  2 ++
>   hw/ssi/ssi.c         | 15 +++++++++++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
> index 9e0706a5248c..01662521b09a 100644
> --- a/include/hw/ssi/ssi.h
> +++ b/include/hw/ssi/ssi.h
> @@ -112,4 +112,6 @@ SSIBus *ssi_create_bus(DeviceState *parent, const char *name);
>   
>   uint32_t ssi_transfer(SSIBus *bus, uint32_t val);
>   
> +DeviceState *ssi_get_cs(SSIBus *bus, uint8_t addr);

Revisiting this patch, I now think this should be:

   qemu_irq ssi_get_cs(SSIBus *bus, uint8_t chipselect);


>   #endif
> diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
> index d4409535429c..7c71fce0db90 100644
> --- a/hw/ssi/ssi.c
> +++ b/hw/ssi/ssi.c
> @@ -27,6 +27,21 @@ struct SSIBus {
>   #define TYPE_SSI_BUS "SSI"
>   OBJECT_DECLARE_SIMPLE_TYPE(SSIBus, SSI_BUS)
>   
> +DeviceState *ssi_get_cs(SSIBus *bus, uint8_t addr)
> +{
> +    BusState *b = BUS(bus);
> +    BusChild *kid;
> +
> +    QTAILQ_FOREACH(kid, &b->children, sibling) {
> +        SSIPeripheral *kid_ssi = SSI_PERIPHERAL(kid->child);
> +        if (kid_ssi->addr == addr) {
> +            return kid->child;

and:

                return qdev_get_gpio_in_named(kid->child,
                                              SSI_GPIO_CS, 0);

> +        }
> +    }
> +
> +    return NULL;
> +}
> +
>   static const TypeInfo ssi_bus_info = {
>       .name = TYPE_SSI_BUS,
>       .parent = TYPE_BUS,



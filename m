Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9F17D7B84
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 06:34:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvs2p-0000C7-58; Thu, 26 Oct 2023 00:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1qvs2j-0000BO-2H; Thu, 26 Oct 2023 00:32:25 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1qvs2g-0007FK-59; Thu, 26 Oct 2023 00:32:24 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso72097766b.1; 
 Wed, 25 Oct 2023 21:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698294739; x=1698899539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=oQeLLJX1SNl3fiduP6mhol3eLmwp6WdGHayJ5XYZBfw=;
 b=CpeFUW9IFDcZzEMIqUfHq69YA2ri2OryEtCB/6brmpF5KI9G5prFtc1TN3i5+2Gs2b
 m4QTiHfnE3EVM04Gy+B0KFL/GqqB2cwt+7Y4Dddquk07myHs3dEUfuALruWObdJfOyrU
 Dbf0hCxuE7YOZxww9DmAAtCLk6SLGC1VNw3eJVs3Ol1BKSfjXjt7Xy1mukp03aiN7WKV
 Wz98aWo6gEhl0pL4Yk2/X5CMwz7bIojcSLjyi+pQWCr6AXnMkb4ZtfbeAHmUQlHkaxqT
 Gp0u9qQbfxRmWz7uwZOuJ5rVx9LbizWqfzhszkxRCErluknTUMKDpA2Tg8KEXq9nxII4
 YKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698294739; x=1698899539;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oQeLLJX1SNl3fiduP6mhol3eLmwp6WdGHayJ5XYZBfw=;
 b=TnAfLYIItmkK89tBZCo0qKpd408OHniVvZZD2cNDl6YUc62nfGR/NfMxJ5HqmrIfEK
 c1IZalXllt/nN5/E3O2YliP1AuZE6oa5GE68SPlELPbxoYI1ZVQNDThgrFp2ww8C+LLm
 ecoRpWj1HiKEWshanpHowIJl7YOamwcovz7YHLPCdqO5Joe3r9GArcn1Rl5gKMMuy9Ch
 ZgLS4H5SZNEY8ck+7EM151NCHBW3KeBlFm+4nstwtiohZq/LjOrbF6AtpgS7H3WeMkQo
 op3l8KTWOoOI7LovcnbYiSU0s77SHPEWvpNRqJVYb1G7uOV6xxRDeUInAj0EhxDRrK4O
 9QGA==
X-Gm-Message-State: AOJu0YzGBhqa9JsSBZeRc5fqmVgKDyKcOsF4A3NYdd6LXq5MdtQvrK0l
 nq0diwUF/X89QTJBGmC9h9cuL5ExwympcQ==
X-Google-Smtp-Source: AGHT+IGGr2ehydQ1fnWrSM7J0ndrgQz/HW87Yv1wYxh73Uz6fBji7E/KGfxVTNRVLQmRjIRyLWlS+A==
X-Received: by 2002:a17:907:7da7:b0:9a9:ef41:e5c7 with SMTP id
 oz39-20020a1709077da700b009a9ef41e5c7mr13271742ejc.8.1698294738902; 
 Wed, 25 Oct 2023 21:32:18 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-114-150.dsl.sta.abo.bbox.fr. [176.172.114.150])
 by smtp.gmail.com with ESMTPSA id
 ga23-20020a170906b85700b009b65b2be80bsm10869958ejb.76.2023.10.25.21.32.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 21:32:17 -0700 (PDT)
Message-ID: <fbc5f8a6-a5ae-c60e-272f-6c96d150308d@amsat.org>
Date: Thu, 26 Oct 2023 06:32:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/5] hw/arm: ast2600: Set AST2600_MAX_IRQ to value from
 datasheet
Content-Language: en-US
To: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org
Cc: clg@kaod.org, joel@jms.id.au, minyard@acm.org, ryan_chen@aspeedtech.com,
 qemu-devel@nongnu.org
References: <20210301010610.355702-1-andrew@aj.id.au>
 <20210301010610.355702-3-andrew@aj.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
In-Reply-To: <20210301010610.355702-3-andrew@aj.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-3.339,
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

Hi Andrew,

On 1/3/21 02:06, Andrew Jeffery wrote:
> The datasheet says we have 197 IRQs allocated, and we need more than 128
> to describe IRQs from LPC devices. Raise the value now to allow
> modelling of the LPC devices.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>   hw/arm/aspeed_ast2600.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index bc0eeb058b24..22fcb5b0edbe 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -65,7 +65,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
>   
>   #define ASPEED_A7MPCORE_ADDR 0x40460000
>   
> -#define AST2600_MAX_IRQ 128
> +#define AST2600_MAX_IRQ 197

Revisiting this patch (now commit b151de69f6), do we want 197 here or
197 - GIC_INTERNAL = 197 - 32 = 165?

Otherwise this ROUND line from commit 957ad79f73:

   ROUND_UP(AST2600_MAX_IRQ + GIC_INTERNAL, 32),

end requesting a GIC with 256 SPIs, but the A15MPCORE one is limited
to 224...

Hmm I see you name this as 'a7mpcore' but use the A15MPCORE...

     object_initialize_child(obj, "a7mpcore", &a->a7mpcore,
                             TYPE_A15MPCORE_PRIV);

Per [*], A7MPCORE indeed can have up to 480 SPIs.

Maybe we need to implement A7MPCORE along with A15MPCORE but
relaxing the GIC SPIs limit?

[*] 
https://developer.arm.com/documentation/ddi0464/f/Introduction/Configurable-options?lang=en

>   /* Shared Peripheral Interrupt values below are offset by -32 from datasheet */
>   static const int aspeed_soc_ast2600_irqmap[] = {



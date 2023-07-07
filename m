Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A2474ABBA
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 09:20:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHfkr-0003sz-I4; Fri, 07 Jul 2023 03:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHfkm-0003rQ-3F; Fri, 07 Jul 2023 03:19:44 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHfkj-0005wJ-Ca; Fri, 07 Jul 2023 03:19:43 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1b078b34df5so1587733fac.2; 
 Fri, 07 Jul 2023 00:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688714378; x=1691306378;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=djlhlMLFUCYNHJTzu9cUmLcInqc0Hn3qYDrDPlMZWao=;
 b=j0VXMBgPTHy0TjvL5AoPKhS0804pXcrii7vuKiC2qzww8dViHbfsG7xU4WBL+Q92L5
 UIMWX9FD6IKC69dF50FOa+5+uGfhCb0sZou4+LPILijCSuhALZppcUDs5aJVuJVrJO0z
 GDSD5ToTFUPI5e54ravvRPUqNj4VKFOOPZ78rdGRfcoWCaL6C+ax7D/mT9mjW2CMGiQO
 Pf0KIWlikgNNACMo5+YWMJ7GvOpw23nW8c310ArAOV3mpJ14XNddzvhxOJxRCU91GLOv
 Xsy6t4nXtPj/xHHNPknohf2ydDwOQb7Ls9+H/h4h8VHHIyOIzA7vZgI5nJTuC82q9U0o
 +/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688714378; x=1691306378;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=djlhlMLFUCYNHJTzu9cUmLcInqc0Hn3qYDrDPlMZWao=;
 b=In+RwfRoSSGkYiY+vbJepZIvQYnICKfpGJzXC5Nd3v/L5YOLil2Q9IVlniv6R+TjE6
 whmIa1skJ6wxOtL+i9tdA0CMjfxVY+qliNCwjbwnPNcUSnSuA4S0iQuEmUYWgdFejY6G
 wNCnjNEygdJhAjgD7wbxPAsNiEVcB3NODFPjXoMihmB4CpQMRkqwXFAgof0D+CdNVl9X
 +hmC2aR5qo3WCV7IOei+Vu9fPAgUO0KwfbmWVIpD6513qyjS0q4J91SsvaxDjCzYqTm4
 aMVR76VPDS4nji0ZPOfQWBdUDXae00UKHwRBc1RXEPeqbwiHO92vyfG0XTUxu8AgsIXz
 r2rQ==
X-Gm-Message-State: ABy/qLYhshMcxjaKFqZzTqpowZsp/l9Ev7JyiTcXU6i4wr6N/++/qnBc
 0sxwzhWYM6D+fkuzTsi/MO8=
X-Google-Smtp-Source: APBJJlF/Wqd1V5yvy0eodPGVELREu5deM1SJH0p7uMlfFrnTBOqZ4J7Gp4WWbWgDtV70GJx7R8gV7Q==
X-Received: by 2002:a05:6870:a706:b0:1b4:4a6c:ff56 with SMTP id
 g6-20020a056870a70600b001b44a6cff56mr2272268oam.14.1688714378492; 
 Fri, 07 Jul 2023 00:19:38 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-19.dial-up.telesp.net.br.
 [201.69.66.19]) by smtp.gmail.com with ESMTPSA id
 y82-20020a4a4555000000b005667b061eebsm643275ooa.13.2023.07.07.00.19.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 00:19:38 -0700 (PDT)
Message-ID: <f25113e7-b23d-ebd8-03c3-c5dc9db6e524@gmail.com>
Date: Fri, 7 Jul 2023 04:19:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ppc/pnv: Log all unimp warnings with similar message
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230706024528.40065-1-joel@jms.id.au>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230706024528.40065-1-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.091,
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

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

On 7/5/23 23:45, Joel Stanley wrote:
> Add the function name so there's an indication as to where the message
> is coming from. Change all prints to use the offset instead of the
> address.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> Happy to use the address instead of the offset (or print both), but I
> like the idea of being consistent.
> ---
>   hw/ppc/pnv_core.c | 34 ++++++++++++++++++----------------
>   1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index ffbc29cbf4f9..3eb95670d6a3 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -85,8 +85,8 @@ static uint64_t pnv_core_power8_xscom_read(void *opaque, hwaddr addr,
>           val = 0x24f000000000000ull;
>           break;
>       default:
> -        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
> -                  addr);
> +        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
> +                      offset);
>       }
>   
>       return val;
> @@ -95,8 +95,10 @@ static uint64_t pnv_core_power8_xscom_read(void *opaque, hwaddr addr,
>   static void pnv_core_power8_xscom_write(void *opaque, hwaddr addr, uint64_t val,
>                                           unsigned int width)
>   {
> -    qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=0x%" HWADDR_PRIx "\n",
> -                  addr);
> +    uint32_t offset = addr >> 3;
> +
> +    qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
> +                  offset);
>   }
>   
>   static const MemoryRegionOps pnv_core_power8_xscom_ops = {
> @@ -140,8 +142,8 @@ static uint64_t pnv_core_power9_xscom_read(void *opaque, hwaddr addr,
>           val = 0;
>           break;
>       default:
> -        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
> -                  addr);
> +        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
> +                      offset);
>       }
>   
>       return val;
> @@ -157,8 +159,8 @@ static void pnv_core_power9_xscom_write(void *opaque, hwaddr addr, uint64_t val,
>       case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR:
>           break;
>       default:
> -        qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=0x%" HWADDR_PRIx "\n",
> -                      addr);
> +        qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
> +                      offset);
>       }
>   }
>   
> @@ -189,8 +191,8 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
>           val = 0;
>           break;
>       default:
> -        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
> -                  addr);
> +        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
> +                      offset);
>       }
>   
>       return val;
> @@ -203,8 +205,8 @@ static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
>   
>       switch (offset) {
>       default:
> -        qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=0x%" HWADDR_PRIx "\n",
> -                      addr);
> +        qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
> +                      offset);
>       }
>   }
>   
> @@ -421,7 +423,7 @@ static uint64_t pnv_quad_power9_xscom_read(void *opaque, hwaddr addr,
>           val = 0;
>           break;
>       default:
> -        qemu_log_mask(LOG_UNIMP, "%s: reading @0x%08x\n", __func__,
> +        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
>                         offset);
>       }
>   
> @@ -438,7 +440,7 @@ static void pnv_quad_power9_xscom_write(void *opaque, hwaddr addr, uint64_t val,
>       case P9X_EX_NCU_SPEC_BAR + 0x400: /* Second EX */
>           break;
>       default:
> -        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
> +        qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
>                     offset);
>       }
>   }
> @@ -465,7 +467,7 @@ static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
>   
>       switch (offset) {
>       default:
> -        qemu_log_mask(LOG_UNIMP, "%s: reading @0x%08x\n", __func__,
> +        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
>                         offset);
>       }
>   
> @@ -479,7 +481,7 @@ static void pnv_quad_power10_xscom_write(void *opaque, hwaddr addr,
>   
>       switch (offset) {
>       default:
> -        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
> +        qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
>                         offset);
>       }
>   }


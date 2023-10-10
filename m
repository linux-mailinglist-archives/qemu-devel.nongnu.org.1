Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 119567C40F3
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 22:15:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqJ7w-0006UP-Js; Tue, 10 Oct 2023 16:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qqJ7u-0006U7-Ts
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 16:14:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qqJ7t-0000u2-AA
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 16:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696968884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sPI38s19oUjpwE/fbDuWRCBivxrw+UZUMx9j8jE/GwM=;
 b=IskcHtco7Gw72d8E14q1WF9ZAFcprjuJAWkff7hj2r3mFWewikUcT/HlgWxjxMdV/gZhAu
 QcusS2AgH4NHVjMbaP4pDEhRoS7aCh1Hm1ASlVZeyYIzZy1SYF1x6NcFy8jI5yJEeCFvTy
 IG0zR+U7LFSuhdxjcww6nur7M3LuMgw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-CoehdpHJO5yNb8uOMBTi-g-1; Tue, 10 Oct 2023 16:14:42 -0400
X-MC-Unique: CoehdpHJO5yNb8uOMBTi-g-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66d026cae6eso3375366d6.3
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 13:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696968882; x=1697573682;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sPI38s19oUjpwE/fbDuWRCBivxrw+UZUMx9j8jE/GwM=;
 b=aEIwnjKLuWVKRFgDYaAOWIkhhtGwhKlJsug2NhgCpJKHRyuNf63YUHJkdSvA5FJj4C
 /N3aSfjBLGfjXWVfmuEB2L8j+V70mP458HVcradSE20q9LI8CDVlWnlOWO0zHtmNJlJ2
 TRVQouDNmPY3WK3gOSOnCwfF6paotTqYyJdM9jZdahId7K9i8w2KteacnZXDjTX2N7+c
 uYaq0fWMquWLv7xUnDCUOMj9h5gjAVctjQQxQ5n+g+ULQ1uF1co3fzcdtt+HV2CtTb8Z
 yQXcElmBjCUXLZvPBbCQgn2albjysNGv22Vc3ZOTPk/+NO/r8cANEzo3QpP4vuBiB37M
 9Nsg==
X-Gm-Message-State: AOJu0YytbumyZ4KGrJmsqJ/Po2j7svFSpvlTu9ou64UNQovSM2dTWTod
 06sO3lI0HU1AaR+a1kaJZEgyIENS8xbaGzmATe2+aHM6P677HK8DeIBV0JQ6mwLxGhXZfTeOsC+
 3nonYl+F19k5s4OE=
X-Received: by 2002:a0c:e105:0:b0:658:8767:8d32 with SMTP id
 w5-20020a0ce105000000b0065887678d32mr21795632qvk.25.1696968882369; 
 Tue, 10 Oct 2023 13:14:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbDAQy2DRAgKLbllxgjBSTiOaTuIdaXnK8B2IA/bUtTAPhkjjbTV6pCJBC4wqdlyKSztBLJQ==
X-Received: by 2002:a0c:e105:0:b0:658:8767:8d32 with SMTP id
 w5-20020a0ce105000000b0065887678d32mr21795620qvk.25.1696968882119; 
 Tue, 10 Oct 2023 13:14:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 bu7-20020ad455e7000000b0066cf48df24dsm786915qvb.13.2023.10.10.13.14.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 13:14:41 -0700 (PDT)
Message-ID: <7c55e7b5-cff6-0f57-b3ff-9869a920f08a@redhat.com>
Date: Tue, 10 Oct 2023 22:14:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] ppc/pnv: Connect I2C controller model to powernv9 chip
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com
References: <20231010171951.4165180-1-milesg@linux.vnet.ibm.com>
 <20231010171951.4165180-3-milesg@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20231010171951.4165180-3-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 10/10/23 19:19, Glenn Miles wrote:
> From: Cédric Le Goater <clg@kaod.org>
> 
> Wires up three I2C controller instances to the powernv9 chip
> XSCOM address space.
> 
> Each controller instance is wired up to a single I2C bus of
> its own.  No other I2C devices are connected to the buses
> at this time.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> [milesg: Split wiring from addition of model itself]
> [milesg: Added new commit message]
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
>   hw/ppc/pnv.c              | 26 ++++++++++++++++++++++++++
>   include/hw/ppc/pnv_chip.h |  4 ++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index eb54f93986..32b6d9889d 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1438,6 +1438,10 @@ static void pnv_chip_power9_instance_init(Object *obj)
>           object_initialize_child(obj, "pec[*]", &chip9->pecs[i],
>                                   TYPE_PNV_PHB4_PEC);
>       }
> +
> +    for (i = 0; i < PNV9_CHIP_MAX_I2C; i++) {
> +        object_initialize_child(obj, "i2c[*]", &chip9->i2c[i], TYPE_PNV_I2C);
> +    }
>   }
>   
>   static void pnv_chip_quad_realize_one(PnvChip *chip, PnvQuad *eq,
> @@ -1510,6 +1514,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>       PnvChip *chip = PNV_CHIP(dev);
>       Pnv9Psi *psi9 = &chip9->psi;
>       Error *local_err = NULL;
> +    int i;
>   
>       /* XSCOM bridge is first */
>       pnv_xscom_realize(chip, PNV9_XSCOM_SIZE, &local_err);
> @@ -1613,6 +1618,27 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>           error_propagate(errp, local_err);
>           return;
>       }
> +
> +    /*
> +     * I2C
> +     * TODO: The number of busses is specific to each platform

Could the hardcoded values  used in the properties below be PnvChipClass
attributes instead ?

Thanks,

C.


> +     */
> +    for (i = 0; i < PNV9_CHIP_MAX_I2C; i++) {
> +        Object *obj =  OBJECT(&chip9->i2c[i]);
> +
> +        object_property_set_int(obj, "engine", i + 1, &error_fatal);
> +        object_property_set_int(obj, "num-busses", 1, &error_fatal);
> +        object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
> +        if (!qdev_realize(DEVICE(obj), NULL, errp)) {
> +            return;
> +        }
> +        pnv_xscom_add_subregion(chip, PNV9_XSCOM_I2CM_BASE +
> +                               chip9->i2c[i].engine * PNV9_XSCOM_I2CM_SIZE,
> +                                &chip9->i2c[i].xscom_regs);
> +        qdev_connect_gpio_out(DEVICE(&chip9->i2c[i]), 0,
> +                              qdev_get_gpio_in(DEVICE(&chip9->psi),
> +                                               PSIHB9_IRQ_SBE_I2C));
> +    }
>   }
>   
>   static uint32_t pnv_chip_power9_xscom_pcba(PnvChip *chip, uint64_t addr)
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 53e1d921d7..3bbe2783c9 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -9,6 +9,7 @@
>   #include "hw/ppc/pnv_psi.h"
>   #include "hw/ppc/pnv_sbe.h"
>   #include "hw/ppc/pnv_xive.h"
> +#include "hw/ppc/pnv_i2c.h"
>   #include "hw/sysbus.h"
>   
>   OBJECT_DECLARE_TYPE(PnvChip, PnvChipClass,
> @@ -86,6 +87,9 @@ struct Pnv9Chip {
>   
>   #define PNV9_CHIP_MAX_PEC 3
>       PnvPhb4PecState pecs[PNV9_CHIP_MAX_PEC];
> +
> +#define PNV9_CHIP_MAX_I2C 3
> +    PnvI2C      i2c[PNV9_CHIP_MAX_I2C];
>   };
>   
>   /*



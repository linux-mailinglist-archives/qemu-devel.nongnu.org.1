Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AC87E48CF
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:54:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0RDY-0006vz-NA; Tue, 07 Nov 2023 13:54:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0RDW-0006ll-0Z; Tue, 07 Nov 2023 13:54:26 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0RDU-0002hK-AR; Tue, 07 Nov 2023 13:54:25 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a7dd65052aso74042587b3.0; 
 Tue, 07 Nov 2023 10:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699383263; x=1699988063; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9ctKCWSPUD2rWT6q9NV9nkN//SnOlswoA8DqNFrX0dc=;
 b=I7zccLCvgtS0LIEryZJyKUlxd5L3i7BSR4+N3SQHT9CNU72XJQh+9EkpfpvTINQFC0
 gqLsqPYfjQIcGoHvtV8KxG6EkfYN4vouWLAG9ffD1OSRSq4ixrcralJn/3WrJng3XSPE
 qkqJXehxPNUdggeFDx52qZ827g0N/QS1vwJ9QeT+ewsrQrAPxrELnEGl3tJzBlEELEBu
 B4mfF3it4Tzk99mlHgPDG/7oPccbJvDItB6BU4FeSTH80IXF1WB64dRNx/fK/XBi0qRf
 pogfyVJoKSSSlPcOj5BOp3dFjaZBbbhta3F8vpUMxwm4De/W8QmP4h/Aj0ZWpHdOgQLw
 +MDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699383263; x=1699988063;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9ctKCWSPUD2rWT6q9NV9nkN//SnOlswoA8DqNFrX0dc=;
 b=ppYrAN41xLs1+th+Bg6PDhj/XTWFGbeVuuIE8RSmQoGeZiTW1RR27cBlZa4dcISvHh
 /fn4I1eRWLhW+rcRsqlJcnW6cfjsSUbwY+5ujAJLs1dbGBf3SFHRcdvSqIrhz5d7J5pc
 YBOq+3x/Bqw/149swgHpHpQ9WAAij+bLaVN0gBwASiQ5In9BJqX2zw5wUIO+KBGlTanb
 HtkgSvIflBp4uvYU3lEuXAsroKy8jOnp8S0CKZz8Y7dMI/tCWsd1NdNjN+YEUwPng7pK
 PkJxWcmBQlnXljgMAbTuRIKdJFu+gY1T2c27T+M+koB3gpM0InflPn4mSY0QV1om6YLP
 vKXQ==
X-Gm-Message-State: AOJu0YyXvCgMWSnsAzT9B6TxBCVcS+ed3xBUcP9XITYfMEJljgNccIdA
 X/0YIlp73dTi4nvTOl5TiRM=
X-Google-Smtp-Source: AGHT+IH4OSpxlI11IUzYA8Eqr/ABd0UDc/lg3EQwha2b2SFqrASsl5UWD2dNC1SfikoPPhy6xdCdiQ==
X-Received: by 2002:a05:6902:18d2:b0:da0:4032:18b6 with SMTP id
 ck18-20020a05690218d200b00da0403218b6mr38171604ybb.30.1699383262712; 
 Tue, 07 Nov 2023 10:54:22 -0800 (PST)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a259111000000b00d7b8a1074d4sm5286568ybl.57.2023.11.07.10.54.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 10:54:22 -0800 (PST)
Message-ID: <ad0c1dac-22a8-4ec6-b3b9-5b546739a732@gmail.com>
Date: Tue, 7 Nov 2023 15:54:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: Connect PNV I2C controller to powernv10
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com
References: <20231017221434.810363-1-milesg@linux.vnet.ibm.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20231017221434.810363-1-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=danielhb413@gmail.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On 10/17/23 19:14, Glenn Miles wrote:
> Wires up four I2C controller instances to the powernv10 chip
> XSCOM address space.
> 
> Each controller instance is wired up to two I2C buses of
> its own.  No other I2C devices are connected to the buses
> at this time.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
> Based-on: <20231016222013.3739530-1-milesg@linux.vnet.ibm.com>
> ([PATCH v3 0/2] Add PowerNV I2C Controller Model)
> 
>   hw/ppc/pnv.c               | 29 +++++++++++++++++++++++++++++
>   include/hw/ppc/pnv_chip.h  |  4 ++++
>   include/hw/ppc/pnv_xscom.h |  3 +++
>   3 files changed, 36 insertions(+)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index e0b3478325..2655b6e506 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1695,6 +1695,10 @@ static void pnv_chip_power10_instance_init(Object *obj)
>           object_initialize_child(obj, "pec[*]", &chip10->pecs[i],
>                                   TYPE_PNV_PHB5_PEC);
>       }
> +
> +    for (i = 0; i < pcc->i2c_num_engines; i++) {
> +        object_initialize_child(obj, "i2c[*]", &chip10->i2c[i], TYPE_PNV_I2C);
> +    }
>   }
>   
>   static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
> @@ -1753,6 +1757,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>       PnvChip *chip = PNV_CHIP(dev);
>       Pnv10Chip *chip10 = PNV10_CHIP(dev);
>       Error *local_err = NULL;
> +    int i;
>   
>       /* XSCOM bridge is first */
>       pnv_xscom_realize(chip, PNV10_XSCOM_SIZE, &local_err);
> @@ -1863,6 +1868,28 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>           error_propagate(errp, local_err);
>           return;
>       }
> +
> +
> +    /*
> +     * I2C
> +     */
> +    for (i = 0; i < pcc->i2c_num_engines; i++) {
> +        Object *obj =  OBJECT(&chip10->i2c[i]);
> +
> +        object_property_set_int(obj, "engine", i + 1, &error_fatal);
> +        object_property_set_int(obj, "num-busses", pcc->i2c_num_ports,
> +                                &error_fatal);
> +        object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
> +        if (!qdev_realize(DEVICE(obj), NULL, errp)) {
> +            return;
> +        }
> +        pnv_xscom_add_subregion(chip, PNV10_XSCOM_I2CM_BASE +
> +                                chip10->i2c[i].engine * PNV10_XSCOM_I2CM_SIZE,
> +                                &chip10->i2c[i].xscom_regs);
> +        qdev_connect_gpio_out(DEVICE(&chip10->i2c[i]), 0,
> +                              qdev_get_gpio_in(DEVICE(&chip10->psi),
> +                                               PSIHB9_IRQ_SBE_I2C));
> +    }
>   }
>   
>   static uint32_t pnv_chip_power10_xscom_pcba(PnvChip *chip, uint64_t addr)
> @@ -1890,6 +1917,8 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
>       k->xscom_pcba = pnv_chip_power10_xscom_pcba;
>       dc->desc = "PowerNV Chip POWER10";
>       k->num_pecs = PNV10_CHIP_MAX_PEC;
> +    k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
> +    k->i2c_num_ports = PNV10_CHIP_MAX_I2C_PORTS;
>   
>       device_class_set_parent_realize(dc, pnv_chip_power10_realize,
>                                       &k->parent_realize);
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 90cfbad1a5..5815d96ecf 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -120,6 +120,10 @@ struct Pnv10Chip {
>   
>   #define PNV10_CHIP_MAX_PEC 2
>       PnvPhb4PecState pecs[PNV10_CHIP_MAX_PEC];
> +
> +#define PNV10_CHIP_MAX_I2C 4
> +#define PNV10_CHIP_MAX_I2C_PORTS 2
> +    PnvI2C       i2c[PNV10_CHIP_MAX_I2C];
>   };
>   
>   #define PNV10_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index 0c8b873c4c..2b607b22c9 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -152,6 +152,9 @@ struct PnvXScomInterfaceClass {
>   #define PNV10_XSCOM_PSIHB_BASE     0x3011D00
>   #define PNV10_XSCOM_PSIHB_SIZE     0x100
>   
> +#define PNV10_XSCOM_I2CM_BASE      PNV9_XSCOM_I2CM_BASE
> +#define PNV10_XSCOM_I2CM_SIZE      PNV9_XSCOM_I2CM_SIZE
> +
>   #define PNV10_XSCOM_OCC_BASE       PNV9_XSCOM_OCC_BASE
>   #define PNV10_XSCOM_OCC_SIZE       PNV9_XSCOM_OCC_SIZE
>   


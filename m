Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2E57BEBD6
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 22:43:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpx67-0005AD-O3; Mon, 09 Oct 2023 16:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qpx62-00059k-PY
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 16:43:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qpx5y-0007zP-S5
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 16:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696884197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IBxnfvLuUyvuy98nxSl67Y8kTAp9qmdPYRAA3DmJakQ=;
 b=VTlCiEM0UUV3ozfsvRNX9mCTvWqOQy2EU9ZJ4xKicikjxTocuk2FcS71705lCelYuwY6hC
 wGhmhvwvCJWaYkKvBopPSXbdwm9tkluq/df+vrX8Zbm7y2rQsPC/Kne8mi4+Q6SXkBY18o
 WZNcoROHXYgFTI2+h5Xa0kgSy1Mvyso=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-6Cl6OCkiMee7_7K3kh1oMQ-1; Mon, 09 Oct 2023 16:42:55 -0400
X-MC-Unique: 6Cl6OCkiMee7_7K3kh1oMQ-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-5a507eb61a6so74736257b3.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 13:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696884175; x=1697488975;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IBxnfvLuUyvuy98nxSl67Y8kTAp9qmdPYRAA3DmJakQ=;
 b=Rz8p4CqUAW5wsmTPjhoLsPRm2COqXxikZR5SiJrgI78aQVZwmCK7GDhpE9MLS+495j
 T0/8HD99W6xaqxDSgRyuoB0nMeTJ/2V5KT5vUeHcOGmKljdQxXQuoqzX0zec36wBAU1e
 VvpoQiBa16ruWieHEyGrKehilBurYZ+IxmB+ApTUqdkIKp7dO4vtoT4GfZslUjLKB+TA
 gYxN/TIo1O60c+e/j05sbcTwAty2djlKL2Jcq3QT3nABvxkYjIWxpNuSQNcgBXfDAzff
 nKa9IXq038MBotmmjwgPs9tjD+HQYARtKjahJwTECEvCa6SV30241OcTQkcJn3w5geu/
 2s7A==
X-Gm-Message-State: AOJu0Yz35yCNesyFfXvEIwp1qdiw1NWt/y6eK7uaW5g2oVbl0AJHtDyR
 DqmwgNb1BAb/3ZqjhMvalgKoi8dq4GJ0uH+Igg7BFHjruooFpPc3l7zyA6YLy2VGYDDtwe87hjy
 hvjtYjATwH4vro4Q=
X-Received: by 2002:a25:abe8:0:b0:d78:98f:4aa1 with SMTP id
 v95-20020a25abe8000000b00d78098f4aa1mr15811147ybi.7.1696884174869; 
 Mon, 09 Oct 2023 13:42:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsXJEoI0X8VelHLt8jWRtjDzFi60172uTalfeowQ07Zz+Y1vz/JrV1/ZILWPDGLP5RLbMYaQ==
X-Received: by 2002:a25:abe8:0:b0:d78:98f:4aa1 with SMTP id
 v95-20020a25abe8000000b00d78098f4aa1mr15811133ybi.7.1696884174428; 
 Mon, 09 Oct 2023 13:42:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a0cdd12000000b0065b12c7a48dsm4125428qvk.133.2023.10.09.13.42.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 13:42:54 -0700 (PDT)
Message-ID: <b8c0d60c-fbce-3eb6-9bae-85034effec6a@redhat.com>
Date: Mon, 9 Oct 2023 22:42:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ppc/pnv: Add an I2C master controller model
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com
References: <20231009180539.2686698-1-milesg@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20231009180539.2686698-1-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hello Glenn,

On 10/9/23 20:05, Glenn Miles wrote:
> From: Cédric Le Goater <clg@kaod.org>
> 
> Not supported :
> 
>   . 10 bit addresses
>   . multimaster
>   . slave
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> [milesg: fixed formatting warning]


Overall it looks good ;)

Some suggestions for the respin :

* Please split the model implementation from the wiring in the board.
   Adding a cover letter would be nice.

* In the commit log, please add more details on the unit being modeled,
   how this I2C unit interacts with the rest of the machine, what is
   modeled, what is not, etc. A simple intro in short.

* Add a SPDX-License-Identifier tag in new files.

Thanks,

C.

PS: I am not getting your emails for some (corporate) reasons.


> ---
>   hw/ppc/meson.build         |   1 +
>   hw/ppc/pnv.c               |  26 ++
>   hw/ppc/pnv_i2c.c           | 678 +++++++++++++++++++++++++++++++++++++
>   include/hw/ppc/pnv_chip.h  |   4 +
>   include/hw/ppc/pnv_i2c.h   |  39 +++
>   include/hw/ppc/pnv_xscom.h |   3 +
>   6 files changed, 751 insertions(+)
>   create mode 100644 hw/ppc/pnv_i2c.c
>   create mode 100644 include/hw/ppc/pnv_i2c.h
> 
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index 7c2c52434a..87b756a701 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -43,6 +43,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
>     'pnv.c',
>     'pnv_xscom.c',
>     'pnv_core.c',
> +  'pnv_i2c.c',
>     'pnv_lpc.c',
>     'pnv_psi.c',
>     'pnv_occ.c',
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
> diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
> new file mode 100644
> index 0000000000..8c191912bf
> --- /dev/null
> +++ b/hw/ppc/pnv_i2c.c
> @@ -0,0 +1,678 @@
> +/*
> + * QEMU PowerPC PowerNV Processor I2C model
> + *
> + * Copyright (c) 2019-2021, IBM Corporation.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/module.h"
> +#include "qemu/log.h"
> +#include "sysemu/reset.h"
> +
> +#include "hw/irq.h"
> +#include "hw/qdev-properties.h"
> +
> +#include "hw/ppc/pnv.h"
> +#include "hw/ppc/pnv_chip.h"
> +#include "hw/ppc/pnv_i2c.h"
> +#include "hw/ppc/pnv_xscom.h"
> +#include "hw/ppc/fdt.h"
> +
> +#include <libfdt.h>
> +
> +/* I2C FIFO register */
> +#define I2C_FIFO_REG                    0x4
> +#define I2C_FIFO                        PPC_BITMASK(0, 7)
> +
> +/* I2C command register */
> +#define I2C_CMD_REG                     0x5
> +#define I2C_CMD_WITH_START              PPC_BIT(0)
> +#define I2C_CMD_WITH_ADDR               PPC_BIT(1)
> +#define I2C_CMD_READ_CONT               PPC_BIT(2)
> +#define I2C_CMD_WITH_STOP               PPC_BIT(3)
> +#define I2C_CMD_INTR_STEERING           PPC_BITMASK(6, 7) /* P9 */
> +#define   I2C_CMD_INTR_STEER_HOST       1
> +#define   I2C_CMD_INTR_STEER_OCC        2
> +#define I2C_CMD_DEV_ADDR                PPC_BITMASK(8, 14)
> +#define I2C_CMD_READ_NOT_WRITE          PPC_BIT(15)
> +#define I2C_CMD_LEN_BYTES               PPC_BITMASK(16, 31)
> +#define I2C_MAX_TFR_LEN                 0xfff0ull
> +
> +/* I2C mode register */
> +#define I2C_MODE_REG                    0x6
> +#define I2C_MODE_BIT_RATE_DIV           PPC_BITMASK(0, 15)
> +#define I2C_MODE_PORT_NUM               PPC_BITMASK(16, 21)
> +#define I2C_MODE_ENHANCED               PPC_BIT(28)
> +#define I2C_MODE_DIAGNOSTIC             PPC_BIT(29)
> +#define I2C_MODE_PACING_ALLOW           PPC_BIT(30)
> +#define I2C_MODE_WRAP                   PPC_BIT(31)
> +
> +/* I2C watermark register */
> +#define I2C_WATERMARK_REG               0x7
> +#define I2C_WATERMARK_HIGH              PPC_BITMASK(16, 19)
> +#define I2C_WATERMARK_LOW               PPC_BITMASK(24, 27)
> +
> +/*
> + * I2C interrupt mask and condition registers
> + *
> + * NB: The function of 0x9 and 0xa changes depending on whether you're reading
> + *     or writing to them. When read they return the interrupt condition bits
> + *     and on writes they update the interrupt mask register.
> + *
> + *  The bit definitions are the same for all the interrupt registers.
> + */
> +#define I2C_INTR_MASK_REG               0x8
> +
> +#define I2C_INTR_RAW_COND_REG           0x9 /* read */
> +#define I2C_INTR_MASK_OR_REG            0x9 /* write*/
> +
> +#define I2C_INTR_COND_REG               0xa /* read */
> +#define I2C_INTR_MASK_AND_REG           0xa /* write */
> +
> +#define I2C_INTR_ALL                    PPC_BITMASK(16, 31)
> +#define I2C_INTR_INVALID_CMD            PPC_BIT(16)
> +#define I2C_INTR_LBUS_PARITY_ERR        PPC_BIT(17)
> +#define I2C_INTR_BKEND_OVERRUN_ERR      PPC_BIT(18)
> +#define I2C_INTR_BKEND_ACCESS_ERR       PPC_BIT(19)
> +#define I2C_INTR_ARBT_LOST_ERR          PPC_BIT(20)
> +#define I2C_INTR_NACK_RCVD_ERR          PPC_BIT(21)
> +#define I2C_INTR_DATA_REQ               PPC_BIT(22)
> +#define I2C_INTR_CMD_COMP               PPC_BIT(23)
> +#define I2C_INTR_STOP_ERR               PPC_BIT(24)
> +#define I2C_INTR_I2C_BUSY               PPC_BIT(25)
> +#define I2C_INTR_NOT_I2C_BUSY           PPC_BIT(26)
> +#define I2C_INTR_SCL_EQ_1               PPC_BIT(28)
> +#define I2C_INTR_SCL_EQ_0               PPC_BIT(29)
> +#define I2C_INTR_SDA_EQ_1               PPC_BIT(30)
> +#define I2C_INTR_SDA_EQ_0               PPC_BIT(31)
> +
> +/* I2C status register */
> +#define I2C_RESET_I2C_REG               0xb /* write */
> +#define I2C_RESET_ERRORS                0xc
> +#define I2C_STAT_REG                    0xb /* read */
> +#define I2C_STAT_INVALID_CMD            PPC_BIT(0)
> +#define I2C_STAT_LBUS_PARITY_ERR        PPC_BIT(1)
> +#define I2C_STAT_BKEND_OVERRUN_ERR      PPC_BIT(2)
> +#define I2C_STAT_BKEND_ACCESS_ERR       PPC_BIT(3)
> +#define I2C_STAT_ARBT_LOST_ERR          PPC_BIT(4)
> +#define I2C_STAT_NACK_RCVD_ERR          PPC_BIT(5)
> +#define I2C_STAT_DATA_REQ               PPC_BIT(6)
> +#define I2C_STAT_CMD_COMP               PPC_BIT(7)
> +#define I2C_STAT_STOP_ERR               PPC_BIT(8)
> +#define I2C_STAT_UPPER_THRS             PPC_BITMASK(9, 15)
> +#define I2C_STAT_ANY_I2C_INTR           PPC_BIT(16)
> +#define I2C_STAT_PORT_HISTORY_BUSY      PPC_BIT(19)
> +#define I2C_STAT_SCL_INPUT_LEVEL        PPC_BIT(20)
> +#define I2C_STAT_SDA_INPUT_LEVEL        PPC_BIT(21)
> +#define I2C_STAT_PORT_BUSY              PPC_BIT(22)
> +#define I2C_STAT_INTERFACE_BUSY         PPC_BIT(23)
> +#define I2C_STAT_FIFO_ENTRY_COUNT       PPC_BITMASK(24, 31)
> +
> +#define I2C_STAT_ANY_ERR (I2C_STAT_INVALID_CMD | I2C_STAT_LBUS_PARITY_ERR | \
> +                          I2C_STAT_BKEND_OVERRUN_ERR | \
> +                          I2C_STAT_BKEND_ACCESS_ERR | I2C_STAT_ARBT_LOST_ERR | \
> +                          I2C_STAT_NACK_RCVD_ERR | I2C_STAT_STOP_ERR)
> +
> +
> +#define I2C_INTR_ACTIVE \
> +        ((I2C_STAT_ANY_ERR >> 16) | I2C_INTR_CMD_COMP | I2C_INTR_DATA_REQ)
> +
> +/* Pseudo-status used for timeouts */
> +#define I2C_STAT_PSEUDO_TIMEOUT         PPC_BIT(63)
> +
> +/* I2C extended status register */
> +#define I2C_EXTD_STAT_REG               0xc
> +#define I2C_EXTD_STAT_FIFO_SIZE         PPC_BITMASK(0, 7)
> +#define I2C_EXTD_STAT_MSM_CURSTATE      PPC_BITMASK(11, 15)
> +#define I2C_EXTD_STAT_SCL_IN_SYNC       PPC_BIT(16)
> +#define I2C_EXTD_STAT_SDA_IN_SYNC       PPC_BIT(17)
> +#define I2C_EXTD_STAT_S_SCL             PPC_BIT(18)
> +#define I2C_EXTD_STAT_S_SDA             PPC_BIT(19)
> +#define I2C_EXTD_STAT_M_SCL             PPC_BIT(20)
> +#define I2C_EXTD_STAT_M_SDA             PPC_BIT(21)
> +#define I2C_EXTD_STAT_HIGH_WATER        PPC_BIT(22)
> +#define I2C_EXTD_STAT_LOW_WATER         PPC_BIT(23)
> +#define I2C_EXTD_STAT_I2C_BUSY          PPC_BIT(24)
> +#define I2C_EXTD_STAT_SELF_BUSY         PPC_BIT(25)
> +#define I2C_EXTD_STAT_I2C_VERSION       PPC_BITMASK(27, 31)
> +
> +/* I2C residual front end/back end length */
> +#define I2C_RESIDUAL_LEN_REG            0xd
> +#define I2C_RESIDUAL_FRONT_END          PPC_BITMASK(0, 15)
> +#define I2C_RESIDUAL_BACK_END           PPC_BITMASK(16, 31)
> +
> +/* Port busy register */
> +#define I2C_PORT_BUSY_REG               0xe
> +#define I2C_SET_S_SCL_REG               0xd
> +#define I2C_RESET_S_SCL_REG             0xf
> +#define I2C_SET_S_SDA_REG               0x10
> +#define I2C_RESET_S_SDA_REG             0x11
> +
> +#define PNV_I2C_FIFO_SIZE 8
> +
> +static I2CBus *pnv_i2c_get_bus(PnvI2C *i2c)
> +{
> +    uint8_t port = GETFIELD(I2C_MODE_PORT_NUM, i2c->regs[I2C_MODE_REG]);
> +
> +    if (port >= i2c->num_busses) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "I2C: invalid bus number %d/%d\n", port,
> +                      i2c->num_busses);
> +        return NULL;
> +    }
> +    return i2c->busses[port];
> +}
> +
> +static void pnv_i2c_update_irq(PnvI2C *i2c)
> +{
> +    I2CBus *bus = pnv_i2c_get_bus(i2c);
> +    bool recv = !!(i2c->regs[I2C_CMD_REG] & I2C_CMD_READ_NOT_WRITE);
> +    uint16_t front_end = GETFIELD(I2C_RESIDUAL_FRONT_END,
> +                                  i2c->regs[I2C_RESIDUAL_LEN_REG]);
> +    uint16_t back_end = GETFIELD(I2C_RESIDUAL_BACK_END,
> +                                 i2c->regs[I2C_RESIDUAL_LEN_REG]);
> +    uint8_t fifo_count = GETFIELD(I2C_STAT_FIFO_ENTRY_COUNT,
> +                                   i2c->regs[I2C_STAT_REG]);
> +    uint8_t fifo_free = PNV_I2C_FIFO_SIZE - fifo_count;
> +
> +    if (i2c_bus_busy(bus)) {
> +        i2c->regs[I2C_STAT_REG] &= ~I2C_STAT_DATA_REQ;
> +
> +        if (recv) {
> +            if (fifo_count >=
> +                GETFIELD(I2C_WATERMARK_HIGH, i2c->regs[I2C_WATERMARK_REG])) {
> +                i2c->regs[I2C_EXTD_STAT_REG] |= I2C_EXTD_STAT_HIGH_WATER;
> +            } else {
> +                i2c->regs[I2C_EXTD_STAT_REG] &= ~I2C_EXTD_STAT_HIGH_WATER;
> +            }
> +
> +            if (((i2c->regs[I2C_EXTD_STAT_REG] & I2C_EXTD_STAT_HIGH_WATER) &&
> +                 fifo_count != 0) || front_end == 0) {
> +                i2c->regs[I2C_STAT_REG] |= I2C_STAT_DATA_REQ;
> +            }
> +        } else {
> +            if (fifo_count <=
> +                GETFIELD(I2C_WATERMARK_LOW, i2c->regs[I2C_WATERMARK_REG])) {
> +                i2c->regs[I2C_EXTD_STAT_REG] |= I2C_EXTD_STAT_LOW_WATER;
> +            } else {
> +                i2c->regs[I2C_EXTD_STAT_REG] &= ~I2C_EXTD_STAT_LOW_WATER;
> +            }
> +
> +            if (back_end > 0 &&
> +                (fifo_free >= back_end ||
> +                 (i2c->regs[I2C_EXTD_STAT_REG] & I2C_EXTD_STAT_LOW_WATER))) {
> +                i2c->regs[I2C_STAT_REG] |= I2C_STAT_DATA_REQ;
> +            }
> +        }
> +
> +        if (back_end == 0 && front_end == 0) {
> +            i2c->regs[I2C_STAT_REG] &= ~I2C_STAT_DATA_REQ;
> +            i2c->regs[I2C_STAT_REG] |= I2C_STAT_CMD_COMP;
> +
> +            if (i2c->regs[I2C_CMD_REG] & I2C_CMD_WITH_STOP) {
> +                i2c_end_transfer(bus);
> +                i2c->regs[I2C_EXTD_STAT_REG] &=
> +                    ~(I2C_EXTD_STAT_I2C_BUSY | I2C_EXTD_STAT_SELF_BUSY);
> +            }
> +        } else {
> +            i2c->regs[I2C_STAT_REG] &= ~I2C_STAT_CMD_COMP;
> +        }
> +    }
> +
> +    /*
> +     * Status and interrupt registers have nearly the same layout.
> +     */
> +    i2c->regs[I2C_INTR_RAW_COND_REG] = i2c->regs[I2C_STAT_REG] >> 16;
> +    i2c->regs[I2C_INTR_COND_REG] =
> +        i2c->regs[I2C_INTR_RAW_COND_REG] & i2c->regs[I2C_INTR_MASK_REG];
> +
> +    qemu_set_irq(i2c->psi_irq, i2c->regs[I2C_INTR_COND_REG] != 0);
> +}
> +
> +static void pnv_i2c_fifo_update_count(PnvI2C *i2c)
> +{
> +    uint64_t stat = i2c->regs[I2C_STAT_REG];
> +
> +    i2c->regs[I2C_STAT_REG] = SETFIELD(I2C_STAT_FIFO_ENTRY_COUNT, stat,
> +                                       fifo8_num_used(&i2c->fifo));
> +}
> +
> +static void pnv_i2c_frontend_update(PnvI2C *i2c)
> +{
> +    uint64_t residual_end = i2c->regs[I2C_RESIDUAL_LEN_REG];
> +    uint16_t front_end = GETFIELD(I2C_RESIDUAL_FRONT_END, residual_end);
> +
> +    i2c->regs[I2C_RESIDUAL_LEN_REG] =
> +        SETFIELD(I2C_RESIDUAL_FRONT_END, residual_end, front_end - 1);
> +}
> +
> +static void pnv_i2c_fifo_flush(PnvI2C *i2c)
> +{
> +    I2CBus *bus = pnv_i2c_get_bus(i2c);
> +    uint8_t data;
> +    int ret;
> +
> +    if (!i2c_bus_busy(bus)) {
> +        return;
> +    }
> +
> +    if (i2c->regs[I2C_CMD_REG] & I2C_CMD_READ_NOT_WRITE) {
> +        if (fifo8_is_full(&i2c->fifo)) {
> +            return;
> +        }
> +
> +        data = i2c_recv(bus);
> +        fifo8_push(&i2c->fifo, data);
> +    } else {
> +        if (fifo8_is_empty(&i2c->fifo)) {
> +            return;
> +        }
> +
> +        data = fifo8_pop(&i2c->fifo);
> +        ret = i2c_send(bus, data);
> +        if (ret) {
> +            i2c->regs[I2C_STAT_REG] |= I2C_STAT_NACK_RCVD_ERR;
> +            i2c_end_transfer(bus);
> +        }
> +    }
> +
> +    pnv_i2c_fifo_update_count(i2c);
> +    pnv_i2c_frontend_update(i2c);
> +}
> +
> +static void pnv_i2c_handle_cmd(PnvI2C *i2c, uint64_t val)
> +{
> +    I2CBus *bus = pnv_i2c_get_bus(i2c);
> +    uint8_t addr = GETFIELD(I2C_CMD_DEV_ADDR, val);
> +    int recv = !!(val & I2C_CMD_READ_NOT_WRITE);
> +    uint32_t len_bytes = GETFIELD(I2C_CMD_LEN_BYTES, val);
> +
> +    if (!(val & I2C_CMD_WITH_START) && !(val & I2C_CMD_WITH_ADDR) &&
> +        !(val & I2C_CMD_WITH_STOP) && !len_bytes) {
> +        i2c->regs[I2C_STAT_REG] |= I2C_STAT_INVALID_CMD;
> +        qemu_log_mask(LOG_GUEST_ERROR, "I2C: invalid command 0x%"PRIx64"\n",
> +                      val);
> +        return;
> +    }
> +
> +    if (!(i2c->regs[I2C_STAT_REG] & I2C_STAT_CMD_COMP)) {
> +        i2c->regs[I2C_STAT_REG] |= I2C_STAT_INVALID_CMD;
> +        qemu_log_mask(LOG_GUEST_ERROR, "I2C: command in progress\n");
> +        return;
> +    }
> +
> +    if (!bus) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "I2C: invalid port\n");
> +        return;
> +    }
> +
> +    i2c->regs[I2C_RESIDUAL_LEN_REG] =
> +        SETFIELD(I2C_RESIDUAL_FRONT_END, 0ull, len_bytes) |
> +        SETFIELD(I2C_RESIDUAL_BACK_END, 0ull, len_bytes);
> +
> +    if (val & I2C_CMD_WITH_START) {
> +        if (i2c_start_transfer(bus, addr, recv)) {
> +            i2c->regs[I2C_STAT_REG] |= I2C_STAT_NACK_RCVD_ERR;
> +        } else {
> +            i2c->regs[I2C_EXTD_STAT_REG] |=
> +                (I2C_EXTD_STAT_I2C_BUSY | I2C_EXTD_STAT_SELF_BUSY);
> +            pnv_i2c_fifo_flush(i2c);
> +        }
> +    }
> +}
> +
> +static void pnv_i2c_backend_update(PnvI2C *i2c)
> +{
> +    uint64_t residual_end = i2c->regs[I2C_RESIDUAL_LEN_REG];
> +    uint16_t back_end = GETFIELD(I2C_RESIDUAL_BACK_END, residual_end);
> +
> +    if (!back_end) {
> +        i2c->regs[I2C_STAT_REG] |= I2C_STAT_BKEND_ACCESS_ERR;
> +        return;
> +    }
> +
> +    i2c->regs[I2C_RESIDUAL_LEN_REG] =
> +        SETFIELD(I2C_RESIDUAL_BACK_END, residual_end, back_end - 1);
> +}
> +
> +static void pnv_i2c_fifo_in(PnvI2C *i2c)
> +{
> +    uint8_t data = GETFIELD(I2C_FIFO, i2c->regs[I2C_FIFO_REG]);
> +    I2CBus *bus = pnv_i2c_get_bus(i2c);
> +
> +    if (!i2c_bus_busy(bus)) {
> +        i2c->regs[I2C_STAT_REG] |= I2C_STAT_INVALID_CMD;
> +        qemu_log_mask(LOG_GUEST_ERROR, "I2C: no command in progress\n");
> +        return;
> +    }
> +
> +    if (i2c->regs[I2C_CMD_REG] & I2C_CMD_READ_NOT_WRITE) {
> +        i2c->regs[I2C_STAT_REG] |= I2C_STAT_INVALID_CMD;
> +        qemu_log_mask(LOG_GUEST_ERROR, "I2C: read command in progress\n");
> +        return;
> +    }
> +
> +    if (fifo8_is_full(&i2c->fifo)) {
> +        if (!(i2c->regs[I2C_MODE_REG] & I2C_MODE_PACING_ALLOW)) {
> +            i2c->regs[I2C_STAT_REG] |= I2C_STAT_BKEND_OVERRUN_ERR;
> +        }
> +        return;
> +    }
> +
> +    fifo8_push(&i2c->fifo, data);
> +    pnv_i2c_fifo_update_count(i2c);
> +    pnv_i2c_backend_update(i2c);
> +    pnv_i2c_fifo_flush(i2c);
> +}
> +
> +static void pnv_i2c_fifo_out(PnvI2C *i2c)
> +{
> +    uint8_t data;
> +    I2CBus *bus = pnv_i2c_get_bus(i2c);
> +
> +    if (!i2c_bus_busy(bus)) {
> +        i2c->regs[I2C_STAT_REG] |= I2C_STAT_INVALID_CMD;
> +        qemu_log_mask(LOG_GUEST_ERROR, "I2C: no command in progress\n");
> +        return;
> +    }
> +
> +    if (!(i2c->regs[I2C_CMD_REG] & I2C_CMD_READ_NOT_WRITE)) {
> +        i2c->regs[I2C_STAT_REG] |= I2C_STAT_INVALID_CMD;
> +        qemu_log_mask(LOG_GUEST_ERROR, "I2C: write command in progress\n");
> +        return;
> +    }
> +
> +    if (fifo8_is_empty(&i2c->fifo)) {
> +        if (!(i2c->regs[I2C_MODE_REG] & I2C_MODE_PACING_ALLOW)) {
> +            i2c->regs[I2C_STAT_REG] |= I2C_STAT_BKEND_OVERRUN_ERR;
> +        }
> +        return;
> +    }
> +
> +    data = fifo8_pop(&i2c->fifo);
> +
> +    i2c->regs[I2C_FIFO_REG] = SETFIELD(I2C_FIFO, 0ull, data);
> +    pnv_i2c_fifo_update_count(i2c);
> +    pnv_i2c_backend_update(i2c);
> +}
> +
> +static uint64_t pnv_i2c_xscom_read(void *opaque, hwaddr addr,
> +                                   unsigned size)
> +{
> +    PnvI2C *i2c = PNV_I2C(opaque);
> +    uint32_t offset = addr >> 3;
> +    uint64_t val = -1;
> +    int i;
> +
> +    switch (offset) {
> +    case I2C_STAT_REG:
> +        val = i2c->regs[offset];
> +        break;
> +
> +    case I2C_FIFO_REG:
> +        pnv_i2c_fifo_out(i2c);
> +        val = i2c->regs[offset];
> +        break;
> +
> +    case I2C_PORT_BUSY_REG: /* compute busy bit for each port  */
> +        val = 0;
> +        for (i = 0; i < i2c->num_busses; i++) {
> +            val |= i2c_bus_busy(i2c->busses[i]) << i;
> +        }
> +        break;
> +
> +    case I2C_CMD_REG:
> +    case I2C_MODE_REG:
> +    case I2C_WATERMARK_REG:
> +    case I2C_INTR_MASK_REG:
> +    case I2C_INTR_RAW_COND_REG:
> +    case I2C_INTR_COND_REG:
> +    case I2C_EXTD_STAT_REG:
> +    case I2C_RESIDUAL_LEN_REG:
> +        val = i2c->regs[offset];
> +        break;
> +    default:
> +        i2c->regs[I2C_STAT_REG] |= I2C_STAT_INVALID_CMD;
> +        qemu_log_mask(LOG_GUEST_ERROR, "I2C: read at register: 0x%"
> +                      HWADDR_PRIx "\n", addr >> 3);
> +    }
> +
> +    pnv_i2c_update_irq(i2c);
> +
> +    return val;
> +}
> +
> +static void pnv_i2c_xscom_write(void *opaque, hwaddr addr,
> +                                uint64_t val, unsigned size)
> +{
> +    PnvI2C *i2c = PNV_I2C(opaque);
> +    uint32_t offset = addr >> 3;
> +
> +    switch (offset) {
> +    case I2C_MODE_REG:
> +        i2c->regs[offset] = val;
> +        if (i2c_bus_busy(pnv_i2c_get_bus(i2c))) {
> +            i2c->regs[I2C_STAT_REG] |= I2C_STAT_INVALID_CMD;
> +            qemu_log_mask(LOG_GUEST_ERROR, "I2C: command in progress\n");
> +        }
> +        break;
> +
> +    case I2C_CMD_REG:
> +        i2c->regs[offset] = val;
> +        pnv_i2c_handle_cmd(i2c, val);
> +        break;
> +
> +    case I2C_FIFO_REG:
> +        i2c->regs[offset] = val;
> +        pnv_i2c_fifo_in(i2c);
> +        break;
> +
> +    case I2C_WATERMARK_REG:
> +        i2c->regs[offset] = val;
> +        break;
> +
> +    case I2C_RESET_I2C_REG:
> +        i2c->regs[I2C_MODE_REG] = 0;
> +        i2c->regs[I2C_CMD_REG] = 0;
> +        i2c->regs[I2C_WATERMARK_REG] = 0;
> +        i2c->regs[I2C_INTR_MASK_REG] = 0;
> +        i2c->regs[I2C_INTR_COND_REG] = 0;
> +        i2c->regs[I2C_INTR_RAW_COND_REG] = 0;
> +        i2c->regs[I2C_STAT_REG] = 0;
> +        i2c->regs[I2C_RESIDUAL_LEN_REG] = 0;
> +        i2c->regs[I2C_EXTD_STAT_REG] &=
> +            (I2C_EXTD_STAT_FIFO_SIZE | I2C_EXTD_STAT_I2C_VERSION);
> +        break;
> +
> +    case I2C_RESET_ERRORS:
> +        i2c->regs[I2C_STAT_REG] &= ~I2C_STAT_ANY_ERR;
> +        i2c->regs[I2C_RESIDUAL_LEN_REG] = 0;
> +        i2c->regs[I2C_EXTD_STAT_REG] &=
> +            (I2C_EXTD_STAT_FIFO_SIZE | I2C_EXTD_STAT_I2C_VERSION);
> +        fifo8_reset(&i2c->fifo);
> +        break;
> +
> +    case I2C_INTR_MASK_REG:
> +        i2c->regs[offset] = val;
> +        break;
> +
> +    case I2C_INTR_MASK_OR_REG:
> +        i2c->regs[I2C_INTR_MASK_REG] |= val;
> +        break;
> +
> +    case I2C_INTR_MASK_AND_REG:
> +        i2c->regs[I2C_INTR_MASK_REG] &= val;
> +        break;
> +
> +    case I2C_PORT_BUSY_REG:
> +    case I2C_SET_S_SCL_REG:
> +    case I2C_RESET_S_SCL_REG:
> +    case I2C_SET_S_SDA_REG:
> +    case I2C_RESET_S_SDA_REG:
> +        i2c->regs[offset] = val;
> +        break;
> +    default:
> +        i2c->regs[I2C_STAT_REG] |= I2C_STAT_INVALID_CMD;
> +        qemu_log_mask(LOG_GUEST_ERROR, "I2C: write at register: 0x%"
> +                      HWADDR_PRIx " val=0x%"PRIx64"\n", addr >> 3, val);
> +    }
> +
> +    pnv_i2c_update_irq(i2c);
> +}
> +
> +static const MemoryRegionOps pnv_i2c_xscom_ops = {
> +    .read = pnv_i2c_xscom_read,
> +    .write = pnv_i2c_xscom_write,
> +    .valid.min_access_size = 8,
> +    .valid.max_access_size = 8,
> +    .impl.min_access_size = 8,
> +    .impl.max_access_size = 8,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
> +static int pnv_i2c_bus_dt_xscom(PnvI2C *i2c, void *fdt,
> +                                int offset, int index)
> +{
> +    char *name;
> +    int i2c_bus_offset;
> +    const char i2c_compat[] =
> +        "ibm,opal-i2c\0ibm,power8-i2c-port\0ibm,power9-i2c-port";
> +    char *i2c_port_name;
> +
> +    name = g_strdup_printf("i2c-bus@%x", index);
> +    i2c_bus_offset = fdt_add_subnode(fdt, offset, name);
> +    _FDT(i2c_bus_offset);
> +    g_free(name);
> +
> +    _FDT((fdt_setprop_cell(fdt, i2c_bus_offset, "reg", index)));
> +    _FDT((fdt_setprop_cell(fdt, i2c_bus_offset, "#address-cells", 1)));
> +    _FDT((fdt_setprop_cell(fdt, i2c_bus_offset, "#size-cells", 0)));
> +    _FDT(fdt_setprop(fdt, i2c_bus_offset, "compatible", i2c_compat,
> +                     sizeof(i2c_compat)));
> +    _FDT((fdt_setprop_cell(fdt, i2c_bus_offset, "bus-frequency", 400000)));
> +
> +    i2c_port_name = g_strdup_printf("p8_%08x_e%dp%d", i2c->chip->chip_id,
> +                                    i2c->engine, index);
> +    _FDT(fdt_setprop_string(fdt, i2c_bus_offset, "ibm,port-name",
> +                            i2c_port_name));
> +    g_free(i2c_port_name);
> +
> +    return 0;
> +}
> +
> +#define XSCOM_BUS_FREQUENCY 466500000
> +#define I2C_CLOCK_FREQUENCY (XSCOM_BUS_FREQUENCY / 4)
> +
> +static int pnv_i2c_dt_xscom(PnvXScomInterface *dev, void *fdt,
> +                            int offset)
> +{
> +    PnvI2C *i2c = PNV_I2C(dev);
> +    char *name;
> +    int i2c_offset;
> +    const char i2c_compat[] = "ibm,power8-i2cm\0ibm,power9-i2cm";
> +    uint32_t i2c_pcba = PNV9_XSCOM_I2CM_BASE +
> +        i2c->engine * PNV9_XSCOM_I2CM_SIZE;
> +    uint32_t reg[2] = {
> +        cpu_to_be32(i2c_pcba),
> +        cpu_to_be32(PNV9_XSCOM_I2CM_SIZE)
> +    };
> +    int i;
> +
> +    name = g_strdup_printf("i2cm@%x", i2c_pcba);
> +    i2c_offset = fdt_add_subnode(fdt, offset, name);
> +    _FDT(i2c_offset);
> +    g_free(name);
> +
> +    _FDT(fdt_setprop(fdt, i2c_offset, "reg", reg, sizeof(reg)));
> +
> +    _FDT((fdt_setprop_cell(fdt, i2c_offset, "#address-cells", 1)));
> +    _FDT((fdt_setprop_cell(fdt, i2c_offset, "#size-cells", 0)));
> +    _FDT(fdt_setprop(fdt, i2c_offset, "compatible", i2c_compat,
> +                     sizeof(i2c_compat)));
> +    _FDT((fdt_setprop_cell(fdt, i2c_offset, "chip-engine#", i2c->engine)));
> +    _FDT((fdt_setprop_cell(fdt, i2c_offset, "clock-frequency",
> +                           I2C_CLOCK_FREQUENCY)));
> +
> +    for (i = 0; i < i2c->num_busses; i++) {
> +        pnv_i2c_bus_dt_xscom(i2c, fdt, i2c_offset, i);
> +    }
> +    return 0;
> +}
> +
> +static void pnv_i2c_reset(void *dev)
> +{
> +    PnvI2C *i2c = PNV_I2C(dev);
> +
> +    memset(i2c->regs, 0, sizeof(i2c->regs));
> +
> +    i2c->regs[I2C_STAT_REG] = I2C_STAT_CMD_COMP;
> +    i2c->regs[I2C_EXTD_STAT_REG] =
> +        SETFIELD(I2C_EXTD_STAT_FIFO_SIZE, 0ull, PNV_I2C_FIFO_SIZE) |
> +        SETFIELD(I2C_EXTD_STAT_I2C_VERSION, 0ull, 23); /* last version */
> +
> +    fifo8_reset(&i2c->fifo);
> +}
> +
> +static void pnv_i2c_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvI2C *i2c = PNV_I2C(dev);
> +    int i;
> +
> +    assert(i2c->chip);
> +
> +    pnv_xscom_region_init(&i2c->xscom_regs, OBJECT(i2c), &pnv_i2c_xscom_ops,
> +                          i2c, "xscom-i2c", PNV9_XSCOM_I2CM_SIZE);
> +
> +    i2c->busses = g_new(I2CBus *, i2c->num_busses);
> +    for (i = 0; i < i2c->num_busses; i++) {
> +        char name[32];
> +
> +        snprintf(name, sizeof(name), TYPE_PNV_I2C ".%d", i);
> +        i2c->busses[i] = i2c_init_bus(dev, name);
> +    }
> +
> +    fifo8_create(&i2c->fifo, PNV_I2C_FIFO_SIZE);
> +
> +    qemu_register_reset(pnv_i2c_reset, dev);
> +
> +    qdev_init_gpio_out(DEVICE(dev), &i2c->psi_irq, 1);
> +}
> +
> +static Property pnv_i2c_properties[] = {
> +    DEFINE_PROP_LINK("chip", PnvI2C, chip, TYPE_PNV_CHIP, PnvChip *),
> +    DEFINE_PROP_UINT32("engine", PnvI2C, engine, 1),
> +    DEFINE_PROP_UINT32("num-busses", PnvI2C, num_busses, 1),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void pnv_i2c_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PnvXScomInterfaceClass *xscomc = PNV_XSCOM_INTERFACE_CLASS(klass);
> +
> +    xscomc->dt_xscom = pnv_i2c_dt_xscom;
> +
> +    dc->desc = "PowerNV I2C";
> +    dc->realize = pnv_i2c_realize;
> +    device_class_set_props(dc, pnv_i2c_properties);
> +}
> +
> +static const TypeInfo pnv_i2c_info = {
> +    .name          = TYPE_PNV_I2C,
> +    .parent        = TYPE_DEVICE,
> +    .instance_size = sizeof(PnvI2C),
> +    .class_init    = pnv_i2c_class_init,
> +    .interfaces    = (InterfaceInfo[]) {
> +        { TYPE_PNV_XSCOM_INTERFACE },
> +        { }
> +    }
> +};
> +
> +static void pnv_i2c_register_types(void)
> +{
> +    type_register_static(&pnv_i2c_info);
> +}
> +
> +type_init(pnv_i2c_register_types);
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
> diff --git a/include/hw/ppc/pnv_i2c.h b/include/hw/ppc/pnv_i2c.h
> new file mode 100644
> index 0000000000..8bb5ecf6bc
> --- /dev/null
> +++ b/include/hw/ppc/pnv_i2c.h
> @@ -0,0 +1,39 @@
> +/*
> + * QEMU PowerPC PowerNV Processor I2C model
> + *
> + * Copyright (c) 2019-2021, IBM Corporation.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#ifndef PPC_PNV_I2C_H
> +#define PPC_PNV_I2C_H
> +
> +#include "hw/ppc/pnv.h"
> +#include "hw/i2c/i2c.h"
> +#include "qemu/fifo8.h"
> +
> +#define TYPE_PNV_I2C "pnv-i2c"
> +#define PNV_I2C(obj) OBJECT_CHECK(PnvI2C, (obj), TYPE_PNV_I2C)
> +
> +#define PNV_I2C_REGS 0x20
> +
> +typedef struct PnvI2C {
> +    DeviceState parent;
> +
> +    struct PnvChip *chip;
> +
> +    qemu_irq psi_irq;
> +
> +    uint64_t regs[PNV_I2C_REGS];
> +    uint32_t engine;
> +    uint32_t num_busses;
> +    I2CBus **busses;
> +
> +    MemoryRegion xscom_regs;
> +
> +    Fifo8 fifo;
> +} PnvI2C;
> +
> +#endif /* PPC_PNV_I2C_H */
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index 9bc6463547..0c8b873c4c 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -90,6 +90,9 @@ struct PnvXScomInterfaceClass {
>       ((uint64_t)(((core) & 0x1C) + 0x40) << 22)
>   #define PNV9_XSCOM_EQ_SIZE        0x100000
>   
> +#define PNV9_XSCOM_I2CM_BASE      0xa0000
> +#define PNV9_XSCOM_I2CM_SIZE      0x1000
> +
>   #define PNV9_XSCOM_OCC_BASE       PNV_XSCOM_OCC_BASE
>   #define PNV9_XSCOM_OCC_SIZE       0x8000
>   



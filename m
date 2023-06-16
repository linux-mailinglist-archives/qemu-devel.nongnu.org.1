Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4E0733308
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 16:02:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAA0t-0006UA-4F; Fri, 16 Jun 2023 10:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qAA0q-0006St-Ev
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 10:01:16 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qAA0n-00050s-Nz
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 10:01:16 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3111547c8f9so576377f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jun 2023 07:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686924072; x=1689516072;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1vdthDz2o64xcLeOTa4DRezOZa/pgzos86q0Eeg+/GI=;
 b=juSKlnSEmpgwI+HqozKgwvAQL/4gPw+gaarvb8UPKtWp3xXrfoV36+iOsmM5HqDb6G
 bs+lPm6RCKre5/4DG5dZ9AO1r+/m/MPSU8rdPJV5whETWnWYhWEy/LEkD6okvuDaIXAv
 ShYXmLnnn3jTUoO0L1xo0K/o6UbwzqvSFS05alfKzKMNHBuspOx4PZA81hetcZVIGR2R
 BL7A2SGchnm5Et+KWsI6TMtgie1mYk1LCiWuvfZ/K08L1bGw8NzI9erCVfHJnW4SlpJh
 nnzngde6l0ng0yBlPkxQWKKfRJIJFdWOOIz0+3kxDOdeVf9LiUEslgUaTsy6zRCitqSK
 Op9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686924072; x=1689516072;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1vdthDz2o64xcLeOTa4DRezOZa/pgzos86q0Eeg+/GI=;
 b=ICt++/3F39btam+bWpOgQdbTeDu+A1o7TtNQ7RflAKcSb+0UY1bvC2G1pD99MD2ypr
 oENJ7EU5QZO53nytqweMxfFEHVxnpxKjEFTWdLST0OEK5Jnhzqc+RLpn1shpjYCMce0U
 oW5ZgDnuzKjTkC7QBTu9L11gwFco7L79uLhu4X3y6IuARc02cy94Cy/Sy3CRyZYi9KDf
 PNDNE/lMPoTfKt4H3+eUjB/Bw182iHlek7X/3EpqDoWGi5idlUPO07HVGQ+Ch4lU4Yz5
 be1mSujez4F+kQJn9nagl6Jg2hSX2oYQIUk+viA8saEl6JVl3JeVzpC6/2xB00tzLPHN
 +lvQ==
X-Gm-Message-State: AC+VfDyWDkDySBa/ecCcxrb0H4c2pg2zKuIv3Q3KdTHaQgi3/MFMSiWJ
 vSdl3CFMk5xs0lBAi3cFi5hQ2A==
X-Google-Smtp-Source: ACHHUZ7D05CR7pa9ArPWlyhatxQOiwf2EqbSIYFkoU3nV1y5yMob+P1q8pRlZqKcymfd+OU+ZGeh6Q==
X-Received: by 2002:a5d:4643:0:b0:30e:4a21:808b with SMTP id
 j3-20020a5d4643000000b0030e4a21808bmr1384926wrs.55.1686924071592; 
 Fri, 16 Jun 2023 07:01:11 -0700 (PDT)
Received: from [192.168.164.175] (146.red-88-29-160.dynamicip.rima-tde.net.
 [88.29.160.146]) by smtp.gmail.com with ESMTPSA id
 z18-20020a5d44d2000000b003110dc7f408sm6836175wrr.41.2023.06.16.07.01.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jun 2023 07:01:11 -0700 (PDT)
Message-ID: <d77b97c1-2f59-bf40-bea6-4f1a72a3aa24@linaro.org>
Date: Fri, 16 Jun 2023 12:47:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 10/12] hw/vmapple/cfg: Introduce vmapple cfg region
Content-Language: en-US
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20230614224038.86148-1-graf>
 <20230614225734.806-1-graf@amazon.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230614225734.806-1-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 15/6/23 00:57, Alexander Graf wrote:
> Instead of device tree or other more standardized means, VMApple passes
> platform configuration to the first stage boot loader in a binary encoded
> format that resides at a dedicated RAM region in physical address space.
> 
> This patch models this configuration space as a qdev device which we can
> then map at the fixed location in the address space. That way, we can
> influence and annotate all configuration fields easily.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>   hw/vmapple/Kconfig       |   3 ++
>   hw/vmapple/cfg.c         | 105 +++++++++++++++++++++++++++++++++++++++
>   hw/vmapple/meson.build   |   1 +
>   include/hw/vmapple/cfg.h |  68 +++++++++++++++++++++++++
>   4 files changed, 177 insertions(+)
>   create mode 100644 hw/vmapple/cfg.c
>   create mode 100644 include/hw/vmapple/cfg.h


> diff --git a/hw/vmapple/cfg.c b/hw/vmapple/cfg.c
> new file mode 100644
> index 0000000000..d48e3c3afa
> --- /dev/null
> +++ b/hw/vmapple/cfg.c
> @@ -0,0 +1,105 @@
> +/*
> + * VMApple Configuration Region
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/vmapple/cfg.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +
> +static void vmapple_cfg_reset(DeviceState *dev)
> +{
> +    VMAppleCfgState *s = VMAPPLE_CFG(dev);
> +    VMAppleCfg *cfg;
> +
> +    cfg = memory_region_get_ram_ptr(&s->mem);
> +    memset((void *)cfg, 0, VMAPPLE_CFG_SIZE);

I'm a bit confused here: DeviceReset() handler is called _after_
DeviceRealize().

> +    *cfg = s->cfg;
> +}
> +
> +static void vmapple_cfg_realize(DeviceState *dev, Error **errp)
> +{
> +    VMAppleCfgState *s = VMAPPLE_CFG(dev);
> +    uint32_t i;
> +
> +    strncpy(s->cfg.serial, s->serial, sizeof(s->cfg.serial));
> +    strncpy(s->cfg.model, s->model, sizeof(s->cfg.model));
> +    strncpy(s->cfg.soc_name, s->soc_name, sizeof(s->cfg.soc_name));
> +    strncpy(s->cfg.unk8, "D/A", sizeof(s->cfg.soc_name));
> +    s->cfg.ecid = cpu_to_be64(s->cfg.ecid);
> +    s->cfg.version = 2;
> +    s->cfg.unk1 = 1;
> +    s->cfg.unk2 = 1;
> +    s->cfg.unk3 = 0x20;
> +    s->cfg.unk4 = 0;
> +    s->cfg.unk5 = 1;
> +    s->cfg.unk6 = 1;
> +    s->cfg.unk7 = 0;
> +    s->cfg.unk10 = 1;
> +
> +    g_assert(s->cfg.nr_cpus < ARRAY_SIZE(s->cfg.cpu_ids));
> +    for (i = 0; i < s->cfg.nr_cpus; i++) {
> +        s->cfg.cpu_ids[i] = i;
> +    }
> +}


> diff --git a/include/hw/vmapple/cfg.h b/include/hw/vmapple/cfg.h
> new file mode 100644
> index 0000000000..3337064e44
> --- /dev/null
> +++ b/include/hw/vmapple/cfg.h
> @@ -0,0 +1,68 @@
> +/*
> + * VMApple Configuration Region
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_VMAPPLE_CFG_H
> +#define HW_VMAPPLE_CFG_H
> +
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +#include "net/net.h"
> +
> +typedef struct VMAppleCfg {
> +    uint32_t version;         /* 0x000 */
> +    uint32_t nr_cpus;         /* 0x004 */
> +    uint32_t unk1;            /* 0x008 */
> +    uint32_t unk2;            /* 0x00c */
> +    uint32_t unk3;            /* 0x010 */
> +    uint32_t unk4;            /* 0x014 */
> +    uint64_t ecid;            /* 0x018 */
> +    uint64_t ram_size;        /* 0x020 */
> +    uint32_t run_installer1;  /* 0x028 */
> +    uint32_t unk5;            /* 0x02c */
> +    uint32_t unk6;            /* 0x030 */
> +    uint32_t run_installer2;  /* 0x034 */
> +    uint32_t rnd;             /* 0x038 */
> +    uint32_t unk7;            /* 0x03c */
> +    MACAddr mac_en0;          /* 0x040 */
> +    uint8_t pad1[2];
> +    MACAddr mac_en1;          /* 0x048 */
> +    uint8_t pad2[2];
> +    MACAddr mac_wifi0;        /* 0x050 */
> +    uint8_t pad3[2];
> +    MACAddr mac_bt0;          /* 0x058 */
> +    uint8_t pad4[2];
> +    uint8_t reserved[0xa0];   /* 0x060 */
> +    uint32_t cpu_ids[0x80];   /* 0x100 */
> +    uint8_t scratch[0x200];   /* 0x180 */
> +    char serial[32];          /* 0x380 */
> +    char unk8[32];            /* 0x3a0 */
> +    char model[32];           /* 0x3c0 */
> +    uint8_t unk9[32];         /* 0x3e0 */
> +    uint32_t unk10;           /* 0x400 */
> +    char soc_name[32];        /* 0x404 */
> +} VMAppleCfg;

Since you access this structure via qdev properties (which is
good), then we can restrict its definition to cfg.c (no need to
expose it).


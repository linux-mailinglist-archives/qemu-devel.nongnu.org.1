Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC207CD12E
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 02:16:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsuDT-0002Hx-L6; Tue, 17 Oct 2023 20:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1qsuDQ-0002Ha-PS
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 20:15:12 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1qsuDN-00071P-Tz
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 20:15:12 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4063bfc6c03so24285e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 17:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697588107; x=1698192907; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rnfOGC/k1nG9MnrhHOdnNsV42Tz+qu9ib6h5GGBM3to=;
 b=NouByqZBDsqOoUrccm0RglZyihPR5AR1713jtVjCwFK3V3E9iRUHZYy+p2VJqwqi3H
 SEj48Lq7iX1hSllH5OJAnxK3x5LPhFwkkQspubFhWccRV3B7nsdlCIVjSpRKGkfOf9R0
 hJQ43Lo54f+Z3XyKS+vDRVXZatmip11IxT6MRWqpRvGaFcGOJfiX+AOcADFV7ZFbxFQp
 ResZYslppiG/4O3iujXjBq0faNAAVTscv1F13ljBbOSIAq6enOQH/oNxoWwpAu3mjoxJ
 UYlQeZW7goFzjNILrzEVLQ+seMJ379uFKsdOLYtCDfYJDDDD+NssPH/7TVT9/WWrdGaO
 s0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697588107; x=1698192907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rnfOGC/k1nG9MnrhHOdnNsV42Tz+qu9ib6h5GGBM3to=;
 b=ImxPyyCn9BbRyGgPQWkXRY7Pr3tdALOy5Vt3hTJ1AltNpFtTRTp0kG3qRRSbKU7p42
 PQ3CVx0Aoqf3mhsU8yeZkwmJ29W9ewUt2gmCkpW5L2hG1bDI69vpS7VQCYk56szGzxMk
 CaXTILKupOcC2isAf4/YTYAOMWzS5j8jtvKEk4+EDOAwQvKFTIIsBDGDLjr4EAG1Oa5C
 ZVGFEFt2t+iwQTikVBmV2M+BsEwee+ltDXGy4Nj0/3blTlSVq759RJp/tuAFdiSbQyCa
 WmZZwFonpZIHpdKc6iHTTEQHhaNp2IzWU974Qg9M+zz6+ESvBg826fgc+B7RBwYCSiUJ
 y3gw==
X-Gm-Message-State: AOJu0YzahHIdY8BuK4janRL98um9bty9b54O0tLVF1ixMG/so+eT8u4P
 0PUQgLKxOrEiBY080OfniEq2pkI75Wd/tucwMfTBRg==
X-Google-Smtp-Source: AGHT+IF0mGnIjplt4I0PUyUZqe9qi9MzBtdZ5KQAoV/mw352v+ADcaXUEtLpQBWPHCH/B1dv7bZssQt/dCSTt+WFKG0=
X-Received: by 2002:a05:600c:13c3:b0:405:35bf:7362 with SMTP id
 e3-20020a05600c13c300b0040535bf7362mr67123wmg.0.1697588107481; Tue, 17 Oct
 2023 17:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231017230342.311227-1-nabihestefan@google.com>
 <20231017230342.311227-7-nabihestefan@google.com>
In-Reply-To: <20231017230342.311227-7-nabihestefan@google.com>
From: Hao Wu <wuhaotsh@google.com>
Date: Tue, 17 Oct 2023 17:14:54 -0700
Message-ID: <CAGcCb13_EhKT751wR8o6QNAJCfuasqbeF+pJdR3por=QNL1t8A@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] \tests/qtest: Creating qtest for GMAC Module
To: Nabih Estefan <nabihestefan@google.com>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 kfting@nuvoton.com, jasonwang@redhat.com, avi.fishman@nuvoton.com
Content-Type: multipart/alternative; boundary="0000000000001f663d0607f2884d"
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=wuhaotsh@google.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--0000000000001f663d0607f2884d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You have an extra "\" in the title.

On Tue, Oct 17, 2023 at 4:04=E2=80=AFPM Nabih Estefan <nabihestefan@google.=
com>
wrote:

> From: Nabih Estefan Diaz <nabihestefan@google.com>
>
>  - Created qtest to check initialization of registers in GMAC Module.
>  - Implemented test into Build File.
>
> Signed-off-by: Nabih Estefan Diaz <nabihestefan@google.com>
> ---
>  tests/qtest/meson.build      |  11 +-
>  tests/qtest/npcm_gmac-test.c | 209 +++++++++++++++++++++++++++++++++++
>  2 files changed, 215 insertions(+), 5 deletions(-)
>  create mode 100644 tests/qtest/npcm_gmac-test.c
>
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 05d26e9292..3ff9f5d364 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -191,6 +191,8 @@ qtests_npcm7xx =3D \
>     'npcm7xx_timer-test',
>     'npcm7xx_watchdog_timer-test'] + \
>     (slirp.found() ? ['npcm7xx_emc-test'] : [])
> +qtests_npcm8xx =3D \
> +  ['npcm_gmac-test']
>
I haven't sent 8xx code yet (which I should do, sorry!). Maybe we should
remove 8xx related config for now?

>  qtests_aspeed =3D \
>    ['aspeed_hace-test',
>     'aspeed_smc-test',
> @@ -205,9 +207,7 @@ qtests_arm =3D \
>    (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed : [])
> + \
>    (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) +=
 \
>    (config_all_devices.has_key('CONFIG_GENERIC_LOADER') ?
> ['hexloader-test'] : []) + \
> -  (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ?
> ['tpm-tis-i2c-test'] : []) + \
> -  (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] =
:
> []) + \
> -  (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] :
> []) + \
> +  (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) +=
 \
>
ditto.

>    ['arm-cpu-features',
>     'boot-serial-test']
>
> @@ -219,8 +219,9 @@ qtests_aarch64 =3D \
>    (config_all_devices.has_key('CONFIG_XLNX_ZYNQMP_ARM') ?
> ['xlnx-can-test', 'fuzz-xlnx-dp-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test'=
]
> : []) + \
>    (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test'] :
> []) +  \
> -  (config_all.has_key('CONFIG_TCG') and
>           \
> -   config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ?
> ['tpm-tis-i2c-test'] : []) + \
> +  (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed : [])
> + \
> +  (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) +=
 \
> +  (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) +=
 \
>
ditto

>    ['arm-cpu-features',
>     'numa-test',
>     'boot-serial-test',
> diff --git a/tests/qtest/npcm_gmac-test.c b/tests/qtest/npcm_gmac-test.c
> new file mode 100644
> index 0000000000..30d27e8dcc
> --- /dev/null
> +++ b/tests/qtest/npcm_gmac-test.c
> @@ -0,0 +1,209 @@
> +/*
> + * QTests for Nuvoton NPCM7xx/8xx GMAC Modules.
> + *
> + * Copyright 2022 Google LLC
>
nit: could be 2023 right now?

> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqos/libqos.h"
> +
> +/* Name of the GMAC Device */
> +#define TYPE_NPCM_GMAC "npcm-gmac"
> +
> +typedef struct GMACModule {
> +    int irq;
> +    uint64_t base_addr;
> +} GMACModule;
> +
> +typedef struct TestData {
> +    const GMACModule *module;
> +} TestData;
> +
> +/* Values extracted from hw/arm/npcm8xx.c */
>
I think 7xx and 8xx has the same config for GMAC. Maybe use 7xx for now?

> +static const GMACModule gmac_module_list[] =3D {
> +    {
> +        .irq        =3D 14,
> +        .base_addr  =3D 0xf0802000
> +    },
> +    {
> +        .irq        =3D 15,
> +        .base_addr  =3D 0xf0804000
> +    },
> +    {
> +        .irq        =3D 16,
> +        .base_addr  =3D 0xf0806000
> +    },
> +    {
> +        .irq        =3D 17,
> +        .base_addr  =3D 0xf0808000
> +    }
> +};
> +
> +/* Returns the index of the GMAC module. */
> +static int gmac_module_index(const GMACModule *mod)
> +{
> +    ptrdiff_t diff =3D mod - gmac_module_list;
> +
> +    g_assert_true(diff >=3D 0 && diff < ARRAY_SIZE(gmac_module_list));
> +
> +    return diff;
> +}
> +
> +/* 32-bit register indices. Taken from npcm_gmac.c */
> +typedef enum NPCMRegister {
> +    /* DMA Registers */
> +    NPCM_DMA_BUS_MODE =3D 0x1000,
> +    NPCM_DMA_XMT_POLL_DEMAND =3D 0x1004,
> +    NPCM_DMA_RCV_POLL_DEMAND =3D 0x1008,
> +    NPCM_DMA_RCV_BASE_ADDR =3D 0x100c,
> +    NPCM_DMA_TX_BASE_ADDR =3D 0x1010,
> +    NPCM_DMA_STATUS =3D 0x1014,
> +    NPCM_DMA_CONTROL =3D 0x1018,
> +    NPCM_DMA_INTR_ENA =3D 0x101c,
> +    NPCM_DMA_MISSED_FRAME_CTR =3D 0x1020,
> +    NPCM_DMA_HOST_TX_DESC =3D 0x1048,
> +    NPCM_DMA_HOST_RX_DESC =3D 0x104c,
> +    NPCM_DMA_CUR_TX_BUF_ADDR =3D 0x1050,
> +    NPCM_DMA_CUR_RX_BUF_ADDR =3D 0x1054,
> +    NPCM_DMA_HW_FEATURE =3D 0x1058,
> +
> +    /* GMAC Registers */
> +    NPCM_GMAC_MAC_CONFIG =3D 0x0,
> +    NPCM_GMAC_FRAME_FILTER =3D 0x4,
> +    NPCM_GMAC_HASH_HIGH =3D 0x8,
> +    NPCM_GMAC_HASH_LOW =3D 0xc,
> +    NPCM_GMAC_MII_ADDR =3D 0x10,
> +    NPCM_GMAC_MII_DATA =3D 0x14,
> +    NPCM_GMAC_FLOW_CTRL =3D 0x18,
> +    NPCM_GMAC_VLAN_FLAG =3D 0x1c,
> +    NPCM_GMAC_VERSION =3D 0x20,
> +    NPCM_GMAC_WAKEUP_FILTER =3D 0x28,
> +    NPCM_GMAC_PMT =3D 0x2c,
> +    NPCM_GMAC_LPI_CTRL =3D 0x30,
> +    NPCM_GMAC_TIMER_CTRL =3D 0x34,
> +    NPCM_GMAC_INT_STATUS =3D 0x38,
> +    NPCM_GMAC_INT_MASK =3D 0x3c,
> +    NPCM_GMAC_MAC0_ADDR_HI =3D 0x40,
> +    NPCM_GMAC_MAC0_ADDR_LO =3D 0x44,
> +    NPCM_GMAC_MAC1_ADDR_HI =3D 0x48,
> +    NPCM_GMAC_MAC1_ADDR_LO =3D 0x4c,
> +    NPCM_GMAC_MAC2_ADDR_HI =3D 0x50,
> +    NPCM_GMAC_MAC2_ADDR_LO =3D 0x54,
> +    NPCM_GMAC_MAC3_ADDR_HI =3D 0x58,
> +    NPCM_GMAC_MAC3_ADDR_LO =3D 0x5c,
> +    NPCM_GMAC_RGMII_STATUS =3D 0xd8,
> +    NPCM_GMAC_WATCHDOG =3D 0xdc,
> +    NPCM_GMAC_PTP_TCR =3D 0x700,
> +    NPCM_GMAC_PTP_SSIR =3D 0x704,
> +    NPCM_GMAC_PTP_STSR =3D 0x708,
> +    NPCM_GMAC_PTP_STNSR =3D 0x70c,
> +    NPCM_GMAC_PTP_STSUR =3D 0x710,
> +    NPCM_GMAC_PTP_STNSUR =3D 0x714,
> +    NPCM_GMAC_PTP_TAR =3D 0x718,
> +    NPCM_GMAC_PTP_TTSR =3D 0x71c,
> +} NPCMRegister;
> +
> +static uint32_t gmac_read(QTestState *qts, const GMACModule *mod,
> +                          NPCMRegister regno)
> +{
> +    return qtest_readl(qts, mod->base_addr + regno);
> +}
> +
> +/* Check that GMAC registers are reset to default value */
> +static void test_init(gconstpointer test_data)
> +{
> +    const TestData *td =3D test_data;
> +    const GMACModule *mod =3D td->module;
> +    QTestState *qts =3D qtest_init("-machine npcm845-evb");
> +
> +#define CHECK_REG32(regno, value) \
> +    do { \
> +        g_assert_cmphex(gmac_read(qts, mod, (regno)), =3D=3D, (value)); =
\
> +    } while (0)
> +
> +    CHECK_REG32(NPCM_DMA_BUS_MODE, 0x00020100);
> +    CHECK_REG32(NPCM_DMA_XMT_POLL_DEMAND, 0);
> +    CHECK_REG32(NPCM_DMA_RCV_POLL_DEMAND, 0);
> +    CHECK_REG32(NPCM_DMA_RCV_BASE_ADDR, 0);
> +    CHECK_REG32(NPCM_DMA_TX_BASE_ADDR, 0);
> +    CHECK_REG32(NPCM_DMA_STATUS, 0);
> +    CHECK_REG32(NPCM_DMA_CONTROL, 0);
> +    CHECK_REG32(NPCM_DMA_INTR_ENA, 0);
> +    CHECK_REG32(NPCM_DMA_MISSED_FRAME_CTR, 0);
> +    CHECK_REG32(NPCM_DMA_HOST_TX_DESC, 0);
> +    CHECK_REG32(NPCM_DMA_HOST_RX_DESC, 0);
> +    CHECK_REG32(NPCM_DMA_CUR_TX_BUF_ADDR, 0);
> +    CHECK_REG32(NPCM_DMA_CUR_RX_BUF_ADDR, 0);
> +    CHECK_REG32(NPCM_DMA_HW_FEATURE, 0x100d4f37);
> +
> +    CHECK_REG32(NPCM_GMAC_MAC_CONFIG, 0);
> +    CHECK_REG32(NPCM_GMAC_FRAME_FILTER, 0);
> +    CHECK_REG32(NPCM_GMAC_HASH_HIGH, 0);
> +    CHECK_REG32(NPCM_GMAC_HASH_LOW, 0);
> +    CHECK_REG32(NPCM_GMAC_MII_ADDR, 0);
> +    CHECK_REG32(NPCM_GMAC_MII_DATA, 0);
> +    CHECK_REG32(NPCM_GMAC_FLOW_CTRL, 0);
> +    CHECK_REG32(NPCM_GMAC_VLAN_FLAG, 0);
> +    CHECK_REG32(NPCM_GMAC_VERSION, 0x00001037);
> +    CHECK_REG32(NPCM_GMAC_WAKEUP_FILTER, 0);
> +    CHECK_REG32(NPCM_GMAC_PMT, 0);
> +    CHECK_REG32(NPCM_GMAC_LPI_CTRL, 0);
> +    CHECK_REG32(NPCM_GMAC_TIMER_CTRL, 0x03e80000);
> +    CHECK_REG32(NPCM_GMAC_INT_STATUS, 0);
> +    CHECK_REG32(NPCM_GMAC_INT_MASK, 0);
> +    CHECK_REG32(NPCM_GMAC_MAC0_ADDR_HI, 0x8000ffff);
> +    CHECK_REG32(NPCM_GMAC_MAC0_ADDR_LO, 0xffffffff);
> +    CHECK_REG32(NPCM_GMAC_MAC1_ADDR_HI, 0x0000ffff);
> +    CHECK_REG32(NPCM_GMAC_MAC1_ADDR_LO, 0xffffffff);
> +    CHECK_REG32(NPCM_GMAC_MAC2_ADDR_HI, 0x0000ffff);
> +    CHECK_REG32(NPCM_GMAC_MAC2_ADDR_LO, 0xffffffff);
> +    CHECK_REG32(NPCM_GMAC_MAC3_ADDR_HI, 0x0000ffff);
> +    CHECK_REG32(NPCM_GMAC_MAC3_ADDR_LO, 0xffffffff);
> +    CHECK_REG32(NPCM_GMAC_RGMII_STATUS, 0);
> +    CHECK_REG32(NPCM_GMAC_WATCHDOG, 0);
> +    CHECK_REG32(NPCM_GMAC_PTP_TCR, 0x00002000);
> +    CHECK_REG32(NPCM_GMAC_PTP_SSIR, 0);
> +    CHECK_REG32(NPCM_GMAC_PTP_STSR, 0);
> +    CHECK_REG32(NPCM_GMAC_PTP_STNSR, 0);
> +    CHECK_REG32(NPCM_GMAC_PTP_STSUR, 0);
> +    CHECK_REG32(NPCM_GMAC_PTP_STNSUR, 0);
> +    CHECK_REG32(NPCM_GMAC_PTP_TAR, 0);
> +    CHECK_REG32(NPCM_GMAC_PTP_TTSR, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void gmac_add_test(const char *name, const TestData* td,
> +                          GTestDataFunc fn)
> +{
> +    g_autofree char *full_name =3D g_strdup_printf(
> +            "npcm8xx_gmac/gmac[%d]/%s", gmac_module_index(td->module),
> name);
> +    qtest_add_data_func(full_name, td, fn);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    TestData test_data_list[ARRAY_SIZE(gmac_module_list)];
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    for (int i =3D 0; i < ARRAY_SIZE(gmac_module_list); ++i) {
> +        TestData *td =3D &test_data_list[i];
> +
> +        td->module =3D &gmac_module_list[i];
> +
> +        gmac_add_test("init", td, test_init);
> +    }
> +
> +    return g_test_run();
> +}
> --
> 2.42.0.655.g421f12c284-goog
>
>

--0000000000001f663d0607f2884d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">You have an extra &quot;\&quot; in the ti=
tle.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Tue, Oct 17, 2023 at 4:04=E2=80=AFPM Nabih Estefan &lt;<a href=3D"ma=
ilto:nabihestefan@google.com">nabihestefan@google.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">From: Nabih Estefan Di=
az &lt;<a href=3D"mailto:nabihestefan@google.com" target=3D"_blank">nabihes=
tefan@google.com</a>&gt;<br>
<br>
=C2=A0- Created qtest to check initialization of registers in GMAC Module.<=
br>
=C2=A0- Implemented test into Build File.<br>
<br>
Signed-off-by: Nabih Estefan Diaz &lt;<a href=3D"mailto:nabihestefan@google=
.com" target=3D"_blank">nabihestefan@google.com</a>&gt;<br>
---<br>
=C2=A0tests/qtest/meson.build=C2=A0 =C2=A0 =C2=A0 |=C2=A0 11 +-<br>
=C2=A0tests/qtest/npcm_gmac-test.c | 209 ++++++++++++++++++++++++++++++++++=
+<br>
=C2=A02 files changed, 215 insertions(+), 5 deletions(-)<br>
=C2=A0create mode 100644 tests/qtest/npcm_gmac-test.c<br>
<br>
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build<br>
index 05d26e9292..3ff9f5d364 100644<br>
--- a/tests/qtest/meson.build<br>
+++ b/tests/qtest/meson.build<br>
@@ -191,6 +191,8 @@ qtests_npcm7xx =3D \<br>
=C2=A0 =C2=A0 &#39;npcm7xx_timer-test&#39;,<br>
=C2=A0 =C2=A0 &#39;npcm7xx_watchdog_timer-test&#39;] + \<br>
=C2=A0 =C2=A0 (slirp.found() ? [&#39;npcm7xx_emc-test&#39;] : [])<br>
+qtests_npcm8xx =3D \<br>
+=C2=A0 [&#39;npcm_gmac-test&#39;]<br></blockquote><div>I haven&#39;t sent =
8xx code yet (which I should do, sorry!). Maybe we should remove 8xx relate=
d config for now?=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
=C2=A0qtests_aspeed =3D \<br>
=C2=A0 =C2=A0[&#39;aspeed_hace-test&#39;,<br>
=C2=A0 =C2=A0 &#39;aspeed_smc-test&#39;,<br>
@@ -205,9 +207,7 @@ qtests_arm =3D \<br>
=C2=A0 =C2=A0(config_all_devices.has_key(&#39;CONFIG_ASPEED_SOC&#39;) ? qte=
sts_aspeed : []) + \<br>
=C2=A0 =C2=A0(config_all_devices.has_key(&#39;CONFIG_NPCM7XX&#39;) ? qtests=
_npcm7xx : []) + \<br>
=C2=A0 =C2=A0(config_all_devices.has_key(&#39;CONFIG_GENERIC_LOADER&#39;) ?=
 [&#39;hexloader-test&#39;] : []) + \<br>
-=C2=A0 (config_all_devices.has_key(&#39;CONFIG_TPM_TIS_I2C&#39;) ? [&#39;t=
pm-tis-i2c-test&#39;] : []) + \<br>
-=C2=A0 (config_all_devices.has_key(&#39;CONFIG_VEXPRESS&#39;) ? [&#39;test=
-arm-mptimer&#39;] : []) + \<br>
-=C2=A0 (config_all_devices.has_key(&#39;CONFIG_MICROBIT&#39;) ? [&#39;micr=
obit-test&#39;] : []) + \<br>
+=C2=A0 (config_all_devices.has_key(&#39;CONFIG_NPCM8XX&#39;) ? qtests_npcm=
8xx : []) + \<br></blockquote><div>ditto.=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
=C2=A0 =C2=A0[&#39;arm-cpu-features&#39;,<br>
=C2=A0 =C2=A0 &#39;boot-serial-test&#39;]<br>
<br>
@@ -219,8 +219,9 @@ qtests_aarch64 =3D \<br>
=C2=A0 =C2=A0(config_all_devices.has_key(&#39;CONFIG_XLNX_ZYNQMP_ARM&#39;) =
? [&#39;xlnx-can-test&#39;, &#39;fuzz-xlnx-dp-test&#39;] : []) + \<br>
=C2=A0 =C2=A0(config_all_devices.has_key(&#39;CONFIG_XLNX_VERSAL&#39;) ? [&=
#39;xlnx-canfd-test&#39;] : []) + \<br>
=C2=A0 =C2=A0(config_all_devices.has_key(&#39;CONFIG_RASPI&#39;) ? [&#39;bc=
m2835-dma-test&#39;] : []) +=C2=A0 \<br>
-=C2=A0 (config_all.has_key(&#39;CONFIG_TCG&#39;) and=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0config_all_devices.has_key(&#39;CONFIG_TPM_TIS_I2C&#39;) ? [&=
#39;tpm-tis-i2c-test&#39;] : []) + \<br>
+=C2=A0 (config_all_devices.has_key(&#39;CONFIG_ASPEED_SOC&#39;) ? qtests_a=
speed : []) + \<br>
+=C2=A0 (config_all_devices.has_key(&#39;CONFIG_NPCM7XX&#39;) ? qtests_npcm=
7xx : []) + \<br>
+=C2=A0 (config_all_devices.has_key(&#39;CONFIG_NPCM8XX&#39;) ? qtests_npcm=
8xx : []) + \<br></blockquote><div>ditto=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
=C2=A0 =C2=A0[&#39;arm-cpu-features&#39;,<br>
=C2=A0 =C2=A0 &#39;numa-test&#39;,<br>
=C2=A0 =C2=A0 &#39;boot-serial-test&#39;,<br>
diff --git a/tests/qtest/npcm_gmac-test.c b/tests/qtest/npcm_gmac-test.c<br=
>
new file mode 100644<br>
index 0000000000..30d27e8dcc<br>
--- /dev/null<br>
+++ b/tests/qtest/npcm_gmac-test.c<br>
@@ -0,0 +1,209 @@<br>
+/*<br>
+ * QTests for Nuvoton NPCM7xx/8xx GMAC Modules.<br>
+ *<br>
+ * Copyright 2022 Google LLC<br></blockquote><div>nit: could be 2023 right=
 now?=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+ *<br>
+ * This program is free software; you can redistribute it and/or modify it=
<br>
+ * under the terms of the GNU General Public License as published by the<b=
r>
+ * Free Software Foundation; either version 2 of the License, or<br>
+ * (at your option) any later version.<br>
+ *<br>
+ * This program is distributed in the hope that it will be useful, but WIT=
HOUT<br>
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or<b=
r>
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License<br=
>
+ * for more details.<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;libqos/libqos.h&quot;<br>
+<br>
+/* Name of the GMAC Device */<br>
+#define TYPE_NPCM_GMAC &quot;npcm-gmac&quot;<br>
+<br>
+typedef struct GMACModule {<br>
+=C2=A0 =C2=A0 int irq;<br>
+=C2=A0 =C2=A0 uint64_t base_addr;<br>
+} GMACModule;<br>
+<br>
+typedef struct TestData {<br>
+=C2=A0 =C2=A0 const GMACModule *module;<br>
+} TestData;<br>
+<br>
+/* Values extracted from hw/arm/npcm8xx.c */<br></blockquote><div>I think =
7xx and 8xx has the same config for GMAC. Maybe use 7xx for now?=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
+static const GMACModule gmac_module_list[] =3D {<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .irq=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 14,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .base_addr=C2=A0 =3D 0xf0802000<br>
+=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .irq=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 15,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .base_addr=C2=A0 =3D 0xf0804000<br>
+=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .irq=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .base_addr=C2=A0 =3D 0xf0806000<br>
+=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .irq=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 17,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .base_addr=C2=A0 =3D 0xf0808000<br>
+=C2=A0 =C2=A0 }<br>
+};<br>
+<br>
+/* Returns the index of the GMAC module. */<br>
+static int gmac_module_index(const GMACModule *mod)<br>
+{<br>
+=C2=A0 =C2=A0 ptrdiff_t diff =3D mod - gmac_module_list;<br>
+<br>
+=C2=A0 =C2=A0 g_assert_true(diff &gt;=3D 0 &amp;&amp; diff &lt; ARRAY_SIZE=
(gmac_module_list));<br>
+<br>
+=C2=A0 =C2=A0 return diff;<br>
+}<br>
+<br>
+/* 32-bit register indices. Taken from npcm_gmac.c */<br>
+typedef enum NPCMRegister {<br>
+=C2=A0 =C2=A0 /* DMA Registers */<br>
+=C2=A0 =C2=A0 NPCM_DMA_BUS_MODE =3D 0x1000,<br>
+=C2=A0 =C2=A0 NPCM_DMA_XMT_POLL_DEMAND =3D 0x1004,<br>
+=C2=A0 =C2=A0 NPCM_DMA_RCV_POLL_DEMAND =3D 0x1008,<br>
+=C2=A0 =C2=A0 NPCM_DMA_RCV_BASE_ADDR =3D 0x100c,<br>
+=C2=A0 =C2=A0 NPCM_DMA_TX_BASE_ADDR =3D 0x1010,<br>
+=C2=A0 =C2=A0 NPCM_DMA_STATUS =3D 0x1014,<br>
+=C2=A0 =C2=A0 NPCM_DMA_CONTROL =3D 0x1018,<br>
+=C2=A0 =C2=A0 NPCM_DMA_INTR_ENA =3D 0x101c,<br>
+=C2=A0 =C2=A0 NPCM_DMA_MISSED_FRAME_CTR =3D 0x1020,<br>
+=C2=A0 =C2=A0 NPCM_DMA_HOST_TX_DESC =3D 0x1048,<br>
+=C2=A0 =C2=A0 NPCM_DMA_HOST_RX_DESC =3D 0x104c,<br>
+=C2=A0 =C2=A0 NPCM_DMA_CUR_TX_BUF_ADDR =3D 0x1050,<br>
+=C2=A0 =C2=A0 NPCM_DMA_CUR_RX_BUF_ADDR =3D 0x1054,<br>
+=C2=A0 =C2=A0 NPCM_DMA_HW_FEATURE =3D 0x1058,<br>
+<br>
+=C2=A0 =C2=A0 /* GMAC Registers */<br>
+=C2=A0 =C2=A0 NPCM_GMAC_MAC_CONFIG =3D 0x0,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_FRAME_FILTER =3D 0x4,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_HASH_HIGH =3D 0x8,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_HASH_LOW =3D 0xc,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_MII_ADDR =3D 0x10,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_MII_DATA =3D 0x14,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_FLOW_CTRL =3D 0x18,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_VLAN_FLAG =3D 0x1c,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_VERSION =3D 0x20,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_WAKEUP_FILTER =3D 0x28,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_PMT =3D 0x2c,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_LPI_CTRL =3D 0x30,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_TIMER_CTRL =3D 0x34,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_INT_STATUS =3D 0x38,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_INT_MASK =3D 0x3c,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_MAC0_ADDR_HI =3D 0x40,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_MAC0_ADDR_LO =3D 0x44,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_MAC1_ADDR_HI =3D 0x48,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_MAC1_ADDR_LO =3D 0x4c,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_MAC2_ADDR_HI =3D 0x50,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_MAC2_ADDR_LO =3D 0x54,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_MAC3_ADDR_HI =3D 0x58,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_MAC3_ADDR_LO =3D 0x5c,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_RGMII_STATUS =3D 0xd8,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_WATCHDOG =3D 0xdc,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_PTP_TCR =3D 0x700,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_PTP_SSIR =3D 0x704,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_PTP_STSR =3D 0x708,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_PTP_STNSR =3D 0x70c,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_PTP_STSUR =3D 0x710,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_PTP_STNSUR =3D 0x714,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_PTP_TAR =3D 0x718,<br>
+=C2=A0 =C2=A0 NPCM_GMAC_PTP_TTSR =3D 0x71c,<br>
+} NPCMRegister;<br>
+<br>
+static uint32_t gmac_read(QTestState *qts, const GMACModule *mod,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 NPCMRegister regno)<br>
+{<br>
+=C2=A0 =C2=A0 return qtest_readl(qts, mod-&gt;base_addr + regno);<br>
+}<br>
+<br>
+/* Check that GMAC registers are reset to default value */<br>
+static void test_init(gconstpointer test_data)<br>
+{<br>
+=C2=A0 =C2=A0 const TestData *td =3D test_data;<br>
+=C2=A0 =C2=A0 const GMACModule *mod =3D td-&gt;module;<br>
+=C2=A0 =C2=A0 QTestState *qts =3D qtest_init(&quot;-machine npcm845-evb&qu=
ot;);<br>
+<br>
+#define CHECK_REG32(regno, value) \<br>
+=C2=A0 =C2=A0 do { \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmphex(gmac_read(qts, mod, (regno)), =
=3D=3D, (value)); \<br>
+=C2=A0 =C2=A0 } while (0)<br>
+<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_DMA_BUS_MODE, 0x00020100);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_DMA_XMT_POLL_DEMAND, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_DMA_RCV_POLL_DEMAND, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_DMA_RCV_BASE_ADDR, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_DMA_TX_BASE_ADDR, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_DMA_STATUS, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_DMA_CONTROL, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_DMA_INTR_ENA, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_DMA_MISSED_FRAME_CTR, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_DMA_HOST_TX_DESC, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_DMA_HOST_RX_DESC, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_DMA_CUR_TX_BUF_ADDR, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_DMA_CUR_RX_BUF_ADDR, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_DMA_HW_FEATURE, 0x100d4f37);<br>
+<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_MAC_CONFIG, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_FRAME_FILTER, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_HASH_HIGH, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_HASH_LOW, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_MII_ADDR, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_MII_DATA, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_FLOW_CTRL, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_VLAN_FLAG, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_VERSION, 0x00001037);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_WAKEUP_FILTER, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_PMT, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_LPI_CTRL, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_TIMER_CTRL, 0x03e80000);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_INT_STATUS, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_INT_MASK, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_MAC0_ADDR_HI, 0x8000ffff);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_MAC0_ADDR_LO, 0xffffffff);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_MAC1_ADDR_HI, 0x0000ffff);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_MAC1_ADDR_LO, 0xffffffff);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_MAC2_ADDR_HI, 0x0000ffff);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_MAC2_ADDR_LO, 0xffffffff);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_MAC3_ADDR_HI, 0x0000ffff);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_MAC3_ADDR_LO, 0xffffffff);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_RGMII_STATUS, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_WATCHDOG, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_PTP_TCR, 0x00002000);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_PTP_SSIR, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_PTP_STSR, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_PTP_STNSR, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_PTP_STSUR, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_PTP_STNSUR, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_PTP_TAR, 0);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_PTP_TTSR, 0);<br>
+<br>
+=C2=A0 =C2=A0 qtest_quit(qts);<br>
+}<br>
+<br>
+static void gmac_add_test(const char *name, const TestData* td,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 GTestDataFunc fn)<br>
+{<br>
+=C2=A0 =C2=A0 g_autofree char *full_name =3D g_strdup_printf(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;npcm8xx_gmac/gmac[%d]/%s&q=
uot;, gmac_module_index(td-&gt;module), name);<br>
+=C2=A0 =C2=A0 qtest_add_data_func(full_name, td, fn);<br>
+}<br>
+<br>
+int main(int argc, char **argv)<br>
+{<br>
+=C2=A0 =C2=A0 TestData test_data_list[ARRAY_SIZE(gmac_module_list)];<br>
+<br>
+=C2=A0 =C2=A0 g_test_init(&amp;argc, &amp;argv, NULL);<br>
+<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; ARRAY_SIZE(gmac_module_list); ++i) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestData *td =3D &amp;test_data_list[i];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 td-&gt;module =3D &amp;gmac_module_list[i];<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac_add_test(&quot;init&quot;, td, test_init)=
;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return g_test_run();<br>
+}<br>
-- <br>
2.42.0.655.g421f12c284-goog<br>
<br>
</blockquote></div></div>

--0000000000001f663d0607f2884d--


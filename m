Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0392C823B29
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 04:40:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLEaS-0003tx-BW; Wed, 03 Jan 2024 22:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rLEaH-0003tY-9y; Wed, 03 Jan 2024 22:39:54 -0500
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rLEaE-00067Z-Ej; Wed, 03 Jan 2024 22:39:52 -0500
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-4b756f2aec8so36746e0c.0; 
 Wed, 03 Jan 2024 19:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704339589; x=1704944389; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YtL2a9/mbQnWkeq3vhFdVrITrp++cVl8L+LWhRAKfHY=;
 b=jwG036K3jtPBBE/Rp2F5Ipws2o7vGL0wF29bfq+VQSL9yduXn2BAkRyCwMfu1N7yDx
 4K1Eu0LNWA8EOr+0DIvzFAu/weXigvnAEGEL+b37WnxyS0T/0zzfMPqvXR51ek4Vp4NE
 d1Noa5RGGch7WCLcuCVq3bGFreJwYNWzLFlwHa7zEBq/1hGkhrMZ1iIA3m8X5UZ6WP2T
 bMrKiPtwkpGMJhSMhsAbQwsFnCu+j4T2jczNYEqW8zHxwi7dsZvkUeLztWv3bg/7/fPd
 ZVb/llgvJfy3ciNUXd9ygx+n5SX1j3xhW0VjARHfxKtW0OkYaNgfR5910pSquxiohkkk
 xhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704339589; x=1704944389;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YtL2a9/mbQnWkeq3vhFdVrITrp++cVl8L+LWhRAKfHY=;
 b=kItX+pm9KQCBsRQO3E6GlQ6dvVAd6FOkrdquDcQUmx0Q17jcQ+hcUSYeAbsMak40uC
 QWarTWkGsvVt79A3mzIP8OKfRgbT5YCDtbgpxWbW1eptKcy4SVU1bdkoFFGgPW2hMwzI
 wJsA8JUYyKACYz0ku8qaddOh4khSHNGr0pB6GklI+RwNJsHZPt6t544QawFjzLy6bco3
 ja5y7ZdzMYTbEeA7kAQO74KUgUhZTZmcHgwBAoSEb6fCFow+INcbasBP2oOTDRAfBXB1
 PPOLjenu+KpwzgaVxLeLXj7CZpm7V4GWkpNAqcv+EczMUFLx7xJaiTlCnMa/+t69NvID
 82CA==
X-Gm-Message-State: AOJu0Yy59iaFOxmMiaxYBVncYIdXNaWdZgQENMEg3g5PtzFZajLK51SO
 9G/KJR53egH0VEVE1ppYnE4QB9w/fNQg6DFi6NU=
X-Google-Smtp-Source: AGHT+IFMJ/LaJKufLbpwhBzdcDe5QQsMkU1Wyz796gAIH7U2Qal5HwmwqyNi9+ob9uTg/ilMsnFI03Nj+YKZ23WuSwM=
X-Received: by 2002:ac5:c307:0:b0:4b6:f13f:8cd7 with SMTP id
 j7-20020ac5c307000000b004b6f13f8cd7mr9487vkk.15.1704339588731; Wed, 03 Jan
 2024 19:39:48 -0800 (PST)
MIME-Version: 1.0
References: <20231228161944.303768-1-ines.varhol@telecom-paris.fr>
 <20231228161944.303768-3-ines.varhol@telecom-paris.fr>
In-Reply-To: <20231228161944.303768-3-ines.varhol@telecom-paris.fr>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 4 Jan 2024 13:39:22 +1000
Message-ID: <CAKmqyKMyHSeRaRAJaoKdL+i8DA42gzfsx_Qd=AE-XhvJQL-Syw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] tests/qtest: Add STM32L4x5 EXTI QTest testcase
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
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

On Fri, Dec 29, 2023 at 3:34=E2=80=AFAM In=C3=A8s Varhol
<ines.varhol@telecom-paris.fr> wrote:
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/qtest/meson.build           |   5 +
>  tests/qtest/stm32l4x5_exti-test.c | 596 ++++++++++++++++++++++++++++++
>  2 files changed, 601 insertions(+)
>  create mode 100644 tests/qtest/stm32l4x5_exti-test.c
>
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 47dabf91d0..d5126f4d86 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -194,6 +194,10 @@ qtests_aspeed =3D \
>    ['aspeed_hace-test',
>     'aspeed_smc-test',
>     'aspeed_gpio-test']
> +
> +qtests_stm32l4x5 =3D \
> +  ['stm32l4x5_exti-test']
> +
>  qtests_arm =3D \
>    (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) =
+ \
>    (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-ap=
b-dualtimer-test'] : []) + \
> @@ -207,6 +211,7 @@ qtests_arm =3D \
>    (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test=
'] : []) + \
>    (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] =
: []) + \
>    (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : [=
]) + \
> +  (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5=
 : []) + \
>    ['arm-cpu-features',
>     'boot-serial-test']
>
> diff --git a/tests/qtest/stm32l4x5_exti-test.c b/tests/qtest/stm32l4x5_ex=
ti-test.c
> new file mode 100644
> index 0000000000..60c8297246
> --- /dev/null
> +++ b/tests/qtest/stm32l4x5_exti-test.c
> @@ -0,0 +1,596 @@
> +/*
> + * QTest testcase for STM32L4x5_EXTI
> + *
> + * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest-single.h"
> +
> +#define EXTI_BASE_ADDR 0x40010400
> +#define EXTI_IMR1 0x00
> +#define EXTI_EMR1 0x04
> +#define EXTI_RTSR1 0x08
> +#define EXTI_FTSR1 0x0C
> +#define EXTI_SWIER1 0x10
> +#define EXTI_PR1 0x14
> +#define EXTI_IMR2 0x20
> +#define EXTI_EMR2 0x24
> +#define EXTI_RTSR2 0x28
> +#define EXTI_FTSR2 0x2C
> +#define EXTI_SWIER2 0x30
> +#define EXTI_PR2 0x34
> +
> +#define NVIC_ISER 0xE000E100
> +#define NVIC_ISPR 0xE000E200
> +#define NVIC_ICPR 0xE000E280
> +
> +#define EXTI0_IRQ 6
> +#define EXTI1_IRQ 7
> +#define EXTI35_IRQ 1
> +
> +static void enable_nvic_irq(unsigned int n)
> +{
> +    writel(NVIC_ISER, 1 << n);
> +}
> +
> +static void unpend_nvic_irq(unsigned int n)
> +{
> +    writel(NVIC_ICPR, 1 << n);
> +}
> +
> +static bool check_nvic_pending(unsigned int n)
> +{
> +    return readl(NVIC_ISPR) & (1 << n);
> +}
> +
> +static void exti_writel(unsigned int offset, uint32_t value)
> +{
> +    writel(EXTI_BASE_ADDR + offset, value);
> +}
> +
> +static uint32_t exti_readl(unsigned int offset)
> +{
> +    return readl(EXTI_BASE_ADDR + offset);
> +}
> +
> +static void test_reg_write_read(void)
> +{
> +    /* Test that non-reserved bits in xMR and xTSR can be set and cleare=
d */
> +
> +    exti_writel(EXTI_IMR1, 0xFFFFFFFF);
> +    uint32_t imr1 =3D exti_readl(EXTI_IMR1);
> +    g_assert_cmpuint(imr1, =3D=3D, 0xFFFFFFFF);
> +    exti_writel(EXTI_IMR1, 0x00000000);
> +    imr1 =3D exti_readl(EXTI_IMR1);
> +    g_assert_cmpuint(imr1, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_EMR1, 0xFFFFFFFF);
> +    uint32_t emr1 =3D exti_readl(EXTI_EMR1);
> +    g_assert_cmpuint(emr1, =3D=3D, 0xFFFFFFFF);
> +    exti_writel(EXTI_EMR1, 0x00000000);
> +    emr1 =3D exti_readl(EXTI_EMR1);
> +    g_assert_cmpuint(emr1, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_RTSR1, 0xFFFFFFFF);
> +    uint32_t rtsr1 =3D exti_readl(EXTI_RTSR1);
> +    g_assert_cmpuint(rtsr1, =3D=3D, 0x007DFFFF);
> +    exti_writel(EXTI_RTSR1, 0x00000000);
> +    rtsr1 =3D exti_readl(EXTI_RTSR1);
> +    g_assert_cmpuint(rtsr1, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_FTSR1, 0xFFFFFFFF);
> +    uint32_t ftsr1 =3D exti_readl(EXTI_FTSR1);
> +    g_assert_cmpuint(ftsr1, =3D=3D, 0x007DFFFF);
> +    exti_writel(EXTI_FTSR1, 0x00000000);
> +    ftsr1 =3D exti_readl(EXTI_FTSR1);
> +    g_assert_cmpuint(ftsr1, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_IMR2, 0xFFFFFFFF);
> +    uint32_t imr2 =3D exti_readl(EXTI_IMR2);
> +    g_assert_cmpuint(imr2, =3D=3D, 0x000000FF);
> +    exti_writel(EXTI_IMR2, 0x00000000);
> +    imr2 =3D exti_readl(EXTI_IMR2);
> +    g_assert_cmpuint(imr2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_EMR2, 0xFFFFFFFF);
> +    uint32_t emr2 =3D exti_readl(EXTI_EMR2);
> +    g_assert_cmpuint(emr2, =3D=3D, 0x000000FF);
> +    exti_writel(EXTI_EMR2, 0x00000000);
> +    emr2 =3D exti_readl(EXTI_EMR2);
> +    g_assert_cmpuint(emr2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_RTSR2, 0xFFFFFFFF);
> +    uint32_t rtsr2 =3D exti_readl(EXTI_RTSR2);
> +    g_assert_cmpuint(rtsr2, =3D=3D, 0x00000078);
> +    exti_writel(EXTI_RTSR2, 0x00000000);
> +    rtsr2 =3D exti_readl(EXTI_RTSR2);
> +    g_assert_cmpuint(rtsr2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_FTSR2, 0xFFFFFFFF);
> +    uint32_t ftsr2 =3D exti_readl(EXTI_FTSR2);
> +    g_assert_cmpuint(ftsr2, =3D=3D, 0x00000078);
> +    exti_writel(EXTI_FTSR2, 0x00000000);
> +    ftsr2 =3D exti_readl(EXTI_FTSR2);
> +    g_assert_cmpuint(ftsr2, =3D=3D, 0x00000000);
> +}
> +
> +static void test_direct_lines_write(void)
> +{
> +    /* Test that direct lines reserved bits are not written to */
> +
> +    exti_writel(EXTI_RTSR1, 0xFF820000);
> +    uint32_t rtsr1 =3D exti_readl(EXTI_RTSR1);
> +    g_assert_cmpuint(rtsr1, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_FTSR1, 0xFF820000);
> +    uint32_t ftsr1 =3D exti_readl(EXTI_FTSR1);
> +    g_assert_cmpuint(ftsr1, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_SWIER1, 0xFF820000);
> +    uint32_t swier1 =3D exti_readl(EXTI_SWIER1);
> +    g_assert_cmpuint(swier1, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_PR1, 0xFF820000);
> +    uint32_t pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_RTSR2, 0x00000087);
> +    const uint32_t rtsr2 =3D exti_readl(EXTI_RTSR2);
> +    g_assert_cmpuint(rtsr2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_FTSR2, 0x00000087);
> +    const uint32_t ftsr2 =3D exti_readl(EXTI_FTSR2);
> +    g_assert_cmpuint(ftsr2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_SWIER2, 0x00000087);
> +    const uint32_t swier2 =3D exti_readl(EXTI_SWIER2);
> +    g_assert_cmpuint(swier2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_PR2, 0x00000087);
> +    const uint32_t pr2 =3D exti_readl(EXTI_PR2);
> +    g_assert_cmpuint(pr2, =3D=3D, 0x00000000);
> +}
> +
> +static void test_reserved_bits_write(void)
> +{
> +    /* Test that reserved bits stay are not written to */
> +
> +    exti_writel(EXTI_IMR2, 0xFFFFFF00);
> +    uint32_t imr2 =3D exti_readl(EXTI_IMR2);
> +    g_assert_cmpuint(imr2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_EMR2, 0xFFFFFF00);
> +    uint32_t emr2 =3D exti_readl(EXTI_EMR2);
> +    g_assert_cmpuint(emr2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_RTSR2, 0xFFFFFF00);
> +    const uint32_t rtsr2 =3D exti_readl(EXTI_RTSR2);
> +    g_assert_cmpuint(rtsr2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_FTSR2, 0xFFFFFF00);
> +    const uint32_t ftsr2 =3D exti_readl(EXTI_FTSR2);
> +    g_assert_cmpuint(ftsr2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_SWIER2, 0xFFFFFF00);
> +    const uint32_t swier2 =3D exti_readl(EXTI_SWIER2);
> +    g_assert_cmpuint(swier2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_PR2, 0xFFFFFF00);
> +    const uint32_t pr2 =3D exti_readl(EXTI_PR2);
> +    g_assert_cmpuint(pr2, =3D=3D, 0x00000000);
> +}
> +
> +static void test_software_interrupt(void)
> +{
> +    /*
> +     * Test that we can launch a software irq by :
> +     * - enabling its line in IMR
> +     * - and then setting a bit from '0' to '1' in SWIER
> +     *
> +     * And that the interruption stays pending in NVIC
> +     * even after clearing the pending bit in PR.
> +     */
> +
> +    /*
> +     * Testing interrupt line EXTI0
> +     * Bit 0 in EXTI_*1 registers (EXTI0) corresponds to GPIO Px_0
> +     */
> +
> +    enable_nvic_irq(EXTI0_IRQ);
> +    /* Check that there are no interrupts already pending in PR */
> +    uint32_t pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    /* Check that this specific interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI0_IRQ));
> +
> +    /* Enable interrupt line EXTI0 */
> +    exti_writel(EXTI_IMR1, 0x00000001);
> +    /* Set the right SWIER bit from '0' to '1' */
> +    exti_writel(EXTI_SWIER1, 0x00000000);
> +    exti_writel(EXTI_SWIER1, 0x00000001);
> +
> +    /* Check that the write in SWIER was effective */
> +    uint32_t swier1 =3D exti_readl(EXTI_SWIER1);
> +    g_assert_cmpuint(swier1, =3D=3D, 0x00000001);
> +    /* Check that the corresponding pending bit in PR is set */
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000001);
> +    /* Check that the corresponding interrupt is pending in the NVIC */
> +    g_assert_true(check_nvic_pending(EXTI0_IRQ));
> +
> +    /* Clear the pending bit in PR */
> +    exti_writel(EXTI_PR1, 0x00000001);
> +
> +    /* Check that the write in PR was effective */
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    /* Check that the corresponding bit in SWIER was cleared */
> +    swier1 =3D exti_readl(EXTI_SWIER1);
> +    g_assert_cmpuint(swier1, =3D=3D, 0x00000000);
> +    /* Check that the interrupt is still pending in the NVIC */
> +    g_assert_true(check_nvic_pending(EXTI0_IRQ));
> +
> +    /*
> +     * Testing interrupt line EXTI35
> +     * Bit 3 in EXTI_*2 registers (EXTI35) corresponds to PVM 1 Wakeup
> +     */
> +
> +    enable_nvic_irq(EXTI35_IRQ);
> +    /* Check that there are no interrupts already pending */
> +    uint32_t pr2 =3D exti_readl(EXTI_PR2);
> +    g_assert_cmpuint(pr2, =3D=3D, 0x00000000);
> +    g_assert_false(check_nvic_pending(EXTI35_IRQ));
> +
> +    /* Enable interrupt line EXTI0 */
> +    exti_writel(EXTI_IMR2, 0x00000008);
> +    /* Set the right SWIER bit from '0' to '1' */
> +    exti_writel(EXTI_SWIER2, 0x00000000);
> +    exti_writel(EXTI_SWIER2, 0x00000008);
> +
> +    /* Check that the write in SWIER was effective */
> +    uint32_t swier2 =3D exti_readl(EXTI_SWIER2);
> +    g_assert_cmpuint(swier2, =3D=3D, 0x00000008);
> +    /* Check that the corresponding pending bit in PR is set */
> +    pr2 =3D exti_readl(EXTI_PR2);
> +    g_assert_cmpuint(pr2, =3D=3D, 0x00000008);
> +    /* Check that the corresponding interrupt is pending in the NVIC */
> +    g_assert_true(check_nvic_pending(EXTI35_IRQ));
> +
> +    /* Clear the pending bit in PR */
> +    exti_writel(EXTI_PR2, 0x00000008);
> +
> +    /* Check that the write in PR was effective */
> +    pr2 =3D exti_readl(EXTI_PR2);
> +    g_assert_cmpuint(pr2, =3D=3D, 0x00000000);
> +    /* Check that the corresponding bit in SWIER was cleared */
> +    swier2 =3D exti_readl(EXTI_SWIER2);
> +    g_assert_cmpuint(swier2, =3D=3D, 0x00000000);
> +    /* Check that the interrupt is still pending in the NVIC */
> +    g_assert_true(check_nvic_pending(EXTI35_IRQ));
> +
> +    /* Clean NVIC */
> +    unpend_nvic_irq(EXTI0_IRQ);
> +    g_assert_false(check_nvic_pending(EXTI0_IRQ));
> +    unpend_nvic_irq(EXTI35_IRQ);
> +    g_assert_false(check_nvic_pending(EXTI35_IRQ));
> +}
> +
> +static void test_edge_selector(void)
> +{
> +    enable_nvic_irq(EXTI0_IRQ);
> +
> +    /* Configure EXTI line 0 irq on rising edge */
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> +                     NULL, 0, 1);
> +    exti_writel(EXTI_IMR1, 0x00000001);
> +    exti_writel(EXTI_RTSR1, 0x00000001);
> +    exti_writel(EXTI_FTSR1, 0x00000000);
> +
> +    /* Test that an irq is raised on rising edge only */
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> +                     NULL, 0, 0);
> +
> +    uint32_t pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    g_assert_false(check_nvic_pending(EXTI0_IRQ));
> +
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> +                     NULL, 0, 1);
> +
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000001);
> +    g_assert_true(check_nvic_pending(EXTI0_IRQ));
> +
> +    /* Clean the test */
> +    exti_writel(EXTI_PR1, 0x00000001);
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    unpend_nvic_irq(EXTI0_IRQ);
> +    g_assert_false(check_nvic_pending(EXTI0_IRQ));
> +
> +    /* Configure EXTI line 0 irq on falling edge */
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> +                     NULL, 0, 0);
> +    exti_writel(EXTI_IMR1, 0x00000001);
> +    exti_writel(EXTI_RTSR1, 0x00000000);
> +    exti_writel(EXTI_FTSR1, 0x00000001);
> +
> +    /* Test that an irq is raised on falling edge only */
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> +                     NULL, 0, 1);
> +
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    g_assert_false(check_nvic_pending(EXTI0_IRQ));
> +
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> +                     NULL, 0, 0);
> +
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000001);
> +    g_assert_true(check_nvic_pending(EXTI0_IRQ));
> +
> +    /* Clean the test */
> +    exti_writel(EXTI_PR1, 0x00000001);
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    unpend_nvic_irq(EXTI0_IRQ);
> +    g_assert_false(check_nvic_pending(EXTI0_IRQ));
> +
> +    /* Configure EXTI line 0 irq on falling and rising edge */
> +    exti_writel(EXTI_IMR1, 0x00000001);
> +    exti_writel(EXTI_RTSR1, 0x00000001);
> +    exti_writel(EXTI_FTSR1, 0x00000000);
> +
> +    /* Test that an irq is raised on rising and falling edge */
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> +                     NULL, 0, 1);
> +
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000001);
> +    g_assert_true(check_nvic_pending(EXTI0_IRQ));
> +
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> +                     NULL, 0, 0);
> +
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000001);
> +    g_assert_true(check_nvic_pending(EXTI0_IRQ));
> +
> +    /* Clean the test */
> +    exti_writel(EXTI_PR1, 0x00000001);
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    unpend_nvic_irq(EXTI0_IRQ);
> +    g_assert_false(check_nvic_pending(EXTI0_IRQ));
> +
> +    /* Configure EXTI line 0 irq without selecting an edge trigger */
> +    exti_writel(EXTI_IMR1, 0x00000001);
> +    exti_writel(EXTI_RTSR1, 0x00000000);
> +    exti_writel(EXTI_FTSR1, 0x00000000);
> +
> +    /* Test that no irq is raised */
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> +                     NULL, 0, 1);
> +
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    g_assert_false(check_nvic_pending(EXTI0_IRQ));
> +
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> +                     NULL, 0, 0);
> +
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    g_assert_false(check_nvic_pending(EXTI0_IRQ));
> +}
> +
> +static void test_no_software_interrupt(void)
> +{
> +    /*
> +     * Test that software irq doesn't happen when :
> +     * - corresponding bit in IMR isn't set
> +     * - SWIER is set to 1 before IMR is set to 1
> +     */
> +
> +    /*
> +     * Testing interrupt line EXTI0
> +     * Bit 0 in EXTI_*1 registers (EXTI0) corresponds to GPIO Px_0
> +     */
> +
> +    enable_nvic_irq(EXTI0_IRQ);
> +    /* Check that there are no interrupts already pending in PR */
> +    uint32_t pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    /* Check that this specific interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI0_IRQ));
> +
> +    /* Mask interrupt line EXTI0 */
> +    exti_writel(EXTI_IMR1, 0x00000000);
> +    /* Set the corresponding SWIER bit from '0' to '1' */
> +    exti_writel(EXTI_SWIER1, 0x00000000);
> +    exti_writel(EXTI_SWIER1, 0x00000001);
> +
> +    /* Check that the write in SWIER was effective */
> +    uint32_t swier1 =3D exti_readl(EXTI_SWIER1);
> +    g_assert_cmpuint(swier1, =3D=3D, 0x00000001);
> +    /* Check that the pending bit in PR wasn't set */
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    /* Check that the interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI0_IRQ));
> +
> +    /* Enable interrupt line EXTI0 */
> +    exti_writel(EXTI_IMR1, 0x00000001);
> +
> +    /* Check that the pending bit in PR wasn't set */
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    /* Check that the interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI0_IRQ));
> +
> +    /*
> +     * Testing interrupt line EXTI35
> +     * Bit 3 in EXTI_*2 registers (EXTI35) corresponds to PVM 1 Wakeup
> +     */
> +
> +    enable_nvic_irq(EXTI35_IRQ);
> +    /* Check that there are no interrupts already pending in PR */
> +    uint32_t pr2 =3D exti_readl(EXTI_PR2);
> +    g_assert_cmpuint(pr2, =3D=3D, 0x00000000);
> +    /* Check that this specific interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI35_IRQ));
> +
> +    /* Mask interrupt line EXTI35 */
> +    exti_writel(EXTI_IMR2, 0x00000000);
> +    /* Set the corresponding SWIER bit from '0' to '1' */
> +    exti_writel(EXTI_SWIER2, 0x00000000);
> +    exti_writel(EXTI_SWIER2, 0x00000008);
> +
> +    /* Check that the write in SWIER was effective */
> +    uint32_t swier2 =3D exti_readl(EXTI_SWIER2);
> +    g_assert_cmpuint(swier2, =3D=3D, 0x00000008);
> +    /* Check that the pending bit in PR wasn't set */
> +    pr2 =3D exti_readl(EXTI_PR2);
> +    g_assert_cmpuint(pr2, =3D=3D, 0x00000000);
> +    /* Check that the interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI35_IRQ));
> +
> +    /* Enable interrupt line EXTI35 */
> +    exti_writel(EXTI_IMR2, 0x00000008);
> +
> +    /* Check that the pending bit in PR wasn't set */
> +    pr2 =3D exti_readl(EXTI_PR2);
> +    g_assert_cmpuint(pr2, =3D=3D, 0x00000000);
> +    /* Check that the interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI35_IRQ));
> +}
> +
> +static void test_masked_interrupt(void)
> +{
> +    /*
> +     * Test that irq doesn't happen when :
> +     * - corresponding bit in IMR isn't set
> +     * - SWIER is set to 1 before IMR is set to 1
> +     */
> +
> +    /*
> +     * Testing interrupt line EXTI1
> +     * with rising edge from GPIOx pin 1
> +     */
> +
> +    enable_nvic_irq(EXTI1_IRQ);
> +    /* Check that there are no interrupts already pending in PR */
> +    uint32_t pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    /* Check that this specific interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI1_IRQ));
> +
> +    /* Mask interrupt line EXTI1 */
> +    exti_writel(EXTI_IMR1, 0x00000000);
> +
> +    /* Configure interrupt on rising edge */
> +    exti_writel(EXTI_RTSR1, 0x00000002);
> +
> +    /* Simulate rising edge from GPIO line 1 */
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> +                     NULL, 1, 1);
> +
> +    /* Check that the pending bit in PR wasn't set */
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    /* Check that the interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI1_IRQ));
> +
> +    /* Enable interrupt line EXTI1 */
> +    exti_writel(EXTI_IMR1, 0x00000002);
> +
> +    /* Check that the pending bit in PR wasn't set */
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    /* Check that the interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI1_IRQ));
> +}
> +
> +static void test_interrupt(void)
> +{
> +    /*
> +     * Test that we can launch an irq by :
> +     * - enabling its line in IMR
> +     * - configuring interrupt on rising edge
> +     * - and then setting the input line from '0' to '1'
> +     *
> +     * And that the interruption stays pending in NVIC
> +     * even after clearing the pending bit in PR.
> +     */
> +
> +    /*
> +     * Testing interrupt line EXTI1
> +     * with rising edge from GPIOx pin 1
> +     */
> +
> +    enable_nvic_irq(EXTI1_IRQ);
> +    /* Check that there are no interrupts already pending in PR */
> +    uint32_t pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    /* Check that this specific interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI1_IRQ));
> +
> +    /* Enable interrupt line EXTI1 */
> +    exti_writel(EXTI_IMR1, 0x00000002);
> +
> +    /* Configure interrupt on rising edge */
> +    exti_writel(EXTI_RTSR1, 0x00000002);
> +
> +    /* Simulate rising edge from GPIO line 1 */
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> +                     NULL, 1, 1);
> +
> +    /* Check that the pending bit in PR was set */
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000002);
> +    /* Check that the interrupt is pending in NVIC */
> +    g_assert_true(check_nvic_pending(EXTI1_IRQ));
> +
> +    /* Clear the pending bit in PR */
> +    exti_writel(EXTI_PR1, 0x00000002);
> +
> +    /* Check that the write in PR was effective */
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    /* Check that the interrupt is still pending in the NVIC */
> +    g_assert_true(check_nvic_pending(EXTI1_IRQ));
> +
> +    /* Clean NVIC */
> +    unpend_nvic_irq(EXTI1_IRQ);
> +    g_assert_false(check_nvic_pending(EXTI1_IRQ));
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    int ret;
> +
> +    g_test_init(&argc, &argv, NULL);
> +    g_test_set_nonfatal_assertions();
> +    qtest_add_func("stm32l4x5/exti/direct_lines", test_direct_lines_writ=
e);
> +    qtest_add_func("stm32l4x5/exti/reserved_bits", test_reserved_bits_wr=
ite);
> +    qtest_add_func("stm32l4x5/exti/reg_write_read", test_reg_write_read)=
;
> +    qtest_add_func("stm32l4x5/exti/no_software_interrupt",
> +                   test_no_software_interrupt);
> +    qtest_add_func("stm32l4x5/exti/software_interrupt",
> +                   test_software_interrupt);
> +    qtest_add_func("stm32l4x5/exti/masked_interrupt", test_masked_interr=
upt);
> +    qtest_add_func("stm32l4x5/exti/interrupt", test_interrupt);
> +    qtest_add_func("stm32l4x5/exti/test_edge_selector", test_edge_select=
or);
> +
> +    qtest_start("-machine b-l475e-iot01a");
> +    ret =3D g_test_run();
> +    qtest_end();
> +
> +    return ret;
> +}
> --
> 2.43.0
>
>


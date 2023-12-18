Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DF4816577
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 04:54:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF4hl-0002ZR-CO; Sun, 17 Dec 2023 22:54:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rF4hj-0002Z8-RT; Sun, 17 Dec 2023 22:54:07 -0500
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rF4hb-0008Sn-3j; Sun, 17 Dec 2023 22:54:07 -0500
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7c5bfd8858cso789823241.3; 
 Sun, 17 Dec 2023 19:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702871637; x=1703476437; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wN031gcCCNtfrxFzHxY93r20SOdcJsChBfIxrYUP6Rw=;
 b=OhRAJjQmbcH094+KG8U0gGuJkE+tHyvWZYIXoU4RwTpO8Fmmc8fYe47sRGiAfeuAZ5
 qz6F1BMBHSDWmA/SU3cfkgByRU1fXHi/i/RJYjY8Wm0IcLZRv3fhSs6t/H/97MrE7t15
 8Awbqn5lIcwXwakeKThTnPTIp9CR/10DqqfNnwdAIKPp4yrd1zjYqX9k5aFACoeV1P+0
 LVN+52irIqayw8vK1piYQEaKicV8xAnI6uaNBScUTNYoW17h/u/TR8hCBixLng56dDq8
 7zcMZsjk/m62yzaOiXc5cpBACSi7x3jvm7t/bgfT64nKPKrt2pQqe1i3ax6ajM6df1Vd
 Fh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702871637; x=1703476437;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wN031gcCCNtfrxFzHxY93r20SOdcJsChBfIxrYUP6Rw=;
 b=Raoq4ezc2kqPJwas018wrebCHASLCxCVThz8444FnrCIcQcP2ESryKO/msbfYQ7rFD
 vD8XmwuNAE3u23Js5msihX/hL1xKhpP5zT66GehMpRk50zhl8sJ5NcSkcznlFwNR/pKn
 jhFJ23yRzNmt76H43b/LmqUnLp/4PkCXOpncphoL5x2F2CScAaPeOENgX4GzUmSvTlb0
 wTqnF6rvybzeY2Qv4hN7Qs94V0yEDbPQaL/UzPa774uoDGCrY3nLKOj+5+7yUp5X3y2A
 09N9NmrmOisQKWy3HzqbPFkDnkMFMg2U3kLG2J0ipZRdjUgzfhugb4Zl2YbmEwbSOUYs
 BT/g==
X-Gm-Message-State: AOJu0Yw74PUrSjCCcr7fk3Lymf5fWOUaYOphmxjsB9LzgDX9iIgbvzQq
 OA0yRJbtxX66RmBoJhBS3BlKYXPp+xerLg3PhRhRcX9AR2I=
X-Google-Smtp-Source: AGHT+IHhkPeGdZGnw4MVYxRMmLqJp1PffwYuk6IGcqXcmU+j6iUOgUYXUxbedgTxDwhDzXm3qcwzYEAa7n+/W4ldExM=
X-Received: by 2002:a05:6102:6697:b0:466:964d:ab60 with SMTP id
 gw23-20020a056102669700b00466964dab60mr356474vsb.52.1702871637427; Sun, 17
 Dec 2023 19:53:57 -0800 (PST)
MIME-Version: 1.0
References: <170223510627.13579.3191933474458037037-0@git.sr.ht>
 <170223510627.13579.3191933474458037037-2@git.sr.ht>
In-Reply-To: <170223510627.13579.3191933474458037037-2@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Dec 2023 13:53:31 +1000
Message-ID: <CAKmqyKOdU8EO23Qie-jz68SdrD1RsUaHD0zfw=h2nRGCmLKZSg@mail.gmail.com>
Subject: Re: [PATCH qemu 2/3] tests/qtest: Add STM32L4xx SYSCFG QTest testcase
To: "~inesvarhol" <inesvarhol@proton.me>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alistair@alistair23.me, 
 philmd@linaro.org, peter.maydell@linaro.org, ines.varhol@telecom-paris.fr, 
 arnaud.minier@telecom-paris.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
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

On Mon, Dec 11, 2023 at 5:07=E2=80=AFAM ~inesvarhol <inesvarhol@git.sr.ht> =
wrote:
>
> From: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/qtest/meson.build             |   3 +-
>  tests/qtest/stm32l4xx_syscfg-test.c | 408 ++++++++++++++++++++++++++++
>  2 files changed, 410 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/stm32l4xx_syscfg-test.c
>
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index d5126f4d86..06a04ed17d 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -196,7 +196,8 @@ qtests_aspeed =3D \
>     'aspeed_gpio-test']
>
>  qtests_stm32l4x5 =3D \
> -  ['stm32l4x5_exti-test']
> +  ['stm32l4x5_exti-test',
> +   'stm32l4xx_syscfg-test']
>
>  qtests_arm =3D \
>    (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) =
+ \
> diff --git a/tests/qtest/stm32l4xx_syscfg-test.c b/tests/qtest/stm32l4xx_=
syscfg-test.c
> new file mode 100644
> index 0000000000..166b596ba6
> --- /dev/null
> +++ b/tests/qtest/stm32l4xx_syscfg-test.c
> @@ -0,0 +1,408 @@
> +/*
> + * QTest testcase for STM32L4xx_SYSCFG
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
> +#define SYSCFG_BASE_ADDR 0x40010000
> +#define SYSCFG_MEMRMP 0x00
> +#define SYSCFG_CFGR1 0x04
> +#define SYSCFG_EXTICR1 0x08
> +#define SYSCFG_EXTICR2 0x0C
> +#define SYSCFG_EXTICR3 0x10
> +#define SYSCFG_EXTICR4 0x14
> +#define SYSCFG_SCSR 0x18
> +#define SYSCFG_CFGR2 0x1C
> +#define SYSCFG_SWPR 0x20
> +#define SYSCFG_SKR 0x24
> +#define SYSCFG_SWPR2 0x28
> +#define INVALID_ADDR 0x2C
> +
> +#define EXTI_BASE_ADDR 0x40010400
> +#define EXTI_IMR1 0x00
> +#define EXTI_RTSR1 0x08
> +#define EXTI_FTSR1 0x0C
> +
> +static void syscfg_writel(unsigned int offset, uint32_t value)
> +{
> +    writel(SYSCFG_BASE_ADDR + offset, value);
> +}
> +
> +static uint32_t syscfg_readl(unsigned int offset)
> +{
> +    return readl(SYSCFG_BASE_ADDR + offset);
> +}
> +
> +static void exti_writel(unsigned int offset, uint32_t value)
> +{
> +    writel(EXTI_BASE_ADDR + offset, value);
> +}
> +
> +static void system_reset(void)
> +{
> +    QDict *response;
> +    response =3D qtest_qmp(global_qtest, "{'execute': 'system_reset'}");
> +    g_assert(qdict_haskey(response, "return"));
> +    qobject_unref(response);
> +}
> +
> +static void test_reset(void)
> +{
> +    /*
> +     * Test that registers are initialized at the correct values
> +     */
> +    const uint32_t memrmp =3D syscfg_readl(SYSCFG_MEMRMP);
> +    g_assert_cmpuint(memrmp, =3D=3D, 0x00000000);
> +
> +    const uint32_t cfgr1 =3D syscfg_readl(SYSCFG_CFGR1);
> +    g_assert_cmpuint(cfgr1, =3D=3D, 0x7C000001);
> +
> +    const uint32_t exticr1 =3D syscfg_readl(SYSCFG_EXTICR1);
> +    g_assert_cmpuint(exticr1, =3D=3D, 0x00000000);
> +
> +    const uint32_t exticr2 =3D syscfg_readl(SYSCFG_EXTICR2);
> +    g_assert_cmpuint(exticr2, =3D=3D, 0x00000000);
> +
> +    const uint32_t exticr3 =3D syscfg_readl(SYSCFG_EXTICR3);
> +    g_assert_cmpuint(exticr3, =3D=3D, 0x00000000);
> +
> +    const uint32_t exticr4 =3D syscfg_readl(SYSCFG_EXTICR4);
> +    g_assert_cmpuint(exticr4, =3D=3D, 0x00000000);
> +
> +    const uint32_t scsr =3D syscfg_readl(SYSCFG_SCSR);
> +    g_assert_cmpuint(scsr, =3D=3D, 0x00000000);
> +
> +    const uint32_t cfgr2 =3D syscfg_readl(SYSCFG_CFGR2);
> +    g_assert_cmpuint(cfgr2, =3D=3D, 0x00000000);
> +
> +    const uint32_t swpr =3D syscfg_readl(SYSCFG_SWPR);
> +    g_assert_cmpuint(swpr, =3D=3D, 0x00000000);
> +
> +    const uint32_t skr =3D syscfg_readl(SYSCFG_SKR);
> +    g_assert_cmpuint(skr, =3D=3D, 0x00000000);
> +
> +    const uint32_t swpr2 =3D syscfg_readl(SYSCFG_SWPR2);
> +    g_assert_cmpuint(swpr2, =3D=3D, 0x00000000);
> +}
> +
> +static void test_reserved_bits(void)
> +{
> +    /*
> +     * Test that reserved bits stay at reset value
> +     * (which is 0 for all of them) by writing '1'
> +     * in all reserved bits (keeping reset value for
> +     * other bits) and checking that the
> +     * register is still at reset value
> +     */
> +    syscfg_writel(SYSCFG_MEMRMP, 0xFFFFFEF8);
> +    const uint32_t memrmp =3D syscfg_readl(SYSCFG_MEMRMP);
> +    g_assert_cmpuint(memrmp, =3D=3D, 0x00000000);
> +
> +    syscfg_writel(SYSCFG_CFGR1, 0x7F00FEFF);
> +    const uint32_t cfgr1 =3D syscfg_readl(SYSCFG_CFGR1);
> +    g_assert_cmpuint(cfgr1, =3D=3D, 0x7C000001);
> +
> +    syscfg_writel(SYSCFG_EXTICR1, 0xFFFF0000);
> +    const uint32_t exticr1 =3D syscfg_readl(SYSCFG_EXTICR1);
> +    g_assert_cmpuint(exticr1, =3D=3D, 0x00000000);
> +
> +    syscfg_writel(SYSCFG_EXTICR2, 0xFFFF0000);
> +    const uint32_t exticr2 =3D syscfg_readl(SYSCFG_EXTICR2);
> +    g_assert_cmpuint(exticr2, =3D=3D, 0x00000000);
> +
> +    syscfg_writel(SYSCFG_EXTICR3, 0xFFFF0000);
> +    const uint32_t exticr3 =3D syscfg_readl(SYSCFG_EXTICR3);
> +    g_assert_cmpuint(exticr3, =3D=3D, 0x00000000);
> +
> +    syscfg_writel(SYSCFG_EXTICR4, 0xFFFF0000);
> +    const uint32_t exticr4 =3D syscfg_readl(SYSCFG_EXTICR4);
> +    g_assert_cmpuint(exticr4, =3D=3D, 0x00000000);
> +
> +    syscfg_writel(SYSCFG_SKR, 0xFFFFFF00);
> +    const uint32_t skr =3D syscfg_readl(SYSCFG_SKR);
> +    g_assert_cmpuint(skr, =3D=3D, 0x00000000);
> +}
> +
> +static void test_set_and_clear(void)
> +{
> +    /*
> +     * Test that regular bits can be set and cleared
> +     */
> +    syscfg_writel(SYSCFG_MEMRMP, 0x00000107);
> +    uint32_t memrmp =3D syscfg_readl(SYSCFG_MEMRMP);
> +    g_assert_cmpuint(memrmp, =3D=3D, 0x00000107);
> +    syscfg_writel(SYSCFG_MEMRMP, 0x00000000);
> +    memrmp =3D syscfg_readl(SYSCFG_MEMRMP);
> +    g_assert_cmpuint(memrmp, =3D=3D, 0x00000000);
> +
> +    /* cfgr1 bit 0 is clear only so we keep it set */
> +    syscfg_writel(SYSCFG_CFGR1, 0xFCFF0101);
> +    uint32_t cfgr1 =3D syscfg_readl(SYSCFG_CFGR1);
> +    g_assert_cmpuint(cfgr1, =3D=3D, 0xFCFF0101);
> +    syscfg_writel(SYSCFG_CFGR1, 0x00000001);
> +    cfgr1 =3D syscfg_readl(SYSCFG_CFGR1);
> +    g_assert_cmpuint(cfgr1, =3D=3D, 0x00000001);
> +
> +    syscfg_writel(SYSCFG_EXTICR1, 0x0000FFFF);
> +    uint32_t exticr1 =3D syscfg_readl(SYSCFG_EXTICR1);
> +    g_assert_cmpuint(exticr1, =3D=3D, 0x0000FFFF);
> +    syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
> +    exticr1 =3D syscfg_readl(SYSCFG_EXTICR1);
> +    g_assert_cmpuint(exticr1, =3D=3D, 0x00000000);
> +
> +    syscfg_writel(SYSCFG_EXTICR2, 0x0000FFFF);
> +    uint32_t exticr2 =3D syscfg_readl(SYSCFG_EXTICR2);
> +    g_assert_cmpuint(exticr2, =3D=3D, 0x0000FFFF);
> +    syscfg_writel(SYSCFG_EXTICR2, 0x00000000);
> +    exticr2 =3D syscfg_readl(SYSCFG_EXTICR2);
> +    g_assert_cmpuint(exticr2, =3D=3D, 0x00000000);
> +
> +    syscfg_writel(SYSCFG_EXTICR3, 0x0000FFFF);
> +    uint32_t exticr3 =3D syscfg_readl(SYSCFG_EXTICR3);
> +    g_assert_cmpuint(exticr3, =3D=3D, 0x0000FFFF);
> +    syscfg_writel(SYSCFG_EXTICR3, 0x00000000);
> +    exticr3 =3D syscfg_readl(SYSCFG_EXTICR3);
> +    g_assert_cmpuint(exticr3, =3D=3D, 0x00000000);
> +
> +    syscfg_writel(SYSCFG_EXTICR4, 0x0000FFFF);
> +    uint32_t exticr4 =3D syscfg_readl(SYSCFG_EXTICR4);
> +    g_assert_cmpuint(exticr4, =3D=3D, 0x0000FFFF);
> +    syscfg_writel(SYSCFG_EXTICR4, 0x00000000);
> +    exticr4 =3D syscfg_readl(SYSCFG_EXTICR4);
> +    g_assert_cmpuint(exticr4, =3D=3D, 0x00000000);
> +
> +    syscfg_writel(SYSCFG_SKR, 0x000000FF);
> +    uint32_t skr =3D syscfg_readl(SYSCFG_SKR);
> +    g_assert_cmpuint(skr, =3D=3D, 0x000000FF);
> +    syscfg_writel(SYSCFG_SKR, 0x00000000);
> +    skr =3D syscfg_readl(SYSCFG_SKR);
> +    g_assert_cmpuint(skr, =3D=3D, 0x00000000);
> +}
> +
> +static void test_clear_by_writing_1(void)
> +{
> +    /*
> +     * Test that writing '1' doesn't set the bit
> +     */
> +    syscfg_writel(SYSCFG_CFGR2, 0x00000100);
> +    const uint32_t cfgr2 =3D syscfg_readl(SYSCFG_CFGR2);
> +    g_assert_cmpuint(cfgr2, =3D=3D, 0x00000000);
> +}
> +
> +static void test_set_only_bits(void)
> +{
> +    /*
> +     * Test that set only bits stay can't be cleared
> +     */
> +    syscfg_writel(SYSCFG_CFGR2, 0x0000000F);
> +    syscfg_writel(SYSCFG_CFGR2, 0x00000000);
> +    const uint32_t exticr3 =3D syscfg_readl(SYSCFG_CFGR2);
> +    g_assert_cmpuint(exticr3, =3D=3D, 0x0000000F);
> +
> +    syscfg_writel(SYSCFG_SWPR, 0xFFFFFFFF);
> +    syscfg_writel(SYSCFG_SWPR, 0x00000000);
> +    const uint32_t swpr =3D syscfg_readl(SYSCFG_SWPR);
> +    g_assert_cmpuint(swpr, =3D=3D, 0xFFFFFFFF);
> +
> +    syscfg_writel(SYSCFG_SWPR2, 0xFFFFFFFF);
> +    syscfg_writel(SYSCFG_SWPR2, 0x00000000);
> +    const uint32_t swpr2 =3D syscfg_readl(SYSCFG_SWPR2);
> +    g_assert_cmpuint(swpr2, =3D=3D, 0xFFFFFFFF);
> +
> +    system_reset();
> +}
> +
> +static void test_clear_only_bits(void)
> +{
> +    /*
> +     * Test that clear only bits stay can't be set
> +     */
> +    syscfg_writel(SYSCFG_CFGR1, 0x00000000);
> +    syscfg_writel(SYSCFG_CFGR1, 0x00000001);
> +    const uint32_t cfgr1 =3D syscfg_readl(SYSCFG_CFGR1);
> +    g_assert_cmpuint(cfgr1, =3D=3D, 0x00000000);
> +
> +    system_reset();
> +}
> +
> +static void test_interrupt(void)
> +{
> +    /*
> +     * Test that GPIO rising lines result in an irq
> +     * with the right configuration
> +     */
> +    qtest_irq_intercept_in(global_qtest, "/machine/unattached/device[0]/=
exti");
> +    /* Enable interrupt on rising edge of GPIO PA[0] */
> +    exti_writel(EXTI_IMR1, 0x00000001);
> +    exti_writel(EXTI_RTSR1, 0x00000001);
> +
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg=
",
> +                     NULL, 0, 1);
> +
> +    g_assert_true(get_irq(0));
> +
> +    /* Enable interrupt on rising edge of GPIO PA[15] */
> +    exti_writel(EXTI_IMR1, 0x00008000);
> +    exti_writel(EXTI_RTSR1, 0x00008000);
> +
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg=
",
> +                     NULL, 15, 1);
> +
> +    g_assert_true(get_irq(15));
> +
> +    /* Enable interrupt on rising edge of GPIO PB[1] */
> +    syscfg_writel(SYSCFG_EXTICR1, 0x00000010);
> +    exti_writel(EXTI_IMR1, 0x00000002);
> +    exti_writel(EXTI_RTSR1, 0x00000002);
> +
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg=
",
> +                     NULL, 17, 1);
> +
> +    g_assert_true(get_irq(1));
> +
> +    /* Clean the test */
> +    syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg=
",
> +                     NULL, 0, 0);
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg=
",
> +                     NULL, 15, 0);
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg=
",
> +                     NULL, 17, 0);
> +}
> +
> +static void test_irq_pin_multiplexer(void)
> +{
> +    /*
> +     * Test that syscfg irq sets the right exti irq
> +     */
> +
> +    qtest_irq_intercept_in(global_qtest, "/machine/unattached/device[0]/=
exti");
> +
> +    /* Enable interrupt on rising edge of GPIO PA[0] */
> +    exti_writel(EXTI_IMR1, 0x00000001);
> +    exti_writel(EXTI_RTSR1, 0x00000001);
> +
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg=
",
> +                     NULL, 0, 1);
> +
> +    /* Check that irq 0 was set and irq 15 wasn't */
> +    g_assert_true(get_irq(0));
> +    g_assert_false(get_irq(15));
> +
> +    /* Clean the test */
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg=
",
> +                     NULL, 0, 0);
> +
> +    /* Enable interrupt on rising edge of GPIO PA[15] */
> +    exti_writel(EXTI_IMR1, 0x00008000);
> +    exti_writel(EXTI_RTSR1, 0x00008000);
> +
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg=
",
> +                     NULL, 15, 1);
> +
> +    /* Check that irq 15 was set and irq 0 wasn't */
> +    g_assert_true(get_irq(15));
> +    g_assert_false(get_irq(0));
> +
> +    /* Clean the test */
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg=
",
> +                     NULL, 15, 0);
> +}
> +
> +static void test_irq_gpio_multiplexer(void)
> +{
> +    /*
> +     * Test that an irq is generated only by the right GPIO
> +     */
> +
> +    qtest_irq_intercept_in(global_qtest, "/machine/unattached/device[0]/=
exti");
> +
> +    /* Enable interrupt on rising edge of GPIO PA[0] */
> +    exti_writel(EXTI_IMR1, 0x00000001);
> +    exti_writel(EXTI_RTSR1, 0x00000001);
> +
> +    /* Check that setting rising pin GPIOA[0] generates an irq */
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg=
",
> +                     NULL, 0, 1);
> +
> +    g_assert_true(get_irq(0));
> +
> +    /* Clean the test */
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg=
",
> +                     NULL, 0, 0);
> +
> +    /* Check that setting rising pin GPIOB[0] doesn't generate an irq */
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg=
",
> +                     NULL, 16, 1);
> +
> +    g_assert_false(get_irq(0));
> +
> +    /* Clean the test */
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg=
",
> +                     NULL, 16, 0);
> +
> +    /* Enable interrupt on rising edge of GPIO PB[0] */
> +    exti_writel(EXTI_IMR1, 0x00000001);
> +    exti_writel(EXTI_RTSR1, 0x00000001);
> +    syscfg_writel(SYSCFG_EXTICR1, 0x00000001);
> +
> +    /* Check that setting rising pin GPIOA[0] doesn't generate an irq */
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg=
",
> +                     NULL, 0, 1);
> +
> +    g_assert_false(get_irq(0));
> +
> +    /* Clean the test */
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg=
",
> +                     NULL, 0, 0);
> +
> +    /* Check that setting rising pin GPIOB[0] generates an irq */
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg=
",
> +                     NULL, 16, 1);
> +
> +    g_assert_true(get_irq(0));
> +
> +    /* Clean the test */
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg=
",
> +                     NULL, 16, 0);
> +    syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    int ret;
> +
> +    g_test_init(&argc, &argv, NULL);
> +    g_test_set_nonfatal_assertions();
> +
> +    qtest_add_func("stm32l4x5/syscfg/test_reset", test_reset);
> +    qtest_add_func("stm32l4x5/syscfg/test_reserved_bits",
> +                   test_reserved_bits);
> +    qtest_add_func("stm32l4x5/syscfg/test_set_and_clear",
> +                   test_set_and_clear);
> +    qtest_add_func("stm32l4x5/syscfg/test_clear_by_writing_1",
> +                   test_clear_by_writing_1);
> +    qtest_add_func("stm32l4x5/syscfg/test_set_only_bits",
> +                   test_set_only_bits);
> +    qtest_add_func("stm32l4x5/syscfg/test_clear_only_bits",
> +                   test_clear_only_bits);
> +    qtest_add_func("stm32l4x5/syscfg/test_interrupt",
> +                   test_interrupt);
> +    qtest_add_func("stm32l4x5/syscfg/test_irq_pin_multiplexer",
> +                   test_irq_pin_multiplexer);
> +    qtest_add_func("stm32l4x5/syscfg/test_irq_gpio_multiplexer",
> +                   test_irq_gpio_multiplexer);
> +
> +    qtest_start("-machine b-l475e-iot01a");
> +    ret =3D g_test_run();
> +    qtest_end();
> +
> +    return ret;
> +}
> --
> 2.38.5
>
>


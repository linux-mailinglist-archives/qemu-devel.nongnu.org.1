Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2298242F6
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 14:48:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLO3T-0001vR-8e; Thu, 04 Jan 2024 08:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <inesvarhol@proton.me>)
 id 1rLO2g-0001WD-5L
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:45:50 -0500
Received: from mail-4318.protonmail.ch ([185.70.43.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <inesvarhol@proton.me>)
 id 1rLO2b-00022Q-Ac
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1704375942; x=1704635142;
 bh=t0Yxl9VW5WvFjF/FalnTSQcUgwlftiRhZvicw8QVMmY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Xmsbs0p8SYvx52M5ajHJQRSQOKWOEqPHe5W8QOa6z5NbDtDqUW4o+OcOwnsd5hc7M
 cldVNyCaqmmDShfuhrXbpefEHWfVHQd/RPmnrpwQBQ70BC+gdeKt8i6Sit1mrB9Jmo
 UcdtdpDjp8P0e1vFvOz1wWRXNqFhqqYhSl4QhcBFTACnoBBN0LZkwreYaL8ylvCK65
 zu7p+c2hpVHN3ImPf0aLkNDio/LuQGHPge18jX8gAX1luxWvZM3DSCwO5K4A1tGJOX
 sWHbXXQr+SU5U/ZRebDVYiGUU2dKQCF4GGTOI0rm0AkPHCWQossqW3pMrlhkqocwEY
 o3G9Zw2TSf2dw==
Date: Thu, 04 Jan 2024 13:45:21 +0000
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
From: inesvarhol <inesvarhol@proton.me>
Cc: =?utf-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v5 2/3] tests/qtest: Add STM32L4x5 EXTI QTest testcase
Message-ID: <vueSA6LNk2OEd9t7plxmNvtm9LVj_TIG9PEY1n8Gz9MMPMHL8jXTaStS6_-AddPqbYwLbbm-ZZgAbg0ezFyTS0_VQ5gq1-FvMG5m5tomJe8=@proton.me>
In-Reply-To: <cd41459a-b96d-4b51-bc2a-37724ccc4db1@linaro.org>
References: <20231228161944.303768-1-ines.varhol@telecom-paris.fr>
 <20231228161944.303768-3-ines.varhol@telecom-paris.fr>
 <cd41459a-b96d-4b51-bc2a-37724ccc4db1@linaro.org>
Feedback-ID: 78004345:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.18; envelope-from=inesvarhol@proton.me;
 helo=mail-4318.protonmail.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 04 Jan 2024 08:46:37 -0500
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

Le jeudi 4 janvier 2024 =C3=A0 14:33, Philippe Mathieu-Daud=C3=A9 <philmd@l=
inaro.org> a =C3=A9crit :


> On 28/12/23 17:19, In=C3=A8s Varhol wrote:
>
> > Signed-off-by: Arnaud Minier arnaud.minier@telecom-paris.fr
> > Signed-off-by: In=C3=A8s Varhol ines.varhol@telecom-paris.fr
> > ---
> > tests/qtest/meson.build | 5 +
> > tests/qtest/stm32l4x5_exti-test.c | 596 ++++++++++++++++++++++++++++++
> > 2 files changed, 601 insertions(+)
> > create mode 100644 tests/qtest/stm32l4x5_exti-test.c
>
>
> Once the SoC parentship fixed in based series, this patch
> requires:
>
> -- >8 --
>
> diff --git a/tests/qtest/stm32l4x5_exti-test.c
> b/tests/qtest/stm32l4x5_exti-test.c
> index 60c8297246..543199cd4d 100644
> --- a/tests/qtest/stm32l4x5_exti-test.c
> +++ b/tests/qtest/stm32l4x5_exti-test.c
> @@ -287,4 +287,3 @@ static void test_edge_selector(void)
> /* Configure EXTI line 0 irq on rising edge /
> - qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> - NULL, 0, 1);
> + qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 0, 1);
> exti_writel(EXTI_IMR1, 0x00000001);
> @@ -294,4 +293,3 @@ static void test_edge_selector(void)
> / Test that an irq is raised on rising edge only /
> - qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> - NULL, 0, 0);
> + qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 0, 0);
>
> @@ -301,4 +299,3 @@ static void test_edge_selector(void)
>
> - qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> - NULL, 0, 1);
> + qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 0, 1);
>
> @@ -316,4 +313,3 @@ static void test_edge_selector(void)
> / Configure EXTI line 0 irq on falling edge /
> - qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> - NULL, 0, 0);
> + qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 0, 0);
> exti_writel(EXTI_IMR1, 0x00000001);
> @@ -323,4 +319,3 @@ static void test_edge_selector(void)
> / Test that an irq is raised on falling edge only /
> - qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> - NULL, 0, 1);
> + qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 0, 1);
>
> @@ -330,4 +325,3 @@ static void test_edge_selector(void)
>
> - qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> - NULL, 0, 0);
> + qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 0, 0);
>
> @@ -350,4 +344,3 @@ static void test_edge_selector(void)
> / Test that an irq is raised on rising and falling edge /
> - qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> - NULL, 0, 1);
> + qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 0, 1);
>
> @@ -357,4 +350,3 @@ static void test_edge_selector(void)
>
> - qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> - NULL, 0, 0);
> + qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 0, 0);
>
> @@ -377,4 +369,3 @@ static void test_edge_selector(void)
> / Test that no irq is raised /
> - qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> - NULL, 0, 1);
> + qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 0, 1);
>
> @@ -384,4 +375,3 @@ static void test_edge_selector(void)
>
> - qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> - NULL, 0, 0);
> + qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 0, 0);
>
> @@ -500,4 +490,3 @@ static void test_masked_interrupt(void)
> / Simulate rising edge from GPIO line 1 /
> - qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> - NULL, 1, 1);
> + qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 1, 1);
>
> @@ -550,4 +539,3 @@ static void test_interrupt(void)
> / Simulate rising edge from GPIO line 1 */
> - qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> - NULL, 1, 1);
> + qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 1, 1);
> ---
>
> Note you could use a helper to ease readability:
>
> static void exti_set_irq(int num, int lvl)
> {
> qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, num, lvl);
> }
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 philmd@linaro.org

Ok thank you a lot !
And yes, we'll swap the 2nd and 3rd commit as you said.


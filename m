Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7668242F7
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 14:48:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLO3T-0001vh-Kx; Thu, 04 Jan 2024 08:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <inesvarhol@proton.me>)
 id 1rLNvE-0006ka-1l
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:38:08 -0500
Received: from mail-40138.protonmail.ch ([185.70.40.138])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <inesvarhol@proton.me>)
 id 1rLNuy-0006Lh-Sx
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1704375467; x=1704634667;
 bh=qzVBR4lBcGJVgTKzHaiagV6F7F9YSUdTi14Y6w2hhuw=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=LsngcGavZ3qKg8o41q4w5QIwSLInkO83ER4qMPjXtWHqxZuTtNUCyut4upaBB0ZZK
 Nq+TLAUAbLbEgItGX3s3uzy2jO+XrbIMxUTgtPD6SeH7hm6d/vsA5M0fTYc4Ok90iw
 91pWXS/c/Y8y6LehE8hzqJ9Hj1waYHX9Ewt353ucXkvrmDkTMcqI5r7TI0QUgSW8V3
 21lJqSqB6lmFwDVHHj0AtmbUqNYQapKqUSIZSPuLMV6S8YvsuMokei3CXV914l1L1d
 16/V3J45D7u/kjV+Tk40WLjeBVYu6KHkp5ttNjgl8wm5S/dB9YcfhPnljpa7eoQK81
 06w86msCLWPzQ==
Date: Thu, 04 Jan 2024 13:37:22 +0000
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
From: inesvarhol <inesvarhol@proton.me>
Cc: =?utf-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v5 2/3] tests/qtest: Add STM32L4x5 EXTI QTest testcase
Message-ID: <ZjC6phtwjcDoQP-NDP6GF-dvCVK8Ctk9EeW_JezuNBqnQq4-V6NU6eAhECMqxJzMDRxwjbb-LPcHTvysc6YGuLD7ckWhbtpqD1g9lnklofI=@proton.me>
In-Reply-To: <61fd13b3-7cc9-4e27-bf91-bd2b4aedf97b@linaro.org>
References: <20231228161944.303768-1-ines.varhol@telecom-paris.fr>
 <20231228161944.303768-3-ines.varhol@telecom-paris.fr>
 <61fd13b3-7cc9-4e27-bf91-bd2b4aedf97b@linaro.org>
Feedback-ID: 78004345:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.138; envelope-from=inesvarhol@proton.me;
 helo=mail-40138.protonmail.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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


Le jeudi 4 janvier 2024 =C3=A0 14:05, Philippe Mathieu-Daud=C3=A9 <philmd@l=
inaro.org> a =C3=A9crit=C2=A0:

Hello,

> > +static void test_edge_selector(void)
> > +{
> > + enable_nvic_irq(EXTI0_IRQ);
> > +
> > + / Configure EXTI line 0 irq on rising edge */
> > + qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
>=20
>=20
> Markus, this qtest use seems to expect some stability in QOM path...
>=20
> In=C3=A8s, Arnaud, having the SoC unattached is dubious, it belongs to
> the machine.

Noted, we will fix that.=20
Should we be concerned about the "stability in QOM path" ?

>=20
> (qemu) info qom-tree
> /machine (b-l475e-iot01a-machine)
> /SYSCLK (clock)
> /peripheral (container)
> /peripheral-anon (container)
> /unattached (container)
> /device[0] (stm32l4x5xg-soc)
>=20
> Eh I don't see the 'exti' here...
>=20
> Indeed the test fails:
>=20
> 17/35 qemu:qtest+qtest-arm / qtest-arm/test-arm-mptimer
> OK 0.44s 61 subtests passed
> =E2=96=B6 18/35 /arm/stm32l4x5/exti/reg_write_read
> FAIL
> =E2=96=B6 18/35 /arm/stm32l4x5/exti/no_software_interrupt
> FAIL
> =E2=96=B6 18/35 /arm/stm32l4x5/exti/software_interrupt
> FAIL
> =E2=96=B6 18/35 /arm/stm32l4x5/exti/masked_interrupt
> FAIL
> =E2=96=B6 18/35 /arm/stm32l4x5/exti/interrupt
> FAIL
> =E2=96=B6 18/35 /arm/stm32l4x5/exti/test_edge_selector
> FAIL
> Listing only the last 100 lines from a long log.

Yes indeed, the tests fail in this 2nd commit as the EXTI device isn't conn=
ected to the SoC yet (3rd commit).
I forgot to mention it in this in this version :/
Swapping the 2nd and 3rd commmit seems more straightforward to do ?=20




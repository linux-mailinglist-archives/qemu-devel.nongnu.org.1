Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A40D4744AF1
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 21:30:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFgHg-0003N4-Er; Sat, 01 Jul 2023 15:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qFgHe-0003Mu-Dh
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 15:29:26 -0400
Received: from mail-4317.proton.ch ([185.70.43.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qFgHa-0007OU-RC
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 15:29:26 -0400
Date: Sat, 01 Jul 2023 19:29:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laplante.io;
 s=protonmail3; t=1688239752; x=1688498952;
 bh=i8K2vJUiowWcsU37uUHc9qV1/+nmDQbDDIlxVWpMCxY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=amNwJED0W9OY4g38LFCN3ye41hV6zHawwzSc//mhUJxnfV2bDn8jMu/1uRG6cwS74
 TGTHhbMXKD6KWs5xyqlZu75Wvii3KIPfJgVN8a9o9orSBwT4N5xl/zYFOZMeytdNDi
 A5Zv4d34vuCkbImSGZgsiGshwYj4ZS/m7oDLCaED7V5PIPWLsI2Prw1qO6XLpqIHfi
 7i0OMkdKOjE6TdTEuPFaf2w7Qfi1OFYDV1W7ATtcK+U6qs+Rb8CqziB0teWy6jJkQz
 0bFT+b8hfzPzsPqzQEfw+Xvnbxv3aGDu31spwoBag2TeQX5qTit+ReNmg1L3D5jQfS
 bXSacdgYzMiIw==
To: Peter Maydell <peter.maydell@linaro.org>
From: Chris Laplante <chris@laplante.io>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: Emulation of 'System OFF' mode in ARM nRF51 SoCs
Message-ID: <qy_CVPE85v6mhzp6uqOrcOH8ZTGsRDVzv4I4n1WWEjnOr4hSeYVEw9BvjbINNK7mCtMxWSyWBFhUGEZLSgAzJWPHZcfnEEX15e-kwZGEEGE=@laplante.io>
In-Reply-To: <CAFEAcA-L=LsAiLAeeQUH1AFFdNJw3D=mNtd4sQW7ZVDme4yhyw@mail.gmail.com>
References: <j6_NJPGssQ1eBAedcPGs0eURXeMcehbzMcwJtaGvzN_FdUbQKyTP1cyEJWC759G72UNSVpX-QmQ4u6iJvZmt2c_vRO7rhryDQs9icVy5iEI=@laplante.io>
 <CAFEAcA-L=LsAiLAeeQUH1AFFdNJw3D=mNtd4sQW7ZVDme4yhyw@mail.gmail.com>
Feedback-ID: 43500449:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.17; envelope-from=chris@laplante.io;
 helo=mail-4317.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Peter,

> The reference manual is very unclear about what this "emulated
> system off" mode actually does. I think that implementing
> real "system off" is probably simpler. For that you should be able
> to implement it something like this:
>=20
> (1) the power management device implements the SYSTEMOFF register
> to call arm_set_cpu_off() when a 1 is written
> (2) make sure the GPIO device implements DETECT as a GPIO output
> signal, ie an outbound qemu_irq (if we don't do this already
> the functionality will need to be added to the device model)

Working on adding this now. One question - if the CPU is off (via arm_set_c=
pu_off), will the 'DETECT' IRQ I add to nrf51_gpio.c still fire?=20

> (3) similarly for ANADETECT from the LPCOMP device
> (4) Wire those qemu_irq GPIO outputs up to inputs on the
> power management device. When the power management device
> sees those signals go high and the CPU is in system off mode,
> it should trigger the reset of the CPU by calling
> arm_set_cpu_on_and_reset().
>

There is no power management IC or device in this system. Is it something I=
 can implement in nrf51 directly, or will I need to do it in machine contex=
t? I guess what I'm asking is, if the CPU is off, can it still wake itself =
up?

Thanks,
Chris


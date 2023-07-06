Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F0474A69F
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 00:14:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHXEe-0001j3-EF; Thu, 06 Jul 2023 18:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qHXEb-0001is-Um
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 18:13:57 -0400
Received: from mail-40136.proton.ch ([185.70.40.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qHXEa-00031Z-5J
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 18:13:57 -0400
Date: Thu, 06 Jul 2023 22:13:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laplante.io;
 s=protonmail3; t=1688681633; x=1688940833;
 bh=ihzoZCGFZ5ntzCwiE9JXn3gSY8YOVOv7eLTav8aubpQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=bz2/ackP9D0Z+yzWR1UWKDkiwF6p+go6sZ4mhFzFtTUXeDH3x5WNuky0wEs5olbKZ
 wc/B6u/ovHBtBp4Qub3kUo9+Fqt+ZEEmiJzG20+Df7SaaQbCZYhaMzsRF4d4jp+++A
 FeVBkSh5u3V7MnKHgKz2hGx4PM1/iIDqVYk9a48i1F8yLyVLJmRLPO2VCkJ0maUMgT
 lom4WzorBpWvts6/OyJJiCpJb//UPjbc4mlZ5URbSXxyOeLGDHm9O0AquWKnkF/H59
 yu69nSdoLQiNJGeveC25qyNeYjWN1mpM2ySQFIIrxGNTIfoWaCS513y85YvGzbeUp4
 bxsnpOT+5fcrA==
To: Peter Maydell <peter.maydell@linaro.org>
From: Chris Laplante <chris@laplante.io>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: Emulation of 'System OFF' mode in ARM nRF51 SoCs
Message-ID: <h-2hS-ejSNKrLMH2VXf9yt2ig1aK7v79-UbWvGm_BOWBJDO4OXM3XCw3-GeLr8IaSaEjHayBxbERUcJu95s_PRk6CQzSH432RbUFVCRuJec=@laplante.io>
In-Reply-To: <CAFEAcA-4A0Lzy2g2vk0Ja3Bw_j904ePMfD0Z9eNc5ZVkrLpfKA@mail.gmail.com>
References: <j6_NJPGssQ1eBAedcPGs0eURXeMcehbzMcwJtaGvzN_FdUbQKyTP1cyEJWC759G72UNSVpX-QmQ4u6iJvZmt2c_vRO7rhryDQs9icVy5iEI=@laplante.io>
 <CAFEAcA-L=LsAiLAeeQUH1AFFdNJw3D=mNtd4sQW7ZVDme4yhyw@mail.gmail.com>
 <qy_CVPE85v6mhzp6uqOrcOH8ZTGsRDVzv4I4n1WWEjnOr4hSeYVEw9BvjbINNK7mCtMxWSyWBFhUGEZLSgAzJWPHZcfnEEX15e-kwZGEEGE=@laplante.io>
 <CAFEAcA-4A0Lzy2g2vk0Ja3Bw_j904ePMfD0Z9eNc5ZVkrLpfKA@mail.gmail.com>
Feedback-ID: 43500449:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.136; envelope-from=chris@laplante.io;
 helo=mail-40136.proton.ch
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

> >=20
> > Working on adding this now. One question - if the CPU is off (via arm_s=
et_cpu_off), will the 'DETECT' IRQ I add to nrf51_gpio.c still fire?
>=20
>=20
> Yes. The only thing that turning the CPU off affects is
> the CPU -- all the rest of the devices in the system
> continue to behave as normal.
>=20

Excellent, thanks.

> > There is no power management IC or device in this system.
>=20
>=20
> The manual says there is: chapter 12 describes the
> power management and the registers involved, which are
> in the POWER peripheral part of the SoC, starting at
> 0x4000_0000. QEMU just doesn't model that yet.
>

Ah yes, my mistake. I am working on implementing the POWER peripheral (alon=
g with CLOCK and MPU, since they are overlapped at 0x4000_0000). It will be=
 called nrf51_cpm.

I have modified the GPIO peripheral to support the DETECT mechanism, and so=
 far it seems to work. I have also locally implemented a version of qtest_i=
rq_intercept_out which supports named GPIO out interrupts, and I have a qte=
st that confirms that basic functionality of DETECT is working.=20

Hoping to have patches to send in the next couple weeks.

Thanks,
Chris


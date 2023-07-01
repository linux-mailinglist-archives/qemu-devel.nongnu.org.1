Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A98DD744AF2
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 21:30:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFgIB-0003SQ-7d; Sat, 01 Jul 2023 15:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>)
 id 1qFgI8-0003Qr-WE; Sat, 01 Jul 2023 15:29:57 -0400
Received: from mail-4018.proton.ch ([185.70.40.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>)
 id 1qFgI7-0007Ss-BO; Sat, 01 Jul 2023 15:29:56 -0400
Date: Sat, 01 Jul 2023 19:29:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laplante.io;
 s=protonmail3; t=1688239792; x=1688498992;
 bh=pl+wOjZUOTFt0Nk3510CBbG02v9fl37VNTEj7ZB0OcA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Fyl0cqC7solQoeTK0eH+KseDQZvL2LmPBSVA0QByO2uuHX7h9vKZ+LEvRQ0aQWKNv
 FzLvp6RNNGnnidRtFFa++lDv37g9QTo0y+CykkHQeA0ngRjnev11S7tmfCni8u54lx
 42Hhjvb+sxWEWHVnw3XzNTo+jEAbxfny9oVHo36bPknmMnTfDf17gQzsuIkvHdjHj7
 Z/LTQHYKzvtnT2pZ6jmWSqXbUdrfie7OQdOS7uV0CO0L6+PLTdSQftW4UPv6rCDQ8K
 Nwx2aewu5ANEXlZ2dWq3XlijTxwv+gP/sqNBniTQ4meu29fNLYEUkZZJGR+UdbQ/4O
 uYAA0gprIlxbA==
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
From: Chris Laplante <chris@laplante.io>
Cc: qemu-arm <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: Emulation of 'System OFF' mode in ARM nRF51 SoCs
Message-ID: <MohQfUExfL0nZ3j8PyHN2oCI7rFFewEiEJGrkiEJvvj1R6VDX2KhN4miSxpq8MVBbXD0NqZG_F1ZVYQZ9fhNnISfa8p6JC2hOuXajIgMiew=@laplante.io>
In-Reply-To: <80bafa6e-77d0-184d-4798-207d13ab435d@linaro.org>
References: <j6_NJPGssQ1eBAedcPGs0eURXeMcehbzMcwJtaGvzN_FdUbQKyTP1cyEJWC759G72UNSVpX-QmQ4u6iJvZmt2c_vRO7rhryDQs9icVy5iEI=@laplante.io>
 <80bafa6e-77d0-184d-4798-207d13ab435d@linaro.org>
Feedback-ID: 43500449:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.18; envelope-from=chris@laplante.io;
 helo=mail-4018.proton.ch
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

Hi Phil,

> What problem are you getting with a single CPU?
> The "arm/arm-powerctl.h" API should work well.
> If you scheduled a timer, I expect it to awake
> your CPU on expiration. You can also use a QMP
> command to toggle a GPIO and trigger an IRQ.
>=20
> You can use the qtest API to test your code,
> see some tests in tests/qtest/ using:
> - qtest_set_irq_in()
> - qtest_qom_set_bool() for GPIO

Thanks for the tips - I am working on implementing this now!

Chris


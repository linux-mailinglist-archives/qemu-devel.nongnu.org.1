Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B26772FF51
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 15:02:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Q7k-0002iT-E3; Wed, 14 Jun 2023 09:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1q9GF5-0007uE-JV
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 22:28:15 -0400
Received: from mail-4323.proton.ch ([185.70.43.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1q9GF2-0002ft-DR
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 22:28:15 -0400
Date: Wed, 14 Jun 2023 02:27:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laplante.io;
 s=protonmail3; t=1686709688; x=1686968888;
 bh=8uPW03U55VSYSgjj85LL6fF+t0B9YdJD9M2RWCsyShE=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=eXGIMoG+fAVydhTNd2OgL0g4I2P5xXYJB1sSxY6lHEQ98EPgYna7KsyLne5pgh+iX
 vl/W7urSqhEv/CiaysXLB9FnPxIVNksIh1O2SUF0vdfkyweO4EFCqPlYzTNXCZBhdD
 S0jEkK4Jt4HNUQb3mHgNXfd35yiL7/iJQx5sOXeRdzAOCLx/TgfIDC6QuSY2+hvwWS
 BKD9LUcEQ3cjk4WfcOX4DAlmTVwW4M+3AZAwnK0TlSR9YX2UnC7Ua6V48NFg17nDUW
 Qi5lXSIuXgdejWr6n//F0H+tl75M9O2ILZPn6be8nxKLnRwIbTVjTXdB1hjqBQquJg
 iWBy5Z29k1SCQ==
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: Chris Laplante <chris@laplante.io>
Subject: Emulation of 'System OFF' mode in ARM nRF51 SoCs
Message-ID: <j6_NJPGssQ1eBAedcPGs0eURXeMcehbzMcwJtaGvzN_FdUbQKyTP1cyEJWC759G72UNSVpX-QmQ4u6iJvZmt2c_vRO7rhryDQs9icVy5iEI=@laplante.io>
Feedback-ID: 43500449:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.23; envelope-from=chris@laplante.io;
 helo=mail-4323.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Jun 2023 09:01:16 -0400
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

Hi all,

I am working on improving nRF51 emulation. Specifically I want to implement=
 the special "System OFF" mode. System OFF is a power saving mode. In this =
mode, the system can only be woken up by a reset or a handful of peripheral=
s (most notably, GPIO via high/low level detection on configured pins).=
=C2=A0System reset is triggered upon wakeup.

I've been digging into the QEMU mailing list and source code and have come =
to the conclusion that deep sleep and low power modes are not implemented. =
There seems to be support for turning off ARM CPU cores, e.g. as used by im=
x6_src.c. But that doesn't apply here because I only have one CPU.=C2=A0

So ultimately what I think I will try to implement is what the nRF51 refere=
nce manual calls "Emulated System OFF mode". From the reference manual:

    If the device is in debug interface mode, System OFF will be emulated t=
o secure=20
    that all required resources needed for debugging are available during S=
ystem OFF...=20
    Since the CPU is kept on in emulated System OFF mode, it is recommended=
=20
    to add an infinite loop directly after entering System OFF, to prevent =
the CPU from=20
    executing code that normally should not be executed.

Does anyone have any guidance on how to implement this? I don't particularl=
y care about fidelity. As long as a GPIO level trigger can break the CPU ou=
t of the infinite loop (which the reference manual tells users to add) and =
jump into the reset vector, it will be good enough for my use. I don't real=
ly care about masking out other interrupt sources, for example.

Thanks,
Chris


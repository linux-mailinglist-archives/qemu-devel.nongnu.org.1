Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F107EBEB0
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 09:40:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3BQW-0004aE-5d; Wed, 15 Nov 2023 03:39:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1r3BDN-0005jc-6F
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 03:25:37 -0500
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1r3BDK-00088x-Ih
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 03:25:35 -0500
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id B4DF411F042;
 Wed, 15 Nov 2023 08:25:32 +0000 (UTC)
From: ~inesvarhol <inesvarhol@git.sr.ht>
Date: Wed, 15 Nov 2023 08:25:32 +0000
MIME-Version: 1.0
Subject: [PATCH RFC 0/2] hw/arm: Add minimal support for the B-L475E-IOT01A
 board
Message-ID: <170003673257.14701.8139061802716120109-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 15 Nov 2023 03:39:05 -0500
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
Reply-To: ~inesvarhol <inesvarhol@proton.me>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This patch allows to emulate the B-L475E-IOT01A ARM Cortex-M4 board.
This is RFC since the implementation isn't complete yet, there are no
implemented
peripherals, and it's a first contribution to QEMU.

In=C3=A8s Varhol (2):
  hw/arm: Add minimal support for the STM32L475VG SoC
  hw/arm: Add minimal support for the B-L475E-IOT01A board

 configs/devices/arm-softmmu/default.mak |   1 +
 hw/arm/Kconfig                          |  11 ++
 hw/arm/b-l475e-iot01a.c                 |  71 +++++++
 hw/arm/meson.build                      |   2 +
 hw/arm/stm32l475vg_soc.c                | 241 ++++++++++++++++++++++++
 include/hw/arm/stm32l475vg_soc.h        |  60 ++++++
 6 files changed, 386 insertions(+)
 create mode 100644 hw/arm/b-l475e-iot01a.c
 create mode 100644 hw/arm/stm32l475vg_soc.c
 create mode 100644 include/hw/arm/stm32l475vg_soc.h

--=20
2.38.5


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB2E80BCA5
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 20:07:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCP75-0007Cx-19; Sun, 10 Dec 2023 14:05:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1rCP71-0007C9-Jp; Sun, 10 Dec 2023 14:05:11 -0500
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1rCP6z-0000jW-SM; Sun, 10 Dec 2023 14:05:11 -0500
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 943FF11EEAC;
 Sun, 10 Dec 2023 19:05:06 +0000 (UTC)
From: ~inesvarhol <inesvarhol@git.sr.ht>
Date: Sun, 10 Dec 2023 19:05:06 +0000
MIME-Version: 1.0
Subject: [PATCH qemu 0/3] [PATCH qemu 0/3] hw/arm: Add device STM32L4x5 SYSCFG
Message-ID: <170223510627.13579.3191933474458037037-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alistair@alistair23.me, philmd@linaro.org,
 peter.maydell@linaro.org, ines.varhol@telecom-paris.fr,
 arnaud.minier@telecom-paris.fr
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

This patch adds a new SYSCFG peripheral used by the STM32L4x5 SoC.
The implementation is inspired from the STM32F4xx SYSCFG, the device
registers however aren't the same.

The patch is split up in 3 commits :
- implementing the SYSCFG device
- adding tests (that fail in this commit)
- connecting the SYSCFG device to the SoC (the tests pass in this
commit)

Based-on: <170198462199.32162.284497577253427308-0@git.sr.ht>
([PATCH qemu 0/3] hw/arm: Add device STM32L4x5 EXTI)

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

In=C3=A8s Varhol (3):
  hw/misc: Implement STM32L4xx SYSCFG
  tests/qtest: Add STM32L4xx SYSCFG QTest testcase
  hw/arm: Connect STM32L4xx SYSCFG to STM32L4x5 SoC

 hw/arm/Kconfig                      |   1 +
 hw/arm/stm32l4x5_soc.c              |  24 +-
 hw/misc/Kconfig                     |   3 +
 hw/misc/meson.build                 |   1 +
 hw/misc/stm32l4xx_syscfg.c          | 277 +++++++++++++++++++
 hw/misc/trace-events                |   6 +
 include/hw/arm/stm32l4x5_soc.h      |   2 +
 include/hw/misc/stm32l4xx_syscfg.h  |  62 +++++
 tests/qtest/meson.build             |   3 +-
 tests/qtest/stm32l4xx_syscfg-test.c | 408 ++++++++++++++++++++++++++++
 10 files changed, 778 insertions(+), 9 deletions(-)
 create mode 100644 hw/misc/stm32l4xx_syscfg.c
 create mode 100644 include/hw/misc/stm32l4xx_syscfg.h
 create mode 100644 tests/qtest/stm32l4xx_syscfg-test.c

--=20
2.38.5


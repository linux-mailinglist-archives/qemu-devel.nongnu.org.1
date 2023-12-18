Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FF8816C08
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:17:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBb8-00072F-GV; Mon, 18 Dec 2023 06:15:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1rFBb4-00071K-ON; Mon, 18 Dec 2023 06:15:42 -0500
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1rFBb2-0008IM-Oi; Mon, 18 Dec 2023 06:15:42 -0500
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id D6CDA11EFC9;
 Mon, 18 Dec 2023 11:15:38 +0000 (UTC)
From: ~inesvarhol <inesvarhol@git.sr.ht>
Date: Mon, 18 Dec 2023 11:15:38 +0000
MIME-Version: 1.0
Subject: [PATCH qemu v2 0/3] Add device STM32L4x5 SYSCFG
Message-ID: <170289813862.19159.2545029501234884208-0@git.sr.ht>
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

Hello Alistair, thank you for your comments.

Changes from v1 to v2:
- explain in 3rd commit why SYSCFG input GPIOs aren't connected and add
a TODO comment in stm32l4x5_soc.c
- use macros `NUM_GPIOS` and `GPIO_NUM_PINS` in
`stm32l4x5_syscfg_set_irq`
- rename STM32L4XX to STM32L4X5, Stm32l4xx to Stm32l4x5
(the SYSCFG implementation is only valid for STM32L4x5 and STM32L4x6
but not for STM32L41xx/42xx/43xx/44xx)
- refactor STM32L4x5SyscfgState to Stm32l4x5SyscfgState to be
consistent with other peripherals

Based-on: <170289109015.23396.9428181315206234398-0@git.sr.ht>
([PATCH qemu v3 0/3] Add device STM32L4x5 EXTI)

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

In=C3=A8s Varhol (3):
  hw/misc: Implement STM32L4x5 SYSCFG
  tests/qtest: Add STM32L4x5 SYSCFG QTest testcase
  hw/arm: Connect STM32L4x5 SYSCFG to STM32L4x5 SoC

 hw/arm/Kconfig                      |   1 +
 hw/arm/stm32l4x5_soc.c              |  23 +-
 hw/misc/Kconfig                     |   3 +
 hw/misc/meson.build                 |   1 +
 hw/misc/stm32l4x5_syscfg.c          | 265 ++++++++++++++++++
 hw/misc/trace-events                |   6 +
 include/hw/arm/stm32l4x5_soc.h      |   2 +
 include/hw/misc/stm32l4x5_syscfg.h  |  54 ++++
 tests/qtest/meson.build             |   3 +-
 tests/qtest/stm32l4x5_syscfg-test.c | 408 ++++++++++++++++++++++++++++
 10 files changed, 764 insertions(+), 2 deletions(-)
 create mode 100644 hw/misc/stm32l4x5_syscfg.c
 create mode 100644 include/hw/misc/stm32l4x5_syscfg.h
 create mode 100644 tests/qtest/stm32l4x5_syscfg-test.c

--=20
2.38.5


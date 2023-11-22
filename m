Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1457F4768
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 14:12:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5n0s-0006te-Aa; Wed, 22 Nov 2023 08:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1r5n0o-0006sK-PX; Wed, 22 Nov 2023 08:11:26 -0500
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1r5n0m-0001vc-2a; Wed, 22 Nov 2023 08:11:25 -0500
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id DA7EF11EE04;
 Wed, 22 Nov 2023 13:11:19 +0000 (UTC)
From: ~aminier <aminier@git.sr.ht>
Date: Wed, 22 Nov 2023 13:11:19 +0000
MIME-Version: 1.0
Subject: [PATCH qemu v2 0/1] Implement STM32L4x5 EXTI
Message-ID: <170065867969.8823.8108107963720785285-0@git.sr.ht>
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
Reply-To: ~aminier <arnaud.minier@telecom-paris.fr>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This patch allows to emulate the STM32L4x5 EXTI device.
It implements register access and software interruptions.

This is RFC since we still have troubles to make all tests pass.
More precisely, the line `g_assert_true(get_irq(GPIO_0_IRQ));` fails in
the software interrupts test. No irq seems to be fired.
(We also tested the stm32f4_exti (on which this implementation is based
upon) on but it also fails so don't really know if the test or the
implementation is incorrect).

Thank you Philippe for your reviews ! They are really useful !
The code is now more concise and clear.

Also, In=C3=A8s and I were wondering what would be the next step for our
previous patchset that adds support for the B-L475E-IOT01A board and
STM32L4x5 SoC.
We used the RFC tag because we were unsure if this met Qemu quality
standard.
But now that this has been reviewed, is there anything we should to move
it forward and merge it ?

Sincerely,
Arnaud Minier

Changes from v1 to v2:
- use arrays to deduplicate code and logic
- move internal constant `EXTI_NUM_GPIO_EVENT_IN_LINES` from the header
to the .c file
- Improve copyright headers
- replace `static const` with `#define`
- use the DEFINE_TYPES macro
- fill the `impl` and `valid` field of the exti's `MemoryRegionOps`
- fix invalid test caused by a last minute change

Based-on: <170049810484.22920.612074576971878323-0@git.sr.ht>
([RFC v3 2/2] hw/arm: Add minimal support for the B-L475E-IOT01A board)

Arnaud Minier (1):
  Implement STM32L4x5 EXTI

 hw/arm/Kconfig                    |   1 +
 hw/arm/stm32l4x5_soc.c            |  65 ++++++-
 hw/misc/Kconfig                   |   3 +
 hw/misc/meson.build               |   1 +
 hw/misc/stm32l4x5_exti.c          | 303 ++++++++++++++++++++++++++++++
 hw/misc/trace-events              |   5 +
 include/hw/arm/stm32l4x5_soc.h    |   3 +
 include/hw/misc/stm32l4x5_exti.h  |  58 ++++++
 tests/qtest/meson.build           |   5 +
 tests/qtest/stm32l4x5_exti-test.c | 104 ++++++++++
 10 files changed, 546 insertions(+), 2 deletions(-)
 create mode 100644 hw/misc/stm32l4x5_exti.c
 create mode 100644 include/hw/misc/stm32l4x5_exti.h
 create mode 100644 tests/qtest/stm32l4x5_exti-test.c

--=20
2.38.5


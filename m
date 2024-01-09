Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF8F828E0B
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 20:46:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNI1t-00013f-Du; Tue, 09 Jan 2024 14:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rNI1r-00013N-7B; Tue, 09 Jan 2024 14:44:51 -0500
Received: from zproxy1.enst.fr ([137.194.2.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rNI1p-0005c4-2j; Tue, 09 Jan 2024 14:44:50 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 8D9F4C0CDE;
 Tue,  9 Jan 2024 20:44:46 +0100 (CET)
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id Iy8tK8_qiNsi; Tue,  9 Jan 2024 20:44:45 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id A77C0C0CF6;
 Tue,  9 Jan 2024 20:44:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy1.enst.fr A77C0C0CF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1704829485;
 bh=AALDtbxiHDFlIUTu8ehdDRQQJ3tSs7nKyZkmY3F09Ng=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=owQmPfSHTFVjw87NWKV0zwa6Zk17qwcJn5h87NuKdlGS0Cdx5wpveA8uCn0CDtQ/z
 MIj+tRGhbgoyzbl+wNxaPTLowQOYlruVq2tz5ZkaJw40p4EHx0REZAgGP7WNz9BcDj
 9DXUTvNeEy9OJzptB0ZDlNB2nPFnFLTF0iMbCq6w=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id ad4DrU6UqU8m; Tue,  9 Jan 2024 20:44:45 +0100 (CET)
Received: from localhost.localdomain (74.0.125.80.rev.sfr.net [80.125.0.74])
 by zproxy1.enst.fr (Postfix) with ESMTPSA id 0AC82C0643;
 Tue,  9 Jan 2024 20:44:44 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v4 0/3] Add device STM32L4x5 SYSCFG
Date: Tue,  9 Jan 2024 20:41:56 +0100
Message-ID: <20240109194438.70934-1-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.220;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy1.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This patch adds a new device STM32L4x5 SYSCFG device and is part
of a series implementing the STM32L4x5 with a few peripherals.

Changes from v3 to v4:
- swapping commit 2 (add tests) and commit 3 (connect syscfg to SoC)
so that the tests pass in the commit they're added
- in `stm32l4x5_syscfg-test.c`: instead of declaring intermediate
variables, using `syscfg_readl` directly in `g_assert_cmpuint`
so that QEMU coding style is respected
- in `stm32l4x5_syscfg-test.c`: the tests are now independant
from the EXTI device (the reads in EXTI registers were unnecessary)
- in `stm32l4x5_syscfg-test.c` : using a helper function
`syscfg_set_irq()` to help readability
- in `stm32l4x5_soc.c` : reducing scope of `i` used in for loops
- in `stm32l4x5_soc.c` : removing useless variable `dev`
- in `stm32l4x5_syscfg.c`: add macro `NUM_LINES_PER_EXTICR_REG`,
correct some coding styles issues

Changes from v2 to v3:
- updating the B-L475E-IOT01A machine's documentation file
- using `GPIO_NUM_PINS` instead of 16 in `stm32l4x5_syscfg_init`
- correcting the formatting of multiline indents
- renaming a trace function (`trace_stm32l4x5_syscfg_forward_exti`
instead of `trace_stm32l4x5_syscfg_pulse_exti`)

Changes from v1 to v2:
- explain in 3rd commit why SYSCFG input GPIOs aren't connected and add
a TODO comment in stm32l4x5_soc.c
- use macros `NUM_GPIOS` and `GPIO_NUM_PINS` in
`stm32l4x5_syscfg_set_irq`
- rename STM32L4XX to STM32L4X5, Stm32l4xx to Stm32l4x5
(the SYSCFG implementation is only valid for STM32L4x5 and STM32L4x6
but not for STM32L41xx/42xx/43xx/44xx)
- refactor `STM32L4x5SyscfgState` to `Stm32l4x5SyscfgState` to be
consistent with other peripherals

Based-on: 20240109160658.311932-1-ines.varhol@telecom-paris.fr
([PATCH v8 0/3] Add device STM32L4x5 EXTI)

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

In=C3=A8s Varhol (3):
  hw/misc: Implement STM32L4x5 SYSCFG
  hw/arm: Connect STM32L4x5 SYSCFG to STM32L4x5 SoC
  tests/qtest: Add STM32L4x5 SYSCFG QTest testcase

 docs/system/arm/b-l475e-iot01a.rst  |   2 +-
 hw/arm/Kconfig                      |   1 +
 hw/arm/stm32l4x5_soc.c              |  21 +-
 hw/misc/Kconfig                     |   3 +
 hw/misc/meson.build                 |   1 +
 hw/misc/stm32l4x5_syscfg.c          | 266 ++++++++++++++++++++++
 hw/misc/trace-events                |   6 +
 include/hw/arm/stm32l4x5_soc.h      |   2 +
 include/hw/misc/stm32l4x5_syscfg.h  |  54 +++++
 tests/qtest/meson.build             |   3 +-
 tests/qtest/stm32l4x5_syscfg-test.c | 331 ++++++++++++++++++++++++++++
 11 files changed, 687 insertions(+), 3 deletions(-)
 create mode 100644 hw/misc/stm32l4x5_syscfg.c
 create mode 100644 include/hw/misc/stm32l4x5_syscfg.h
 create mode 100644 tests/qtest/stm32l4x5_syscfg-test.c

--=20
2.43.0



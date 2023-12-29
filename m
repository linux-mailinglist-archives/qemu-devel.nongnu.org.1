Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B0982009D
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 17:50:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJG3I-0002jG-CT; Fri, 29 Dec 2023 11:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rJG3A-0002gY-Sx; Fri, 29 Dec 2023 11:49:33 -0500
Received: from zproxy2.enst.fr ([2001:660:330f:2::dd])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rJG37-0001MT-6z; Fri, 29 Dec 2023 11:49:31 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id 4FA628082A;
 Fri, 29 Dec 2023 17:49:22 +0100 (CET)
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id meM-v03YeSjf; Fri, 29 Dec 2023 17:49:21 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id 7B0A88082B;
 Fri, 29 Dec 2023 17:49:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy2.enst.fr 7B0A88082B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1703868561;
 bh=3kKpPsrpqgSAk1g9O4K0piP5JlztXljlDIhqx5moJOU=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=Ckc5vaDem0LZS5C+Qhd6n6h63OXTUPctqFLmVsp2Q+cw75U6TyfE/6MCEjWIMSame
 6WCz43bTt9Qs13+ZaRMe17zoo4h+xBz1TWGj5p2GQswvEoaQd5PfsUhC2KlXGohHl/
 slvEvo+FVxjzXaJ9TyNgHQLmx/gO5aPSTMVjY1IM=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id 8xY6zcvJqJbt; Fri, 29 Dec 2023 17:49:21 +0100 (CET)
Received: from inesv-Inspiron-3501.lan (176-138-236-114.abo.bbox.fr
 [176.138.236.114])
 by zproxy2.enst.fr (Postfix) with ESMTPSA id 24D5D80819;
 Fri, 29 Dec 2023 17:49:21 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 0/3] Add device STM32L4x5 SYSCFG
Date: Fri, 29 Dec 2023 17:47:08 +0100
Message-ID: <20231229164915.133199-1-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::dd;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy2.enst.fr
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

Based-on: <20231228161944.303768-1-ines.varhol@telecom-paris.fr>
([PATCH v5 0/3] Add device STM32L4x5 EXTI)

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

In=C3=A8s Varhol (3):
  hw/misc: Implement STM32L4x5 SYSCFG
  tests/qtest: Add STM32L4x5 SYSCFG QTest testcase
  hw/arm: Connect STM32L4x5 SYSCFG to STM32L4x5 SoC

 docs/system/arm/b-l475e-iot01a.rst  |   2 +-
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
 11 files changed, 765 insertions(+), 3 deletions(-)
 create mode 100644 hw/misc/stm32l4x5_syscfg.c
 create mode 100644 include/hw/misc/stm32l4x5_syscfg.h
 create mode 100644 tests/qtest/stm32l4x5_syscfg-test.c

--=20
2.43.0



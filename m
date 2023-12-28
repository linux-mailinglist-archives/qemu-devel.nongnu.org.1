Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0036B81F9D9
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 17:08:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIsuX-00023j-QS; Thu, 28 Dec 2023 11:07:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rIsuV-00022t-CG; Thu, 28 Dec 2023 11:07:03 -0500
Received: from zproxy3.enst.fr ([2001:660:330f:2::de])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rIsuS-0007D3-S9; Thu, 28 Dec 2023 11:07:03 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 32C56A063C;
 Thu, 28 Dec 2023 17:06:56 +0100 (CET)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id 7OLnJomStnis; Thu, 28 Dec 2023 17:06:55 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 58AE6A0585;
 Thu, 28 Dec 2023 17:06:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr 58AE6A0585
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1703779615;
 bh=x8v0icMcmEibBI7DduO2fvAYF7UGdZjmzjHeRogK3XY=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=ErIawWsz5TLme69tqdyzDajjGDZbPb/HtJDmffI76Z85TaxalJ7DA3cK5tfcJ1wg/
 nlcwj/flRuQIpMoktVM8fvMfQIJi0kBcctgZd16BXVSQNuhBmiEvsa4xkRl2KuCTeb
 P8En4c+AIx4lu3zkT+sChpC4txRgh0Z6d5bO2Qig=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id bF8Bn3M6uNnP; Thu, 28 Dec 2023 17:06:55 +0100 (CET)
Received: from inesv-Inspiron-3501.lan (unknown
 [IPv6:2001:861:4680:b1b0:3937:c54c:5417:70d4])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id 078F5A051C;
 Thu, 28 Dec 2023 17:06:54 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>
Subject: [PATCH v4 0/3] Add device STM32L4x5 EXTI
Date: Thu, 28 Dec 2023 17:06:29 +0100
Message-ID: <20231228160649.299058-1-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::de;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy3.enst.fr
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

Changes from v3 to v4:
- add a test to check that irq trigger selection works correctly
(`test_edge_selector`) and correct `stm32l4x5_exti_set_irq` accordingly
- update the documentation file

Changes from v2 to v3:
- corrected the license to GPL

Changes from v1 to v2:
- correct the commit messages
- remove a misleading comment

Changes from v3 to v1:
- separating the patch in 3 commits
- justifying in the commit message why we implement a new model instead
of changing the existing stm32f4xx_exti
- changed irq_raise to irq_pulse in register SWIERx write
(in `stm32l4x5_exti_write`) to be consistent with the irq_pulse in
`stm32l4x5_exti_set_irq` (and also both these interrupts are
edge-triggered)
- changed the license to GPL

Changes from v2 to v3:
- adding more tests writing/reading in exti registers
- adding tests checking that interrupt work by reading NVIC registers
- correcting exti_write in SWIER (so it sets an irq only when a bit
goes from '0' to '1')
- correcting exti_set_irq (so it never writes in PR when the relevant
bit in IMR is '0')

Changes from v1 to v2:
- use arrays to deduplicate code and logic
- move internal constant `EXTI_NUM_GPIO_EVENT_IN_LINES` from the header
to the .c file
- Improve copyright headers
- replace `static const` with `#define`
- use the DEFINE_TYPES macro
- fill the `impl` and `valid` field of the exti's `MemoryRegionOps`
- fix invalid test caused by a last minute change

Based-on: 20231221213838.54944-1-ines.varhol@telecom-paris.fr
([PATCH v4 0/2] Add minimal support for the B-L475E-IOT01A board)

In=C3=A8s Varhol (3):
  hw/misc: Implement STM32L4x5 EXTI
  tests/qtest: Add STM32L4x5 EXTI QTest testcase
  hw/arm: Connect STM32L4x5 EXTI to STM32L4x5 SoC

 hw/arm/Kconfig                    |   1 +
 hw/arm/stm32l4x5_soc.c            |  56 ++-
 hw/misc/Kconfig                   |   3 +
 hw/misc/meson.build               |   1 +
 hw/misc/stm32l4x5_exti.c          | 288 +++++++++++++++
 hw/misc/trace-events              |   5 +
 include/hw/arm/stm32l4x5_soc.h    |   3 +
 include/hw/misc/stm32l4x5_exti.h  |  51 +++
 tests/qtest/meson.build           |   5 +
 tests/qtest/stm32l4x5_exti-test.c | 596 ++++++++++++++++++++++++++++++
 10 files changed, 1007 insertions(+), 2 deletions(-)
 create mode 100644 hw/misc/stm32l4x5_exti.c
 create mode 100644 include/hw/misc/stm32l4x5_exti.h
 create mode 100644 tests/qtest/stm32l4x5_exti-test.c

--=20
2.43.0



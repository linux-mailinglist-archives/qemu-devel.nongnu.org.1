Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC2682C43C
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 18:07:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOKzc-0005IR-T4; Fri, 12 Jan 2024 12:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rOKza-0005I9-HC; Fri, 12 Jan 2024 12:06:50 -0500
Received: from zproxy2.enst.fr ([137.194.2.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rOKzX-000503-6g; Fri, 12 Jan 2024 12:06:49 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id 23D908068A;
 Fri, 12 Jan 2024 18:06:42 +0100 (CET)
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id hv8Iltz2pEga; Fri, 12 Jan 2024 18:06:41 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id 26877806A7;
 Fri, 12 Jan 2024 18:06:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy2.enst.fr 26877806A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1705079201;
 bh=nN4AxN4bZ4OGgQmrqiZVBP3Aptm+OlATveS92Sj9fmc=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=sxLDPFnNmQs8iyQBWD4IqJP50HIUy2I5ATry898uILT38m3NShBqXohIu71otwjsx
 plGvq0f2k5u39f856yxHLlJqODtM4HkaLSanmlkebdDhHPJfyYXYLwdsuGjC26XPtS
 ikvCgHjnj9wZScBPZjvhsAiA3OMKgY4EsxKKBadc=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id fFkiPx4NyS4X; Fri, 12 Jan 2024 18:06:41 +0100 (CET)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:240:fa97:9da:79c1:e167])
 by zproxy2.enst.fr (Postfix) with ESMTPSA id B22CE8066D;
 Fri, 12 Jan 2024 18:06:40 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [RFC 0/3] Add device STM32L4x5 GPIO
Date: Fri, 12 Jan 2024 18:05:37 +0100
Message-ID: <20240112170635.303226-1-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.221;
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

This patch adds a new device STM32L4x5 GPIO device and is part
of a series implementing the STM32L4x5 with a few peripherals.

This is RFC as the tests need to be corrected and completed.

The way the short-circuits are handled in the code currently :
(0) The model is simplified (it detects pins driven internally and
externally, not actual short-circuits)
(1) It reacts by ignoring external driving and writes
a `qemu_log_mask` about it
(2) The model is tested by using a fake register
`GPIO_DISCONNECTED_PINS` which is quite practical.
However the tests could disconnect pins and check if a pin is
disconnected in other ways (like setting all pins in push-pull
output to disconnect them), should I unmap this attribute?

Some context and more details for (0)

This code uses a simplified model. Instead of checking for
short-circuits each time the driving (internal and external) changes,
some configurations aren't allowed :
- push-pull with external driving
- open-drain with pin set high

Concretely, the pins configured as output can't be set externally
when in push-pull mode, or set high when in open-drain mode.
Conversely, when input/output mode or push-pull/open-drain mode
is changed, the problematic pins driven externally are "disconnected"
and the external value isn't considered anymore.

I saw sifive_gpio.c uses a similar model :
```
/* Pin both driven externally and internally */
if (output_en && in_mask) {
    qemu_log_mask(LOG_GUEST_ERROR, "GPIO pin %zu short circuited\n", i);
}
```

But nrf51_gpio.c actually checks for short-circuits :
```
if (connected_out && connected_in && out !=3D in) {
    /* Pin both driven externally and internally */
    qemu_log_mask(LOG_GUEST_ERROR,
                    "GPIO pin %zu short circuited\n", i);
}
```

Based-on: 20240109194438.70934-1-ines.varhol@telecom-paris.fr
([PATCH v4 0/3] Add device STM32L4x5 SYSCFG)

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

In=C3=A8s Varhol (3):
  hw/gpio: Implement STM32L4x5 GPIO
  hw/arm: Connect STM32L4x5 GPIO to STM32L4x5 SoC
  tests/qtest: Add STM32L4x5 GPIO QTest testcase

 docs/system/arm/b-l475e-iot01a.rst |   2 +-
 hw/arm/Kconfig                     |   3 +-
 hw/arm/stm32l4x5_soc.c             |  62 +++-
 hw/gpio/Kconfig                    |   3 +
 hw/gpio/meson.build                |   1 +
 hw/gpio/stm32l4x5_gpio.c           | 520 +++++++++++++++++++++++++++++
 hw/gpio/trace-events               |   6 +
 include/hw/arm/stm32l4x5_soc.h     |   9 +
 include/hw/gpio/stm32l4x5_gpio.h   |  79 +++++
 tests/qtest/meson.build            |   3 +-
 tests/qtest/stm32l4x5_gpio-test.c  | 319 ++++++++++++++++++
 11 files changed, 991 insertions(+), 16 deletions(-)
 create mode 100644 hw/gpio/stm32l4x5_gpio.c
 create mode 100644 include/hw/gpio/stm32l4x5_gpio.h
 create mode 100644 tests/qtest/stm32l4x5_gpio-test.c

--=20
2.43.0



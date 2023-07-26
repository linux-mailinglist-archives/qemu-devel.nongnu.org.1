Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6B6763B70
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:43:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeWg-0002pf-G6; Wed, 26 Jul 2023 09:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeW3-0002Mm-Dm; Wed, 26 Jul 2023 09:25:23 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeW1-00030h-6T; Wed, 26 Jul 2023 09:25:23 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fe04882c66so3274346e87.3; 
 Wed, 26 Jul 2023 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377918; x=1690982718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RsNy9Hy1FVnRBYygcSGuJbreOH5QR/RlS6aSFKkHkPo=;
 b=pZtSKZ13Av3E0GU/LvHqVRGihRFsKs403XOZSdbRxAyMe9OxgFhXiT2FBu2h+Ku3IR
 kDqwfY+Mq/6ReW+fco97v7QTCg6zzDp3SVcsOXj5+JcA1PhhGbQScwlADz6LDIg8Podu
 MwW1doIIGwb3z1i5NEZvt65mrK6leKY3NuoV5ZKrtuvZh2eTxo+3DqG3BXfM9YVuDhgX
 RxZCxFQVOBS4i6dKCPG9vnY+H4aVZY3AXZP+3I2IGqPbPRrOC7ExZBAfG5iCHzRhBInl
 R71WBJF27FOjHgpSItBhZQb+kXwr8AWVHIi2mWT4yyzfM9GmLe8vQQfVQFgzIjr6brLo
 Ghiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377918; x=1690982718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RsNy9Hy1FVnRBYygcSGuJbreOH5QR/RlS6aSFKkHkPo=;
 b=a5kJPY6OelnkCCzU5woDn7QhVakDQd7+VrcdYhVTVp5I57JbtXtl0rM5xSTKL5RLdi
 bwwYAFnwW/7SoWTJTjSN81SB1Z0O6NwT/ArZ9pjl/hwhaP48YCT2U7RQbvGT17xS7YVm
 l8Yef/o+Y9ZwhZNjKD+7bBWgxYYTDkj2R5umk1P/R2bTueaSZ8Z1TI7zhyevMc22BLUX
 AbGPkWSMNof0z/LOrUZMaQWLQ6384R6R+8ePrDnym1CTAcAss5MZnDJUf/yamDJdjEcq
 wdpSBEyyNthZlZU3lkYFm+z16v3Eeubx1ZTbwO2yLvjLUDH3M2HXpmhExCpu2YsagxfO
 r2ZA==
X-Gm-Message-State: ABy/qLa3MFe2KHVo+eyzRSCMDsljIGWFIjVrAewj5jlWhepDeAwLEJ7f
 x2QuegSKto7pqhafjpeNK5KYsAFl9w0=
X-Google-Smtp-Source: APBJJlGtGzLlCP9vQn7zKBErcr9jlST52NI1kPI1ilzUS7fAbJUThXS7F5ZUSWPVpVSsj9banMLPMg==
X-Received: by 2002:ac2:5f48:0:b0:4fe:676:8c0b with SMTP id
 8-20020ac25f48000000b004fe06768c0bmr1424894lfz.11.1690377918310; 
 Wed, 26 Jul 2023 06:25:18 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:25:17 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 00/44] Raspberry Pi 4B machine
Date: Wed, 26 Jul 2023 16:24:28 +0300
Message-Id: <20230726132512.149618-1-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Introducing Raspberry Pi 4B model.
It contains new BCM2838 SoC, PCIE subsystem,
RNG200, Thermal sensor and Genet network controller.

It can work with recent linux kernels 6.x.x.
Two avocado tests was added to check that.

Unit tests has been made as read/write operations
via mailbox properties.

Genet integration test is under development.

Every single commit
1) builds without errors
2) passes regression tests
3) passes style check*
*the only exception is bcm2838-mbox-property-test.c file
containing heavy macros usage which cause a lot of
false-positives of checkpatch.pl.

I did my best to keep the commits less than 200 changes,
but had to make some of them a bit more in order to
keep their integrity.

Sergey Kambalin (44):
  Split out common part of BCM283X classes
  Split out common part of peripherals
  Split out raspi machine common part
  Introduce BCM2838 SoC
  Add GIC-400 to BCM2838 SoC
  Add BCM2838 GPIO stub
  Implement BCM2838 GPIO functionality
  Connect SD controller to BCM2838 GPIO
  Add GPIO and SD to BCM2838 periph
  Add BCM2838 checkpoint support
  Introduce Raspberry PI 4 machine
  Temporary disable unimplemented rpi4b devices
  Add memory region for BCM2837 RPiVid ASB
  Add BCM2838 PCIE Root Complex
  Add BCM2838 PCIE host
  Enable BCM2838 PCIE
  Add RNG200 skeleton
  Add RNG200 RNG and RBG
  Add RNG200 timer
  Implement BCM2838 thermal sensor
  Add clock_isp stub
  Add GENET stub
  Add GENET register structs. Part 1
  Add GENET register structs. Part 2
  Add GENET register structs. Part 3
  Add GENET register structs. Part 4
  Add GENET register access macros
  Impl GENET register ops.
  Impl GENET MDIO
  Impl GENET TX path
  Impl GENET RX path
  Enable BCM2838 GENET controller
  Connect RNG200, PCIE and GENET to GIC
  Add Rpi4b boot tests
  Add mailbox test stub
  Add mailbox test constants
  Add mailbox tests tags. Part 1
  Add mailbox tests tags. Part 2
  Add mailbox tests tags. Part 3
  Add mailbox property tests. Part 1
  Add mailbox property tests. Part 2
  Add mailbox property tests. Part 3
  Add missed BCM2835 properties
  Append added properties to mailbox test

 hw/arm/bcm2835_peripherals.c             | 218 ++++---
 hw/arm/bcm2836.c                         | 116 ++--
 hw/arm/bcm2838.c                         | 298 +++++++++
 hw/arm/bcm2838_pcie.c                    | 293 +++++++++
 hw/arm/bcm2838_peripherals.c             | 288 +++++++++
 hw/arm/meson.build                       |   8 +-
 hw/arm/raspi.c                           | 128 ++--
 hw/arm/raspi4b.c                         | 225 +++++++
 hw/arm/trace-events                      |   6 +
 hw/gpio/bcm2838_gpio.c                   | 392 ++++++++++++
 hw/gpio/meson.build                      |   5 +-
 hw/misc/bcm2835_property.c               | 170 +++++
 hw/misc/bcm2838_rng200.c                 | 419 +++++++++++++
 hw/misc/bcm2838_thermal.c                |  96 +++
 hw/misc/meson.build                      |   2 +
 hw/misc/trace-events                     |  10 +
 hw/net/bcm2838_genet.c                   | 756 +++++++++++++++++++++++
 hw/net/meson.build                       |   2 +
 hw/net/trace-events                      |  17 +
 include/hw/arm/bcm2835_peripherals.h     |  29 +-
 include/hw/arm/bcm2836.h                 |  27 +-
 include/hw/arm/bcm2838.h                 |  28 +
 include/hw/arm/bcm2838_pcie.h            |  67 ++
 include/hw/arm/bcm2838_peripherals.h     |  95 +++
 include/hw/arm/raspi_platform.h          |  34 +
 include/hw/display/bcm2835_fb.h          |   2 +
 include/hw/gpio/bcm2838_gpio.h           |  45 ++
 include/hw/misc/bcm2838_rng200.h         |  77 +++
 include/hw/misc/bcm2838_thermal.h        |  24 +
 include/hw/misc/raspberrypi-fw-defs.h    |  11 +
 include/hw/net/bcm2838_genet.h           | 732 ++++++++++++++++++++++
 tests/avocado/boot_linux_console.py      |  92 +++
 tests/qtest/bcm2838-mailbox.c            |  70 +++
 tests/qtest/bcm2838-mailbox.h            | 603 ++++++++++++++++++
 tests/qtest/bcm2838-mbox-property-test.c | 666 ++++++++++++++++++++
 tests/qtest/meson.build                  |   3 +-
 36 files changed, 5857 insertions(+), 197 deletions(-)
 create mode 100644 hw/arm/bcm2838.c
 create mode 100644 hw/arm/bcm2838_pcie.c
 create mode 100644 hw/arm/bcm2838_peripherals.c
 create mode 100644 hw/arm/raspi4b.c
 create mode 100644 hw/gpio/bcm2838_gpio.c
 create mode 100644 hw/misc/bcm2838_rng200.c
 create mode 100644 hw/misc/bcm2838_thermal.c
 create mode 100644 hw/net/bcm2838_genet.c
 create mode 100644 include/hw/arm/bcm2838.h
 create mode 100644 include/hw/arm/bcm2838_pcie.h
 create mode 100644 include/hw/arm/bcm2838_peripherals.h
 create mode 100644 include/hw/gpio/bcm2838_gpio.h
 create mode 100644 include/hw/misc/bcm2838_rng200.h
 create mode 100644 include/hw/misc/bcm2838_thermal.h
 create mode 100644 include/hw/net/bcm2838_genet.h
 create mode 100644 tests/qtest/bcm2838-mailbox.c
 create mode 100644 tests/qtest/bcm2838-mailbox.h
 create mode 100644 tests/qtest/bcm2838-mbox-property-test.c

-- 
2.34.1



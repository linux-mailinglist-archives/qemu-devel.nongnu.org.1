Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE73866719
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Feb 2024 01:05:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reOSs-0006ch-B1; Sun, 25 Feb 2024 19:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOSg-0006VM-8B; Sun, 25 Feb 2024 19:03:15 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOSb-0000GX-S1; Sun, 25 Feb 2024 19:03:11 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-608dcb3a1cdso9551927b3.3; 
 Sun, 25 Feb 2024 16:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708905783; x=1709510583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xh9GUoztdsMw4XbJM+HrJ0RmMjhiGtE6C1BDJ8vP0lo=;
 b=WYVGU0mqmR2BAmKjwkFdcsGegUqI9ISAqgRhptd63vwtvHS5xrJ/i0gskGNPlaHzCk
 Mdcwcco/UP0KfePlO97xxNvjhbMuwB7g6ULmjNQD5BXLz2m3RuIR1jjRQ8pqC8k2zmrk
 RtB8w3RlnqGQkvVClSJ7LsJ1DaDuENiUEXpEyg4GBq5GfjGBYK5WJPfGUI48KNHkf415
 urcJMiyvib765Dk6pfhLqnFHm2IALzbnb5ODvBwB7n9ilDFixcNibYiDqBItLptvM6IX
 tOYQrrpE3cyHzEpKaLi9lzPXPlgLWl8HN1OVq+tJk+RlyS+9aXojAOpRFquMxuubmtn/
 GXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708905783; x=1709510583;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xh9GUoztdsMw4XbJM+HrJ0RmMjhiGtE6C1BDJ8vP0lo=;
 b=qY1Qnv7AHwsfLCtnmPrHM37/HgG0jQEN7aXJTYzaKHADMkxuhBfMVs7iTW+vEdYG2O
 5wlabBrbXXgGiR4FvrMgwBMSY4/LAGMZlvt7PrKfylfwtCagzp8xIf2vSZk03BlkCrYV
 dzMxiruQadlhBgpXG9yG/yT6EuqDtjNT15SsOfnDyHuKIJTPlF9xFXQQmBsuQRlC3d+x
 wnCKM8beQxt5ntgflCVIaitAy2u2h5tmUj3B3Qqde5pTYXGO5TKxTKg4HCDn5NO1PUlZ
 SiURdi5Y2rpIWKHBWYHHxxi0Ztq+E5wVke7145hIXHc+hkUhpt/PXEvgUc/FIIh+Zc/C
 A+GA==
X-Gm-Message-State: AOJu0YxsKlMQuyB0YE9N68nSVDAjZ7/D8z+GV2+CcoibCng8VjgXB2TQ
 tv9bYKCeM2FlE2mYbs77r8wQBCK04miRl4355u/YYmGfjRQxRDpJmisKGGjCLiRLrA==
X-Google-Smtp-Source: AGHT+IEFKuobnqQmRjUDpMwzE9vHVfT4pajkkMxWKZ8ZUZLssU8LfiNIB/tgg0oaFyFWuwEd5BT4ew==
X-Received: by 2002:a81:5213:0:b0:608:f9f2:6574 with SMTP id
 g19-20020a815213000000b00608f9f26574mr1233517ywb.24.1708905782906; 
 Sun, 25 Feb 2024 16:03:02 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a818312000000b00607bfa1913csm938171ywf.114.2024.02.25.16.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 16:03:02 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v6 00/41] Raspberry Pi 4B machine
Date: Sun, 25 Feb 2024 18:02:18 -0600
Message-Id: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1133.google.com
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


Sergey Kambalin (41):
  Split out common part of BCM283X classes
  Split out common part of peripherals
  Split out raspi machine common part
  Introduce BCM2838 SoC
  Add GIC-400 to BCM2838 SoC
  Add BCM2838 GPIO stub
  Implement BCM2838 GPIO functionality
  Connect SD controller to BCM2838 GPIO
  Add GPIO and SD to BCM2838 periph
  Introduce Raspberry PI 4 machine
  Temporarily disable unimplemented rpi4b devices
  Add memory region for BCM2837 RPiVid ASB
  Add BCM2838 PCIE Root Complex
  Add BCM2838 PCIE host
  Enable BCM2838 PCIE
  Add RPi4 RNG200
  Implement BCM2838 thermal sensor
  Add clock_isp stub
  Add GENET stub
  Add GENET register structs. Part 1
  Add GENET register structs. Part 2
  Add GENET register structs. Part 3
  Add GENET register structs. Part 4
  Add GENET register access macros
  Implement GENET register ops
  Implement GENET MDIO
  Implement GENET TX path
  Implement GENET RX path
  Enable BCM2838 GENET controller
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
  Add RPi4B to raspi.rst

 docs/system/arm/raspi.rst                |   11 +-
 hw/arm/bcm2835_peripherals.c             |  215 +++--
 hw/arm/bcm2836.c                         |  117 ++-
 hw/arm/bcm2838.c                         |  282 ++++++
 hw/arm/bcm2838_pcie.c                    |  295 ++++++
 hw/arm/bcm2838_peripherals.c             |  287 ++++++
 hw/arm/meson.build                       |    8 +-
 hw/arm/raspi.c                           |  130 +--
 hw/arm/raspi4b.c                         |  111 +++
 hw/arm/trace-events                      |    7 +
 hw/gpio/bcm2838_gpio.c                   |  390 ++++++++
 hw/gpio/meson.build                      |    5 +-
 hw/misc/bcm2835_property.c               |   21 +
 hw/misc/bcm2838_rng200.c                 |  405 ++++++++
 hw/misc/bcm2838_thermal.c                |   98 ++
 hw/misc/meson.build                      |    2 +
 hw/misc/trace-events                     |    9 +
 hw/net/bcm2838_genet.c                   | 1088 ++++++++++++++++++++++
 hw/net/meson.build                       |    2 +
 hw/net/trace-events                      |   16 +
 include/hw/arm/bcm2835_peripherals.h     |   29 +-
 include/hw/arm/bcm2836.h                 |   27 +-
 include/hw/arm/bcm2838.h                 |   31 +
 include/hw/arm/bcm2838_pcie.h            |   75 ++
 include/hw/arm/bcm2838_peripherals.h     |   94 ++
 include/hw/arm/raspberrypi-fw-defs.h     |   11 +
 include/hw/arm/raspi_platform.h          |   38 +-
 include/hw/display/bcm2835_fb.h          |    2 +
 include/hw/gpio/bcm2838_gpio.h           |   45 +
 include/hw/misc/bcm2838_rng200.h         |   43 +
 include/hw/misc/bcm2838_thermal.h        |   24 +
 include/hw/net/bcm2838_genet.h           |  426 +++++++++
 tests/avocado/boot_linux_console.py      |   92 ++
 tests/qtest/bcm2838-mailbox.c            |   60 ++
 tests/qtest/bcm2838-mailbox.h            |  532 +++++++++++
 tests/qtest/bcm2838-mbox-property-test.c |  631 +++++++++++++
 tests/qtest/meson.build                  |    3 +-
 37 files changed, 5457 insertions(+), 205 deletions(-)
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



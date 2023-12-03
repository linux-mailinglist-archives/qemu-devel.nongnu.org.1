Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC0A80281B
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 22:51:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9uL3-0002qd-SG; Sun, 03 Dec 2023 16:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9uL0-0002pw-DX; Sun, 03 Dec 2023 16:49:18 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9uKy-0008Hh-LW; Sun, 03 Dec 2023 16:49:18 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5d34f8f211fso38041247b3.0; 
 Sun, 03 Dec 2023 13:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701640155; x=1702244955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vjJI0cIxkRTZ5OWIw3bVVRHcwjcOeypwu8X8iyLqwmA=;
 b=OWXLZ7hopVimcmy6e0JkLjT7jNDBTTSjR5M2rWFnl537aRUHAde3MW4Bipo8fx8WKO
 xlk1yIInUhkDcyJjODN5Meg7fO744UrqWZVBxs6sYsh/FyuthUoO10JaRg79on8Dzyp6
 1gn+ZJI2WRQKA2KD/rqBGNuEZEpFN7bSKT9nuhdc/bs0vRpdC0uCWpHUEjpdMTCcBWGm
 bDizYaNF/iiHBryC37jKC5lbnbp7AzzE7A/W4aVauuocqqysjGVdlr6bt/cCrnWLxSud
 2pgH+R8ak1f56ZEfppBg2STR5rQgLFbx32QIUPGmKNNe7Ec9sanc4wuNAzdaAo0AGSTX
 4iUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701640155; x=1702244955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vjJI0cIxkRTZ5OWIw3bVVRHcwjcOeypwu8X8iyLqwmA=;
 b=lNTUBCLtcJVeyXeT8JmOEybmlfd+0pfW4Y7fBfI9jwKSwA0tjB8NMSssMSZs8Zh0Jv
 kAPh2odjeoAbvCn3I37H0/iOUxJk1iu6OPkblGzeMXfUaBUlwvDyeMlAsw0mXygFW3ND
 z01MhMcs94oQS9zIo01NtPJR8OBcf/S0gDKG46neJ+ozyQQ52Z6Gg7xcUl0y0dxzXtEX
 YIsIUic1ODObzUbgD+UkhSLZLh1mai2Vjz8QTxoA83Y3aaB5AvY91Uw8R8kgoY9+yLOV
 fcNgDddcfqwlFgi6k7fFBeT3oRVhM7XCCPMxQpNl4UslVzT2jlu45nzz+IJAU79YrdSd
 l0mw==
X-Gm-Message-State: AOJu0YwjPvuHnEXVPfy3jNFovEm+MbP3+9kjPzpTo4Scr9f2tqQoKb7Q
 qyW18SCavyJsvWVBR+WjrgJoPTswHXMy6Q==
X-Google-Smtp-Source: AGHT+IE2KoI09SxcEY+bD1jtd5/AJeujAYnyxUooS9KCwsWY2SPSVRWNUE3a+pT1x4sR1Jgn+LBq1A==
X-Received: by 2002:a81:f011:0:b0:5d7:1940:53ef with SMTP id
 p17-20020a81f011000000b005d7194053efmr1664325ywm.103.1701640154770; 
 Sun, 03 Dec 2023 13:49:14 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a816502000000b00597e912e67esm2832788ywb.131.2023.12.03.13.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 13:49:14 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 00/45] Raspberry Pi 4B machine
Date: Sun,  3 Dec 2023 15:48:25 -0600
Message-Id: <20231203214910.1364468-1-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112d.google.com
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

This is v2 patchset with the most of v1 remarks fixed.
I named it as 'v3' because of mistakes while attempts to send v2 patchset.
Please remove all other v1 and v2 patchsets except the very first one.

Sergey Kambalin (45):
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
  Temporarily disable unimplemented rpi4b devices
  Add memory region for BCM2837 RPiVid ASB
  Add BCM2838 PCIE Root Complex
  Add BCM2838 PCIE host
  Enable BCM2838 PCIE
  Add RNG200 skeleton
  Add RNG200 RNG and RBG
  Get rid of RNG200 timer
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
  Add RPi4B to paspi4.rst

 docs/system/arm/raspi.rst                |   11 +-
 hw/arm/bcm2835_peripherals.c             |  218 +++--
 hw/arm/bcm2836.c                         |  116 ++-
 hw/arm/bcm2838.c                         |  288 ++++++
 hw/arm/bcm2838_pcie.c                    |  289 ++++++
 hw/arm/bcm2838_peripherals.c             |  292 ++++++
 hw/arm/meson.build                       |    8 +-
 hw/arm/raspi.c                           |  131 +--
 hw/arm/raspi4b.c                         |  112 +++
 hw/arm/trace-events                      |    6 +
 hw/gpio/bcm2838_gpio.c                   |  389 ++++++++
 hw/gpio/meson.build                      |    5 +-
 hw/misc/bcm2835_property.c               |   47 +
 hw/misc/bcm2838_rng200.c                 |  420 +++++++++
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
 include/hw/arm/bcm2838_peripherals.h     |   97 ++
 include/hw/arm/raspberrypi-fw-defs.h     |   12 +-
 include/hw/arm/raspi_platform.h          |   37 +
 include/hw/display/bcm2835_fb.h          |    2 +
 include/hw/gpio/bcm2838_gpio.h           |   45 +
 include/hw/misc/bcm2838_rng200.h         |   43 +
 include/hw/misc/bcm2838_thermal.h        |   24 +
 include/hw/net/bcm2838_genet.h           |  426 +++++++++
 tests/avocado/boot_linux_console.py      |   92 ++
 tests/qtest/bcm2838-mailbox.c            |   61 ++
 tests/qtest/bcm2838-mailbox.h            |  584 ++++++++++++
 tests/qtest/bcm2838-mbox-property-test.c |  621 ++++++++++++
 tests/qtest/meson.build                  |    3 +-
 37 files changed, 5551 insertions(+), 205 deletions(-)
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



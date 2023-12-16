Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 487F3815905
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 13:31:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEToM-0005ZP-Vg; Sat, 16 Dec 2023 07:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEToK-0005Z5-4c; Sat, 16 Dec 2023 07:30:28 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEToH-0002sp-Pp; Sat, 16 Dec 2023 07:30:27 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a1f8f470903so183165666b.1; 
 Sat, 16 Dec 2023 04:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702729822; x=1703334622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AFS9iujz41NdKC5CR7zGJgqOPxxqQSCJLa0qqW6ATxI=;
 b=ewtJfs6nJoKghhPWpS6uzgbn0Q8TIswXYgysrldXHL7cFUgP5Re/YS7ZkaAU3tyj4R
 g9mOUy6RNrepM148Y7qSDnqNMjKUxmYH1MmmQgqj4h2tll9UAPjAwutIrbeKDWITBHlf
 6HH+OOKtfab4PeBN6O35tS1a6DzuewDy5MaYswhc4Kpg5rigDg8XLd8B0wyBeKVc8OfE
 H/0IiiJKNKu5Q+uHstZ7HWcf2RneZodvSeFAqRuKuooVoxbd26BUMVdgbPQZXA2JAMMJ
 cryLCLDch/Pg/hfbMH0qYtPIxTFmJCOyxOCu6SuCSIS20V2bk/V0M11CwOHNbEDf/Tkt
 i5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702729822; x=1703334622;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AFS9iujz41NdKC5CR7zGJgqOPxxqQSCJLa0qqW6ATxI=;
 b=Q+aqvHph12DdXzPNgML/m0zRbGQkw3T6laHRNmMcGT+0nA2AhyP1QPHr1tp8YdrWtt
 t2Qnt630coBhW5bo5RbdIfH0SvNNA6RX/CebLBTPKYlu8HkENUjSb1qPuVeyls8QM+ji
 ptx1vvAWcYqdjGx8jQRrBerSt+nLtxYIyO9uPL6PBqAYihKL13R5Lg3PNmUZiqSpkrvk
 iY3OxwVQcIFP1bUojVyrX5pmFOm2azXd6JY8bEbRJP8us5gxwuvcnUiPz6lSYXPcqdQt
 7AfE6reLi9M4m8b814kX8KdwcG1BI10Hh//NXgOHHhAliLb19yx8WY1XWhv2YWmyCXSY
 jaug==
X-Gm-Message-State: AOJu0YxFb08dvEu3RYze18kCDdzKZtZ5USpjRb3AhWGj02cz1BiC9icY
 v1GnurhW7MVIVJAdZoYgN5QnV9qq0sQ=
X-Google-Smtp-Source: AGHT+IFHSufgAhb9luH2C1vE0mJV7Mm1RavzWq/zoF8sg0xo2+h9xI4p3EmKYFwG9ECPC3qAgwguvg==
X-Received: by 2002:a17:906:ce4e:b0:a23:2cc9:3bde with SMTP id
 se14-20020a170906ce4e00b00a232cc93bdemr241123ejb.22.1702729821753; 
 Sat, 16 Dec 2023 04:30:21 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-078-054-007-001.78.54.pool.telefonica.de. [78.54.7.1])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a170906530700b00a1b32663d7csm11896102ejo.102.2023.12.16.04.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 04:30:21 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH] docs/system: Document running Linux on amigaone machine
Date: Sat, 16 Dec 2023 13:30:10 +0100
Message-ID: <20231216123013.67978-1-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
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

Documentation on how to run Linux on the amigaone machine is currently burried
in the depths of the qemu-devel mailing list [1] and in the source code. Let's
collect the information in the QEMU handbook for a one stop solution.

[1] https://lore.kernel.org/qemu-devel/dafc407d-3749-e6f4-3a66-750fde8965f9@eik.bme.hu/

Co-authored-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS                  |  1 +
 docs/system/ppc/amigaone.rst | 53 ++++++++++++++++++++++++++++++++++++
 docs/system/target-ppc.rst   |  1 +
 hw/ppc/amigaone.c            |  9 ------
 4 files changed, 55 insertions(+), 9 deletions(-)
 create mode 100644 docs/system/ppc/amigaone.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 695e0bd34f..a2dd1407e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1560,6 +1560,7 @@ amigaone
 M: BALATON Zoltan <balaton@eik.bme.hu>
 L: qemu-ppc@nongnu.org
 S: Maintained
+F: docs/system/ppc/amigaone.rst
 F: hw/ppc/amigaone.c
 F: hw/pci-host/articia.c
 F: include/hw/pci-host/articia.h
diff --git a/docs/system/ppc/amigaone.rst b/docs/system/ppc/amigaone.rst
new file mode 100644
index 0000000000..c3f11a7bb2
--- /dev/null
+++ b/docs/system/ppc/amigaone.rst
@@ -0,0 +1,53 @@
+Eyetech AmigaOne/Mai Logic Teron (``amigaone``)
+===============================================
+
+The ``amigaone`` model emulates an AmigaOne XE mainboard developed by Eyetech. Use
+the executable ``qemu-system-ppc`` to simulate a complete system.
+
+
+Emulated devices
+----------------
+
+ *  PowerPC 7457 v1.2 CPU
+ *  Articia S north bridge
+ *  VT82C686B south bridge
+ *  PCI VGA compatible card
+
+
+Preparation
+-----------
+
+A firmware binary is necessary for the boot process and is available at
+https://www.hyperion-entertainment.com/index.php/downloads?view=files&parent=28.
+It needs to be extracted with the following command:
+
+.. code-block:: bash
+
+  $ tail -c 524288 updater.image > u-boot-amigaone.bin
+
+The firmware binary is unable to run QEMU‘s standard vgabios and
+``VGABIOS-lgpl-latest.bin`` is needed instead. It can be downloaded from
+http://www.nongnu.org/vgabios.
+
+
+Running Linux
+-------------
+
+There are some Linux images under the following link that work on the
+``amigaone`` machine:
+https://sourceforge.net/projects/amigaone-linux/files/debian-installer/. To boot
+the system run:
+
+.. code-block:: bash
+
+  $ qemu-system-ppc -M amigaone -bios u-boot-amigaone.bin \
+                    -cdrom "A1 Linux Net Installer.iso" \
+                    -device ati-vga,model=rv100,romfile=VGABIOS-lgpl-latest.bin
+
+From the firmware menu that appears select ``Boot sequence`` →
+``Amiga Multiboot Options`` and set ``Boot device 1`` to
+``Onboard VIA IDE CDROM``. Then hit escape until the main screen appears again,
+hit escape once more and from the exit menu that appears select either
+``Save settings and exit`` or ``Use settings for this session only``. It may
+take a long time loading the kernel into memory but eventually it boots and the
+installer becomes visible.
diff --git a/docs/system/target-ppc.rst b/docs/system/target-ppc.rst
index 4f6eb93b17..c1daa463cf 100644
--- a/docs/system/target-ppc.rst
+++ b/docs/system/target-ppc.rst
@@ -18,6 +18,7 @@ help``.
    :maxdepth: 1
 
    ppc/embedded
+   ppc/amigaone
    ppc/powermac
    ppc/powernv
    ppc/ppce500
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index ddfa09457a..4f680a5bdd 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -27,15 +27,6 @@
 
 #define BUS_FREQ_HZ 100000000
 
-/*
- * Firmware binary available at
- * https://www.hyperion-entertainment.com/index.php/downloads?view=files&parent=28
- * then "tail -c 524288 updater.image >u-boot-amigaone.bin"
- *
- * BIOS emulator in firmware cannot run QEMU vgabios and hangs on it, use
- * -device VGA,romfile=VGABIOS-lgpl-latest.bin
- * from http://www.nongnu.org/vgabios/ instead.
- */
 #define PROM_ADDR 0xfff00000
 #define PROM_SIZE (512 * KiB)
 
-- 
2.43.0



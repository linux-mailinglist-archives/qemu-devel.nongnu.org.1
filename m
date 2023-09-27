Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2907B07E4
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 17:13:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlWD6-0003Bd-CJ; Wed, 27 Sep 2023 11:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlWD0-00035b-Ra
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:12:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlWCw-0005kW-0E
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:12:14 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40566f89f6eso84396875e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695827528; x=1696432328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9LcmYDCPs9a7neLG0AeIOd4rekXRKUZPlGGvZGGI0cQ=;
 b=r6PMhWnzBKnR3L1PaDOvJTIqJHKSG2NwXkvAH32jK1Dqgkou4wd6TmWvcLF6Fix/st
 MofWp1MCxNffKO9E43QHwm0ooZsf1e0TPAqfAAkAxhHVu0E470zdcDka+YZ2RS0InNTB
 9OaxVi3U7aLFAMTmIB4aP2d0mNzqo1ild2JjonqBGEn2BPEe+wJA+hyZXAs5sfh5tKl+
 vv7mLjkK3ECBe9giOe3VXOIziFJUO4IdGi1DLsl8PTcB34VvbNM+AsLNGUkMcqztvi82
 MBXPG7wa9FXAGeFNBz+HB+ntIbO8QGmJXgrYS0CVJjClVTMBy+jcVGH1vc2AHptKVcRG
 8BCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695827528; x=1696432328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9LcmYDCPs9a7neLG0AeIOd4rekXRKUZPlGGvZGGI0cQ=;
 b=usWz9vbTTVx87Y+Th8iYXmh94jJowc7YCUTkt1XLoeGWWTwTfoc1tDI8/xcXMw4PQp
 27/MZSCmWZIwXtWmi0Rccdde7aq4paF9gtZFD9y0o41YhcPZByfJClA9Yt2jrGe4iwTm
 s9SMFG2hJp5j+p+8dhuDZHcfK0URlLa6F5FyiD0X0Al8MGc8vnyFUySV0OP2f3V+Yh6K
 N+ZlSS/clgCBeTJHXeJoSbYY8rLYrveHBC4yARbi5cDN+sGGMcBZ4TtQWzgcKfrSX0as
 JkKmqmOZKg860px5SoH7VZnlRSCZBVA5Gxl3Gu20qvlDvD0M41tGwL1MTFn7CAaRQl9Q
 GxCg==
X-Gm-Message-State: AOJu0YzI5r6wD7x8JeCX6HXcujmuaAe8a4VpqdJJXAqs4wPBAV846gMX
 f74rF7bAqu6V8mVfBFRQh9knXXBARwmCd8d0oLQ=
X-Google-Smtp-Source: AGHT+IH3oi3tsbcX1D3XwBKYFHOwDFtoi8Uaj/3mSM8WFiQ+OCp2yz8xXCLwF/G6yhvcbyjxl5j1/w==
X-Received: by 2002:a7b:c3d5:0:b0:400:419c:bbde with SMTP id
 t21-20020a7bc3d5000000b00400419cbbdemr2206108wmj.18.1695827528217; 
 Wed, 27 Sep 2023 08:12:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a1c7209000000b00401bbfb9b2bsm467474wmc.0.2023.09.27.08.12.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 08:12:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/8] docs/specs/edu: Convert to rST
Date: Wed, 27 Sep 2023 16:11:59 +0100
Message-Id: <20230927151205.70930-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927151205.70930-1-peter.maydell@linaro.org>
References: <20230927151205.70930-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Convert docs/specs/edu.txt to rST format.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                     |  1 +
 docs/specs/{edu.txt => edu.rst} | 84 ++++++++++++++++++++-------------
 docs/specs/index.rst            |  1 +
 3 files changed, 54 insertions(+), 32 deletions(-)
 rename docs/specs/{edu.txt => edu.rst} (64%)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0e23907871..9e27cad11c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1825,6 +1825,7 @@ EDU
 M: Jiri Slaby <jslaby@suse.cz>
 S: Maintained
 F: hw/misc/edu.c
+F: docs/specs/edu.rst
 
 IDE
 M: John Snow <jsnow@redhat.com>
diff --git a/docs/specs/edu.txt b/docs/specs/edu.rst
similarity index 64%
rename from docs/specs/edu.txt
rename to docs/specs/edu.rst
index 08763108099..ae72737dbb4 100644
--- a/docs/specs/edu.txt
+++ b/docs/specs/edu.rst
@@ -2,9 +2,10 @@
 EDU device
 ==========
 
-Copyright (c) 2014-2015 Jiri Slaby
+..
+   Copyright (c) 2014-2015 Jiri Slaby
 
-This document is licensed under the GPLv2 (or later).
+   This document is licensed under the GPLv2 (or later).
 
 This is an educational device for writing (kernel) drivers. Its original
 intention was to support the Linux kernel lectures taught at the Masaryk
@@ -15,10 +16,11 @@ The devices behaves very similar to the PCI bridge present in the COMBO6 cards
 developed under the Liberouter wings. Both PCI device ID and PCI space is
 inherited from that device.
 
-Command line switches:
-    -device edu[,dma_mask=mask]
+Command line switches
+---------------------
 
-    dma_mask makes the virtual device work with DMA addresses with the given
+``-device edu[,dma_mask=mask]``
+    ``dma_mask`` makes the virtual device work with DMA addresses with the given
     mask. For educational purposes, the device supports only 28 bits (256 MiB)
     by default. Students shall set dma_mask for the device in the OS driver
     properly.
@@ -26,7 +28,8 @@ Command line switches:
 PCI specs
 ---------
 
-PCI ID: 1234:11e8
+PCI ID:
+   ``1234:11e8``
 
 PCI Region 0:
    I/O memory, 1 MB in size. Users are supposed to communicate with the card
@@ -35,24 +38,29 @@ PCI Region 0:
 MMIO area spec
 --------------
 
-Only size == 4 accesses are allowed for addresses < 0x80. size == 4 or
-size == 8 for the rest.
+Only ``size == 4`` accesses are allowed for addresses ``< 0x80``.
+``size == 4`` or ``size == 8`` for the rest.
 
-0x00 (RO) : identification (0xRRrr00edu)
-	    RR -- major version
-	    rr -- minor version
+0x00 (RO) : identification
+            Value is in the form ``0xRRrr00edu`` where:
+	    - ``RR`` -- major version
+	    - ``rr`` -- minor version
 
 0x04 (RW) : card liveness check
-	    It is a simple value inversion (~ C operator).
+	    It is a simple value inversion (``~`` C operator).
 
 0x08 (RW) : factorial computation
 	    The stored value is taken and factorial of it is put back here.
 	    This happens only after factorial bit in the status register (0x20
 	    below) is cleared.
 
-0x20 (RW) : status register, bitwise OR
-	    0x01 -- computing factorial (RO)
-	    0x80 -- raise interrupt after finishing factorial computation
+0x20 (RW) : status register
+            Bitwise OR of:
+
+            0x01
+              computing factorial (RO)
+	    0x80
+              raise interrupt after finishing factorial computation
 
 0x24 (RO) : interrupt status register
 	    It contains values which raised the interrupt (see interrupt raise
@@ -76,13 +84,19 @@ size == 8 for the rest.
 0x90 (RW) : DMA transfer count
 	    The size of the area to perform the DMA on.
 
-0x98 (RW) : DMA command register, bitwise OR
-	    0x01 -- start transfer
-	    0x02 -- direction (0: from RAM to EDU, 1: from EDU to RAM)
-	    0x04 -- raise interrupt 0x100 after finishing the DMA
+0x98 (RW) : DMA command register
+            Bitwise OR of:
+
+            0x01
+              start transfer
+	    0x02
+              direction (0: from RAM to EDU, 1: from EDU to RAM)
+	    0x04
+              raise interrupt 0x100 after finishing the DMA
 
 IRQ controller
 --------------
+
 An IRQ is generated when written to the interrupt raise register. The value
 appears in interrupt status register when the interrupt is raised and has to
 be written to the interrupt acknowledge register to lower it.
@@ -94,22 +108,28 @@ routine.
 
 DMA controller
 --------------
+
 One has to specify, source, destination, size, and start the transfer. One
 4096 bytes long buffer at offset 0x40000 is available in the EDU device. I.e.
 one can perform DMA to/from this space when programmed properly.
 
 Example of transferring a 100 byte block to and from the buffer using a given
-PCI address 'addr':
-addr     -> DMA source address
-0x40000  -> DMA destination address
-100      -> DMA transfer count
-1        -> DMA command register
-while (DMA command register & 1)
-	;
+PCI address ``addr``:
 
-0x40000  -> DMA source address
-addr+100 -> DMA destination address
-100      -> DMA transfer count
-3        -> DMA command register
-while (DMA command register & 1)
-	;
+::
+
+  addr     -> DMA source address
+  0x40000  -> DMA destination address
+  100      -> DMA transfer count
+  1        -> DMA command register
+  while (DMA command register & 1)
+      ;
+
+::
+
+  0x40000  -> DMA source address
+  addr+100 -> DMA destination address
+  100      -> DMA transfer count
+  3        -> DMA command register
+  while (DMA command register & 1)
+      ;
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index d23efbe2480..30a0cf3d47e 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -25,3 +25,4 @@ guest hardware that is specific to QEMU.
    sev-guest-firmware
    fw_cfg
    vmw_pvscsi-spec
+   edu
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4057DF8E6
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:40:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybfF-0003P8-Pl; Thu, 02 Nov 2023 13:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeb-0003Cu-R6
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:50 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeW-0002iH-0T
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:48 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32f7c80ab33so705189f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946721; x=1699551521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ec1nL91WJ0scl8pDrGtNON2/Nq+ssKE+wY9dEhgeD6s=;
 b=a64F95qO6pEWsNMWNdswO+5Cbn3Nf63SmbOiJ7eKaPi5ROY/WuIEap35Hottj4zInN
 aeBuyg/YR3Uew+xcRBU3pNqW1LSiw1a4/jxmfkfebbtAi0ipdHsD8rdpIUbDnNAW5i88
 +Eie9qhvh1Bx0jR7/8ngc1oUtos7iqGiWdA8DJ2FeIYkRnolu7ExoDTuFpBZnXBkzVmU
 GZFpHhVNHJLPATlTBcvPZigb79aR+zXJwHA1JZ7Mv5DToTB5oOGt3p23HA46T5yxFSlP
 f88MVdQw/7g/PS7SapfXh47my0Q4wo0b4tHrOFsPyrALIFk5ogXEa9kMMKySrbhula/I
 KyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946721; x=1699551521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ec1nL91WJ0scl8pDrGtNON2/Nq+ssKE+wY9dEhgeD6s=;
 b=qZ4fCaMCO/gsep68nYy7u1dVipP5gl/DG9dDTqC/hmy78teHLgIIvy5FCRmOeGPhsH
 n8bD/mPumYbdgA8Pkscfi98PaXA5iTT9nz66n1rAuH/XzeLM/beMuzy0DmPLPCkUK4MS
 Va8u51PMREvF+NX08xs7tr/Sb6nX76HCcbTeISOZN9imkbfi0c2pZOG4oOeogLhU5F7o
 3TohvI/6xHby7tH3G6HNFDuXDTqum/fhh/nnF6TOt/dB+hsd38M110fdx3MOwiIOqjv1
 bQRDEr/nsxgcHGTVYD4Mp2Xo/v8qLh8npml63/ylDViD70jh9sn0ccJdpKoICSMVo8tE
 g5Tg==
X-Gm-Message-State: AOJu0YyNoR22sM2LE7y0fDwlsdgfs3j5cc6oIZqtQ/ZvgA6jruMNGVRU
 RO+mEJll1QPeGX5drcz3lAj9ALQtr80sarDuCGE=
X-Google-Smtp-Source: AGHT+IHAzRs+Ku+JlRxnD8P+oMJZwSuBlTJhHqGji9X0Q/UCyT9bvseo/bsulfspekPgwWjeUyI4sw==
X-Received: by 2002:a5d:64ad:0:b0:32f:7867:11b with SMTP id
 m13-20020a5d64ad000000b0032f7867011bmr16504117wrp.29.1698946721678; 
 Thu, 02 Nov 2023 10:38:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/33] docs/specs/edu: Convert to rST
Date: Thu,  2 Nov 2023 17:38:11 +0000
Message-Id: <20231102173835.609985-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Convert docs/specs/edu.txt to rST format.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20230927151205.70930-3-peter.maydell@linaro.org
---
 MAINTAINERS                     |  1 +
 docs/specs/{edu.txt => edu.rst} | 84 ++++++++++++++++++++-------------
 docs/specs/index.rst            |  1 +
 3 files changed, 54 insertions(+), 32 deletions(-)
 rename docs/specs/{edu.txt => edu.rst} (64%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 73ec940bea0..8e10bd085ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1882,6 +1882,7 @@ EDU
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



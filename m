Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F16797B07E5
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 17:13:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlWD7-0003BO-6u; Wed, 27 Sep 2023 11:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlWD2-000396-4k
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:12:16 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlWCx-0005kj-HF
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:12:15 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4054496bde3so95800935e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 08:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695827529; x=1696432329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bQLhaSO8bxf2dt7RJ4REkrTORaAg7J28JFhhMvuU+ME=;
 b=zjExUFH8r+VayfBpvcjVwQxKl0LMPAncMU6HxrGCXMR4vMkQnV7GZ7brv+yVNtzWnV
 154RhT5E5wVNedXO7U4wnaxvWjn9gB8Od8gc8wxzlaBUAEiNZm4sHHpQEWpu8EC1uQ5J
 1FlYyexeQHZ1xRWZF6bYU6UJ3fIqjZNNbED2fto3TNgjBMFiCkaMIKJw1/dKXFB4R+Kg
 pwLSNGnM9QXO6pwOGhO2wDysJNoAIRrbHSWBkjmYITx2pb7Q3xIEl4l3Tlhnc/IkE5jg
 hnfg0slRUKEhpmjGCHiAGV2hHj8M4lYMtTHgy2/HvzHiXfotQ1PZSPXZJRONxaXCkDN1
 rWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695827529; x=1696432329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQLhaSO8bxf2dt7RJ4REkrTORaAg7J28JFhhMvuU+ME=;
 b=FV8TLlXuumU9G9r/I2igqeNXtjQzLepjCrrSDMn4FyY4RJ9I8cx29Oj/hy+vd+xw64
 lAegvOut4ojZBjZ/bzrRlahw/Dssal0veTVGx3y+v44DYRa3S+8pXNt1JCV69r/LNTBn
 21CEJ9JMk9j1uGdx8A/17q75mznN4kJMxBwGtCLl58oF+rdsnT63JF1M73l/bDn1YmDD
 u0Ky2xX/OJ8lDbAx2HZmuJGNKRKmseLAvEhF1NvLG5m5LjiNYZdzrQKBD8Dmow1Q0q+8
 6aHu8ylk0Htw/kLW+69B2ZOJSVBLIE3GK9chT5qhGVHyH/ueKO9gukJVBltowv8incqD
 CkFw==
X-Gm-Message-State: AOJu0Yy2+nOtRs476rUEyL840yy37iO/3A0CuL/Y1zytgJeERUPMpCyV
 jfsVDI8ibrbCeZfW40SIBsA0Dj6fyfsGABxV+xc=
X-Google-Smtp-Source: AGHT+IEpfxIH+EqdxyYBaEusYTxjtgBMWXyXXYiW/s5pWMNX+ktZ1WY0VJqt2IPn3Hd4DdyYpBks8g==
X-Received: by 2002:a5d:444e:0:b0:31f:85d9:1bb0 with SMTP id
 x14-20020a5d444e000000b0031f85d91bb0mr2161838wrr.35.1695827529625; 
 Wed, 27 Sep 2023 08:12:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a1c7209000000b00401bbfb9b2bsm467474wmc.0.2023.09.27.08.12.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 08:12:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/8] docs/specs/standard-vga: Convert to rST
Date: Wed, 27 Sep 2023 16:12:02 +0100
Message-Id: <20230927151205.70930-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927151205.70930-1-peter.maydell@linaro.org>
References: <20230927151205.70930-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Convert docs/specs/standard-vga.txt to rST format.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/specs/index.rst        |  1 +
 docs/specs/standard-vga.rst | 94 +++++++++++++++++++++++++++++++++++++
 docs/specs/standard-vga.txt | 81 --------------------------------
 hw/display/vga-isa.c        |  2 +-
 hw/display/vga-pci.c        |  2 +-
 5 files changed, 97 insertions(+), 83 deletions(-)
 create mode 100644 docs/specs/standard-vga.rst
 delete mode 100644 docs/specs/standard-vga.txt

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 52bfab2f68b..ee84b8109d6 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -28,3 +28,4 @@ guest hardware that is specific to QEMU.
    edu
    ivshmem-spec
    pvpanic
+   standard-vga
diff --git a/docs/specs/standard-vga.rst b/docs/specs/standard-vga.rst
new file mode 100644
index 00000000000..992f429ced1
--- /dev/null
+++ b/docs/specs/standard-vga.rst
@@ -0,0 +1,94 @@
+
+QEMU Standard VGA
+=================
+
+Exists in two variants, for isa and pci.
+
+command line switches:
+
+``-vga std``
+   picks isa for -M isapc, otherwise pci
+``-device VGA``
+   pci variant
+``-device isa-vga``
+   isa variant
+``-device secondary-vga``
+   legacy-free pci variant
+
+
+PCI spec
+--------
+
+Applies to the pci variant only for obvious reasons.
+
+PCI ID
+   ``1234:1111``
+
+PCI Region 0
+   Framebuffer memory, 16 MB in size (by default).
+   Size is tunable via vga_mem_mb property.
+
+PCI Region 1
+   Reserved (so we have the option to make the framebuffer bar 64bit).
+
+PCI Region 2
+   MMIO bar, 4096 bytes in size (QEMU 1.3+)
+
+PCI ROM Region
+   Holds the vgabios (QEMU 0.14+).
+
+
+The legacy-free variant has no ROM and has ``PCI_CLASS_DISPLAY_OTHER``
+instead of ``PCI_CLASS_DISPLAY_VGA``.
+
+
+IO ports used
+-------------
+
+Doesn't apply to the legacy-free pci variant, use the MMIO bar instead.
+
+``03c0 - 03df``
+   standard vga ports
+``01ce``
+   bochs vbe interface index port
+``01cf``
+   bochs vbe interface data port (x86 only)
+``01d0``
+   bochs vbe interface data port
+
+
+Memory regions used
+-------------------
+
+``0xe0000000``
+  Framebuffer memory, isa variant only.
+
+The pci variant used to mirror the framebuffer bar here, QEMU 0.14+
+stops doing that (except when in ``-M pc-$old`` compat mode).
+
+
+MMIO area spec
+--------------
+
+Likewise applies to the pci variant only for obvious reasons.
+
+``0000 - 03ff``
+  edid data blob.
+``0400 - 041f``
+  vga ioports (``0x3c0`` to ``0x3df``), remapped 1:1. Word access
+  is supported, bytes are written in little endian order (aka index
+  port first),  so indexed registers can be updated with a single
+  mmio write (and thus only one vmexit).
+``0500 - 0515``
+  bochs dispi interface registers, mapped flat without index/data ports.
+  Use ``(index << 1)`` as offset for (16bit) register access.
+``0600 - 0607``
+  QEMU extended registers.  QEMU 2.2+ only.
+  The pci revision is 2 (or greater) when these registers are present.
+  The registers are 32bit.
+``0600``
+  QEMU extended register region size, in bytes.
+``0604``
+  framebuffer endianness register.
+  - ``0xbebebebe`` indicates big endian.
+  - ``0x1e1e1e1e`` indicates little endian.
diff --git a/docs/specs/standard-vga.txt b/docs/specs/standard-vga.txt
deleted file mode 100644
index 18f75f1b302..00000000000
--- a/docs/specs/standard-vga.txt
+++ /dev/null
@@ -1,81 +0,0 @@
-
-QEMU Standard VGA
-=================
-
-Exists in two variants, for isa and pci.
-
-command line switches:
-    -vga std               [ picks isa for -M isapc, otherwise pci ]
-    -device VGA            [ pci variant ]
-    -device isa-vga        [ isa variant ]
-    -device secondary-vga  [ legacy-free pci variant ]
-
-
-PCI spec
---------
-
-Applies to the pci variant only for obvious reasons.
-
-PCI ID: 1234:1111
-
-PCI Region 0:
-   Framebuffer memory, 16 MB in size (by default).
-   Size is tunable via vga_mem_mb property.
-
-PCI Region 1:
-   Reserved (so we have the option to make the framebuffer bar 64bit).
-
-PCI Region 2:
-   MMIO bar, 4096 bytes in size (qemu 1.3+)
-
-PCI ROM Region:
-   Holds the vgabios (qemu 0.14+).
-
-
-The legacy-free variant has no ROM and has PCI_CLASS_DISPLAY_OTHER
-instead of PCI_CLASS_DISPLAY_VGA.
-
-
-IO ports used
--------------
-
-Doesn't apply to the legacy-free pci variant, use the MMIO bar instead.
-
-03c0 - 03df : standard vga ports
-01ce        : bochs vbe interface index port
-01cf        : bochs vbe interface data port (x86 only)
-01d0        : bochs vbe interface data port
-
-
-Memory regions used
--------------------
-
-0xe0000000 : Framebuffer memory, isa variant only.
-
-The pci variant used to mirror the framebuffer bar here, qemu 0.14+
-stops doing that (except when in -M pc-$old compat mode).
-
-
-MMIO area spec
---------------
-
-Likewise applies to the pci variant only for obvious reasons.
-
-0000 - 03ff : edid data blob.
-0400 - 041f : vga ioports (0x3c0 -> 0x3df), remapped 1:1.
-              word access is supported, bytes are written
-              in little endia order (aka index port first),
-              so indexed registers can be updated with a
-              single mmio write (and thus only one vmexit).
-0500 - 0515 : bochs dispi interface registers, mapped flat
-              without index/data ports.  Use (index << 1)
-              as offset for (16bit) register access.
-
-0600 - 0607 : qemu extended registers.  qemu 2.2+ only.
-              The pci revision is 2 (or greater) when
-              these registers are present.  The registers
-              are 32bit.
-  0600      : qemu extended register region size, in bytes.
-  0604      : framebuffer endianness register.
-              - 0xbebebebe indicates big endian.
-              - 0x1e1e1e1e indicates little endian.
diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
index 2a5437d8037..c096ec93e52 100644
--- a/hw/display/vga-isa.c
+++ b/hw/display/vga-isa.c
@@ -1,7 +1,7 @@
 /*
  * QEMU ISA VGA Emulator.
  *
- * see docs/specs/standard-vga.txt for virtual hardware specs.
+ * see docs/specs/standard-vga.rst for virtual hardware specs.
  *
  * Copyright (c) 2003 Fabrice Bellard
  *
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index b351b8f299d..e4f45b4476d 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -1,7 +1,7 @@
 /*
  * QEMU PCI VGA Emulator.
  *
- * see docs/specs/standard-vga.txt for virtual hardware specs.
+ * see docs/specs/standard-vga.rst for virtual hardware specs.
  *
  * Copyright (c) 2003 Fabrice Bellard
  *
-- 
2.34.1



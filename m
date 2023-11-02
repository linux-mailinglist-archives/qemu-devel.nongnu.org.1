Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CE77DF8F8
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:41:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybfM-0003Yp-A7; Thu, 02 Nov 2023 13:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybed-0003Ey-NV
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:51 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeY-0002jM-Qf
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:51 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32dc918d454so692487f8f.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946724; x=1699551524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4k4TxZbAoPDPMNV3xOemPSGaAx8PeWmBzwgO2tihRic=;
 b=r6B/6sWvxHqQAG4uwXJpxYxb4QiPFFJcILbS8VhNLK4wscRyy8UgoR/9wX9x7yU5N8
 /hf2Hxqr2g8ZyIA2rbCAdllJDI+Xa5VIfvH5gE7/Jzs4/2jGtJqXZI5AAYrzQMMpTaoa
 r9emrZSyKHR55+CAzSH4vaNs5ka+ZBe2c3EijHBgPjeU6cVd1mWN1Lb5EZ0xtIHbR8gX
 ohqO6Iwcu9M9+c/lbNHavuLEqaHNa2cTwhhRXB0o5Klj8tUj3ueLxD1gEcZjx/yMDFHb
 8fz/6PygwSA0K6HPE4UZIJ6QVKWK7OC2mYWNv/cEQ4UAi2uutpPzEsnTfcj8lnhTT1S/
 4FOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946724; x=1699551524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4k4TxZbAoPDPMNV3xOemPSGaAx8PeWmBzwgO2tihRic=;
 b=utQwtWAkM90GILpf5MQoyL1Lh108yLPPZTVS5XJkDJszvLNCIuExS7HMZkg09xR/GB
 EQeHQu898OMFsXWaql3XkRNu1sB1dhEFITFSqVfLZ3nJhsndGK22KbhGp8TH8ubExcJ1
 CUnqWtW+tYN4jRkxdlGbTk2/2F/SdzARJxq6P6R+H4OvZnHSH7oWCLOjpua6P10hWdvd
 GbPS+r5TEATyHXgU8eZZHREiRGe4amx0LAKuJM3Zhhlge7Vd9OcpGGoqs1D5rdzEmpNy
 ghswR+8bFYIP77xPCQbjXGDNkf+xOqvzEjqEY0UvfDSIRjq5CHOUfuFCKnjjBmsO0RNy
 fTkQ==
X-Gm-Message-State: AOJu0Yz7iD2k2oHYGz6Cakc923cZ5ufrDJ9eIhrgGClPXLwPsfJv2+FX
 4xSBk2mAnsAt9ursF71v4YfUPoPog7k4JHoErj8=
X-Google-Smtp-Source: AGHT+IFdmvlZSzyzeihcYJ5xlvl3+VM5FQyEZGerH+VumEQeQvBx2vQkK1vih8J/TXRyYfG2ityE/A==
X-Received: by 2002:a5d:508c:0:b0:32f:abf9:712b with SMTP id
 a12-20020a5d508c000000b0032fabf9712bmr1782361wrt.46.1698946724407; 
 Thu, 02 Nov 2023 10:38:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/33] docs/specs/standard-vga: Convert to rST
Date: Thu,  2 Nov 2023 17:38:14 +0000
Message-Id: <20231102173835.609985-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Convert docs/specs/standard-vga.txt to rST format.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230927151205.70930-6-peter.maydell@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                 |  1 +
 docs/specs/index.rst        |  1 +
 docs/specs/standard-vga.rst | 94 +++++++++++++++++++++++++++++++++++++
 docs/specs/standard-vga.txt | 81 --------------------------------
 hw/display/vga-isa.c        |  2 +-
 hw/display/vga-pci.c        |  2 +-
 6 files changed, 98 insertions(+), 83 deletions(-)
 create mode 100644 docs/specs/standard-vga.rst
 delete mode 100644 docs/specs/standard-vga.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e10bd085ff..b5e1765d7a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2468,6 +2468,7 @@ F: hw/display/vga*
 F: hw/display/bochs-display.c
 F: include/hw/display/vga.h
 F: include/hw/display/bochs-vbe.h
+F: docs/specs/standard-vga.rst
 
 ramfb
 M: Gerd Hoffmann <kraxel@redhat.com>
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



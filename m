Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 498B17F8412
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 20:23:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6bku-0007qQ-NQ; Fri, 24 Nov 2023 14:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6bks-0007oe-SE
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 14:22:22 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6bkr-0007c9-9Q
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 14:22:22 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40a4848c6e1so15309895e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 11:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700853739; x=1701458539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JwuMwX23R9RPHWUcvMcabOd06/+xH+GBxbuV1H3kEV4=;
 b=krvoXzL801aZ+KqrLKB6APdVPk1pEQt4TggxfqzIuT8jTAOP3xAUqBopDAFwye3yfI
 JgQD3GQzlFjiT7DFBtMl+JRoDYFgMrhvyIU0kgfOuWejlVCOZuaKVEEgx6lMChTDsnQx
 5QBeEA6uXLI71saWdZfWOQr58QgTRHsAcJSIvXAoz5iaUYnt+1XRkWmhTCD0pfbZv4ih
 p36MoCHTtAcIMJBfIrK/VqTpqWeosfUjea4Lju2Yju6SmaPAxgDMCRHxxHEn/HZynZ3s
 1ZMMuZoVja2rn5XMGSoteuGac8oTdq9VhQ4Fneiz/f+/udZHGKow6P6TQYZX59p1b4si
 XJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700853739; x=1701458539;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JwuMwX23R9RPHWUcvMcabOd06/+xH+GBxbuV1H3kEV4=;
 b=MdcqBVFTE7TcXazvdcYbZxywA5jdlEYj47X4MpJT4fuunUH8oEtHJwY1AuFS1sS+/3
 YjG8ishF2XYQLtLrqLoOweE+D7HiHzIH334zU3RinWoTlEPfhUZjyqjSqMqx/IVsdtWO
 x0LUDlnm8J6jFwlAjf37LRyGgiKSiVheBG2gPH5hjf01OFazQ+9H8oqR6yoUftwyZtVx
 ETDz6tIM17gbYWfCLNUq5SPGbi55iwk8lSEVvITe4FCZ2rh2k3MSNa0XKjPggA1jzApr
 JYGjBh0/g9bjvFCmO9F2q4OpfqF20RLu9jWus+JajnsV4SfoT4vLUA1YpPaGcFDYQ19o
 hKgQ==
X-Gm-Message-State: AOJu0Yx9Mm3wnSl5T0mwnFLqXRc532DcRX6nJkK6UN1VZ2VWOL+mR5V+
 tw0DETQ+JnIPVVU5tj7O6BxMfYRLeQArew2ZZas=
X-Google-Smtp-Source: AGHT+IHSgqVwgFFsTon7+0PX2FbXuRTfyC3SevpZM/h9TWPaOTgya/dzIMKseJqVifwbSM9FMVTp8A==
X-Received: by 2002:a05:600c:19ca:b0:40b:2aa9:21dd with SMTP id
 u10-20020a05600c19ca00b0040b2aa921ddmr3530816wmq.4.1700853739080; 
 Fri, 24 Nov 2023 11:22:19 -0800 (PST)
Received: from m1x-phil.lan ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a05600c4fd200b0040b38082b99sm4449954wmq.1.2023.11.24.11.22.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Nov 2023 11:22:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.0] hw/display/qxl: Directly use
 VGACommonState::vram_size
Date: Fri, 24 Nov 2023 20:22:16 +0100
Message-ID: <20231124192216.96413-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

PCIQXLDevice::vram_size seems to be some shadow of
VGACommonState::vram_size. Just use the latter.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: I don't understand this field otherwise.
---
 hw/display/qxl.h |  1 -
 hw/display/qxl.c | 17 ++++++++---------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index fdac14edad..47463bd485 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -102,7 +102,6 @@ struct PCIQXLDevice {
     uint16_t           max_outputs;
 
     /* vram pci bar */
-    uint64_t           vram_size;
     MemoryRegion       vram_bar;
     uint64_t           vram32_size;
     MemoryRegion       vram32_bar;
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 7bb00d68f5..0e1c4efc0c 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2067,20 +2067,19 @@ static void qxl_init_ramsize(PCIQXLDevice *qxl)
 
     /* vram (surfaces, 64bit, bar 4+5) */
     if (qxl->vram_size_mb != -1) {
-        qxl->vram_size = (uint64_t)qxl->vram_size_mb * MiB;
+        qxl->vga.vram_size = (uint64_t)qxl->vram_size_mb * MiB;
     }
-    if (qxl->vram_size < qxl->vram32_size) {
-        qxl->vram_size = qxl->vram32_size;
+    if (qxl->vga.vram_size < qxl->vram32_size) {
+        qxl->vga.vram_size = qxl->vram32_size;
     }
 
     if (qxl->revision == 1) {
         qxl->vram32_size = 4096;
-        qxl->vram_size = 4096;
+        qxl->vga.vram_size = 4096;
     }
     qxl->vgamem_size = pow2ceil(qxl->vgamem_size);
     qxl->vga.vram_size = pow2ceil(qxl->vga.vram_size);
     qxl->vram32_size = pow2ceil(qxl->vram32_size);
-    qxl->vram_size = pow2ceil(qxl->vram_size);
 }
 
 static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
@@ -2135,7 +2134,7 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
 
     qxl->guest_surfaces.cmds = g_new0(QXLPHYSICAL, qxl->ssd.num_surfaces);
     memory_region_init_ram(&qxl->vram_bar, OBJECT(qxl), "qxl.vram",
-                           qxl->vram_size, &error_fatal);
+                           qxl->vga.vram_size, &error_fatal);
     memory_region_init_alias(&qxl->vram32_bar, OBJECT(qxl), "qxl.vram32",
                              &qxl->vram_bar, 0, qxl->vram32_size);
 
@@ -2159,7 +2158,7 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
     pci_register_bar(&qxl->pci, QXL_VRAM_RANGE_INDEX,
                      PCI_BASE_ADDRESS_SPACE_MEMORY, &qxl->vram32_bar);
 
-    if (qxl->vram32_size < qxl->vram_size) {
+    if (qxl->vram32_size < qxl->vga.vram_size) {
         /*
          * Make the 64bit vram bar show up only in case it is
          * configured to be larger than the 32bit vram bar.
@@ -2177,8 +2176,8 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
     dprint(qxl, 1, "vram/32: %" PRIx64 " MB [region 1]\n",
            qxl->vram32_size / MiB);
     dprint(qxl, 1, "vram/64: %" PRIx64 " MB %s\n",
-           qxl->vram_size / MiB,
-           qxl->vram32_size < qxl->vram_size ? "[region 4]" : "[unmapped]");
+           qxl->vga.vram_size / MiB,
+           qxl->vram32_size < qxl->vga.vram_size ? "[region 4]" : "[unmapped]");
 
     qxl->ssd.qxl.base.sif = &qxl_interface.base;
     if (qemu_spice_add_display_interface(&qxl->ssd.qxl, qxl->vga.con) != 0) {
-- 
2.41.0



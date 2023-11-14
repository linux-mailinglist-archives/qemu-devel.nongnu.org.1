Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5FA7EB299
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:40:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2uaH-0004ye-MB; Tue, 14 Nov 2023 09:40:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uZg-0004Jq-Mx
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:39:32 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uZd-0007tq-Jn
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:39:32 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5079f6efd64so7528211e87.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699972768; x=1700577568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BqgJC9hPHkcXARLwNhCfo2KLP+5VvJiIzbHQjbp4PnI=;
 b=fbuqc9ntQwV48E1LvGAMhPZiv6ZOdxC9YiiubQOHzAfoSvTDbJ5QGTbc2kpbzAxHBM
 bOcH8tuj6ZxliQNiIVU4KiLoqxgS9qTaBsQ88YqDjTG/BKNVbKn4qantvcxZvcT5z+zG
 16q3WzFp5Se6AsIrB2f6LZSeJNrpNoHztBtO04TyvJ5rEh6PpbYeqnz8Kw3W9ok9ee+Z
 n3FYAaOGtoiD+m0MsRyHa6xP399r0Ne2/EGkMGEZXpWutkgZGEUpZSvuRTw3C3JVdiMd
 G/3zYdPAxcfNzmrzEfXwMqgI9gTvq8i81pUUD5A0MnF+8fl8Z/FBKpwyv41oG7CDBDXP
 fX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699972768; x=1700577568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BqgJC9hPHkcXARLwNhCfo2KLP+5VvJiIzbHQjbp4PnI=;
 b=SgVqT9DaeHnu+IcgYPRVcaHYWsOIo4EurFVbyHkXaUneGhjinfV4103clz0hdiPLAN
 Cp9HmnTMjICgP1+5KNw2baHzr0Yqdi+9ZnKNg2+8DtOfPoeBeqJZ5fr20r68iRRRu16r
 MjPUWfh0iJ1muoXiHFLDVeyKAD8JtWfhk5mXBpulJyGZ93vEQApTAm+Kg86+EzntgA7q
 v/N35Qv6GvW40e3pKKRkAFW4jkF2PGqutJP6HTOjOL57SoRz5b326Shkz2vWoiX4p2Vl
 4BWhcbqVHJyrJUr3vJIyWgHh/DfTOg4EaevlGBUC6YaKYizj1PFwIPuArHq9/qNidTSB
 2egw==
X-Gm-Message-State: AOJu0Yx5IUtZb30yI5pMdyH1Euk2M6rHvnrL+Qwf7bg9hq7OqM3215a1
 1/p5HJyCQlM/xv934AVYLotLGw==
X-Google-Smtp-Source: AGHT+IG5cdmuSMLF1QQ3nk9d4MKQ+Rf9u6gyzBn2OUTA0N6PdU8Lc7kj9gwB2wtfxvTcro7nwctRJA==
X-Received: by 2002:a05:6512:3d90:b0:507:9a49:2d3d with SMTP id
 k16-20020a0565123d9000b005079a492d3dmr7641727lfv.31.1699972767814; 
 Tue, 14 Nov 2023 06:39:27 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 c19-20020a50f613000000b00542d3e470f9sm5256915edn.10.2023.11.14.06.39.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 06:39:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw@amazon.co.uk>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>, kvm@vger.kernel.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH-for-9.0 v2 10/19] hw/xen: Rename 'ram_memory' global variable
 as 'xen_memory'
Date: Tue, 14 Nov 2023 15:38:06 +0100
Message-ID: <20231114143816.71079-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114143816.71079-1-philmd@linaro.org>
References: <20231114143816.71079-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

To avoid a potential global variable shadow in
hw/i386/pc_piix.c::pc_init1(), rename Xen's
"ram_memory" as "xen_memory".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/xen/xen-hvm-common.h |  2 +-
 hw/arm/xen_arm.c                |  6 +++---
 hw/i386/xen/xen-hvm.c           | 10 +++++-----
 hw/xen/xen-hvm-common.c         |  6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
index 4e9904f1a6..d3fa5ed29b 100644
--- a/include/hw/xen/xen-hvm-common.h
+++ b/include/hw/xen/xen-hvm-common.h
@@ -16,7 +16,7 @@
 #include "qemu/error-report.h"
 #include <xen/hvm/ioreq.h>
 
-extern MemoryRegion ram_memory;
+extern MemoryRegion xen_memory;
 extern MemoryListener xen_io_listener;
 extern DeviceListener xen_device_listener;
 
diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index a5631529d0..8a185da193 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -111,17 +111,17 @@ static void xen_init_ram(MachineState *machine)
         block_len = GUEST_RAM1_BASE + ram_size[1];
     }
 
-    memory_region_init_ram(&ram_memory, NULL, "xen.ram", block_len,
+    memory_region_init_ram(&xen_memory, NULL, "xen.ram", block_len,
                            &error_fatal);
 
-    memory_region_init_alias(&ram_lo, NULL, "xen.ram.lo", &ram_memory,
+    memory_region_init_alias(&ram_lo, NULL, "xen.ram.lo", &xen_memory,
                              GUEST_RAM0_BASE, ram_size[0]);
     memory_region_add_subregion(sysmem, GUEST_RAM0_BASE, &ram_lo);
     DPRINTF("Initialized region xen.ram.lo: base 0x%llx size 0x%lx\n",
             GUEST_RAM0_BASE, ram_size[0]);
 
     if (ram_size[1] > 0) {
-        memory_region_init_alias(&ram_hi, NULL, "xen.ram.hi", &ram_memory,
+        memory_region_init_alias(&ram_hi, NULL, "xen.ram.hi", &xen_memory,
                                  GUEST_RAM1_BASE, ram_size[1]);
         memory_region_add_subregion(sysmem, GUEST_RAM1_BASE, &ram_hi);
         DPRINTF("Initialized region xen.ram.hi: base 0x%llx size 0x%lx\n",
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index f42621e674..1ae943370b 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -149,12 +149,12 @@ static void xen_ram_init(PCMachineState *pcms,
          */
         block_len = (4 * GiB) + x86ms->above_4g_mem_size;
     }
-    memory_region_init_ram(&ram_memory, NULL, "xen.ram", block_len,
+    memory_region_init_ram(&xen_memory, NULL, "xen.ram", block_len,
                            &error_fatal);
-    *ram_memory_p = &ram_memory;
+    *ram_memory_p = &xen_memory;
 
     memory_region_init_alias(&ram_640k, NULL, "xen.ram.640k",
-                             &ram_memory, 0, 0xa0000);
+                             &xen_memory, 0, 0xa0000);
     memory_region_add_subregion(sysmem, 0, &ram_640k);
     /* Skip of the VGA IO memory space, it will be registered later by the VGA
      * emulated device.
@@ -163,12 +163,12 @@ static void xen_ram_init(PCMachineState *pcms,
      * the Options ROM, so it is registered here as RAM.
      */
     memory_region_init_alias(&ram_lo, NULL, "xen.ram.lo",
-                             &ram_memory, 0xc0000,
+                             &xen_memory, 0xc0000,
                              x86ms->below_4g_mem_size - 0xc0000);
     memory_region_add_subregion(sysmem, 0xc0000, &ram_lo);
     if (x86ms->above_4g_mem_size > 0) {
         memory_region_init_alias(&ram_hi, NULL, "xen.ram.hi",
-                                 &ram_memory, 0x100000000ULL,
+                                 &xen_memory, 0x100000000ULL,
                                  x86ms->above_4g_mem_size);
         memory_region_add_subregion(sysmem, 0x100000000ULL, &ram_hi);
     }
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 565dc39c8f..cf4053c9f2 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -9,7 +9,7 @@
 #include "hw/boards.h"
 #include "hw/xen/arch_hvm.h"
 
-MemoryRegion ram_memory;
+MemoryRegion xen_memory;
 
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
                    Error **errp)
@@ -26,7 +26,7 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
         return;
     }
 
-    if (mr == &ram_memory) {
+    if (mr == &xen_memory) {
         return;
     }
 
@@ -53,7 +53,7 @@ static void xen_set_memory(struct MemoryListener *listener,
 {
     XenIOState *state = container_of(listener, XenIOState, memory_listener);
 
-    if (section->mr == &ram_memory) {
+    if (section->mr == &xen_memory) {
         return;
     } else {
         if (add) {
-- 
2.41.0



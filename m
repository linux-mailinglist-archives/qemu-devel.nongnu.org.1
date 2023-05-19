Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 418657091FA
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 10:48:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvmU-0005OQ-EX; Fri, 19 May 2023 04:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1pzvmR-0005Nv-5r
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:48:08 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1pzvmB-0006nM-Gk
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:48:06 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-96adcb66f37so589287966b.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 01:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684486070; x=1687078070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0DxN2H+wbhDeqbxcVb7Dm8e2lCaD7q4FsraiuT2tFGc=;
 b=H9f9k9MjmD+FdPv2lxbWX11ShQkMIcbNf5Iw2KrWg+mImkA8cX+jOeYPhzNoUTNqy9
 XGxzT9DD/H0ptTnUGVe3up9P8NX/el6HkR4WVVQ9m/lkxSmgcjp9ChTiG5u9kfa+O/3p
 IQImCW8iVBSapHaMIPgV0UToNDdJUovH7X9eOqKgPEY4NwsYr1ydby5XqCNXdPq804WS
 MOvk3qkePyFODf4I0aDl3+SZGMQhGbGgwYEmQCoNK3+E+VlDpAUZH+UoPX2guG55onYx
 z7TKz99B8FmClKBNaefokHZWvzsIAnjzfxOe3lWu98M4cPjgoHHBIs7/Qbh63syt8p/i
 nEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684486070; x=1687078070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0DxN2H+wbhDeqbxcVb7Dm8e2lCaD7q4FsraiuT2tFGc=;
 b=S1mDVdyC0AgDUdcHy38W34m2U6ZjEAyzOI361K2igGUfN7K4Erb56jhLU1MVfJWiuv
 ZGAAt28hBfzJKEbuAWiTStUUODrXIZPqz09AKLwlz3LwR0WAYMgbeuyMBJuubxAuWksI
 vxDuUWFGAKs+hG9a4tb5xyHw45qy3JQwkBmt2m5Y5qaA89FAixV55mGGXDTjYlGgQJex
 kcju0j5/5c+nEBbiTxqFzAfqnv6IwSF2bymqf2RtfdS+tpRvL0bwxOqBdPTW0HE9DzLZ
 oPIlaNvhV3eHloyTOjdJoOCYW9BGrJLBAKBP0dzuQdEtBb9HF7PMggZc6Dien2hlCOoX
 i/LA==
X-Gm-Message-State: AC+VfDxWkdqiFfn9wlEDy5BXFTk1pUetw9zl4m0YbfjVrdGfJggqqEQ/
 zVfQA093+0Ma7R5v+QNKVh+XnrGlk8A=
X-Google-Smtp-Source: ACHHUZ7ebc0RNqnACDToMRf/gdel7xiqI0+F01IlSlXefXLq6+4XeYRxdWXMBzbAi1NzaTc0OlV/ew==
X-Received: by 2002:a17:906:c2d1:b0:94e:c97b:e3ba with SMTP id
 ch17-20020a170906c2d100b0094ec97be3bamr841123ejb.37.1684486069750; 
 Fri, 19 May 2023 01:47:49 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-089-014-126-098.89.14.pool.telefonica.de. [89.14.126.98])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a170906078900b0096621340285sm2000893ejc.198.2023.05.19.01.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 01:47:49 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 2/2] hw/i386/pc: No need for rtc_state to be an out-parameter
Date: Fri, 19 May 2023 10:47:34 +0200
Message-Id: <20230519084734.220480-3-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519084734.220480-1-shentey@gmail.com>
References: <20230519084734.220480-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Now that the RTC is created as part of the southbridges it doesn't need
to be an out-parameter any longer.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20221022150508.26830-12-shentey@gmail.com>
---
 include/hw/i386/pc.h |  2 +-
 hw/i386/pc.c         | 12 ++++++------
 hw/i386/pc_piix.c    |  2 +-
 hw/i386/pc_q35.c     |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 84935fc958..377e8ebdfb 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -168,7 +168,7 @@ uint64_t pc_pci_hole64_start(void);
 DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
 void pc_basic_device_init(struct PCMachineState *pcms,
                           ISABus *isa_bus, qemu_irq *gsi,
-                          ISADevice **rtc_state,
+                          ISADevice *rtc_state,
                           bool create_fdctrl,
                           uint32_t hpet_irqs);
 void pc_cmos_init(PCMachineState *pcms,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2bf7de694e..1c77bc872e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1265,7 +1265,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
 
 void pc_basic_device_init(struct PCMachineState *pcms,
                           ISABus *isa_bus, qemu_irq *gsi,
-                          ISADevice **rtc_state,
+                          ISADevice *rtc_state,
                           bool create_fdctrl,
                           uint32_t hpet_irqs)
 {
@@ -1320,14 +1320,14 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     }
 
     if (rtc_irq) {
-        qdev_connect_gpio_out(DEVICE(*rtc_state), 0, rtc_irq);
+        qdev_connect_gpio_out(DEVICE(rtc_state), 0, rtc_irq);
     } else {
-        uint32_t irq = object_property_get_uint(OBJECT(*rtc_state),
+        uint32_t irq = object_property_get_uint(OBJECT(rtc_state),
                                                 "irq",
                                                 &error_fatal);
-        isa_connect_gpio_out(*rtc_state, 0, irq);
+        isa_connect_gpio_out(rtc_state, 0, irq);
     }
-    object_property_add_alias(OBJECT(pcms), "rtc-time", OBJECT(*rtc_state),
+    object_property_add_alias(OBJECT(pcms), "rtc-time", OBJECT(rtc_state),
                               "date");
 
 #ifdef CONFIG_XEN_EMU
@@ -1341,7 +1341,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     }
 #endif
 
-    qemu_register_boot_set(pc_boot_set, *rtc_state);
+    qemu_register_boot_set(pc_boot_set, rtc_state);
 
     if (!xen_enabled() &&
         (x86ms->pit == ON_OFF_AUTO_AUTO || x86ms->pit == ON_OFF_AUTO_ON)) {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 682f51577c..d7913887dd 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -277,7 +277,7 @@ static void pc_init1(MachineState *machine,
     }
 
     /* init basic PC hardware */
-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, &rtc_state, true,
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, true,
                          0x4);
 
     pc_nic_init(pcmc, isa_bus, pci_bus);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 2bbd0d02df..0d6720270e 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -293,7 +293,7 @@ static void pc_q35_init(MachineState *machine)
     }
 
     /* init basic PC hardware */
-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, &rtc_state, !mc->no_floppy,
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, !mc->no_floppy,
                          0xff0104);
 
     if (pcms->sata_enabled) {
-- 
2.40.1



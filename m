Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF199BA06F
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Nov 2024 14:21:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E12-0003Gv-NL; Sat, 02 Nov 2024 09:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0d-00034A-Uw; Sat, 02 Nov 2024 09:17:45 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0c-0001xN-Ew; Sat, 02 Nov 2024 09:17:43 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a99e3b3a411so592517566b.0; 
 Sat, 02 Nov 2024 06:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553459; x=1731158259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdW4RukPeYbtzE571oJ5Ywld87248Qqc7eArKKusu5M=;
 b=jNfyr7OUQ648aEFVTyDXqJdpemgbXpclTkx7AAYKxzmK7rhgexKBNHDoflA7XmFihj
 7pTM55okXRmzHrGvLCCx8r79WPY6iHhInyqrUtkJ+MpiTYrldsozf7weiBsA9zMpwpkO
 EOYrROD0H79XtxgjRBgS7NRVhwdM2EELzAegNzhiPZ5x/Nrqo2lCzCT9mh7FX/Hy6umi
 /+fjT/J/i8jkHq/7ogwwZ1prFNNYvjokZ59gB/8fLTJnBgcNY8EaYRK+D4ftphICB8Gr
 ziSB69ywAOmiCufEy3hZIHs3dOjo5BYMWeYgI7If+KlmC71N42441xJFVwrUkH68Ok+W
 nNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553459; x=1731158259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CdW4RukPeYbtzE571oJ5Ywld87248Qqc7eArKKusu5M=;
 b=g8mRBKvDSWGiikIv3l2F27slwn2K7kgD9bx6UgXO3jVmAQ2ffSDqqPf6SSGakLM2FL
 pbnD9LRXpwS4AdzvSn550OVMki0IPj/IHvo8x6GLkUeDuBoq27tQwup7MCcJ6LC7qTav
 cKEt5W97o3r3BVbo2tWAnuGqiHChCk2yedZ5+Le0Ik40pqZjHOEjmrlZB3329yofx4ur
 xaMfTrCRy1p4rWO+RyxonyNahC8OeV/r6PI75Ixk/uSFzM2NBuAIvHA1B/3CX6E2hH2n
 Am2ns2NQs6vsbxB+35+OdH5g0tTDA5GpKiXoCDw+WXfalpUwaUAFgErZPJ6utlYrDKgJ
 bw9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPU9rYr0603PWAra3ddw2NAvdQXmuGGaaJYfaJhk3EHIe2aAs53CuXS8LcrEPczyhf98jeBrqLm3Y=@nongnu.org,
 AJvYcCWRLW3MWkkL63IZXa01dIhn6xmu8EMDrMJOOXavztCswSGUnJ6gNUllPG5kmmpQ0Bqdo2p2l1hrMuf7@nongnu.org
X-Gm-Message-State: AOJu0YwmDtO4VY564aUAH0F5IV2tTPbgGuxJnxnGh0jk5gkO1/uQQHuv
 qecB1c07MhctMv7mpCShVrNaXj2n44pbUftaf8XE03wJSbR7HbcsHFeh2Q==
X-Google-Smtp-Source: AGHT+IFWSQiKE/gW1ann498ne4rFAch8m+7o/TqcDPgO1YVFYQGspmdk3Ea7tRpLaT+QlEuF0AVd2w==
X-Received: by 2002:a17:907:3e1d:b0:a9e:21e5:d6cc with SMTP id
 a640c23a62f3a-a9e65435e10mr567903866b.20.1730553458832; 
 Sat, 02 Nov 2024 06:17:38 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:38 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 07/26] hw/ppc/e500: Use SysBusDevice API to access
 TYPE_CCSR's internal resources
Date: Sat,  2 Nov 2024 14:16:56 +0100
Message-ID: <20241102131715.548849-8-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Rather than accessing the attributes of TYPE_CCSR directly, use the SysBusDevice
API which exists exactly for that purpose. Furthermore, registering the memory
region with the SysBusDevice API makes it show up in QMP's `info qom-tree`
command.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/pci-host/ppce500.c | 10 +++++-----
 hw/ppc/e500.c         |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 95b983b2b3..97e5d47cec 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -16,7 +16,6 @@
 
 #include "qemu/osdep.h"
 #include "hw/irq.h"
-#include "hw/ppc/e500-ccsr.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/pci/pci_device.h"
@@ -419,11 +418,12 @@ static const VMStateDescription vmstate_ppce500_pci = {
 static void e500_pcihost_bridge_realize(PCIDevice *d, Error **errp)
 {
     PPCE500PCIBridgeState *b = PPC_E500_PCI_BRIDGE(d);
-    PPCE500CCSRState *ccsr = CCSR(container_get(qdev_get_machine(),
-                                  "/e500-ccsr"));
+    SysBusDevice *ccsr = SYS_BUS_DEVICE(container_get(qdev_get_machine(),
+                                                      "/e500-ccsr"));
+    MemoryRegion *ccsr_space = sysbus_mmio_get_region(ccsr, 0);
 
-    memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0", &ccsr->ccsr_space,
-                             0, int128_get64(ccsr->ccsr_space.size));
+    memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0",
+                             ccsr_space, 0, int128_get64(ccsr_space->size));
     pci_register_bar(d, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &b->bar0);
 }
 
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 5d75a090ee..2849fba524 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -915,7 +915,6 @@ void ppce500_init(MachineState *machine)
     DriveInfo *dinfo;
     MemoryRegion *ccsr_addr_space;
     SysBusDevice *s;
-    PPCE500CCSRState *ccsr;
     I2CBus *i2c;
 
     irqs = g_new0(IrqLines, smp_cpus);
@@ -971,10 +970,10 @@ void ppce500_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
     dev = qdev_new("e500-ccsr");
+    s = SYS_BUS_DEVICE(dev);
     object_property_add_child(OBJECT(machine), "e500-ccsr", OBJECT(dev));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    ccsr = CCSR(dev);
-    ccsr_addr_space = &ccsr->ccsr_space;
+    sysbus_realize_and_unref(s, &error_fatal);
+    ccsr_addr_space = sysbus_mmio_get_region(s, 0);
     memory_region_add_subregion(address_space_mem, pmc->ccsrbar_base,
                                 ccsr_addr_space);
 
@@ -1262,6 +1261,7 @@ static void e500_ccsr_initfn(Object *obj)
     PPCE500CCSRState *ccsr = CCSR(obj);
     memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
                        MPC8544_CCSRBAR_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(ccsr), &ccsr->ccsr_space);
 }
 
 static const TypeInfo e500_ccsr_info = {
-- 
2.47.0



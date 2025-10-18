Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23588BED0FE
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Oct 2025 16:07:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA7Yp-0000FY-H7; Sat, 18 Oct 2025 10:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vA7Yl-00009T-JZ; Sat, 18 Oct 2025 10:05:27 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vA7Yj-00071w-14; Sat, 18 Oct 2025 10:05:27 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1674F5972FE;
 Sat, 18 Oct 2025 16:05:03 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 3DF0xR6QihYI; Sat, 18 Oct 2025 16:05:01 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 19CC75972F8; Sat, 18 Oct 2025 16:05:01 +0200 (CEST)
Message-ID: <2aa235b8bd820907efffc648df6ebc88cb4d81b6.1760795082.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1760795082.git.balaton@eik.bme.hu>
References: <cover.1760795082.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 16/16] hw/ppc/prep: Add reset method to prep-systemio
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Date: Sat, 18 Oct 2025 16:05:01 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The initial state needs to be reset so it's not enough to set it once
at realize. Add a reset method to fix device reset state.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-host/raven.c    |  1 -
 hw/ppc/prep_systemio.c | 13 ++++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 7ebca8186b..fd45acb7eb 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -173,7 +173,6 @@ static void raven_pcihost_realize(DeviceState *d, Error **errp)
     memory_region_init_io(&s->pci_discontiguous_io, o,
                           &raven_io_ops, &s->pci_io,
                           "pci-discontiguous-io", 8 * MiB);
-    memory_region_set_enabled(&s->pci_discontiguous_io, false);
     memory_region_init(&s->pci_memory, o, "pci-memory", 0x3f000000);
 
     sysbus_init_mmio(dev, &s->pci_io);
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index 6ef9b91317..13b8fdb56b 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -252,6 +252,15 @@ static const MemoryRegionOps ppc_parity_error_ops = {
     },
 };
 
+static void prep_systemio_reset(DeviceState *dev)
+{
+    PrepSystemIoState *s = PREP_SYSTEMIO(dev);
+
+    s->iomap_type = PORT0850_IOMAP_NONCONTIGUOUS;
+    memory_region_set_enabled(s->discontiguous_io,
+                              !(s->iomap_type & PORT0850_IOMAP_NONCONTIGUOUS));
+}
+
 static void prep_systemio_realize(DeviceState *dev, Error **errp)
 {
     ISADevice *isa = ISA_DEVICE(dev);
@@ -259,9 +268,6 @@ static void prep_systemio_realize(DeviceState *dev, Error **errp)
     PowerPCCPU *cpu;
 
     assert(s->discontiguous_io);
-    s->iomap_type = PORT0850_IOMAP_NONCONTIGUOUS;
-    memory_region_set_enabled(s->discontiguous_io,
-                              !(s->iomap_type & PORT0850_IOMAP_NONCONTIGUOUS));
     cpu = POWERPC_CPU(first_cpu);
     s->softreset_irq = qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_HRESET);
 
@@ -301,6 +307,7 @@ static void prep_systemio_class_initfn(ObjectClass *klass, const void *data)
     dc->vmsd = &vmstate_prep_systemio;
     /* Reason: PReP specific device, needs to be wired via properties */
     dc->user_creatable = false;
+    device_class_set_legacy_reset(dc, prep_systemio_reset);
     device_class_set_props(dc, prep_systemio_properties);
 }
 
-- 
2.41.3



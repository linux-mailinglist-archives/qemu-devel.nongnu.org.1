Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 021977B6077
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 07:44:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnYBw-0003lS-GJ; Tue, 03 Oct 2023 01:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qnYBu-0003lB-1I
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 01:43:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qnYBs-00029Q-Eg
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 01:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696311807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MlZSgA05hH7qPf957jWwZVxcYKRZwTchMmzmkdOAf7Q=;
 b=a+AnZTu+/53qd7U1lFUWYEkBsCJ3Yvah8kvInmAAc8ZaY37PDEORNHw+F+dfnMjYkKMs0W
 QixKNoUPTI3pBrnmnOAnGTm98EgOvcipnJ/df6fEj+EXb/pSlorUPswBXmaihtjLkzlzc+
 Cu2usGOSptvZlBd0p75Oh5jSveihSFg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-A53M04eTPx2aI8BJBrfCXA-1; Tue, 03 Oct 2023 01:43:20 -0400
X-MC-Unique: A53M04eTPx2aI8BJBrfCXA-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4194d8856e0so8851811cf.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 22:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696311800; x=1696916600;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MlZSgA05hH7qPf957jWwZVxcYKRZwTchMmzmkdOAf7Q=;
 b=LJupVK/ZFkJjjPW6MFBd1BQTu6ZvLcLGIbEcQhSaw6KSZ5ShWKEmC80Hq6hEZCkfgT
 kW0I7I/UW9Tc9ER0PQHOjtOMmWNb7zzzty3j13Wl7ghLSE9MjOmh6sokpVxW2IvM5Rw6
 yxdpuMSeN5PjROsESmuIqVtx/xEhVYoyb5cd08N4NSuJfykgP622wYGDgoiAqlSpumgt
 gkv+luqOXRADKMmRkZw4vtEnRDeAk0WaXWu8lGwh5S+PRs/3RUdamP0U1uGPu7K+otVI
 KUXwwSkaAUyMHQKtMFAS/HqkzM+Vy1qnL4oPs/G2UkQD2ABl/Efo9XdUi7/371RUI1W8
 ocmg==
X-Gm-Message-State: AOJu0Yzi8EXsEhXxkFaJFEdpj/dNHpQ5yuBcE75RLzf9xyArKBjhHa1d
 9lkzLSWrcJWYwSYWVe8RICORyI/XPseNOeD25c+S6RkMKuCxL8d3Jrm01x4W82+X212i0AUDHNT
 saA21Y7gqfGkh0I0=
X-Received: by 2002:ac8:7f88:0:b0:414:e458:ab0e with SMTP id
 z8-20020ac87f88000000b00414e458ab0emr14810238qtj.68.1696311799926; 
 Mon, 02 Oct 2023 22:43:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDtFxxRXngmk0B/NkCXzOtK5J5sFdNo1nGXq/L20NGl78RbZ/XqLpZkmq5uMHWkJzAoA4AIA==
X-Received: by 2002:ac8:7f88:0:b0:414:e458:ab0e with SMTP id
 z8-20020ac87f88000000b00414e458ab0emr14810222qtj.68.1696311799664; 
 Mon, 02 Oct 2023 22:43:19 -0700 (PDT)
Received: from localhost.localdomain ([115.96.159.31])
 by smtp.googlemail.com with ESMTPSA id
 w7-20020a170902d3c700b001c42d4b3675sm467279plb.309.2023.10.02.22.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 22:43:19 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2] hw/i386: changes towards enabling -Wshadow=local
Date: Tue,  3 Oct 2023 11:13:06 +0530
Message-ID: <20231003054306.4372-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Code changes that addresses all compiler complaints coming from enabling
-Wshadow flags. Enabling -Wshadow catches cases of local variables shadowing
other local variables or parameters. These makes the code confusing and/or adds
bugs that are difficult to catch.

CC: Markus Armbruster <armbru@redhat.com>
CC: Philippe Mathieu-Daude <philmd@linaro.org>
CC: mst@redhat.com
Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/acpi-microvm.c | 4 ++--
 hw/i386/intel_iommu.c  | 8 ++++----
 hw/i386/pc.c           | 1 -
 hw/i386/x86.c          | 2 --
 4 files changed, 6 insertions(+), 9 deletions(-)

changelog:
v2: addressed suggestion from mst.

diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index a075360d85..6ddcfb0419 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -55,8 +55,8 @@ static void acpi_dsdt_add_virtio(Aml *scope,
 
     bus = sysbus_get_default();
     QTAILQ_FOREACH(kid, &bus->children, sibling) {
-        DeviceState *dev = kid->child;
-        Object *obj = object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MMIO);
+        Object *obj = object_dynamic_cast(OBJECT(kid->child),
+                                          TYPE_VIRTIO_MMIO);
 
         if (obj) {
             VirtIOMMIOProxy *mmio = VIRTIO_MMIO(obj);
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c0ce896668..2c832ab68b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3744,7 +3744,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
 /* Unmap the whole range in the notifier's scope. */
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 {
-    hwaddr size, remain;
+    hwaddr total, remain;
     hwaddr start = n->start;
     hwaddr end = n->end;
     IntelIOMMUState *s = as->iommu_state;
@@ -3765,7 +3765,7 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
     }
 
     assert(start <= end);
-    size = remain = end - start + 1;
+    total = remain = end - start + 1;
 
     while (remain >= VTD_PAGE_SIZE) {
         IOMMUTLBEvent event;
@@ -3793,10 +3793,10 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
     trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
                              VTD_PCI_SLOT(as->devfn),
                              VTD_PCI_FUNC(as->devfn),
-                             n->start, size);
+                             n->start, total);
 
     map.iova = n->start;
-    map.size = size - 1; /* Inclusive */
+    map.size = total - 1; /* Inclusive */
     iova_tree_remove(as->iova_tree, map);
 }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3db0743f31..e7a233e886 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1116,7 +1116,6 @@ void pc_memory_init(PCMachineState *pcms,
 
     if (machine->device_memory) {
         uint64_t *val = g_malloc(sizeof(*val));
-        PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
         uint64_t res_mem_end = machine->device_memory->base;
 
         if (!pcmc->broken_reserved_end) {
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index f034df8bf6..b3d054889b 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -365,8 +365,6 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     cpu_slot = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
     if (!cpu_slot) {
-        MachineState *ms = MACHINE(x86ms);
-
         x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
         error_setg(errp,
             "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
-- 
2.42.0



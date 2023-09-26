Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B287AE542
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 07:53:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql10K-0004vv-NQ; Tue, 26 Sep 2023 01:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1ql10G-0004vd-V6
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 01:53:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1ql10F-0007ZH-6r
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 01:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695707577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BtzSg1OhosbfRyB9z6H/AWYQif8HLMpgoXPBTD5WyJM=;
 b=Ny/ZFf1/8zxABnf0rl/VIZQa9NuTfAnkr8cYWQgEETVIiPYX4wxbomVA/gxHkiVFFi26qC
 XcemPzRX5bxT9KxyOBMLZTyzdExo3NVqmH1VXuoZ10zQbzYRP0adpKioJhBYe2x5a+i4Kd
 KSTz79IF8ZSV412Ha0oty4SWM7votHg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-mS-wC955NPqEIQt1oAqn6A-1; Tue, 26 Sep 2023 01:52:56 -0400
X-MC-Unique: mS-wC955NPqEIQt1oAqn6A-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-690f9c65205so11832171b3a.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 22:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695707575; x=1696312375;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BtzSg1OhosbfRyB9z6H/AWYQif8HLMpgoXPBTD5WyJM=;
 b=sgqBvxkkqvfB+Z1N3IPdW4VQmcZfZkaWfgzekTbOPr1qVDgQPPqEWVyW8Qj18CHucQ
 4JSQBMoSZoM3LuwI+BhfKV/BwIUFuSFcMCYtV4WhAZmRNg0az/NVQpRQCIRvLVISwkDO
 RGv6xPXi2ytUFYuNooLOOqAxzUhGOzDx7Y+87UCsARuFPrGnWlZo+j84C31gcNPVrpjM
 w27iTeuxMVQ3MS2Uyqx1qOK6ntZtNxLt993uo6XB+zh0JE3N04qjVGS9BUH6SWqF+iny
 6KHZXzBqJ1Ncl/6gfYaRcRWJnqP+UCK3vKQBqNB80HbmJyoawp4VfN4IJAKs1tLcm7be
 Ukuw==
X-Gm-Message-State: AOJu0YxzS4SiRBz3UZrH6pEEMjVlqArxdkwjOJbI4EuXlNKcxRNCKEK2
 9N8duVrdLCyFWmd4Afn6D5eEUT9wCI9wJoJtx2/tlyigG9ubUJVZL5Fvuza1fAWxaHvj8JdDc+2
 Zs6q9BuEmkVoj6Eo=
X-Received: by 2002:a05:6a21:4843:b0:121:e573:3680 with SMTP id
 au3-20020a056a21484300b00121e5733680mr8241438pzc.62.1695707575108; 
 Mon, 25 Sep 2023 22:52:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5WAsJ/48tKYka/tk1bd05fFpeXbP0gVwxFKV47RJToJ1iSKYwTdINcmvPEVa/ZOiiaMd5rQ==
X-Received: by 2002:a05:6a21:4843:b0:121:e573:3680 with SMTP id
 au3-20020a056a21484300b00121e5733680mr8241431pzc.62.1695707574792; 
 Mon, 25 Sep 2023 22:52:54 -0700 (PDT)
Received: from localhost.localdomain ([115.96.197.4])
 by smtp.googlemail.com with ESMTPSA id
 f21-20020a170902e99500b001bc87e6e26bsm9939079plb.222.2023.09.25.22.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 22:52:54 -0700 (PDT)
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
Date: Tue, 26 Sep 2023 11:22:35 +0530
Message-Id: <20230926055235.9164-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 hw/i386/acpi-microvm.c | 12 ++++++------
 hw/i386/intel_iommu.c  |  8 ++++----
 hw/i386/pc.c           |  1 -
 hw/i386/x86.c          |  2 --
 4 files changed, 10 insertions(+), 13 deletions(-)

changelog:
v2: kept Peter's changes from https://lore.kernel.org/r/20230922160410.138786-1-peterx@redhat.com
and removed mine.

diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index a075360d85..6e4f8061eb 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -78,18 +78,18 @@ static void acpi_dsdt_add_virtio(Aml *scope,
             hwaddr base = VIRTIO_MMIO_BASE + index * 512;
             hwaddr size = 512;
 
-            Aml *dev = aml_device("VR%02u", (unsigned)index);
-            aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")));
-            aml_append(dev, aml_name_decl("_UID", aml_int(index)));
-            aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
+            Aml *adev = aml_device("VR%02u", (unsigned)index);
+            aml_append(adev, aml_name_decl("_HID", aml_string("LNRO0005")));
+            aml_append(adev, aml_name_decl("_UID", aml_int(index)));
+            aml_append(adev, aml_name_decl("_CCA", aml_int(1)));
 
             Aml *crs = aml_resource_template();
             aml_append(crs, aml_memory32_fixed(base, size, AML_READ_WRITE));
             aml_append(crs,
                        aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
                                      AML_EXCLUSIVE, &irq, 1));
-            aml_append(dev, aml_name_decl("_CRS", crs));
-            aml_append(scope, dev);
+            aml_append(adev, aml_name_decl("_CRS", crs));
+            aml_append(scope, adev);
         }
     }
 }
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
2.39.3



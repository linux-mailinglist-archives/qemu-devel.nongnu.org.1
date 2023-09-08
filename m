Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DEC798506
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 11:53:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeY9v-00059o-1z; Fri, 08 Sep 2023 05:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qeY9p-000590-Te
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 05:52:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qeY9n-0004bi-5t
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 05:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694166723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eH2KSff4q/W8d8WrwGTRPf9S33erozzTa2KDDx7htaA=;
 b=a6nD1cs6eGhzR/VaUGEQhdmIGo0lqe/pRgglCMbGoFRyxKgUDKDnlmhKITvKAH1pUISk5Q
 /3JXRax290ti27HA4IN7yrtkCXrtZyNtGjOd5RBDQS2bo8i3tbFQLd5xqY477Ai546i4LJ
 U5X5U8HmK4tOt/1Op1uHwMp2C+dj93M=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-W0eP-LBjP-CTTpqz-9r10A-1; Fri, 08 Sep 2023 05:50:57 -0400
X-MC-Unique: W0eP-LBjP-CTTpqz-9r10A-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1cca78b59a6so2178487fac.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 02:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694166656; x=1694771456;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eH2KSff4q/W8d8WrwGTRPf9S33erozzTa2KDDx7htaA=;
 b=iZa5NN5NRu/0ukPeV0pkRGsSUtSz8NVIbI4F7SDDXjG/F0Wm/mcFydAl+a/GWDTYrL
 dKit7EBmrMF37LGBb/bIvlvpyta0bnBlywNPmWdBeVNzzkH97/+p8axPAMsgj+/bm47R
 LnIt4VTpG7az1YYcBudkywMKpzGsCk1AXJ+3qjMeDie4BpU64I4lsSDmONNB2lq6q41l
 gFLsWvaKncOjqYdyrfuCN0hWm7pRN3OvmjBUiGy/2qAA4zRtLNJC50ekkV6Z8bQ+a9jt
 mzTfwEnRnVIFm7e1qs4/+yNp0M6crJUzRY7bSQfjIrPvuxTZ7GImsfqPlOM5+u+lFwmy
 dE+g==
X-Gm-Message-State: AOJu0YwiyRFHTPrxQgz6J4yEF9DufW3AboYCiJ5eXgGOg9LvEHaDXCLA
 2T2ch08It4E6yUbwW9FNAojX2uFevHxaS/++oLmRenVoJQZFOc7jcCZFvvzBlBoEM1QYP0NJ5xM
 KvDgKvrREbnKltuk=
X-Received: by 2002:a05:6870:a119:b0:1d0:e371:e95c with SMTP id
 m25-20020a056870a11900b001d0e371e95cmr2246547oae.40.1694166656273; 
 Fri, 08 Sep 2023 02:50:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZZaR3jN2dB9nyHWMHk5hgC+WCz/R135SuxFxv36fMePmMX+cf0Q4UnK5fpACBqnW740NuxQ==
X-Received: by 2002:a05:6870:a119:b0:1d0:e371:e95c with SMTP id
 m25-20020a056870a11900b001d0e371e95cmr2246526oae.40.1694166655922; 
 Fri, 08 Sep 2023 02:50:55 -0700 (PDT)
Received: from localhost.localdomain ([115.96.141.163])
 by smtp.googlemail.com with ESMTPSA id
 s16-20020a63af50000000b00573dfae6c2dsm854680pgo.71.2023.09.08.02.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 02:50:55 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] mem/x86: add processor address space check for VM memory
Date: Fri,  8 Sep 2023 15:20:24 +0530
Message-Id: <20230908095024.270946-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
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

Depending on the number of available address bits of the current processor, a
VM can only use a certain maximum amount of memory and no more. This change
makes sure that a VM is not configured to have more memory than what it can use
with the current processor settings when started. Additionally, the change adds
checks during memory hotplug to ensure that the VM does not end up getting more
memory than what it can actually use after hotplug.
Currently, both the above checks are only for pc (x86) platform.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1235403
CC: imammedo@redhat.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/pc.c           | 45 ++++++++++++++++++++++++++++++++++++++++++
 hw/mem/memory-device.c |  6 ++++++
 include/hw/boards.h    |  9 +++++++++
 3 files changed, 60 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 54838c0c41..f84e4c4916 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -31,6 +31,7 @@
 #include "hw/i386/topology.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/i386/vmport.h"
+#include "hw/mem/memory-device.h"
 #include "sysemu/cpus.h"
 #include "hw/block/fdc.h"
 #include "hw/ide/internal.h"
@@ -1006,6 +1007,17 @@ void pc_memory_init(PCMachineState *pcms,
         exit(EXIT_FAILURE);
     }
 
+    /*
+     * check if the VM started with more ram configured than max physical
+     * address available with the current processor.
+     */
+    if (machine->ram_size > maxphysaddr + 1) {
+        error_report("Address space limit 0x%"PRIx64" < 0x%"PRIx64
+                     " (max configured memory), phys-bits too low (%u)",
+                     maxphysaddr, machine->ram_size, cpu->phys_bits);
+        exit(EXIT_FAILURE);
+    }
+
     /*
      * Split single memory region and use aliases to address portions of it,
      * done for backwards compatibility with older qemus.
@@ -1845,6 +1857,38 @@ static bool pc_hotplug_allowed(MachineState *ms, DeviceState *dev, Error **errp)
     return true;
 }
 
+static bool pc_mem_hotplug_allowed(MachineState *ms,
+                                   MemoryRegion *mr, Error **errp)
+{
+    hwaddr maxphysaddr;
+    uint64_t dimm_size, size, ram_size, total_mem_size;
+    X86CPU *cpu = X86_CPU(first_cpu);
+
+    if (!mr) {
+        return true;
+    }
+
+    dimm_size = ms->device_memory->dimm_size;
+    size = memory_region_size(mr);
+    ram_size = (uint64_t) ms->ram_size;
+    total_mem_size = ram_size + dimm_size + size;
+
+    maxphysaddr = ((hwaddr)1 << cpu->phys_bits) - 1;
+
+    /*
+     * total memory after hotplug will exceed the maximum physical
+     * address limit of the processor. So hotplug cannot be allowed.
+     */
+    if ((total_mem_size > (uint64_t)maxphysaddr + 1) &&
+        (total_mem_size > ram_size + dimm_size)) {
+        error_setg(errp, "Address space limit 0x%"PRIx64" < 0x%"PRIx64
+                   " phys-bits too low (%u)",
+                   maxphysaddr, total_mem_size, cpu->phys_bits);
+        return false;
+    }
+    return true;
+}
+
 static void pc_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1870,6 +1914,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotplug_handler;
     mc->hotplug_allowed = pc_hotplug_allowed;
+    mc->mem_hotplug_allowed = pc_mem_hotplug_allowed;
     mc->cpu_index_to_instance_props = x86_cpu_index_to_props;
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 667d56bd29..825bc593ae 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -57,6 +57,7 @@ static void memory_device_check_addable(MachineState *ms, MemoryRegion *mr,
 {
     const uint64_t used_region_size = ms->device_memory->used_region_size;
     const uint64_t size = memory_region_size(mr);
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
 
     /* we will need a new memory slot for kvm and vhost */
     if (kvm_enabled() && !kvm_has_free_slot(ms)) {
@@ -68,6 +69,11 @@ static void memory_device_check_addable(MachineState *ms, MemoryRegion *mr,
         return;
     }
 
+    if (mc->mem_hotplug_allowed &&
+        (!(mc->mem_hotplug_allowed(ms, mr, errp)))) {
+        return;
+    }
+
     /* will we exceed the total amount of memory specified */
     if (used_region_size + size < used_region_size ||
         used_region_size + size > ms->maxram_size - ms->ram_size) {
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 3b541ffd24..84b199ee51 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -210,6 +210,13 @@ typedef struct {
  *    false is returned, an error must be set to show the reason of
  *    the rejection.  If the hook is not provided, all hotplug will be
  *    allowed.
+ * @mem_hotplug_allowed:
+ *    If the hook is provided, then it'll be called for each memory device
+ *    hotplug to check whether the mem device hotplug is allowed.  Return
+ *    true to grant allowance or false to reject the hotplug.  When
+ *    false is returned, an error must be set to show the reason of
+ *    the rejection.  If the hook is not provided, all mem hotplug will be
+ *    allowed.
  * @default_ram_id:
  *    Specifies inital RAM MemoryRegion name to be used for default backend
  *    creation if user explicitly hasn't specified backend with "memory-backend"
@@ -285,6 +292,8 @@ struct MachineClass {
                                            DeviceState *dev);
     bool (*hotplug_allowed)(MachineState *state, DeviceState *dev,
                             Error **errp);
+    bool (*mem_hotplug_allowed)(MachineState *state, MemoryRegion *mr,
+                                Error **errp);
     CpuInstanceProperties (*cpu_index_to_instance_props)(MachineState *machine,
                                                          unsigned cpu_index);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
-- 
2.39.1



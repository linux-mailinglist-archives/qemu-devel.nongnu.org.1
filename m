Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C71767C7074
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:38:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwoT-0002qM-MV; Thu, 12 Oct 2023 10:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoR-0002ob-Mx
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoP-0005h4-8E
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697121436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZapqEeuJK8N92UN9NB9e2BZXJx2uX5S3xPjC5oltZy0=;
 b=GY6i3qHw7q3LD3VtLZ7IM0thN/ODOo2Ku/6tb4Y1DqaCmrJIkn2jnWFVzOzVCCvFAMWDJZ
 hQ57gK9O+8FJtbgT+VE9Jmgul1CCSqc3WBJk4LkG6FRjZvqVldyS+Axa+lAfQJgvyZlgv8
 NxACC+7TRF7rbUnOX1ENwM7LmsKd6+c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-jqRGU745PVmlpsMWZ7juEA-1; Thu, 12 Oct 2023 10:37:02 -0400
X-MC-Unique: jqRGU745PVmlpsMWZ7juEA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 586812800E8A;
 Thu, 12 Oct 2023 14:37:02 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67ACC1C06534;
 Thu, 12 Oct 2023 14:37:01 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [GIT PULL 04/18] kvm: Return number of free memslots
Date: Thu, 12 Oct 2023 16:36:41 +0200
Message-ID: <20231012143655.114631-5-david@redhat.com>
In-Reply-To: <20231012143655.114631-1-david@redhat.com>
References: <20231012143655.114631-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

Let's return the number of free slots instead of only checking if there
is a free slot. While at it, check all address spaces, which will also
consider SMM under x86 correctly.

This is a preparation for memory devices that consume multiple memslots.

Message-ID: <20230926185738.277351-5-david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 accel/kvm/kvm-all.c      | 33 ++++++++++++++++++++-------------
 accel/stubs/kvm-stub.c   |  4 ++--
 hw/mem/memory-device.c   |  2 +-
 include/sysemu/kvm.h     |  2 +-
 include/sysemu/kvm_int.h |  1 +
 5 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 72e1d1141c..5937e46e12 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -181,6 +181,24 @@ int kvm_get_max_memslots(void)
     return s->nr_slots;
 }
 
+unsigned int kvm_get_free_memslots(void)
+{
+    unsigned int used_slots = 0;
+    KVMState *s = kvm_state;
+    int i;
+
+    kvm_slots_lock();
+    for (i = 0; i < s->nr_as; i++) {
+        if (!s->as[i].ml) {
+            continue;
+        }
+        used_slots = MAX(used_slots, s->as[i].ml->nr_used_slots);
+    }
+    kvm_slots_unlock();
+
+    return s->nr_slots - used_slots;
+}
+
 /* Called with KVMMemoryListener.slots_lock held */
 static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
 {
@@ -196,19 +214,6 @@ static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
     return NULL;
 }
 
-bool kvm_has_free_slot(MachineState *ms)
-{
-    KVMState *s = KVM_STATE(ms->accelerator);
-    bool result;
-    KVMMemoryListener *kml = &s->memory_listener;
-
-    kvm_slots_lock();
-    result = !!kvm_get_free_slot(kml);
-    kvm_slots_unlock();
-
-    return result;
-}
-
 /* Called with KVMMemoryListener.slots_lock held */
 static KVMSlot *kvm_alloc_slot(KVMMemoryListener *kml)
 {
@@ -1387,6 +1392,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
             }
             start_addr += slot_size;
             size -= slot_size;
+            kml->nr_used_slots--;
         } while (size);
         return;
     }
@@ -1412,6 +1418,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         ram_start_offset += slot_size;
         ram += slot_size;
         size -= slot_size;
+        kml->nr_used_slots++;
     } while (size);
 }
 
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 235dc661bc..a5d4442d8f 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -109,9 +109,9 @@ int kvm_irqchip_remove_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
     return -ENOSYS;
 }
 
-bool kvm_has_free_slot(MachineState *ms)
+unsigned int kvm_get_free_memslots(void)
 {
-    return false;
+    return 0;
 }
 
 void kvm_init_cpu_signals(CPUState *cpu)
diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 667d56bd29..98e355c960 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -59,7 +59,7 @@ static void memory_device_check_addable(MachineState *ms, MemoryRegion *mr,
     const uint64_t size = memory_region_size(mr);
 
     /* we will need a new memory slot for kvm and vhost */
-    if (kvm_enabled() && !kvm_has_free_slot(ms)) {
+    if (kvm_enabled() && !kvm_get_free_memslots()) {
         error_setg(errp, "hypervisor has no free memory slots left");
         return;
     }
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index ee9025f8e9..c3d831baef 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -215,7 +215,7 @@ typedef struct KVMRouteChange {
 
 /* external API */
 
-bool kvm_has_free_slot(MachineState *ms);
+unsigned int kvm_get_free_memslots(void);
 bool kvm_has_sync_mmu(void);
 int kvm_has_vcpu_events(void);
 int kvm_has_robust_singlestep(void);
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index a5b9122cb8..075939a3c4 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -40,6 +40,7 @@ typedef struct KVMMemoryUpdate {
 typedef struct KVMMemoryListener {
     MemoryListener listener;
     KVMSlot *slots;
+    unsigned int nr_used_slots;
     int as_id;
     QSIMPLEQ_HEAD(, KVMMemoryUpdate) transaction_add;
     QSIMPLEQ_HEAD(, KVMMemoryUpdate) transaction_del;
-- 
2.41.0



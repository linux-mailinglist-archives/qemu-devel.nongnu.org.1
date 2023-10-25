Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E527D7899
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:31:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnHv-0001Xx-7O; Wed, 25 Oct 2023 19:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHs-0001XG-KT
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHq-0004yW-M1
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RuhO2TqI20JU1RsKWXb36MJgMRC8ZPIt1IYf1Th1nb0=;
 b=Bqrd6U1nmdS2K5usH12Bimb+hvXgiz+NxcI6g5heIk/maNqoatrBE5uVURSIkAF3/r8dtQ
 FADbdUh53ocTNntffAVCV2tBzuRAPfERzUi+HpYzGY2QltJk129R1yc8yehRSEZgYiEIRF
 CISXfTad5Xu8qf6da1zxK7jhl85dxT4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-cCjim69pPgmDPj-uu0EHrw-1; Wed, 25 Oct 2023 19:27:40 -0400
X-MC-Unique: cCjim69pPgmDPj-uu0EHrw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7789a691086so47075085a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276460; x=1698881260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RuhO2TqI20JU1RsKWXb36MJgMRC8ZPIt1IYf1Th1nb0=;
 b=M3oBfq4XlCYzDF08w6uemDuUM5C7CQze8xIL5GwrsuQEPSxXElaTuR49TqM21atoz2
 EJwid1Yoi1iiHAbcE4XPxPKQNklhMDYJsNlHQI8YTJIo12PylR8bqdkStp1EkN8Zckoo
 chrzJdy823Z54fPPTwh5jE7m20R+Dft0wfAj45tZQ9Tbs6PEf0Avpb6wzvvYhcXLK3N/
 dV5D991HRUz1LUoanaVyqdScghYo42CEIzFq8McXw3oxi9Nj2VKWzZbakonpHPqmvgKO
 QTXbZ2K/NedExQD6aES3XZKBvKBJ/g82KFRJsMLdbXTr7JuNHXe+EwxgOGEvyvYJDH6L
 b2qQ==
X-Gm-Message-State: AOJu0YwuwKoB1c3WjZ7GXdJ28D0D9+CELb6DGd3TA7cUenC8ll+o+pim
 wGI81l/4rRNoQ/1IwUwNTeAKyf/rkYrUeV9rConi897sshw9+tDZz9ceivn/GvWRTyWEpAOgHGU
 JCBhO0hJZvj8M/xozptWjviBqL56KiVz1Vp5x1KJKCTBwOwWJxzDK2sbS/R3c5+bUqyZV9VQgKm
 g=
X-Received: by 2002:a05:620a:4548:b0:76f:c24:5450 with SMTP id
 u8-20020a05620a454800b0076f0c245450mr20014031qkp.2.1698276459886; 
 Wed, 25 Oct 2023 16:27:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6yLePJJVfVtrvHtqqu8/Qk5fJIiqUTkUuKjCQ8zQ0zj/8ipgFubcApj2P5Nfy0tNAvs8e0Q==
X-Received: by 2002:a05:620a:4548:b0:76f:c24:5450 with SMTP id
 u8-20020a05620a454800b0076f0c245450mr20014008qkp.2.1698276459372; 
 Wed, 25 Oct 2023 16:27:39 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 p14-20020a05620a056e00b0077890c8896bsm4529469qkp.134.2023.10.25.16.27.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/24] kvm: require KVM_CAP_SIGNAL_MSI
Date: Thu, 26 Oct 2023 01:27:03 +0200
Message-ID: <20231025232718.89428-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025232718.89428-1-pbonzini@redhat.com>
References: <20231025232718.89428-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This was introduced in KVM in Linux 3.5, we can require it unconditionally
in kvm_irqchip_send_msi().  However, not all architectures have to implement
it so check it only in x86, the only architecture that ever had MSI injection
but not KVM_CAP_SIGNAL_MSI.

ARM uses it to detect the presence of the ITS emulation in the kernel,
introduced in Linux 4.8.  Assume that it's there and possibly fail when
realizing the arm-its-kvm device.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c            | 102 +++------------------------------
 accel/stubs/kvm-stub.c         |   1 -
 hw/intc/arm_gicv3_its_common.c |   3 +-
 include/sysemu/kvm.h           |   9 ---
 include/sysemu/kvm_int.h       |   1 -
 target/i386/kvm/kvm.c          |   1 +
 6 files changed, 9 insertions(+), 108 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 8eee5042252..0c7b0569da4 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -99,7 +99,6 @@ bool kvm_gsi_direct_mapping;
 bool kvm_allowed;
 bool kvm_readonly_mem_allowed;
 bool kvm_vm_attributes_allowed;
-bool kvm_direct_msi_allowed;
 bool kvm_ioeventfd_any_length_allowed;
 bool kvm_msi_use_devid;
 bool kvm_has_guest_debug;
@@ -1848,7 +1847,7 @@ static void clear_gsi(KVMState *s, unsigned int gsi)
 
 void kvm_init_irq_routing(KVMState *s)
 {
-    int gsi_count, i;
+    int gsi_count;
 
     gsi_count = kvm_check_extension(s, KVM_CAP_IRQ_ROUTING) - 1;
     if (gsi_count > 0) {
@@ -1860,12 +1859,6 @@ void kvm_init_irq_routing(KVMState *s)
     s->irq_routes = g_malloc0(sizeof(*s->irq_routes));
     s->nr_allocated_irq_routes = 0;
 
-    if (!kvm_direct_msi_allowed) {
-        for (i = 0; i < KVM_MSI_HASHTAB_SIZE; i++) {
-            QTAILQ_INIT(&s->msi_hashtab[i]);
-        }
-    }
-
     kvm_arch_init_irq_routing(s);
 }
 
@@ -1985,41 +1978,10 @@ void kvm_irqchip_change_notify(void)
     notifier_list_notify(&kvm_irqchip_change_notifiers, NULL);
 }
 
-static unsigned int kvm_hash_msi(uint32_t data)
-{
-    /* This is optimized for IA32 MSI layout. However, no other arch shall
-     * repeat the mistake of not providing a direct MSI injection API. */
-    return data & 0xff;
-}
-
-static void kvm_flush_dynamic_msi_routes(KVMState *s)
-{
-    KVMMSIRoute *route, *next;
-    unsigned int hash;
-
-    for (hash = 0; hash < KVM_MSI_HASHTAB_SIZE; hash++) {
-        QTAILQ_FOREACH_SAFE(route, &s->msi_hashtab[hash], entry, next) {
-            kvm_irqchip_release_virq(s, route->kroute.gsi);
-            QTAILQ_REMOVE(&s->msi_hashtab[hash], route, entry);
-            g_free(route);
-        }
-    }
-}
-
 static int kvm_irqchip_get_virq(KVMState *s)
 {
     int next_virq;
 
-    /*
-     * PIC and IOAPIC share the first 16 GSI numbers, thus the available
-     * GSI numbers are more than the number of IRQ route. Allocating a GSI
-     * number can succeed even though a new route entry cannot be added.
-     * When this happens, flush dynamic MSI entries to free IRQ route entries.
-     */
-    if (!kvm_direct_msi_allowed && s->irq_routes->nr == s->gsi_count) {
-        kvm_flush_dynamic_msi_routes(s);
-    }
-
     /* Return the lowest unused GSI in the bitmap */
     next_virq = find_first_zero_bit(s->used_gsi_bitmap, s->gsi_count);
     if (next_virq >= s->gsi_count) {
@@ -2029,63 +1991,17 @@ static int kvm_irqchip_get_virq(KVMState *s)
     }
 }
 
-static KVMMSIRoute *kvm_lookup_msi_route(KVMState *s, MSIMessage msg)
-{
-    unsigned int hash = kvm_hash_msi(msg.data);
-    KVMMSIRoute *route;
-
-    QTAILQ_FOREACH(route, &s->msi_hashtab[hash], entry) {
-        if (route->kroute.u.msi.address_lo == (uint32_t)msg.address &&
-            route->kroute.u.msi.address_hi == (msg.address >> 32) &&
-            route->kroute.u.msi.data == le32_to_cpu(msg.data)) {
-            return route;
-        }
-    }
-    return NULL;
-}
-
 int kvm_irqchip_send_msi(KVMState *s, MSIMessage msg)
 {
     struct kvm_msi msi;
-    KVMMSIRoute *route;
 
-    if (kvm_direct_msi_allowed) {
-        msi.address_lo = (uint32_t)msg.address;
-        msi.address_hi = msg.address >> 32;
-        msi.data = le32_to_cpu(msg.data);
-        msi.flags = 0;
-        memset(msi.pad, 0, sizeof(msi.pad));
+    msi.address_lo = (uint32_t)msg.address;
+    msi.address_hi = msg.address >> 32;
+    msi.data = le32_to_cpu(msg.data);
+    msi.flags = 0;
+    memset(msi.pad, 0, sizeof(msi.pad));
 
-        return kvm_vm_ioctl(s, KVM_SIGNAL_MSI, &msi);
-    }
-
-    route = kvm_lookup_msi_route(s, msg);
-    if (!route) {
-        int virq;
-
-        virq = kvm_irqchip_get_virq(s);
-        if (virq < 0) {
-            return virq;
-        }
-
-        route = g_new0(KVMMSIRoute, 1);
-        route->kroute.gsi = virq;
-        route->kroute.type = KVM_IRQ_ROUTING_MSI;
-        route->kroute.flags = 0;
-        route->kroute.u.msi.address_lo = (uint32_t)msg.address;
-        route->kroute.u.msi.address_hi = msg.address >> 32;
-        route->kroute.u.msi.data = le32_to_cpu(msg.data);
-
-        kvm_add_routing_entry(s, &route->kroute);
-        kvm_irqchip_commit_routes(s);
-
-        QTAILQ_INSERT_TAIL(&s->msi_hashtab[kvm_hash_msi(msg.data)], route,
-                           entry);
-    }
-
-    assert(route->kroute.type == KVM_IRQ_ROUTING_MSI);
-
-    return kvm_set_irq(s, route->kroute.gsi, 1);
+    return kvm_vm_ioctl(s, KVM_SIGNAL_MSI, &msi);
 }
 
 int kvm_irqchip_add_msi_route(KVMRouteChange *c, int vector, PCIDevice *dev)
@@ -2660,10 +2576,6 @@ static int kvm_init(MachineState *ms)
 
     s->max_nested_state_len = kvm_check_extension(s, KVM_CAP_NESTED_STATE);
 
-#ifdef KVM_CAP_IRQ_ROUTING
-    kvm_direct_msi_allowed = (kvm_check_extension(s, KVM_CAP_SIGNAL_MSI) > 0);
-#endif
-
     s->intx_set_mask = kvm_check_extension(s, KVM_CAP_PCI_2_3);
 
     s->irq_set_ioctl = KVM_IRQ_LINE;
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index a323252f8e2..bce005adad8 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -27,7 +27,6 @@ bool kvm_allowed;
 bool kvm_readonly_mem_allowed;
 bool kvm_ioeventfd_any_length_allowed;
 bool kvm_msi_use_devid;
-bool kvm_direct_msi_allowed;
 
 void kvm_flush_coalesced_mmio_buffer(void)
 {
diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index abaf77057e1..fddd6d490c2 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -163,8 +163,7 @@ type_init(gicv3_its_common_register_types)
 const char *its_class_name(void)
 {
     if (kvm_irqchip_in_kernel()) {
-        /* KVM implementation requires this capability */
-        return kvm_direct_msi_enabled() ? "arm-its-kvm" : NULL;
+        return "arm-its-kvm";
     } else {
         /* Software emulation based model */
         return "arm-gicv3-its";
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 97a8a4f201c..93dccf5dd92 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -43,7 +43,6 @@ extern bool kvm_msi_via_irqfd_allowed;
 extern bool kvm_gsi_routing_allowed;
 extern bool kvm_gsi_direct_mapping;
 extern bool kvm_readonly_mem_allowed;
-extern bool kvm_direct_msi_allowed;
 extern bool kvm_ioeventfd_any_length_allowed;
 extern bool kvm_msi_use_devid;
 
@@ -147,13 +146,6 @@ extern bool kvm_msi_use_devid;
  */
 #define kvm_readonly_mem_enabled() (kvm_readonly_mem_allowed)
 
-/**
- * kvm_direct_msi_enabled:
- *
- * Returns: true if KVM allows direct MSI injection.
- */
-#define kvm_direct_msi_enabled() (kvm_direct_msi_allowed)
-
 /**
  * kvm_ioeventfd_any_length_enabled:
  * Returns: true if KVM allows any length io eventfd.
@@ -181,7 +173,6 @@ extern bool kvm_msi_use_devid;
 #define kvm_gsi_routing_allowed() (false)
 #define kvm_gsi_direct_mapping() (false)
 #define kvm_readonly_mem_enabled() (false)
-#define kvm_direct_msi_enabled() (false)
 #define kvm_ioeventfd_any_length_enabled() (false)
 #define kvm_msi_devid_required() (false)
 
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 075939a3c4f..a7dacd12d6c 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -103,7 +103,6 @@ struct KVMState
     int nr_allocated_irq_routes;
     unsigned long *used_gsi_bitmap;
     unsigned int gsi_count;
-    QTAILQ_HEAD(, KVMMSIRoute) msi_hashtab[KVM_MSI_HASHTAB_SIZE];
 #endif
     KVMMemoryListener memory_listener;
     QLIST_HEAD(, KVMParkedVcpu) kvm_parked_vcpus;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e7c054cc160..fb6655254fc 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -91,6 +91,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(SET_TSS_ADDR),
     KVM_CAP_INFO(EXT_CPUID),
     KVM_CAP_INFO(MP_STATE),
+    KVM_CAP_INFO(SIGNAL_MSI),
     KVM_CAP_LAST_INFO
 };
 
-- 
2.41.0



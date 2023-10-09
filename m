Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D707BD4BB
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 09:53:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpl4t-0001mY-6r; Mon, 09 Oct 2023 03:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qpl4r-0001fL-18
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:53:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qpl4o-0001Jm-29
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696837996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pmCcm1ngigCRMNHbMb1xhBGl5nuSCKXEWEk4GyTuY7M=;
 b=NpV/EKD1yDDE6RdLx1TL47SKpyPNaMglXfUak7TFGuGhYoe84ioYe8PjTYII4gLFLeevaW
 kGYcehtM0iDvCB0TZhtGLnIJ6QA1FFISme6EMRTFAllwrV31n3roW6uKGaRHERcqxCNsQn
 cdYsgKI3mvjSgdFqrwKSxtUVnCQeWZo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-VzrUjoK7O6Kav2GntNwHtA-1; Mon, 09 Oct 2023 03:53:15 -0400
X-MC-Unique: VzrUjoK7O6Kav2GntNwHtA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2613810BDC;
 Mon,  9 Oct 2023 07:53:14 +0000 (UTC)
Received: from localhost (unknown [10.39.208.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F9AA140E962;
 Mon,  9 Oct 2023 07:53:12 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH] memory: follow Error API guidelines
Date: Mon,  9 Oct 2023 11:53:10 +0400
Message-ID: <20231009075310.153617-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Return true/false on success/failure.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/core/cpu.h             |  4 +++-
 include/hw/core/sysemu-cpu-ops.h  |  2 +-
 include/sysemu/memory_mapping.h   |  2 +-
 target/i386/cpu.h                 |  2 +-
 hw/core/cpu-sysemu.c              |  6 +++---
 softmmu/memory_mapping.c          | 13 ++++++-------
 target/i386/arch_memory_mapping.c |  6 ++++--
 7 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index e02bc5980f..2373fdde18 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -618,8 +618,10 @@ bool cpu_paging_enabled(const CPUState *cpu);
  * @cpu: The CPU whose memory mappings are to be obtained.
  * @list: Where to write the memory mappings to.
  * @errp: Pointer for reporting an #Error.
+ *
+ * Returns: %true on success, %false otherwise.
  */
-void cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
+bool cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
                             Error **errp);
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index ee169b872c..24d003fe04 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -19,7 +19,7 @@ typedef struct SysemuCPUOps {
     /**
      * @get_memory_mapping: Callback for obtaining the memory mappings.
      */
-    void (*get_memory_mapping)(CPUState *cpu, MemoryMappingList *list,
+    bool (*get_memory_mapping)(CPUState *cpu, MemoryMappingList *list,
                                Error **errp);
     /**
      * @get_paging_enabled: Callback for inquiring whether paging is enabled.
diff --git a/include/sysemu/memory_mapping.h b/include/sysemu/memory_mapping.h
index 3bbeb1bcb4..021e0a6230 100644
--- a/include/sysemu/memory_mapping.h
+++ b/include/sysemu/memory_mapping.h
@@ -71,7 +71,7 @@ void guest_phys_blocks_free(GuestPhysBlockList *list);
 void guest_phys_blocks_init(GuestPhysBlockList *list);
 void guest_phys_blocks_append(GuestPhysBlockList *list);
 
-void qemu_get_guest_memory_mapping(MemoryMappingList *list,
+bool qemu_get_guest_memory_mapping(MemoryMappingList *list,
                                    const GuestPhysBlockList *guest_phys_blocks,
                                    Error **errp);
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e1875466b9..471e71dbc5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2055,7 +2055,7 @@ int x86_cpu_write_elf64_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
 int x86_cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
                                  DumpState *s);
 
-void x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
+bool x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
                                 Error **errp);
 
 void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
diff --git a/hw/core/cpu-sysemu.c b/hw/core/cpu-sysemu.c
index 5eaf2e79e6..d0d6a910f9 100644
--- a/hw/core/cpu-sysemu.c
+++ b/hw/core/cpu-sysemu.c
@@ -34,17 +34,17 @@ bool cpu_paging_enabled(const CPUState *cpu)
     return false;
 }
 
-void cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
+bool cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
                             Error **errp)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
     if (cc->sysemu_ops->get_memory_mapping) {
-        cc->sysemu_ops->get_memory_mapping(cpu, list, errp);
-        return;
+        return cc->sysemu_ops->get_memory_mapping(cpu, list, errp);
     }
 
     error_setg(errp, "Obtaining memory mappings is unsupported on this CPU.");
+    return false;
 }
 
 hwaddr cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
diff --git a/softmmu/memory_mapping.c b/softmmu/memory_mapping.c
index 8ba9968f8c..6f884c5b90 100644
--- a/softmmu/memory_mapping.c
+++ b/softmmu/memory_mapping.c
@@ -304,10 +304,11 @@ static CPUState *find_paging_enabled_cpu(void)
     return NULL;
 }
 
-void qemu_get_guest_memory_mapping(MemoryMappingList *list,
+bool qemu_get_guest_memory_mapping(MemoryMappingList *list,
                                    const GuestPhysBlockList *guest_phys_blocks,
                                    Error **errp)
 {
+    ERRP_GUARD();
     CPUState *cpu, *first_paging_enabled_cpu;
     GuestPhysBlock *block;
     ram_addr_t offset, length;
@@ -316,14 +317,11 @@ void qemu_get_guest_memory_mapping(MemoryMappingList *list,
     if (first_paging_enabled_cpu) {
         for (cpu = first_paging_enabled_cpu; cpu != NULL;
              cpu = CPU_NEXT(cpu)) {
-            Error *err = NULL;
-            cpu_get_memory_mapping(cpu, list, &err);
-            if (err) {
-                error_propagate(errp, err);
-                return;
+            if (!cpu_get_memory_mapping(cpu, list, errp)) {
+                return false;
             }
         }
-        return;
+        return true;
     }
 
     /*
@@ -335,6 +333,7 @@ void qemu_get_guest_memory_mapping(MemoryMappingList *list,
         length = block->target_end - block->target_start;
         create_new_memory_mapping(list, offset, offset, length);
     }
+    return true;
 }
 
 void qemu_get_guest_simple_memory_mapping(MemoryMappingList *list,
diff --git a/target/i386/arch_memory_mapping.c b/target/i386/arch_memory_mapping.c
index 271cb5e41b..d1ff659128 100644
--- a/target/i386/arch_memory_mapping.c
+++ b/target/i386/arch_memory_mapping.c
@@ -266,7 +266,7 @@ static void walk_pml5e(MemoryMappingList *list, AddressSpace *as,
 }
 #endif
 
-void x86_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
+bool x86_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
                                 Error **errp)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -275,7 +275,7 @@ void x86_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
 
     if (!cpu_paging_enabled(cs)) {
         /* paging is disabled */
-        return;
+        return true;
     }
 
     a20_mask = x86_get_a20_mask(env);
@@ -310,5 +310,7 @@ void x86_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
         pse = !!(env->cr[4] & CR4_PSE_MASK);
         walk_pde2(list, cs->as, pde_addr, a20_mask, pse);
     }
+
+    return true;
 }
 
-- 
2.41.0



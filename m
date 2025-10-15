Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5CDBDE42A
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Oct 2025 13:25:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8zbv-0008Uz-DI; Wed, 15 Oct 2025 07:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8zbt-0008Um-KA
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 07:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8zbl-0003Dn-Sq
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 07:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760527431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bss9VrrkZjAvO7SOaj3Ahs7ZGtj6irMV84p1n8Tp6NE=;
 b=dAeaUwChB7ZCQFzYtpXjdsKsYK5XTKgR7Oo2WsB3CkazmE1Ci8hyR9FCArgO79eQ/Lfi/p
 +jxZqscOLEJ2Mz9F5kyWB5F5iU+BH0RaM6sPpOi1Nkrstu9PNc3wn2L6cWIvmBxfSaV4DR
 D42Y4V2iaUzQRN76qgLtXMDbZm5BAoc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-nUsEMVVrN9mg0ZSq2Czw4g-1; Wed,
 15 Oct 2025 07:23:49 -0400
X-MC-Unique: nUsEMVVrN9mg0ZSq2Czw4g-1
X-Mimecast-MFC-AGG-ID: nUsEMVVrN9mg0ZSq2Czw4g_1760527428
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1409D1800D89; Wed, 15 Oct 2025 11:23:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FF9330001A1; Wed, 15 Oct 2025 11:23:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EDAC0180099B; Wed, 15 Oct 2025 13:23:42 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 3/5] igvm: add support for initial register state load in
 native mode
Date: Wed, 15 Oct 2025 13:23:40 +0200
Message-ID: <20251015112342.1672955-4-kraxel@redhat.com>
In-Reply-To: <20251015112342.1672955-1-kraxel@redhat.com>
References: <20251015112342.1672955-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add IgvmNativeVpContextX64 struct holding the register state (see igvm
spec), and the qigvm_x86_load_context() function to load the register
state.

Wire up using two new functions: qigvm_x86_set_vp_context() is called
from igvm file handling code and stores the boot processor context.
qigvm_x86_bsp_reset() is called from i386 target cpu reset code and
loads the context into the cpu registers.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/system/igvm.h |   2 +
 target/i386/cpu.h     |   3 +
 backends/igvm.c       |  30 +++++-----
 stubs/igvm.c          |   5 ++
 target/i386/cpu.c     |   4 ++
 target/i386/igvm.c    | 133 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 162 insertions(+), 15 deletions(-)

diff --git a/include/system/igvm.h b/include/system/igvm.h
index 3f72a40b8897..48ce20604259 100644
--- a/include/system/igvm.h
+++ b/include/system/igvm.h
@@ -23,5 +23,7 @@ int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
 int qigvm_x86_get_mem_map_entry(int index,
                                 ConfidentialGuestMemoryMapEntry *entry,
                                 Error **errp);
+int qigvm_x86_set_vp_context(void *data, int index,
+                             Error **errp);
 
 #endif
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ce948861a765..78d4b427c67a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2867,6 +2867,9 @@ void x86_cpu_dump_local_apic_state(CPUState *cs, int flags);
 
 #endif
 
+/* igvm.c */
+void qigvm_x86_bsp_reset(CPUX86State *env);
+
 /* cpu.c */
 bool cpu_is_bsp(X86CPU *cpu);
 
diff --git a/backends/igvm.c b/backends/igvm.c
index e949c81abb9a..ee5ee74c7a66 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -432,18 +432,6 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
         return 0;
     }
 
-    /*
-     * A confidential guest support object must be provided for setting
-     * a VP context.
-     */
-    if (!ctx->cgs) {
-        error_setg(
-            errp,
-            "A VP context is present in the IGVM file but is not supported "
-            "by the current system.");
-        return -1;
-    }
-
     data_handle = igvm_get_header_data(ctx->file, IGVM_HEADER_SECTION_DIRECTIVE,
                                        ctx->current_header_index);
     if (data_handle < 0) {
@@ -453,9 +441,21 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
     }
 
     data = (uint8_t *)igvm_get_buffer(ctx->file, data_handle);
-    result = ctx->cgsc->set_guest_state(
-        vp_context->gpa, data, igvm_get_buffer_size(ctx->file, data_handle),
-        CGS_PAGE_TYPE_VMSA, vp_context->vp_index, errp);
+
+    if (ctx->cgs) {
+        result = ctx->cgsc->set_guest_state(
+            vp_context->gpa, data, igvm_get_buffer_size(ctx->file, data_handle),
+            CGS_PAGE_TYPE_VMSA, vp_context->vp_index, errp);
+    } else if (target_arch() == SYS_EMU_TARGET_X86_64) {
+        result = qigvm_x86_set_vp_context(data, vp_context->vp_index, errp);
+    } else {
+        error_setg(
+            errp,
+            "A VP context is present in the IGVM file but is not supported "
+            "by the current system.");
+        result = -1;
+    }
+
     igvm_free_buffer(ctx->file, data_handle);
     if (result < 0) {
         return result;
diff --git a/stubs/igvm.c b/stubs/igvm.c
index c32058eb2a6e..17cd1e903e35 100644
--- a/stubs/igvm.c
+++ b/stubs/igvm.c
@@ -19,3 +19,8 @@ int qigvm_x86_get_mem_map_entry(int index,
 {
     return -1;
 }
+
+int qigvm_x86_set_vp_context(void *data, int index, Error **errp)
+{
+    return -1;
+}
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 455caff6b230..8dd5ac8020c2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8770,6 +8770,10 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
 
     cs->halted = !cpu_is_bsp(cpu);
 
+    if (cpu_is_bsp(cpu)) {
+        qigvm_x86_bsp_reset(env);
+    }
+
     if (kvm_enabled()) {
         kvm_arch_reset_vcpu(cpu);
     }
diff --git a/target/i386/igvm.c b/target/i386/igvm.c
index 2ed6cd052c79..0921ec830508 100644
--- a/target/i386/igvm.c
+++ b/target/i386/igvm.c
@@ -11,9 +11,114 @@
 
 #include "qemu/osdep.h"
 
+#include "cpu.h"
 #include "hw/i386/e820_memory_layout.h"
 #include "system/igvm.h"
 
+struct IgvmNativeVpContextX64 {
+    uint64_t rax;
+    uint64_t rcx;
+    uint64_t rdx;
+    uint64_t rbx;
+    uint64_t rsp;
+    uint64_t rbp;
+    uint64_t rsi;
+    uint64_t rdi;
+    uint64_t r8;
+    uint64_t r9;
+    uint64_t r10;
+    uint64_t r11;
+    uint64_t r12;
+    uint64_t r13;
+    uint64_t r14;
+    uint64_t r15;
+    uint64_t rip;
+    uint64_t rflags;
+    uint64_t idtr_base;
+    uint16_t idtr_limit;
+    uint16_t reserved[2];
+    uint16_t gdtr_limit;
+    uint64_t gdtr_base;
+
+    uint16_t code_selector;
+    uint16_t code_attributes;
+    uint32_t code_base;
+    uint32_t code_limit;
+
+    uint16_t data_selector;
+    uint16_t data_attributes;
+    uint32_t data_base;
+    uint32_t data_limit;
+
+    uint64_t gs_base;
+    uint64_t cr0;
+    uint64_t cr3;
+    uint64_t cr4;
+    uint64_t efer;
+};
+
+#define FLAGS_TO_SEGCACHE(flags)                \
+    (((unsigned int)flags) << 8)
+
+static void qigvm_x86_load_context(struct IgvmNativeVpContextX64 *context, CPUX86State *env)
+{
+    cpu_load_efer(env, context->efer);
+    cpu_x86_update_cr4(env, context->cr4);
+    cpu_x86_update_cr0(env, context->cr0);
+    cpu_x86_update_cr3(env, context->cr3);
+
+    cpu_x86_load_seg_cache(
+        env, R_CS, context->code_selector,
+        context->code_base, context->code_limit,
+        FLAGS_TO_SEGCACHE(context->code_attributes));
+    cpu_x86_load_seg_cache(
+        env, R_DS, context->data_selector,
+        context->data_base, context->data_limit,
+        FLAGS_TO_SEGCACHE(context->data_attributes));
+    cpu_x86_load_seg_cache(
+        env, R_ES, context->data_selector,
+        context->data_base, context->data_limit,
+        FLAGS_TO_SEGCACHE(context->data_attributes));
+    cpu_x86_load_seg_cache(
+        env, R_FS, context->data_selector,
+        context->data_base, context->data_limit,
+        FLAGS_TO_SEGCACHE(context->data_attributes));
+    cpu_x86_load_seg_cache(
+        env, R_GS, context->data_selector,
+        context->data_base, context->data_limit,
+        FLAGS_TO_SEGCACHE(context->data_attributes));
+    cpu_x86_load_seg_cache(
+        env, R_SS, context->data_selector,
+        context->data_base, context->data_limit,
+        FLAGS_TO_SEGCACHE(context->data_attributes));
+
+    env->gdt.base = context->gdtr_base;
+    env->gdt.limit = context->gdtr_limit;
+    env->idt.base = context->idtr_base;
+    env->idt.limit = context->idtr_limit;
+
+    env->regs[R_EAX] = context->rax;
+    env->regs[R_ECX] = context->rcx;
+    env->regs[R_EDX] = context->rdx;
+    env->regs[R_EBX] = context->rbx;
+    env->regs[R_ESP] = context->rsp;
+    env->regs[R_EBP] = context->rbp;
+    env->regs[R_ESI] = context->rsi;
+    env->regs[R_EDI] = context->rdi;
+#ifdef TARGET_X86_64
+    env->regs[R_R8] = context->r8;
+    env->regs[R_R9] = context->r9;
+    env->regs[R_R10] = context->r10;
+    env->regs[R_R11] = context->r11;
+    env->regs[R_R12] = context->r12;
+    env->regs[R_R13] = context->r13;
+    env->regs[R_R14] = context->r14;
+    env->regs[R_R15] = context->r15;
+#endif
+    env->eip = context->rip;
+    env->eflags = context->rflags;
+}
+
 /*
  * convert e820 table into igvm memory map
  */
@@ -44,3 +149,31 @@ int qigvm_x86_get_mem_map_entry(int index,
     }
     return 0;
 }
+
+/*
+ * set initial cpu context
+ */
+static struct IgvmNativeVpContextX64 *bsp_context;
+
+int qigvm_x86_set_vp_context(void *data, int index, Error **errp)
+{
+    if (index != 0) {
+        error_setg(errp, "context can be set for BSP only");
+        return -1;
+    }
+
+    if (bsp_context == NULL) {
+        bsp_context = g_new0(struct IgvmNativeVpContextX64, 1);
+    }
+    memcpy(bsp_context, data, sizeof(struct IgvmNativeVpContextX64));
+    return 0;
+}
+
+void qigvm_x86_bsp_reset(CPUX86State *env)
+{
+    if (bsp_context == NULL) {
+        return;
+    }
+
+    qigvm_x86_load_context(bsp_context, env);
+}
-- 
2.51.0



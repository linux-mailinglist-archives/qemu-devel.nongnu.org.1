Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EDA9309AB
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jul 2024 13:13:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSx8T-0005jo-Ud; Sun, 14 Jul 2024 07:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sSx8Q-0005Z7-Tr
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 07:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sSx8O-00028w-UH
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 07:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720955476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OUMYHZ6i4EA7K7uyAc3TiRc4wdBbB5/oRUtyZ3vopSw=;
 b=Na84S/NfG1oqdOMwiqZss+OU0dtmX1KnwQSbLost+fwA8oNz1N/UNbVig0BFadmSydBD4a
 clgnK/mCgF2EpyIdPXVO+dBgsrDN653TS7u9g346Ft9UYfASssu3ZYdvm6IeUJG7MPLDlG
 sc7tyM5W1Pu3MJ12IAH/Wjc+latva88=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-Tg4Jw9N5NEWgGkEW6-6gsQ-1; Sun, 14 Jul 2024 07:11:14 -0400
X-MC-Unique: Tg4Jw9N5NEWgGkEW6-6gsQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-367a14a6664so2365241f8f.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 04:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720955473; x=1721560273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OUMYHZ6i4EA7K7uyAc3TiRc4wdBbB5/oRUtyZ3vopSw=;
 b=Pe+oGh3N15Ckd0jQuZrWy+FZ5bbdnbKQFd/QnomA4Nyi565uktR62Bp0hstM2zVFZa
 9zsps3/TtaEdv5gS6VwOZb1CSTNNQ1pcKQF2G+FqTehvj5arB+n+HShcFPfA4ds5Y4yT
 rQFsIRA57XIMFysJ/Z6zNMuMDPjrLvEF6z+phN6Vn56VprIuPX+ljAF1BUKfDcmzIlnL
 FbVyCsIEniq7ZPqGmnVDZi8ASu+Zo4GSpFbINORk9bfsDHCbl4coufdA2k6tMyS+d2hq
 kWfc3yGtXVBf/XXsGfSj0IaFyMsvBkbTGxZ6lWDTAMrzdretwnTeO8+ET7Rsm+z0nOgs
 R5Gw==
X-Gm-Message-State: AOJu0Yx51fLxnoVHPVhhqekO9wFWYuYDbNfco3epZK7cxKxwa8UKR70N
 A3qRqJD2bmgDLA0FgRCpB7G3hhxHQehU1jHu7hHZnkBHgrjXE3jhoaECJl/f+5j/U+uOFsEUG1E
 LpKNVruKNS9CPsnQFbmT2b307CbhVbROAyHVNNBDqagVR5zxm1vN+N/4d1l3hr/QJbmxuiMKvub
 q3A+vNpwH1TwaL5ybEKTFBj1VjO5Co+72vonCw
X-Received: by 2002:a05:6000:184b:b0:367:94f7:88f3 with SMTP id
 ffacd0b85a97d-367ceadd2b3mr13504172f8f.57.1720955472754; 
 Sun, 14 Jul 2024 04:11:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfbuRJpIvgZC60bLNe0h7iePXPBe+I8EhIFNJ4Ak5K9CZIPuGpUzv7QKDOHXP+3T332rjRtw==
X-Received: by 2002:a05:6000:184b:b0:367:94f7:88f3 with SMTP id
 ffacd0b85a97d-367ceadd2b3mr13504160f8f.57.1720955472362; 
 Sun, 14 Jul 2024 04:11:12 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3be3sm3585565f8f.24.2024.07.14.04.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jul 2024 04:11:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/13] target/i386/tcg: use X86Access for TSS access
Date: Sun, 14 Jul 2024 13:10:40 +0200
Message-ID: <20240714111043.14132-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240714111043.14132-1-pbonzini@redhat.com>
References: <20240714111043.14132-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

This takes care of probing the vaddr range in advance, and is also faster
because it avoids repeated TLB lookups.  It also matches the Intel manual
better, as it says "Checks that the current (old) TSS, new TSS, and all
segment descriptors used in the task switch are paged into system memory";
note however that it's not clear how the processor checks for segment
descriptors, and this check is not included in the AMD manual.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 110 ++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 52 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 0242f9d8b58..fea08a2ba0f 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -27,6 +27,7 @@
 #include "exec/log.h"
 #include "helper-tcg.h"
 #include "seg_helper.h"
+#include "access.h"
 
 #ifdef TARGET_X86_64
 #define SET_ESP(val, sp_mask)                                   \
@@ -313,14 +314,15 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
                          uint32_t e1, uint32_t e2, int source,
                          uint32_t next_eip, uintptr_t retaddr)
 {
-    int tss_limit, tss_limit_max, type, old_tss_limit_max, old_type, v1, v2, i;
+    int tss_limit, tss_limit_max, type, old_tss_limit_max, old_type, i;
     target_ulong tss_base;
     uint32_t new_regs[8], new_segs[6];
     uint32_t new_eflags, new_eip, new_cr3, new_ldt, new_trap;
     uint32_t old_eflags, eflags_mask;
     SegmentCache *dt;
-    int index;
+    int mmu_index, index;
     target_ulong ptr;
+    X86Access old, new;
 
     type = (e2 >> DESC_TYPE_SHIFT) & 0xf;
     LOG_PCALL("switch_tss: sel=0x%04x type=%d src=%d\n", tss_selector, type,
@@ -374,35 +376,45 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
         raise_exception_err_ra(env, EXCP0A_TSS, tss_selector & 0xfffc, retaddr);
     }
 
+    /* X86Access avoids memory exceptions during the task switch */
+    mmu_index = cpu_mmu_index_kernel(env);
+    access_prepare_mmu(&old, env, env->tr.base, old_tss_limit_max,
+                       MMU_DATA_STORE, mmu_index, retaddr);
+
+    if (source == SWITCH_TSS_CALL) {
+        /* Probe for future write of parent task */
+        probe_access(env, tss_base, 2, MMU_DATA_STORE,
+                     mmu_index, retaddr);
+    }
+    access_prepare_mmu(&new, env, tss_base, tss_limit,
+                       MMU_DATA_LOAD, mmu_index, retaddr);
+
     /* read all the registers from the new TSS */
     if (type & 8) {
         /* 32 bit */
-        new_cr3 = cpu_ldl_kernel_ra(env, tss_base + 0x1c, retaddr);
-        new_eip = cpu_ldl_kernel_ra(env, tss_base + 0x20, retaddr);
-        new_eflags = cpu_ldl_kernel_ra(env, tss_base + 0x24, retaddr);
+        new_cr3 = access_ldl(&new, tss_base + 0x1c);
+        new_eip = access_ldl(&new, tss_base + 0x20);
+        new_eflags = access_ldl(&new, tss_base + 0x24);
         for (i = 0; i < 8; i++) {
-            new_regs[i] = cpu_ldl_kernel_ra(env, tss_base + (0x28 + i * 4),
-                                            retaddr);
+            new_regs[i] = access_ldl(&new, tss_base + (0x28 + i * 4));
         }
         for (i = 0; i < 6; i++) {
-            new_segs[i] = cpu_lduw_kernel_ra(env, tss_base + (0x48 + i * 4),
-                                             retaddr);
+            new_segs[i] = access_ldw(&new, tss_base + (0x48 + i * 4));
         }
-        new_ldt = cpu_lduw_kernel_ra(env, tss_base + 0x60, retaddr);
-        new_trap = cpu_ldl_kernel_ra(env, tss_base + 0x64, retaddr);
+        new_ldt = access_ldw(&new, tss_base + 0x60);
+        new_trap = access_ldl(&new, tss_base + 0x64);
     } else {
         /* 16 bit */
         new_cr3 = 0;
-        new_eip = cpu_lduw_kernel_ra(env, tss_base + 0x0e, retaddr);
-        new_eflags = cpu_lduw_kernel_ra(env, tss_base + 0x10, retaddr);
+        new_eip = access_ldw(&new, tss_base + 0x0e);
+        new_eflags = access_ldw(&new, tss_base + 0x10);
         for (i = 0; i < 8; i++) {
-            new_regs[i] = cpu_lduw_kernel_ra(env, tss_base + (0x12 + i * 2), retaddr);
+            new_regs[i] = access_ldw(&new, tss_base + (0x12 + i * 2));
         }
         for (i = 0; i < 4; i++) {
-            new_segs[i] = cpu_lduw_kernel_ra(env, tss_base + (0x22 + i * 2),
-                                             retaddr);
+            new_segs[i] = access_ldw(&new, tss_base + (0x22 + i * 2));
         }
-        new_ldt = cpu_lduw_kernel_ra(env, tss_base + 0x2a, retaddr);
+        new_ldt = access_ldw(&new, tss_base + 0x2a);
         new_segs[R_FS] = 0;
         new_segs[R_GS] = 0;
         new_trap = 0;
@@ -412,16 +424,6 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
      chapters 12.2.5 and 13.2.4 on how to implement TSS Trap bit */
     (void)new_trap;
 
-    /* NOTE: we must avoid memory exceptions during the task switch,
-       so we make dummy accesses before */
-    /* XXX: it can still fail in some cases, so a bigger hack is
-       necessary to valid the TLB after having done the accesses */
-
-    v1 = cpu_ldub_kernel_ra(env, env->tr.base, retaddr);
-    v2 = cpu_ldub_kernel_ra(env, env->tr.base + old_tss_limit_max, retaddr);
-    cpu_stb_kernel_ra(env, env->tr.base, v1, retaddr);
-    cpu_stb_kernel_ra(env, env->tr.base + old_tss_limit_max, v2, retaddr);
-
     /* clear busy bit (it is restartable) */
     if (source == SWITCH_TSS_JMP || source == SWITCH_TSS_IRET) {
         tss_set_busy(env, env->tr.selector, 0, retaddr);
@@ -434,35 +436,35 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
     /* save the current state in the old TSS */
     if (old_type & 8) {
         /* 32 bit */
-        cpu_stl_kernel_ra(env, env->tr.base + 0x20, next_eip, retaddr);
-        cpu_stl_kernel_ra(env, env->tr.base + 0x24, old_eflags, retaddr);
-        cpu_stl_kernel_ra(env, env->tr.base + (0x28 + 0 * 4), env->regs[R_EAX], retaddr);
-        cpu_stl_kernel_ra(env, env->tr.base + (0x28 + 1 * 4), env->regs[R_ECX], retaddr);
-        cpu_stl_kernel_ra(env, env->tr.base + (0x28 + 2 * 4), env->regs[R_EDX], retaddr);
-        cpu_stl_kernel_ra(env, env->tr.base + (0x28 + 3 * 4), env->regs[R_EBX], retaddr);
-        cpu_stl_kernel_ra(env, env->tr.base + (0x28 + 4 * 4), env->regs[R_ESP], retaddr);
-        cpu_stl_kernel_ra(env, env->tr.base + (0x28 + 5 * 4), env->regs[R_EBP], retaddr);
-        cpu_stl_kernel_ra(env, env->tr.base + (0x28 + 6 * 4), env->regs[R_ESI], retaddr);
-        cpu_stl_kernel_ra(env, env->tr.base + (0x28 + 7 * 4), env->regs[R_EDI], retaddr);
+        access_stl(&old, env->tr.base + 0x20, next_eip);
+        access_stl(&old, env->tr.base + 0x24, old_eflags);
+        access_stl(&old, env->tr.base + (0x28 + 0 * 4), env->regs[R_EAX]);
+        access_stl(&old, env->tr.base + (0x28 + 1 * 4), env->regs[R_ECX]);
+        access_stl(&old, env->tr.base + (0x28 + 2 * 4), env->regs[R_EDX]);
+        access_stl(&old, env->tr.base + (0x28 + 3 * 4), env->regs[R_EBX]);
+        access_stl(&old, env->tr.base + (0x28 + 4 * 4), env->regs[R_ESP]);
+        access_stl(&old, env->tr.base + (0x28 + 5 * 4), env->regs[R_EBP]);
+        access_stl(&old, env->tr.base + (0x28 + 6 * 4), env->regs[R_ESI]);
+        access_stl(&old, env->tr.base + (0x28 + 7 * 4), env->regs[R_EDI]);
         for (i = 0; i < 6; i++) {
-            cpu_stw_kernel_ra(env, env->tr.base + (0x48 + i * 4),
-                              env->segs[i].selector, retaddr);
+            access_stw(&old, env->tr.base + (0x48 + i * 4),
+                       env->segs[i].selector);
         }
     } else {
         /* 16 bit */
-        cpu_stw_kernel_ra(env, env->tr.base + 0x0e, next_eip, retaddr);
-        cpu_stw_kernel_ra(env, env->tr.base + 0x10, old_eflags, retaddr);
-        cpu_stw_kernel_ra(env, env->tr.base + (0x12 + 0 * 2), env->regs[R_EAX], retaddr);
-        cpu_stw_kernel_ra(env, env->tr.base + (0x12 + 1 * 2), env->regs[R_ECX], retaddr);
-        cpu_stw_kernel_ra(env, env->tr.base + (0x12 + 2 * 2), env->regs[R_EDX], retaddr);
-        cpu_stw_kernel_ra(env, env->tr.base + (0x12 + 3 * 2), env->regs[R_EBX], retaddr);
-        cpu_stw_kernel_ra(env, env->tr.base + (0x12 + 4 * 2), env->regs[R_ESP], retaddr);
-        cpu_stw_kernel_ra(env, env->tr.base + (0x12 + 5 * 2), env->regs[R_EBP], retaddr);
-        cpu_stw_kernel_ra(env, env->tr.base + (0x12 + 6 * 2), env->regs[R_ESI], retaddr);
-        cpu_stw_kernel_ra(env, env->tr.base + (0x12 + 7 * 2), env->regs[R_EDI], retaddr);
+        access_stw(&old, env->tr.base + 0x0e, next_eip);
+        access_stw(&old, env->tr.base + 0x10, old_eflags);
+        access_stw(&old, env->tr.base + (0x12 + 0 * 2), env->regs[R_EAX]);
+        access_stw(&old, env->tr.base + (0x12 + 1 * 2), env->regs[R_ECX]);
+        access_stw(&old, env->tr.base + (0x12 + 2 * 2), env->regs[R_EDX]);
+        access_stw(&old, env->tr.base + (0x12 + 3 * 2), env->regs[R_EBX]);
+        access_stw(&old, env->tr.base + (0x12 + 4 * 2), env->regs[R_ESP]);
+        access_stw(&old, env->tr.base + (0x12 + 5 * 2), env->regs[R_EBP]);
+        access_stw(&old, env->tr.base + (0x12 + 6 * 2), env->regs[R_ESI]);
+        access_stw(&old, env->tr.base + (0x12 + 7 * 2), env->regs[R_EDI]);
         for (i = 0; i < 4; i++) {
-            cpu_stw_kernel_ra(env, env->tr.base + (0x22 + i * 2),
-                              env->segs[i].selector, retaddr);
+            access_stw(&old, env->tr.base + (0x22 + i * 2),
+                       env->segs[i].selector);
         }
     }
 
@@ -470,7 +472,11 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
        context */
 
     if (source == SWITCH_TSS_CALL) {
-        cpu_stw_kernel_ra(env, tss_base, env->tr.selector, retaddr);
+        /*
+         * Thanks to the probe_access above, we know the first two
+         * bytes addressed by &new are writable too.
+         */
+        access_stw(&new, tss_base, env->tr.selector);
         new_eflags |= NT_MASK;
     }
 
-- 
2.45.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1236F772B4A
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:42:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3EX-0007NE-Gl; Mon, 07 Aug 2023 12:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EJ-00073r-EL
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:18 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EH-0002h0-M6
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:15 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1b9c5e07c1bso42277055ad.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691426232; x=1692031032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMertvkjKANJvxbefrHCxJAv2awwG2qfsSApx0ejDkI=;
 b=SN6+KaU16CQ7BBO0ZWGlSIhpncMDd+HHOAFPUgHasS1BYRV8UZc1hZW0aLtX3pnNk3
 Nk1Ceun6lCpgq+L0Fi4WCbC6lo5aiGteW351gE8Hz6BJAinLdXJ7r6e4kpEn9cui21hq
 f/k5jfFVXDtQ5g3NYzYf/blpixECY4TWfIi8xWkBc1FGuZ+Uo+52rnzWEaBxa0A3Moj3
 MzfOYHG59/BKcREWwbYWqV+h2rdna/Aq9MVwvZr8ahGJkRLO8E9AkKf9q5ZWR2K60ylK
 GL+yjVsX/nEiGH+VUrLFbs1mBwITF/W9UhJglxAxH7DsAZ4mhxAmGJNTvalGJpTJJuii
 wrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691426232; x=1692031032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AMertvkjKANJvxbefrHCxJAv2awwG2qfsSApx0ejDkI=;
 b=e8Jcyx/XzklzVo0Fg+QakO4yu16qDKqWVXR+vIWVYBebFbVqK8AfdSBbVAVmau8uO6
 Cz9PUeeK6honWjkvRe/wofa4hQgE2W7ml9m2slGZNsG+jZK81BupC/tZ5pjmcOoEV5Zr
 2c18aDBe/MreaUHLFoiWt2GbRQ1mR7NL5z2qYIQ+bbJpI9bkxS4II2kjSzybYmptmNXG
 gGaDYksQayAULHDMzDcMJWNS0q8AB101eeYl1OLNcYziWR2BqalITjJ/PZbBwtR/qM4a
 6NRRJoFCnaEyTm5yhnluKeavRQVWVYNgO3FqEhzdc2ALIz/+iwZEyrPDq9pl8lMOMnnS
 2xaw==
X-Gm-Message-State: AOJu0YwJ8eWu02UjES9Gp+/abbxFbXOGrpODfKOZZ3FmAUcdvFm2kj0k
 8isTkih2Aw0ycTSY0czv83E8e7aXNqwSURkH4mU=
X-Google-Smtp-Source: AGHT+IEdhJzRE4WX4jUEIFl8QerJ787vgu3JodjZ9i2YIlV3ojEjRDzYbgmpPqTzyT+ehL/VjzwUdw==
X-Received: by 2002:a17:902:f68c:b0:1b3:d4d5:beb2 with SMTP id
 l12-20020a170902f68c00b001b3d4d5beb2mr12616858plg.9.1691426232309; 
 Mon, 07 Aug 2023 09:37:12 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a170902d34600b001b9df8f14d7sm7119837plk.267.2023.08.07.09.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 09:37:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH for-8.1 v10 06/14] linux-user: Adjust initial brk when
 interpreter is close to executable
Date: Mon,  7 Aug 2023 09:36:57 -0700
Message-Id: <20230807163705.9848-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807163705.9848-1-richard.henderson@linaro.org>
References: <20230807163705.9848-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Helge Deller <deller@gmx.de>

While we attempt to load a ET_DYN executable far away from
TASK_UNMAPPED_BASE, we are not completely in control of the
address space layout.  If the interpreter lands close to
the executable, leaving insufficient heap space, move brk.

Tested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
[rth: Re-order after ELF_ET_DYN_BASE patch so that we do not
 "temporarily break" tsan, and also to minimize the changes required.
 Remove image_info.reserve_brk as unused.]
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h    |  1 -
 linux-user/elfload.c | 51 +++++++++++++-------------------------------
 2 files changed, 15 insertions(+), 37 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 2046a23037..4f8b55e2fb 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -30,7 +30,6 @@ struct image_info {
         abi_ulong       start_data;
         abi_ulong       end_data;
         abi_ulong       brk;
-        abi_ulong       reserve_brk;
         abi_ulong       start_mmap;
         abi_ulong       start_stack;
         abi_ulong       stack_limit;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d1b278d799..3553a3eaef 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3110,27 +3110,6 @@ static void load_elf_image(const char *image_name, int image_fd,
     load_addr = loaddr;
 
     if (pinterp_name != NULL) {
-        /*
-         * This is the main executable.
-         *
-         * Reserve extra space for brk.
-         * We hold on to this space while placing the interpreter
-         * and the stack, lest they be placed immediately after
-         * the data segment and block allocation from the brk.
-         *
-         * 16MB is chosen as "large enough" without being so large as
-         * to allow the result to not fit with a 32-bit guest on a
-         * 32-bit host. However some 64 bit guests (e.g. s390x)
-         * attempt to place their heap further ahead and currently
-         * nothing stops them smashing into QEMUs address space.
-         */
-#if TARGET_LONG_BITS == 64
-        info->reserve_brk = 32 * MiB;
-#else
-        info->reserve_brk = 16 * MiB;
-#endif
-        hiaddr += info->reserve_brk;
-
         if (ehdr->e_type == ET_EXEC) {
             /*
              * Make sure that the low address does not conflict with
@@ -3221,7 +3200,8 @@ static void load_elf_image(const char *image_name, int image_fd,
     info->end_code = 0;
     info->start_data = -1;
     info->end_data = 0;
-    info->brk = 0;
+    /* Usual start for brk is after all sections of the main executable. */
+    info->brk = TARGET_PAGE_ALIGN(hiaddr);
     info->elf_flags = ehdr->e_flags;
 
     prot_exec = PROT_EXEC;
@@ -3315,9 +3295,6 @@ static void load_elf_image(const char *image_name, int image_fd,
                     info->end_data = vaddr_ef;
                 }
             }
-            if (vaddr_em > info->brk) {
-                info->brk = vaddr_em;
-            }
 #ifdef TARGET_MIPS
         } else if (eppnt->p_type == PT_MIPS_ABIFLAGS) {
             Mips_elf_abiflags_v0 abiflags;
@@ -3646,6 +3623,19 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
     if (elf_interpreter) {
         load_elf_interp(elf_interpreter, &interp_info, bprm->buf);
 
+        /*
+         * While unusual because of ELF_ET_DYN_BASE, if we are unlucky
+         * with the mappings the interpreter can be loaded above but
+         * near the main executable, which can leave very little room
+         * for the heap.
+         * If the current brk has less than 16MB, use the end of the
+         * interpreter.
+         */
+        if (interp_info.brk > info->brk &&
+            interp_info.load_bias - info->brk < 16 * MiB)  {
+            info->brk = interp_info.brk;
+        }
+
         /* If the program interpreter is one of these two, then assume
            an iBCS2 image.  Otherwise assume a native linux image.  */
 
@@ -3699,17 +3689,6 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
     bprm->core_dump = &elf_core_dump;
 #endif
 
-    /*
-     * If we reserved extra space for brk, release it now.
-     * The implementation of do_brk in syscalls.c expects to be able
-     * to mmap pages in this space.
-     */
-    if (info->reserve_brk) {
-        abi_ulong start_brk = TARGET_PAGE_ALIGN(info->brk);
-        abi_ulong end_brk = TARGET_PAGE_ALIGN(info->brk + info->reserve_brk);
-        target_munmap(start_brk, end_brk - start_brk);
-    }
-
     return 0;
 }
 
-- 
2.34.1



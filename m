Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 795D077136E
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 05:39:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSUaG-0003j4-Kn; Sat, 05 Aug 2023 23:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUaE-0003hZ-5z
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:34 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUaC-0007a4-FF
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:33 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-26837895fc8so1833515a91.0
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 20:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691293051; x=1691897851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEtd4K5hRnVc6hrl39zIoY3R0ensohNvKsrzBxsSkfw=;
 b=cHS0OJKYCyquIm7FeeoY6cLA26O5uN0gbQ5qPoRGidvPqJtadAUMq9SKTQgoDFv9sT
 6J3XpXcWvwvyaJzoVgYRTtd5OqffL6QgpoBZ6M/ykbC/Aei0TL/FS5r5JaBgD5brwHYp
 PxOfWXkBAWYZ136cgA1/6Fz0Dv1lUerYzMNvUlfd9UpI3+ryunosANHL9aTppVyuGZE8
 hHnRHP96+7ADXcy0FVFIYkDKdG2MCjEIJuBPb/GTzT7EKN1RZjp4ha0yUHLJF0OSgPIH
 GHUqW7LOtMOEb46l0Ib1I0otLeBDSq/r40brQS9Cn+wPEVK4ykOEeGS8EhcfdQl5hqOm
 4cAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691293051; x=1691897851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LEtd4K5hRnVc6hrl39zIoY3R0ensohNvKsrzBxsSkfw=;
 b=Jw1VzOne/iOopLLuS3nxjFaV7diuAa95DoIZi60dg589oXKXRXNueasXdgrKKtdmUQ
 6pyJfN0pasRaHGDxcSvfM3KK81kBVnABc+uaVzC7rRhE8plxve0CFCPI/Dt9Q1MJ1q8T
 hPK2Ope540uzbPZCsrb+PiKrSRYDrelUcdPKDEJJQIPrTXGNz7spa5XnmXH+TKF47ZVC
 lVzI9FHiYCIy+rFKNdQem4yJXX+BOLteY0YaPihNtqnuauKieZjy0B6CLC8S18V6HNxS
 ttfmDH7RQY4JZPJlU7ZLU0xH4/VSqm5IRULqbmXDCi9Nd0VhG9ueeSUxBl7WijcW2jhL
 6WMQ==
X-Gm-Message-State: AOJu0Yw2HvLhJi+F514FBqT7ab2PnpPj5mFmFP9k+WaoAxFEauknz7zw
 FgUnpJmyld88GEm0aAoE+Dwa3i77bEUKkRw94Pc=
X-Google-Smtp-Source: AGHT+IGdTFBxenhhT5aRuBO1jz3ePKL7WFrJv9ns8Cow1tTHGPbOSO+B20ErjuGAgXNJ8qm333UXew==
X-Received: by 2002:a17:90a:4587:b0:269:155a:c936 with SMTP id
 v7-20020a17090a458700b00269155ac936mr4496416pjg.28.1691293051161; 
 Sat, 05 Aug 2023 20:37:31 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a17090a740500b00262e604724dsm6306451pjg.50.2023.08.05.20.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 20:37:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 18/24] linux-user: Adjust initial brk when interpreter is close
 to executable
Date: Sat,  5 Aug 2023 20:37:09 -0700
Message-Id: <20230806033715.244648-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806033715.244648-1-richard.henderson@linaro.org>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
index 802794db63..4b0c9da0dc 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -31,7 +31,6 @@ struct image_info {
         abi_ulong       end_data;
         abi_ulong       start_brk;
         abi_ulong       brk;
-        abi_ulong       reserve_brk;
         abi_ulong       start_mmap;
         abi_ulong       start_stack;
         abi_ulong       stack_limit;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a3aa08a13e..fa0c9ace8e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3109,27 +3109,6 @@ static void load_elf_image(const char *image_name, int image_fd,
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
@@ -3220,7 +3199,8 @@ static void load_elf_image(const char *image_name, int image_fd,
     info->end_code = 0;
     info->start_data = -1;
     info->end_data = 0;
-    info->brk = 0;
+    /* Usual start for brk is after all sections of the main executable. */
+    info->brk = TARGET_PAGE_ALIGN(hiaddr);
     info->elf_flags = ehdr->e_flags;
 
     prot_exec = PROT_EXEC;
@@ -3314,9 +3294,6 @@ static void load_elf_image(const char *image_name, int image_fd,
                     info->end_data = vaddr_ef;
                 }
             }
-            if (vaddr_em > info->brk) {
-                info->brk = vaddr_em;
-            }
 #ifdef TARGET_MIPS
         } else if (eppnt->p_type == PT_MIPS_ABIFLAGS) {
             Mips_elf_abiflags_v0 abiflags;
@@ -3645,6 +3622,19 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
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
 
@@ -3698,17 +3688,6 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
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



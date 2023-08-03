Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1797A76DDA3
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 03:54:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRNWm-0000jR-VA; Wed, 02 Aug 2023 21:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWg-0000iA-DQ
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:18 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWe-0000oh-Hh
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:18 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-55b22f82ac8so1092514a12.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 18:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691027595; x=1691632395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iTYiVzZgwnSBm2cJQnzOd6IorKWpOrXyW6rl98Yh7OU=;
 b=pt7YBuQ/7O08Bl4RKc8BNEVYPl6kjlWa6Gr+dxCwfHDUeshjfsf25iSbs/Cbl6P8la
 YR3X6hChjLzDwy0IHgVWwD1p5pRPvTCNniwZHbNXwqfw3hbpTEIrlyJ7lPI5AVkb0fej
 yybHH/e5zzECrWNkbNDAubA01lYS6zkLxqS8DPGRfuYA026Px6kFHeVKmuytoFowTZTE
 TxxV0PWQHu16jacNWCUIk3N6qUSbrEoFF48HpP0ePiuEWbew4MFZ4Qolk7VfAJZeAVsK
 /GICeDKRo3cKMP9VI2K+ROoqB7nGR2t5cfiQjU98AsY15cnGxObOskYitLsp3Rd9yA7A
 J23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691027595; x=1691632395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iTYiVzZgwnSBm2cJQnzOd6IorKWpOrXyW6rl98Yh7OU=;
 b=OwF4sxLnmblsQm7yMa71M5VaxUe3qtbzylEEMrcYjdHprDqlSKidKoqxEfJvk5iV7v
 qhm+OxJi6hwFVShYcuvd7yBaPc59yFfAkNuh3yJzZFc+c12z08tB/5M7Spp/+Q+o9uDZ
 hGG/IitfG3aCXhR85602Wv4Z4mS9B56Mp4qlRufJesF25VdKXChAZv5P+3ebvH39TlCO
 LT7KrMiL4/tnDPYz51o4YtL48oZnF4FU+SoJ94Hkykksv53lwTEwTKCaiwoMkfWKAVlC
 ML440sgPXm0o0nxtknGYxy0QYfA4wZeRZJau4PHPJM3yfuJwQ2/Z2zVCIzIAr3Ubfx3B
 APsA==
X-Gm-Message-State: ABy/qLaG70VMVVFZw4FJv4MpB7C51z4RgGSzxCShHiP/pXHt1f7rWbZa
 WgZPGG5t+6TszSoxoy+J45An0hCEZWBewN0fyVY=
X-Google-Smtp-Source: APBJJlGaiqy/UtRBX82ddqB39MCco4eenv9p0Fd1rhL1e8d7zmvX5AaIYMs5YzuzjXVJEZknmlf9pw==
X-Received: by 2002:a17:90b:1bc6:b0:268:5aaf:fbe with SMTP id
 oa6-20020a17090b1bc600b002685aaf0fbemr22748015pjb.10.1691027594941; 
 Wed, 02 Aug 2023 18:53:14 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 s25-20020a63a319000000b005649cee408fsm157123pge.0.2023.08.02.18.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 18:53:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, laurent@vivier.eu, akihiko.odaki@daynix.com, joel@jms.id.au
Subject: [PATCH v7 13/14] linux-user: Adjust initial brk when interpreter is
 close to executable
Date: Wed,  2 Aug 2023 18:53:01 -0700
Message-Id: <20230803015302.407219-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803015302.407219-1-richard.henderson@linaro.org>
References: <20230803015302.407219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Helge Deller <deller@gmx.de>
[rth: Re-order after ELF_ET_DYN_BASE patch so that we do not
 "temporarily break" tsan, and also to minimize the changes required.
 Remove image_info.reserve_brk as unused.]
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
index fef9a0bc8f..bf747a15b5 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3120,27 +3120,6 @@ static void load_elf_image(const char *image_name, int image_fd,
         load_map_flags = 0;
     }
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
@@ -3229,7 +3208,8 @@ static void load_elf_image(const char *image_name, int image_fd,
     info->end_code = 0;
     info->start_data = -1;
     info->end_data = 0;
-    info->brk = 0;
+    /* Usual start for brk is after all sections of the main executable. */
+    info->brk = TARGET_PAGE_ALIGN(hiaddr);
     info->elf_flags = ehdr->e_flags;
 
     prot_exec = PROT_EXEC;
@@ -3323,9 +3303,6 @@ static void load_elf_image(const char *image_name, int image_fd,
                     info->end_data = vaddr_ef;
                 }
             }
-            if (vaddr_em > info->brk) {
-                info->brk = vaddr_em;
-            }
 #ifdef TARGET_MIPS
         } else if (eppnt->p_type == PT_MIPS_ABIFLAGS) {
             Mips_elf_abiflags_v0 abiflags;
@@ -3654,6 +3631,19 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
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
 
@@ -3707,17 +3697,6 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D078078D058
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:22:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7oz-0003Sm-H3; Tue, 29 Aug 2023 19:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nK-0002OL-RP
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:43 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nH-000491-Gb
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:42 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68bedc0c268so4223623b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 15:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693346558; x=1693951358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37NCcnAuJjn+I5L6WJxLaF09JKApB7jM4OXRupDrJSg=;
 b=WNkWNkOok0jNRZGjMS2Z+5sO5VRuH1vgnkSEoVR/PJG+xzz0bfiy/+4mP6XQmwmQ+v
 ejnc3cqEfEIdHKeWAd+uZbDvisQ6YngrmmVGWcxpf16ftEb9Amc3ihWM7uTMqTHIcSST
 SMq4nOsMdJbe3qhGZdyyQQ7T+8dJm1J9Hpe8xz3AJZnI/zCQX+NAu5mIAaFxdBcetrtA
 cckWk5TDgUFz7+m13haZPTo/KHp5Bcl+yN1TwzWPhAU/oEOYfyrOb/8Me6VuHFvr27p+
 pchC3os7Byynw8fp2WhjD+Pb4hO7taIbrzbKh1sEKzhqEZK0Irjg8g7Wdmg1oxfCPONg
 fgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693346558; x=1693951358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=37NCcnAuJjn+I5L6WJxLaF09JKApB7jM4OXRupDrJSg=;
 b=IZXKqNBiov5c3F7plkx0lZOcNKnHCM53hVTIhjM12MWqCHHmuA6uhk+TN8rcE00nNW
 5hiEF0bqCJPdFKSm/Ygwgb5MsxMuoJD3Z3RPoXRb3kzQvmDa9hyR2h3ezZsHvLEuZT64
 332ekUarGBQcpWttH2er00s1bgwZb0wm5LQx2PQ+4YxYY0H6TTVjfy+ZpbHeTZA+Chjx
 51beZm1De8WxSU6wMXznIGL+HnteYHvqMccCjQLCsuyh/4TkeZydcMATEJTpB6CzxipB
 4SyH2XsBsbXdtvQbp17xXQU1at8mvM0KoRpZSA9eHjza6XMCNJ5xxmFAjnWqt5jt7fN4
 Gklw==
X-Gm-Message-State: AOJu0YzJctXeIsOMMwSXknh/uRvuji5ItWWs9BTuHOND5WBas6Oc8fhD
 /1G0QNfloPKlz2wDMQ7T/IhEID9MDLmbnsqbkOA=
X-Google-Smtp-Source: AGHT+IEivUHd3NncHUTrOT2+P3fTj8QyZ9uJlutLnuL0rS88t8drQIDLs/bZiZJaIrMdiDRpzUMbLw==
X-Received: by 2002:a05:6a00:1acb:b0:687:7d09:c0f with SMTP id
 f11-20020a056a001acb00b006877d090c0fmr551564pfv.12.1693346557728; 
 Tue, 29 Aug 2023 15:02:37 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 b28-20020a63715c000000b0056606274e54sm9538196pgn.31.2023.08.29.15.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 15:02:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	laurent@vivier.eu
Subject: [PATCH v5 08/20] linux-user: Load vdso image if available
Date: Tue, 29 Aug 2023 15:02:16 -0700
Message-Id: <20230829220228.928506-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829220228.928506-1-richard.henderson@linaro.org>
References: <20230829220228.928506-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

The vdso image will be pre-processed into a C data array, with
a simple list of relocations to perform, and identifying the
location of signal trampolines.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 87 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 9 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f34fb64c0c..2a6adebb4a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -33,6 +33,19 @@
 #undef ELF_ARCH
 #endif
 
+#ifndef TARGET_ARCH_HAS_SIGTRAMP_PAGE
+#define TARGET_ARCH_HAS_SIGTRAMP_PAGE 0
+#endif
+
+typedef struct {
+    const uint8_t *image;
+    const uint32_t *relocs;
+    unsigned image_size;
+    unsigned reloc_count;
+    unsigned sigreturn_ofs;
+    unsigned rt_sigreturn_ofs;
+} VdsoImageInfo;
+
 #define ELF_OSABI   ELFOSABI_SYSV
 
 /* from personality.h */
@@ -2292,7 +2305,8 @@ static abi_ulong loader_build_fdpic_loadmap(struct image_info *info, abi_ulong s
 static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
                                    struct elfhdr *exec,
                                    struct image_info *info,
-                                   struct image_info *interp_info)
+                                   struct image_info *interp_info,
+                                   struct image_info *vdso_info)
 {
     abi_ulong sp;
     abi_ulong u_argc, u_argv, u_envp, u_auxv;
@@ -2380,10 +2394,15 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     }
 
     size = (DLINFO_ITEMS + 1) * 2;
-    if (k_base_platform)
+    if (k_base_platform) {
         size += 2;
-    if (k_platform)
+    }
+    if (k_platform) {
         size += 2;
+    }
+    if (vdso_info) {
+        size += 2;
+    }
 #ifdef DLINFO_ARCH_ITEMS
     size += DLINFO_ARCH_ITEMS * 2;
 #endif
@@ -2465,6 +2484,9 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     if (u_platform) {
         NEW_AUX_ENT(AT_PLATFORM, u_platform);
     }
+    if (vdso_info) {
+        NEW_AUX_ENT(AT_SYSINFO_EHDR, vdso_info->load_addr);
+    }
     NEW_AUX_ENT (AT_NULL, 0);
 #undef NEW_AUX_ENT
 
@@ -3342,6 +3364,49 @@ static void load_elf_interp(const char *filename, struct image_info *info,
     load_elf_image(filename, &src, info, &ehdr, NULL);
 }
 
+#ifndef vdso_image_info
+#define vdso_image_info()    NULL
+#endif
+
+static void load_elf_vdso(struct image_info *info, const VdsoImageInfo *vdso)
+{
+    ImageSource src;
+    struct elfhdr ehdr;
+    abi_ulong load_bias, load_addr;
+
+    src.fd = -1;
+    src.cache = vdso->image;
+    src.cache_size = vdso->image_size;
+
+    load_elf_image("<internal-vdso>", &src, info, &ehdr, NULL);
+    load_addr = info->load_addr;
+    load_bias = info->load_bias;
+
+    /*
+     * We need to relocate the VDSO image.  The one built into the kernel
+     * is built for a fixed address.  The one built for QEMU is not, since
+     * that requires close control of the guest address space.
+     * We pre-processed the image to locate all of the addresses that need
+     * to be updated.
+     */
+    for (unsigned i = 0, n = vdso->reloc_count; i < n; i++) {
+        abi_ulong *addr = g2h_untagged(load_addr + vdso->relocs[i]);
+        *addr = tswapal(tswapal(*addr) + load_bias);
+    }
+
+    /* Install signal trampolines, if present. */
+    if (vdso->sigreturn_ofs) {
+        default_sigreturn = load_addr + vdso->sigreturn_ofs;
+    }
+    if (vdso->rt_sigreturn_ofs) {
+        default_rt_sigreturn = load_addr + vdso->rt_sigreturn_ofs;
+    }
+
+    /* Remove write from VDSO segment. */
+    target_mprotect(info->start_data, info->end_data - info->start_data,
+                    PROT_READ | PROT_EXEC);
+}
+
 static int symfind(const void *s0, const void *s1)
 {
     struct elf_sym *sym = (struct elf_sym *)s1;
@@ -3547,7 +3612,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
      * and let elf_load_image do any swapping that may be required.
      */
     struct elfhdr ehdr;
-    struct image_info interp_info;
+    struct image_info interp_info, vdso_info;
     char *elf_interpreter = NULL;
     char *scratch;
 
@@ -3630,10 +3695,13 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
     }
 
     /*
-     * TODO: load a vdso, which would also contain the signal trampolines.
-     * Otherwise, allocate a private page to hold them.
+     * Load a vdso if available, which will amongst other things contain the
+     * signal trampolines.  Otherwise, allocate a separate page for them.
      */
-    if (TARGET_ARCH_HAS_SIGTRAMP_PAGE) {
+    const VdsoImageInfo *vdso = vdso_image_info();
+    if (vdso) {
+        load_elf_vdso(&vdso_info, vdso);
+    } else if (TARGET_ARCH_HAS_SIGTRAMP_PAGE) {
         abi_long tramp_page = target_mmap(0, TARGET_PAGE_SIZE,
                                           PROT_READ | PROT_WRITE,
                                           MAP_PRIVATE | MAP_ANON, -1, 0);
@@ -3645,8 +3713,9 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
         target_mprotect(tramp_page, TARGET_PAGE_SIZE, PROT_READ | PROT_EXEC);
     }
 
-    bprm->p = create_elf_tables(bprm->p, bprm->argc, bprm->envc, &ehdr,
-                                info, (elf_interpreter ? &interp_info : NULL));
+    bprm->p = create_elf_tables(bprm->p, bprm->argc, bprm->envc, &ehdr, info,
+                                elf_interpreter ? &interp_info : NULL,
+                                vdso ? &vdso_info : NULL);
     info->start_stack = bprm->p;
 
     /* If we have an interpreter, set that as the program's entry point.
-- 
2.34.1



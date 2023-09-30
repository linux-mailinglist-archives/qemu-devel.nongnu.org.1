Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C73077B3D86
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 04:16:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmPWL-0000Em-24; Fri, 29 Sep 2023 22:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmPWD-0000Cu-RT
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 22:15:46 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmPW7-0001zL-E1
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 22:15:45 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-27752a1e180so8110472a91.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 19:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696040138; x=1696644938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBtp0SzKAXBPku+nusoqYBCwaytEH/E/j+wssjalB2E=;
 b=zBj0WiQ+agYpsHiOYYjw0TCYPxz1tDuNC2flpaDyd4jdkhb+U6AiGFsa7Pcg4BxQ4q
 emP/Ewh/igogsGENLLwCEn6RVJcKyNTtKSPVuIwI4GW2xGT5FiYJMdq5PsjoDTu/H17t
 mnkaOoMnnhIQFUgGPREvWUamSKrDoKwoxsY9BbQ2oAjtrY72H6fcisOvWaazKAuSRN5n
 RBx1Yw4zc/Iy1aI8x6TvLCTgqIHIQunByuRg63Fx/8vWbrf5EVf164pjVMvi6CaL1l5N
 qZ8iRLyLvTQm3WfNQwcAt2obyv5ZDJUlNOPQbk3mMr17BCV5k+DWZiCdv+1e+tyTc0zg
 umvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696040138; x=1696644938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kBtp0SzKAXBPku+nusoqYBCwaytEH/E/j+wssjalB2E=;
 b=arTT/6JY82IkLsK9uC9kcYAsIS0Qsn4cwmkQsCASwQWIvoafbOBqCPrOnccLlSkQbn
 quCzpz9QR2LZZdmD7MvWmd/aHlaFwHRWya6W3xFZtPhmpMj40aWGnZ94FBuYb1TPrio7
 yLo5LcIwpiCSp4FSjGtfURmbsMSLW5AeO0WsM3xHIrfTLFzbBSBgDxjocQKYwP3aHeBm
 3JkdtPs0u/3uU0E5RaykTmiK98CWS/4KqE8ErqtuaBHKTop4a0VVjEWu886x1c//0aZE
 kM8OZ+57ctOAHzd/2H7Vj+ap4UlRpps6HdZdJWtXUr42Q0PhAXc8N+GuOreyAruuZMZf
 2yvg==
X-Gm-Message-State: AOJu0Yze0/HaUgBAonogGYLo6THr2t86YX38RhDKHrBhNwD3ac8E9Bpf
 geSES/xe4TX8c7Xs+RajsdkCyhBnNifHw2CdlCY=
X-Google-Smtp-Source: AGHT+IGNOqy4+VEf4whtltaon80lHFXjg0pmT5A5RKo19UiOCCjHZU26sOmrFJmRlXiBP1zH6EBm6w==
X-Received: by 2002:a17:90b:34c:b0:274:6f67:e7a8 with SMTP id
 fh12-20020a17090b034c00b002746f67e7a8mr5648465pjb.45.1696040137772; 
 Fri, 29 Sep 2023 19:15:37 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fv21-20020a17090b0e9500b002775281b9easm2130692pjb.50.2023.09.29.19.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 19:15:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	laurent@vivier.eu
Subject: [PATCH v6 07/19] linux-user: Load vdso image if available
Date: Fri, 29 Sep 2023 19:15:17 -0700
Message-Id: <20230930021529.987950-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930021529.987950-1-richard.henderson@linaro.org>
References: <20230930021529.987950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
 linux-user/elfload.c | 90 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 81 insertions(+), 9 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ed276edb3c..9c97d14b7e 100644
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
@@ -2436,7 +2449,8 @@ static abi_ulong loader_build_fdpic_loadmap(struct image_info *info, abi_ulong s
 static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
                                    struct elfhdr *exec,
                                    struct image_info *info,
-                                   struct image_info *interp_info)
+                                   struct image_info *interp_info,
+                                   struct image_info *vdso_info)
 {
     abi_ulong sp;
     abi_ulong u_argc, u_argv, u_envp, u_auxv;
@@ -2524,10 +2538,15 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
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
@@ -2609,6 +2628,9 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     if (u_platform) {
         NEW_AUX_ENT(AT_PLATFORM, u_platform);
     }
+    if (vdso_info) {
+        NEW_AUX_ENT(AT_SYSINFO_EHDR, vdso_info->load_addr);
+    }
     NEW_AUX_ENT (AT_NULL, 0);
 #undef NEW_AUX_ENT
 
@@ -3486,6 +3508,52 @@ static void load_elf_interp(const char *filename, struct image_info *info,
     load_elf_image(filename, &src, info, &ehdr, NULL);
 }
 
+#ifdef VDSO_HEADER
+#include VDSO_HEADER
+#define  vdso_image_info()  &vdso_image_info
+#else
+#define  vdso_image_info()  NULL
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
@@ -3691,7 +3759,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
      * and let elf_load_image do any swapping that may be required.
      */
     struct elfhdr ehdr;
-    struct image_info interp_info;
+    struct image_info interp_info, vdso_info;
     char *elf_interpreter = NULL;
     char *scratch;
 
@@ -3772,10 +3840,13 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
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
@@ -3787,8 +3858,9 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
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



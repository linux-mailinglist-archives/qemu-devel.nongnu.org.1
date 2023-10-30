Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BA17DC1CA
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:21:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZeY-0001jv-O2; Mon, 30 Oct 2023 17:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdp-0000zz-OH
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:49 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdh-0006UT-TA
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:41 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cc5fa0e4d5so6034925ad.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 14:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698700656; x=1699305456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EZdZAtqEe85hgekxO5brk1Ss9vuV7TkNPc+GgulDDCM=;
 b=vG/3griO58Epk+7em350kGyIpqqtA4iVTXoo5EErmD4GlUYvqWE8jpd/CBf91sW6CD
 cq8hj5ltRTkmMX45WdGV2azXjL8VI93ObIaJdwAUB6ID3Hp8Euh0fxxAgZkpP2ztfixU
 tSEaipGKTX74r/K1mvVSqEeD4gjlIT6i8/CbqHNHNdZ7wDT8dGIJk+VnaGqfQMZI8rjL
 HXndpDmQ1wATgqGZ447Fi91A/p0ZKZYnqXLf1zXmXWhMrTZ6AC4sZpwQJAYtgmLF5/ds
 yKs2KBDGJIPTfrK1OMuI94XwDMBEOmdefwT1JhA1YwASqy2PNgBQq9dz6WIDv7E9ck15
 toew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698700656; x=1699305456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EZdZAtqEe85hgekxO5brk1Ss9vuV7TkNPc+GgulDDCM=;
 b=PnvJahS6REHkv8RSgqgu7CFmUPD+iRnKuucL0mrFHF46VL2ocmNp2GxlrKfDia0qfv
 hOwtzPA9GasoGBA7XqcXiGLDX4MoHH3B9kSuF/Msv1v9LRrStS/NjYR8R8i/TTMDwpk4
 zf5hy51v/HTZW9dz8UHgnFmBo26Suuu4oLdOH37iCsaXRVLf5T1FR8fKiHDM/Af1Dk/R
 ZUwaaZgLA14SYZoXA6399FeOkiUpoZhbVSqKh2sN1jjmEgbxf2Y+ORzn8d4zDIidHV/h
 GfxBM9Uf4VQ8QntDYKbSgvreurgN2LD9Hn8oNZEUIwXCQ2QkKu0Esmi+Nqy17a1NyE88
 UdMg==
X-Gm-Message-State: AOJu0Yy0WTZdctxfHICdfuSN/8UB0gz2pxk3fsePst65ETOueYE+Uz8b
 9n7r3+wRzQLQ7F1nJMC3SnErvS7Jrt52F3KIUWU=
X-Google-Smtp-Source: AGHT+IFsfsuFe9gmB+gVArBka8IunnW3QEnY/zu1Ei70+yVfEdiasbJWLo8Hc95Ow5zoed4wLLUqnQ==
X-Received: by 2002:a17:902:efc9:b0:1ca:20a0:7b08 with SMTP id
 ja9-20020a170902efc900b001ca20a07b08mr10893884plb.50.1698700655933; 
 Mon, 30 Oct 2023 14:17:35 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf2-20020a170903268200b001cc32261bdfsm4670350plb.38.2023.10.30.14.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:17:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/21] linux-user: Load vdso image if available
Date: Mon, 30 Oct 2023 14:17:14 -0700
Message-Id: <20231030211727.165090-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030211727.165090-1-richard.henderson@linaro.org>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 90 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 81 insertions(+), 9 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 88c2b01402..b0723071e2 100644
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
@@ -2471,7 +2484,8 @@ static abi_ulong loader_build_fdpic_loadmap(struct image_info *info, abi_ulong s
 static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
                                    struct elfhdr *exec,
                                    struct image_info *info,
-                                   struct image_info *interp_info)
+                                   struct image_info *interp_info,
+                                   struct image_info *vdso_info)
 {
     abi_ulong sp;
     abi_ulong u_argc, u_argv, u_envp, u_auxv;
@@ -2559,10 +2573,15 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
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
@@ -2644,6 +2663,9 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     if (u_platform) {
         NEW_AUX_ENT(AT_PLATFORM, u_platform);
     }
+    if (vdso_info) {
+        NEW_AUX_ENT(AT_SYSINFO_EHDR, vdso_info->load_addr);
+    }
     NEW_AUX_ENT (AT_NULL, 0);
 #undef NEW_AUX_ENT
 
@@ -3521,6 +3543,52 @@ static void load_elf_interp(const char *filename, struct image_info *info,
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
@@ -3726,7 +3794,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
      * and let elf_load_image do any swapping that may be required.
      */
     struct elfhdr ehdr;
-    struct image_info interp_info;
+    struct image_info interp_info, vdso_info;
     char *elf_interpreter = NULL;
     char *scratch;
 
@@ -3807,10 +3875,13 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
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
@@ -3822,8 +3893,9 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
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



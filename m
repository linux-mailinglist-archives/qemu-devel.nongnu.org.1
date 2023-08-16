Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E71A77E833
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:05:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWKs3-0002By-G2; Wed, 16 Aug 2023 14:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKs1-00028C-9s
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:49 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKry-0001Ka-Pc
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:49 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bda9207132so54670885ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692209025; x=1692813825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qAG6PGIV1uQFBhWqnMGM8QSbNiLc7gv0kNNHJcbKMjM=;
 b=GJCrOIzTumK6O7vr8Yvz86qW1wbfEA442N0ulAD1yCvu4XBn8uBytVjco6riWz2rOa
 qweKXi8SAVk1MojcaNgMmUFVbfm6FHtk73bIr9nWEfPoPniZyUT5wligm9d2uNzXM0jf
 NBieQrseUPdYwUeo/3WjqriugytA3510kYJs9ZrxVU5bVHl0jlODniAAZJzh5gipmLlx
 T/7eFa3AzbFFgPgRNC6tfmNoCYgGLqaWJJlrRTEWKb0rrM7jXE9cGbvDGeFyQxfDxTCp
 nF78uQ/RXZ1sA4ptoMnEC37oEkt/qsEBJ57Y0pgXo6xpt1p7IxF3hJVyJXxvVWMyDk22
 Ulrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692209025; x=1692813825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qAG6PGIV1uQFBhWqnMGM8QSbNiLc7gv0kNNHJcbKMjM=;
 b=NUJtnwkf8E5Nok8WGB5NIo54WHiB2SC+x+IHq97fdmE8K8uztE+iuZfGDv9jMMo//R
 /J8lyiQMGe2yi7B+dnNbpPFYc1GP3aG7eAywLaSQHOrnLly4sFkXtVzpm4T4e6nlH137
 7QD+Hc1tDQIri+Zz3PJMenPK3DQmrFnAFCcc9aCCsuFVTDZI0bWtfrUWmf4HzHNVYwKE
 HzGYkE+P5VzJrTUQ9/kkGAGb5kB+KcEkTOF/MQqZN5iop57RPHreZXnpXsicbIG4sJAR
 OfUnwlI/FjYaSIzhTVtHgXqZ/vj85v9xJEsZ0GwoGJdRZeek3ujp5TcdhMimvypI89KQ
 QmOA==
X-Gm-Message-State: AOJu0YwgOIB8yVrpVC5jdFbcIEeErAk6tj7mDkMlo+TfklVxkUt0u0PS
 kloUvZLh1bnIRCq9TQv5ziqxJy7K6m9IhOiDqAc=
X-Google-Smtp-Source: AGHT+IHFWXC+cZSx0xRreOfLCy8cTIWbx3rU5khhsZYIGqVutf6busikg0I+RHeKugD2XWUByyvqAg==
X-Received: by 2002:a17:902:be08:b0:1bb:a4e4:54b6 with SMTP id
 r8-20020a170902be0800b001bba4e454b6mr2588554pls.62.1692209025476; 
 Wed, 16 Aug 2023 11:03:45 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a170902868e00b001bc2831e1a9sm13446584plo.90.2023.08.16.11.03.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 11:03:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 07/18] linux-user: Load vdso image if available
Date: Wed, 16 Aug 2023 11:03:27 -0700
Message-Id: <20230816180338.572576-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816180338.572576-1-richard.henderson@linaro.org>
References: <20230816180338.572576-1-richard.henderson@linaro.org>
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

The vdso image will be pre-processed into a C data array, with
a simple list of relocations to perform, and identifying the
location of signal trampolines.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 87 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 9 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 19d3cac039..f94963638a 100644
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
@@ -2291,7 +2304,8 @@ static abi_ulong loader_build_fdpic_loadmap(struct image_info *info, abi_ulong s
 static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
                                    struct elfhdr *exec,
                                    struct image_info *info,
-                                   struct image_info *interp_info)
+                                   struct image_info *interp_info,
+                                   struct image_info *vdso_info)
 {
     abi_ulong sp;
     abi_ulong u_argc, u_argv, u_envp, u_auxv;
@@ -2379,10 +2393,15 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
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
@@ -2464,6 +2483,9 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     if (u_platform) {
         NEW_AUX_ENT(AT_PLATFORM, u_platform);
     }
+    if (vdso_info) {
+        NEW_AUX_ENT(AT_SYSINFO_EHDR, vdso_info->load_addr);
+    }
     NEW_AUX_ENT (AT_NULL, 0);
 #undef NEW_AUX_ENT
 
@@ -3341,6 +3363,49 @@ static void load_elf_interp(const char *filename, struct image_info *info,
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
@@ -3546,7 +3611,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
      * and let elf_load_image do any swapping that may be required.
      */
     struct elfhdr ehdr;
-    struct image_info interp_info;
+    struct image_info interp_info, vdso_info;
     char *elf_interpreter = NULL;
     char *scratch;
 
@@ -3629,10 +3694,13 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
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
@@ -3644,8 +3712,9 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
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



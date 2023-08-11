Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA8C779527
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:51:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUVLw-0005lp-1B; Fri, 11 Aug 2023 12:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLr-0005kD-OO
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:51:04 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLp-0001MZ-Un
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:51:03 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-563dfffea87so1667661a12.2
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691772660; x=1692377460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lt3tKhxSjXbEIE1KSaUKeQERHy91vOj1K4+DvKn2CTA=;
 b=gRB/ctrocUMXEDcuQbB+os/j0Rhwp7uajBRR+31qIs3VUfKaQ7kOOhHnaYfh61osN2
 UOJnSM3bWxpfbOVwDQWbM7B1Ci2Hn1Vh3Quiauefp9NIddDyVomk35/xv43uzxHaRDsR
 7njqtY7WEMBL3xrpiMa9KJ4XDUUlpobWKDfevGKZunajH9zSzRUd+tFyTXy9Vh7ojao5
 LB9WGDGbHIbVVpNpQONIH1QECXC1rVBjRV8fbsdcJHbyQJV+ON94qWlrEPdY6pFnBFBU
 XMSFTPh7yI3EyilMtzSC5UOpNogZ/IQcEoFQoqvmWPM8lseAe1DGAPH6k2hOR7RamzNB
 jo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691772660; x=1692377460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lt3tKhxSjXbEIE1KSaUKeQERHy91vOj1K4+DvKn2CTA=;
 b=gLtTtjex7j8FqGTSQKDRyrkh/lc49IwOA4IeNGfwYcuRVlT2dhq4+N232+rd8Gyeaf
 gciXLw5Q1OsEZXNmgxTj4TP6de1I2BHy2rjlfB/bSDgwrphY1UQBtfVgT+OUnlTosQY+
 gM6ON0CPVuwE4bB8b6GG+6ICk1S4PzrLAFl3NtJ88muBcyT2VVIFb4X5D9RRf6fAOAPn
 jCTgu24I0vcE+dihaygTlG2bpZ8bVCm5xH5ctD4IaKGG6WrkgGG5V+DACvyiEBqbKd+u
 Nc0j/XoPcWeS2s2OvxY1k35Vhozv7X/HYqxsA6hQoE0AobFvMiOr3397nBfcKaggxJ5t
 mxEw==
X-Gm-Message-State: AOJu0YyVimbjjZ/MHAdKV7DsRuLThpIieGTwyWNU5aMqB23r1eo//Vuw
 se83S3cMGR8rLoncaFFwhZXjXjesm8pmWlg8Lnk=
X-Google-Smtp-Source: AGHT+IHO79zfpo/w0bR4J2ez9zvCAkZWmquaxDwQeccrbIzEa9cZY/cGP5AslFMxNHsw/HjRhoKCMQ==
X-Received: by 2002:a17:90a:ba84:b0:25f:20f:2f7d with SMTP id
 t4-20020a17090aba8400b0025f020f2f7dmr2027762pjr.2.1691772660240; 
 Fri, 11 Aug 2023 09:51:00 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 22-20020a17090a19d600b00263d3448141sm3803713pjj.8.2023.08.11.09.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:50:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH v3 07/15] linux-user: Load vdso image if available
Date: Fri, 11 Aug 2023 09:50:44 -0700
Message-Id: <20230811165052.161080-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811165052.161080-1-richard.henderson@linaro.org>
References: <20230811165052.161080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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
index 19d3cac039..5025611886 100644
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
+    /* Mark the VDSO writable segment read-only. */
+    target_mprotect(info->start_data, info->end_data - info->start_data,
+                    PROT_READ);
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



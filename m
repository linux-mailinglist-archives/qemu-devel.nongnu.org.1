Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3B4773AAE
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 16:20:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTNYX-0001FL-6S; Tue, 08 Aug 2023 10:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNYT-0001EZ-Ur
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:19:26 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNYR-0000He-8h
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:19:25 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bc7b25c699so9707545ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 07:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691504362; x=1692109162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZAHN5GS4NUQT6M8ktSLZlWet0VNdf0LHMoqp/AaJeH8=;
 b=UBMN7lHpnh2eNK1cl2LNUg2DKQaQZlyNmYEjgKn1USoxXUov7y4M0vWTWmQ5rLwvtG
 5gPPfcnyphY9o0L2wWx1J9zEtAZY8DCbfe3C99mEq1eyw15liW18wBl5XYVZ2lMEhDmr
 VdZ5SFL3m2j8abnf6hZDQ9EKFyR65hSFhy4saXxpHReJU3TD4lzmQf2aqHVOdSMOt3GF
 eJLkFmsimdhFNNiILLzIY4por6aFimryheE7zxCAqKGOqUzMVbL10IEZsKVPaYcpCsZc
 ipTLUTRQlsf46PCziBOlfbPoaCMG5RCmMP2u9+sLmZyAIrN3fB7EjGm+QdD0aLIWDU5m
 3ejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691504362; x=1692109162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZAHN5GS4NUQT6M8ktSLZlWet0VNdf0LHMoqp/AaJeH8=;
 b=eQAkwj8xWdTFhedGCt9xKa0suRp9e/sTYP74YimPgHZpWbUHb3yI4IYenIhSEhhjXr
 sUBptioL94FZhe1CgSFRH057OM+eg3fqTeLf/O4mmZTMMfF87aB31C4YTOuAfr0tojnQ
 VL3kIBwXhBhhrAEtp5doL1qHrVDRTGwdvlxvrXNAX63dTiSDQ7CcxQRc3yU2FjBmMepJ
 x+RxpdeYfbs4eOSM0OBQXAKP4g0EGiofoOi0VNlX2N/8KnQfzk4rF1/GB1T5KeUjC7oW
 6JNfL+ErG2maMcmR+nMtk3bLqmeGkLy2frIBxA/l3ndw/XvPg1/1Y5FAxa8mxt5qgx1b
 1TlA==
X-Gm-Message-State: AOJu0Yx36RaBUQVTH8pEMlA5gS6Dr7PSXON3ERFIUot1Yna4VxB4xOFG
 z/4L55nfGI/nqL6NYij3ERSEpjqahbM6xARR
X-Google-Smtp-Source: AGHT+IFOgNWBXOHdM/IIsVgRYQgfG56wHh+TBaDUovJ31r8rwffic2EwIXsEDke26VKp5OmYvIsjEQ==
X-Received: by 2002:a17:902:d482:b0:1b9:e1d6:7c7d with SMTP id
 c2-20020a170902d48200b001b9e1d67c7dmr12386614plg.47.1691504361769; 
 Tue, 08 Aug 2023 07:19:21 -0700 (PDT)
Received: from localhost.localdomain ([223.104.41.22])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a170902b68300b001bb1f0605b2sm9043985pls.214.2023.08.08.07.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 07:19:21 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [RFC v4 05/11] linux-user/elfload: Add support for parsing symbols of
 native libraries.
Date: Tue,  8 Aug 2023 22:17:33 +0800
Message-Id: <20230808141739.3110740-6-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

This commit addresses the need to parse symbols of native libraries.
The base address of a shared library is determined by the dynamic
linker. To simplify the process, we focus on the last three digits,
which reside within the same page and remain unaffected by the base
address.

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 linux-user/elfload.c | 85 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 80 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 9a2ec568b0..9448f91005 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -22,6 +22,9 @@
 #include "qemu/error-report.h"
 #include "target_signal.h"
 #include "accel/tcg/debuginfo.h"
+#if defined(CONFIG_NATIVE_CALL)
+#include "native/native.h"
+#endif
 
 #ifdef _ARCH_PPC64
 #undef ARCH_DLINFO
@@ -2038,8 +2041,10 @@ static inline void bswap_mips_abiflags(Mips_elf_abiflags_v0 *abiflags) { }
 #ifdef USE_ELF_CORE_DUMP
 static int elf_core_dump(int, const CPUArchState *);
 #endif /* USE_ELF_CORE_DUMP */
-static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias);
-
+static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias,
+                         uint load_type);
+#define ELF_SYM 1
+#define NATIVE_LIB_SYM 2
 /* Verify the portions of EHDR within E_IDENT for the target.
    This can be performed before bswapping the entire header.  */
 static bool elf_check_ident(struct elfhdr *ehdr)
@@ -3302,7 +3307,7 @@ static void load_elf_image(const char *image_name, int image_fd,
     }
 
     if (qemu_log_enabled()) {
-        load_symbols(ehdr, image_fd, load_bias);
+        load_symbols(ehdr, image_fd, load_bias, ELF_SYM);
     }
 
     debuginfo_report_elf(image_name, image_fd, load_bias);
@@ -3398,7 +3403,8 @@ static int symcmp(const void *s0, const void *s1)
 }
 
 /* Best attempt to load symbols from this ELF object. */
-static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias)
+static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias,
+                         uint load_type)
 {
     int i, shnum, nsyms, sym_idx = 0, str_idx = 0;
     uint64_t segsz;
@@ -3456,7 +3462,21 @@ static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias)
     for (i = 0; i < nsyms; ) {
         bswap_sym(syms + i);
         /* Throw away entries which we do not need.  */
-        if (syms[i].st_shndx == SHN_UNDEF
+        if (load_type == NATIVE_LIB_SYM)  {
+            /*
+             * Load the native library.
+             * Since the base address of a shared library is determined
+             * by the dynamic linker, we only consider the last three
+             * digits here, which are within the same page and are not
+             * affected by the base address.
+             */
+#if defined(TARGET_ARM) || defined(TARGET_MIPS)
+            /* The bottom address bit marks a Thumb or MIPS16 symbol.  */
+            syms[i].st_value &= ~(target_ulong)1;
+#endif
+            syms[i].st_value &= 0xfff;
+            i++;
+        } else if (syms[i].st_shndx == SHN_UNDEF
             || syms[i].st_shndx >= SHN_LORESERVE
             || ELF_ST_TYPE(syms[i].st_info) != STT_FUNC) {
             if (i < --nsyms) {
@@ -3542,14 +3562,63 @@ uint32_t get_elf_eflags(int fd)
     return ehdr.e_flags;
 }
 
+#if defined(CONFIG_NATIVE_CALL)
+static void load_native_library(const char *filename, struct image_info *info,
+                         char bprm_buf[BPRM_BUF_SIZE])
+{
+    int fd, retval;
+    Error *err = NULL;
+
+    fd = open(path(filename), O_RDONLY);
+    if (fd < 0) {
+        error_setg_file_open(&err, errno, filename);
+        error_report_err(err);
+        exit(-1);
+    }
+
+    retval = read(fd, bprm_buf, BPRM_BUF_SIZE);
+    if (retval < 0) {
+        error_setg_errno(&err, errno, "Error reading file header");
+        error_reportf_err(err, "%s: ", filename);
+        exit(-1);
+    }
+
+    if (retval < BPRM_BUF_SIZE) {
+        memset(bprm_buf + retval, 0, BPRM_BUF_SIZE - retval);
+    }
+
+    struct elfhdr *ehdr = (struct elfhdr *)bprm_buf;
+
+    if (!elf_check_ident(ehdr)) {
+        error_setg(&err, "Invalid ELF image for this architecture");
+        goto exit_errmsg;
+    }
+    bswap_ehdr(ehdr);
+    if (!elf_check_ehdr(ehdr)) {
+        error_setg(&err, "Invalid ELF image for this architecture");
+        goto exit_errmsg;
+    }
+
+    /* We are only concerned with the symbols of native library. */
+    load_symbols(ehdr, fd, 0, NATIVE_LIB_SYM);
+    return;
+
+exit_errmsg:
+    error_reportf_err(err, "%s: ", filename);
+    exit(-1);
+}
+#endif
+
 int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
 {
     struct image_info interp_info;
+    struct image_info nativelib_info;
     struct elfhdr elf_ex;
     char *elf_interpreter = NULL;
     char *scratch;
 
     memset(&interp_info, 0, sizeof(interp_info));
+    memset(&nativelib_info, 0, sizeof(nativelib_info));
 #ifdef TARGET_MIPS
     interp_info.fp_abi = MIPS_ABI_FP_UNKNOWN;
 #endif
@@ -3665,6 +3734,12 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
         target_munmap(start_brk, end_brk - start_brk);
     }
 
+#if defined(CONFIG_NATIVE_CALL)
+    if (native_bypass_enabled()) {
+        load_native_library(native_lib_path, &nativelib_info, bprm->buf);
+    }
+#endif
+
     return 0;
 }
 
-- 
2.34.1



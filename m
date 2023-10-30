Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C44597DC1B3
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:18:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZe2-00011r-CR; Mon, 30 Oct 2023 17:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdj-0000z4-N8
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:43 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZde-0006Tx-Ux
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:39 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc2575dfc7so22791335ad.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 14:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698700653; x=1699305453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yNJnXwqPU+XiPb+hM836A6Y7DrvNcYPhsN4z7hvAs88=;
 b=wpQnFadTdqXNtE//T6uN1JUe3hLVvL4bqrrpRKNlK0dwRDXAc3XxqgJZM9PrvKuF9/
 TnONyJ09WyjaDLNShy+UNikRH9joeyzpFIEJN0hNlDpyfQDcpToIam7UOSIlKVL/njJP
 zlmo68Jx/cZwu3xkAM/MgtRMyl5T/AltH7RrVZdbotTA/deGoU5vhOsU078WbdvYBYZT
 /107o2gcXP4/Cz3QXVpl+9Lx1C2XPDzP0cswTewJo9q24GP6MaP8Q9SdNTOXv6vjf6fu
 s/72TzZiZAtPQX0R/94ko6OQOQm8sxZK1fbTsr9isIVKXUNa51ZOKPJApEFz8tGPrWef
 J8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698700653; x=1699305453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yNJnXwqPU+XiPb+hM836A6Y7DrvNcYPhsN4z7hvAs88=;
 b=SQNR9+C9fMNI5+ugeoBZi+0bYREoFxBn6K6vZyHz5GywRhqnXOpKluUOv5jIswa7bH
 ZLZOMB+X+SnKcbZ9BwdaiqIuNvvkLzw3//HyHlOP0a5TjesjrXEJagkexReQc4vBduQ0
 mgsaAoZ3APhtmveMjyA/HqNOb+y8DSk4p1Aq2ooKksume1vCqSzXF7uFtLN9rOYN8fGL
 uSlpH0AEjegyZCngezN+QTVN0mI0Wz9YPNAqmkW9NmWlros0TNGOchfZbDYjCxYxJCR1
 XHEETRugofmxMumTepS5GNUzR6bKndjK/xb4sdP+7BTdNHphznW6kxRCN/ousSxUDLZI
 IIsw==
X-Gm-Message-State: AOJu0YylRf4Xxv3DmmaBBbKhbICxPV0fJSrlF4ZymcmOmWvA2m2ENmce
 OY2a1oU22ulS46UsFHO/7uixTTbBUdbL2Od2mYA=
X-Google-Smtp-Source: AGHT+IHwp57SIVUkq7EwUvoU3dR2IqrYQ1blDILnOquDM37nvFm/vf1EnOGPWouOQ4zUvka9Ax0Mmg==
X-Received: by 2002:a17:902:f54f:b0:1cc:dda:9a1b with SMTP id
 h15-20020a170902f54f00b001cc0dda9a1bmr10600197plf.34.1698700652862; 
 Mon, 30 Oct 2023 14:17:32 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf2-20020a170903268200b001cc32261bdfsm4670350plb.38.2023.10.30.14.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:17:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/21] linux-user: Use ImageSource in load_elf_image
Date: Mon, 30 Oct 2023 14:17:11 -0700
Message-Id: <20231030211727.165090-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030211727.165090-1-richard.henderson@linaro.org>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Change parse_elf_properties as well, as the bprm_buf argument
ties the two functions closely.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 128 +++++++++++++++++--------------------------
 1 file changed, 49 insertions(+), 79 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d5af354a78..d763cb855a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3102,10 +3102,9 @@ static bool parse_elf_property(const uint32_t *data, int *off, int datasz,
 }
 
 /* Process NT_GNU_PROPERTY_TYPE_0. */
-static bool parse_elf_properties(int image_fd,
+static bool parse_elf_properties(const ImageSource *src,
                                  struct image_info *info,
                                  const struct elf_phdr *phdr,
-                                 char bprm_buf[BPRM_BUF_SIZE],
                                  Error **errp)
 {
     union {
@@ -3133,14 +3132,8 @@ static bool parse_elf_properties(int image_fd,
         return false;
     }
 
-    if (phdr->p_offset + n <= BPRM_BUF_SIZE) {
-        memcpy(&note, bprm_buf + phdr->p_offset, n);
-    } else {
-        ssize_t len = pread(image_fd, &note, n, phdr->p_offset);
-        if (len != n) {
-            error_setg_errno(errp, errno, "Error reading file header");
-            return false;
-        }
+    if (!imgsrc_read(&note, phdr->p_offset, n, src, errp)) {
+        return false;
     }
 
     /*
@@ -3186,30 +3179,34 @@ static bool parse_elf_properties(int image_fd,
     }
 }
 
-/* Load an ELF image into the address space.
+/**
+ * load_elf_image: Load an ELF image into the address space.
+ * @image_name: the filename of the image, to use in error messages.
+ * @src: the ImageSource from which to read.
+ * @info: info collected from the loaded image.
+ * @ehdr: the ELF header, not yet bswapped.
+ * @pinterp_name: record any PT_INTERP string found.
+ *
+ * On return: @info values will be filled in, as necessary or available.
+ */
 
-   IMAGE_NAME is the filename of the image, to use in error messages.
-   IMAGE_FD is the open file descriptor for the image.
-
-   BPRM_BUF is a copy of the beginning of the file; this of course
-   contains the elf file header at offset 0.  It is assumed that this
-   buffer is sufficiently aligned to present no problems to the host
-   in accessing data at aligned offsets within the buffer.
-
-   On return: INFO values will be filled in, as necessary or available.  */
-
-static void load_elf_image(const char *image_name, int image_fd,
+static void load_elf_image(const char *image_name, const ImageSource *src,
                            struct image_info *info, struct elfhdr *ehdr,
-                           char **pinterp_name,
-                           char bprm_buf[BPRM_BUF_SIZE])
+                           char **pinterp_name)
 {
-    struct elf_phdr *phdr;
+    g_autofree struct elf_phdr *phdr = NULL;
     abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
-    int i, retval, prot_exec;
+    int i, prot_exec;
     Error *err = NULL;
 
-    /* First of all, some simple consistency checks */
-    memcpy(ehdr, bprm_buf, sizeof(*ehdr));
+    /*
+     * First of all, some simple consistency checks.
+     * Note that we rely on the bswapped ehdr staying in bprm_buf,
+     * for later use by load_elf_binary and create_elf_tables.
+     */
+    if (!imgsrc_read(ehdr, 0, sizeof(*ehdr), src, &err)) {
+        goto exit_errmsg;
+    }
     if (!elf_check_ident(ehdr)) {
         error_setg(&err, "Invalid ELF image for this architecture");
         goto exit_errmsg;
@@ -3220,15 +3217,11 @@ static void load_elf_image(const char *image_name, int image_fd,
         goto exit_errmsg;
     }
 
-    i = ehdr->e_phnum * sizeof(struct elf_phdr);
-    if (ehdr->e_phoff + i <= BPRM_BUF_SIZE) {
-        phdr = (struct elf_phdr *)(bprm_buf + ehdr->e_phoff);
-    } else {
-        phdr = (struct elf_phdr *) alloca(i);
-        retval = pread(image_fd, phdr, i, ehdr->e_phoff);
-        if (retval != i) {
-            goto exit_read;
-        }
+    phdr = imgsrc_read_alloc(ehdr->e_phoff,
+                             ehdr->e_phnum * sizeof(struct elf_phdr),
+                             src, &err);
+    if (phdr == NULL) {
+        goto exit_errmsg;
     }
     bswap_phdr(phdr, ehdr->e_phnum);
 
@@ -3265,17 +3258,10 @@ static void load_elf_image(const char *image_name, int image_fd,
                 goto exit_errmsg;
             }
 
-            interp_name = g_malloc(eppnt->p_filesz);
-
-            if (eppnt->p_offset + eppnt->p_filesz <= BPRM_BUF_SIZE) {
-                memcpy(interp_name, bprm_buf + eppnt->p_offset,
-                       eppnt->p_filesz);
-            } else {
-                retval = pread(image_fd, interp_name, eppnt->p_filesz,
-                               eppnt->p_offset);
-                if (retval != eppnt->p_filesz) {
-                    goto exit_read;
-                }
+            interp_name = imgsrc_read_alloc(eppnt->p_offset, eppnt->p_filesz,
+                                            src, &err);
+            if (interp_name == NULL) {
+                goto exit_errmsg;
             }
             if (interp_name[eppnt->p_filesz - 1] != 0) {
                 error_setg(&err, "Invalid PT_INTERP entry");
@@ -3283,7 +3269,7 @@ static void load_elf_image(const char *image_name, int image_fd,
             }
             *pinterp_name = g_steal_pointer(&interp_name);
         } else if (eppnt->p_type == PT_GNU_PROPERTY) {
-            if (!parse_elf_properties(image_fd, info, eppnt, bprm_buf, &err)) {
+            if (!parse_elf_properties(src, info, eppnt, &err)) {
                 goto exit_errmsg;
             }
         } else if (eppnt->p_type == PT_GNU_STACK) {
@@ -3436,9 +3422,9 @@ static void load_elf_image(const char *image_name, int image_fd,
              * but no backing file segment.
              */
             if (eppnt->p_filesz != 0) {
-                error = target_mmap(vaddr_ps, eppnt->p_filesz + vaddr_po,
+                error = imgsrc_mmap(vaddr_ps, eppnt->p_filesz + vaddr_po,
                                     elf_prot, MAP_PRIVATE | MAP_FIXED,
-                                    image_fd, eppnt->p_offset - vaddr_po);
+                                    src, eppnt->p_offset - vaddr_po);
                 if (error == -1) {
                     goto exit_mmap;
                 }
@@ -3470,20 +3456,11 @@ static void load_elf_image(const char *image_name, int image_fd,
 #ifdef TARGET_MIPS
         } else if (eppnt->p_type == PT_MIPS_ABIFLAGS) {
             Mips_elf_abiflags_v0 abiflags;
-            if (eppnt->p_filesz < sizeof(Mips_elf_abiflags_v0)) {
-                error_setg(&err, "Invalid PT_MIPS_ABIFLAGS entry");
+
+            if (!imgsrc_read(&abiflags, eppnt->p_offset, sizeof(abiflags),
+                             src, &err)) {
                 goto exit_errmsg;
             }
-            if (eppnt->p_offset + eppnt->p_filesz <= BPRM_BUF_SIZE) {
-                memcpy(&abiflags, bprm_buf + eppnt->p_offset,
-                       sizeof(Mips_elf_abiflags_v0));
-            } else {
-                retval = pread(image_fd, &abiflags, sizeof(Mips_elf_abiflags_v0),
-                               eppnt->p_offset);
-                if (retval != sizeof(Mips_elf_abiflags_v0)) {
-                    goto exit_read;
-                }
-            }
             bswap_mips_abiflags(&abiflags);
             info->fp_abi = abiflags.fp_abi;
 #endif
@@ -3496,23 +3473,16 @@ static void load_elf_image(const char *image_name, int image_fd,
     }
 
     if (qemu_log_enabled()) {
-        load_symbols(ehdr, image_fd, load_bias);
+        load_symbols(ehdr, src->fd, load_bias);
     }
 
-    debuginfo_report_elf(image_name, image_fd, load_bias);
+    debuginfo_report_elf(image_name, src->fd, load_bias);
 
     mmap_unlock();
 
-    close(image_fd);
+    close(src->fd);
     return;
 
- exit_read:
-    if (retval >= 0) {
-        error_setg(&err, "Incomplete read of file header");
-    } else {
-        error_setg_errno(&err, errno, "Error reading file header");
-    }
-    goto exit_errmsg;
  exit_mmap:
     error_setg_errno(&err, errno, "Error mapping file");
     goto exit_errmsg;
@@ -3525,6 +3495,7 @@ static void load_elf_interp(const char *filename, struct image_info *info,
                             char bprm_buf[BPRM_BUF_SIZE])
 {
     struct elfhdr ehdr;
+    ImageSource src;
     int fd, retval;
     Error *err = NULL;
 
@@ -3542,11 +3513,11 @@ static void load_elf_interp(const char *filename, struct image_info *info,
         exit(-1);
     }
 
-    if (retval < BPRM_BUF_SIZE) {
-        memset(bprm_buf + retval, 0, BPRM_BUF_SIZE - retval);
-    }
+    src.fd = fd;
+    src.cache = bprm_buf;
+    src.cache_size = retval;
 
-    load_elf_image(filename, fd, info, &ehdr, NULL, bprm_buf);
+    load_elf_image(filename, &src, info, &ehdr, NULL);
 }
 
 static int symfind(const void *s0, const void *s1)
@@ -3755,8 +3726,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
     interp_info.fp_abi = MIPS_ABI_FP_UNKNOWN;
 #endif
 
-    load_elf_image(bprm->filename, bprm->fd, info,
-                   &ehdr, &elf_interpreter, bprm->buf);
+    load_elf_image(bprm->filename, &bprm->src, info, &ehdr, &elf_interpreter);
 
     /* Do this so that we can load the interpreter, if need be.  We will
        change some of these later */
-- 
2.34.1



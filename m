Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1B4779542
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:52:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUVLw-0005lr-6n; Fri, 11 Aug 2023 12:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLr-0005k1-4O
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:51:03 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLp-0001M0-3Y
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:51:02 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5657a28f920so426859a12.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691772658; x=1692377458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dcDp54///Kf+CDj6N0TXUWsVxMt18CBlFITqwULqOtE=;
 b=Rbzlk7ugFLwlDVbPlSfxPMo5jzNk4pXE1Kpe2B0fgCxc85lywyH1nZHlTi8jXWxK82
 qqPk1uifQdldSiEdru3Ed8dtIG3QdlH5LRdThPqstqE57qAh4avN6MAoGMSx5gdcWn+w
 bMl7SwbIk/qSZhcIhYETC0ZINh8esFthASf3Xo2HRdB2HaP165l2YhuH3FL7KrM7yEsO
 loFY5NaRuMn6K2ioD7XSv0Q1+OupfH+4RJFkBoQRyODDgUVMKPwTfW2sT0NujY+vzNgV
 wA0KWZ0sDjVaZrNUJ1hz/6XHEEkkps1B7TjRYlbFkQJVsT3/T522MK1/fkUemiwXsfzT
 hV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691772658; x=1692377458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dcDp54///Kf+CDj6N0TXUWsVxMt18CBlFITqwULqOtE=;
 b=KSnEP9OU/6fDLG6qDUZV4UkYcD10VWDvLE7+ueli5RJIs2dPXSSvOQy3IiEOh4DlT3
 uIcaqhBB+vvkP31tUOjYzFzV70IfV5V2Yf8s9jd5Kxz3nU6XTo0cQbqV6aH8hPPtgqkg
 D8Cvp5Xx4Qmk1XcWTvcpg0R72kzRJhSEWUU5YvtAES7lzdcQwY7L58znHSh1dV2n4nXz
 8zil4m3cu1jSHoZRemfB/nDhGYsUpQsH8Tn3fjSNyy5ZNgVjVqnLYPMH1vOFPYAdTB3B
 iJ4i0Np1bS6zW7HIrRzQxvpYgrO2sWClv45qx+n0sH/ze1RLEDK/YGx0ppoYCdcIJn1H
 ZfcA==
X-Gm-Message-State: AOJu0YwzRlNZh+DH30/31ici9ijfyNeLkVMO7K+W2fHDre/CYrJfSiWL
 xhm/B4xrcrwrTBO5q3XQk4zro3ZMva5p3VGzbRc=
X-Google-Smtp-Source: AGHT+IEgXB3Uj031DVwU2NKcl0jjVfs6ExJzCIxqCM5daRg6dtKiaIhNMn4OpEAocj3/onHeWz8mBA==
X-Received: by 2002:a17:90a:cb06:b0:26b:2538:d717 with SMTP id
 z6-20020a17090acb0600b0026b2538d717mr1727966pjt.25.1691772657684; 
 Fri, 11 Aug 2023 09:50:57 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 22-20020a17090a19d600b00263d3448141sm3803713pjj.8.2023.08.11.09.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:50:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH v3 04/15] linux-user: Use ImageSource in load_elf_image
Date: Fri, 11 Aug 2023 09:50:41 -0700
Message-Id: <20230811165052.161080-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811165052.161080-1-richard.henderson@linaro.org>
References: <20230811165052.161080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 128 +++++++++++++++++--------------------------
 1 file changed, 49 insertions(+), 79 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 11bbf4e99b..f3511ae766 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2922,10 +2922,9 @@ static bool parse_elf_property(const uint32_t *data, int *off, int datasz,
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
@@ -2953,14 +2952,8 @@ static bool parse_elf_properties(int image_fd,
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
@@ -3006,30 +2999,34 @@ static bool parse_elf_properties(int image_fd,
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
@@ -3040,15 +3037,11 @@ static void load_elf_image(const char *image_name, int image_fd,
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
 
@@ -3085,17 +3078,10 @@ static void load_elf_image(const char *image_name, int image_fd,
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
@@ -3103,7 +3089,7 @@ static void load_elf_image(const char *image_name, int image_fd,
             }
             *pinterp_name = g_steal_pointer(&interp_name);
         } else if (eppnt->p_type == PT_GNU_PROPERTY) {
-            if (!parse_elf_properties(image_fd, info, eppnt, bprm_buf, &err)) {
+            if (!parse_elf_properties(src, info, eppnt, &err)) {
                 goto exit_errmsg;
             }
         } else if (eppnt->p_type == PT_GNU_STACK) {
@@ -3256,9 +3242,9 @@ static void load_elf_image(const char *image_name, int image_fd,
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
@@ -3290,20 +3276,11 @@ static void load_elf_image(const char *image_name, int image_fd,
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
@@ -3316,23 +3293,16 @@ static void load_elf_image(const char *image_name, int image_fd,
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
@@ -3345,6 +3315,7 @@ static void load_elf_interp(const char *filename, struct image_info *info,
                             char bprm_buf[BPRM_BUF_SIZE])
 {
     struct elfhdr ehdr;
+    ImageSource src;
     int fd, retval;
     Error *err = NULL;
 
@@ -3362,11 +3333,11 @@ static void load_elf_interp(const char *filename, struct image_info *info,
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
@@ -3577,8 +3548,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
 
     info->start_mmap = (abi_ulong)ELF_START_MMAP;
 
-    load_elf_image(bprm->filename, bprm->fd, info,
-                   &ehdr, &elf_interpreter, bprm->buf);
+    load_elf_image(bprm->filename, &bprm->src, info, &ehdr, &elf_interpreter);
 
     /* Do this so that we can load the interpreter, if need be.  We will
        change some of these later */
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 763A277E82D
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:04:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWKry-00024b-2b; Wed, 16 Aug 2023 14:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKrw-00022g-1l
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:44 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKrt-0001Ic-In
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:43 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bdb801c667so44707695ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 11:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692209020; x=1692813820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KVQEaJs3GbLkjPKeCbXH/uHTPUARwUrZn+9U7CYMhDA=;
 b=Cbg7Zz8WrgfVFUz1spaNhc2DU3Q4gNkC/eZXP9LXywJdO5dxyj75NeY/7HfGWmauXj
 GnSLFX2cQWIPoe5IZJZLaSZWgPL7OLm6sCoaa7kQ+dYak60Skw6bp9urCVSVmDoLnXTG
 0w1UEO4qnTjRcFJEMZErGLnC4BPUYrdMA2UDri65rVJAqLfbw1i2bgRL+AdrskSoekfT
 ZjOf1ST1UHMm3jm6HFskGcQ6ZxSTAkPDpm1vmeVjRxcgP2Rrk4si4XdbMKPbI22zDdPC
 TeJiHS4Y7A/hfvvYt4DD3sCIm9WZeBxXC3fDiiVj/rC41jx+xE2U7+Fg/25+uzSqmU+X
 UsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692209020; x=1692813820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KVQEaJs3GbLkjPKeCbXH/uHTPUARwUrZn+9U7CYMhDA=;
 b=NZOVO0iBEQX3lClz9FvmFtPgg0OlgSrFqbr3fciETymRoxMqrFuzWpCW7GawB0aB/A
 PZwiNTPtfGw+y2a1EMDSAsu/6UQmguxqtD2l1vKSgRhhj9fwH+zmLzpUk8VxSJRYKx/Y
 lHzR2DfLy2vz23q2y6lNccIApwe2VGz26ChaGLHK7+DE/QxWw3eCi+kzHz3o/CjX7vEH
 KlSeq2mfK5V4Sw6JR5+xImnVtv4zKuY7iDqCTcOgH7UP2oMpF9L9okKzm4VdMvRN3o8n
 EIJrWmPNG2f0PAPsQrLXQxuK2TP3o0lGa5GzUb+EV8q90+E0HsPG55e31uow6pQeqYt8
 RoVg==
X-Gm-Message-State: AOJu0YxuiUDqpt9PPbrfeBc3jzkq9ZF/qVirVchormUW6IJDu2sH2U1c
 6tzhxYIvX0pDeFft2M+SX/jaWdJWVZYz4m5JpWU=
X-Google-Smtp-Source: AGHT+IGfOx/craWJn0/SQ1//cI3X0i5o7AuaDkQr5YZmQGZ/ySBz5knLPp3fnEb7HdVoTNdYdaYkXQ==
X-Received: by 2002:a17:902:dad1:b0:1b3:e90b:93e1 with SMTP id
 q17-20020a170902dad100b001b3e90b93e1mr3349934plx.36.1692209020225; 
 Wed, 16 Aug 2023 11:03:40 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a170902868e00b001bc2831e1a9sm13446584plo.90.2023.08.16.11.03.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 11:03:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/18] linux-user: Introduce imgsrc_read, imgsrc_read_alloc
Date: Wed, 16 Aug 2023 11:03:21 -0700
Message-Id: <20230816180338.572576-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816180338.572576-1-richard.henderson@linaro.org>
References: <20230816180338.572576-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Introduced and initialized, but not yet really used.
These will tidy the current tests vs BPRM_BUF_SIZE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h    | 61 +++++++++++++++++++++++-----
 linux-user/linuxload.c | 90 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+), 9 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 59cbeacf24..311d20f5d1 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -18,6 +18,48 @@
 #ifndef LINUX_USER_LOADER_H
 #define LINUX_USER_LOADER_H
 
+typedef struct {
+    const void *cache;
+    unsigned int cache_size;
+    int fd;
+} ImageSource;
+
+/**
+ * imgsrc_read: Read from ImageSource
+ * @dst: destination for read
+ * @offset: offset within file for read
+ * @len: size of the read
+ * @img: ImageSource to read from
+ * @errp: Error details.
+ *
+ * Read into @dst, using the cache when possible.
+ */
+bool imgsrc_read(void *dst, off_t offset, size_t len,
+                 const ImageSource *img, Error **errp);
+
+/**
+ * imgsrc_read_alloc: Read from ImageSource
+ * @offset: offset within file for read
+ * @size: size of the read
+ * @img: ImageSource to read from
+ * @errp: Error details.
+ *
+ * Read into newly allocated memory, using the cache when possible.
+ */
+void *imgsrc_read_alloc(off_t offset, size_t len,
+                        const ImageSource *img, Error **errp);
+
+/**
+ * imgsrc_mmap: Map from ImageSource
+ *
+ * If @src has a file descriptor, pass on to target_mmap.  Otherwise,
+ * this is "mapping" from a host buffer, which resolves to memcpy.
+ * Therefore, flags must be MAP_PRIVATE | MAP_FIXED; the argument is
+ * retained for clarity.
+ */
+abi_long imgsrc_mmap(abi_ulong start, abi_ulong len, int prot,
+                     int flags, const ImageSource *src, abi_ulong offset);
+
 /*
  * Read a good amount of data initially, to hopefully get all the
  * program headers loaded.
@@ -29,15 +71,16 @@
  * used when loading binaries.
  */
 struct linux_binprm {
-        char buf[BPRM_BUF_SIZE] __attribute__((aligned));
-        abi_ulong p;
-        int fd;
-        int e_uid, e_gid;
-        int argc, envc;
-        char **argv;
-        char **envp;
-        char *filename;        /* Name of binary */
-        int (*core_dump)(int, const CPUArchState *); /* coredump routine */
+    char buf[BPRM_BUF_SIZE] __attribute__((aligned));
+    ImageSource src;
+    abi_ulong p;
+    int fd;
+    int e_uid, e_gid;
+    int argc, envc;
+    char **argv;
+    char **envp;
+    char *filename;        /* Name of binary */
+    int (*core_dump)(int, const CPUArchState *); /* coredump routine */
 };
 
 void do_init_thread(struct target_pt_regs *regs, struct image_info *infop);
diff --git a/linux-user/linuxload.c b/linux-user/linuxload.c
index 745cce70ab..3536dd8104 100644
--- a/linux-user/linuxload.c
+++ b/linux-user/linuxload.c
@@ -3,7 +3,9 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
+#include "user-mmap.h"
 #include "loader.h"
+#include "qapi/error.h"
 
 #define NGROUPS 32
 
@@ -76,6 +78,10 @@ static int prepare_binprm(struct linux_binprm *bprm)
         /* Make sure the rest of the loader won't read garbage.  */
         memset(bprm->buf + retval, 0, BPRM_BUF_SIZE - retval);
     }
+
+    bprm->src.cache = bprm->buf;
+    bprm->src.cache_size = retval;
+
     return retval;
 }
 
@@ -139,6 +145,7 @@ int loader_exec(int fdexec, const char *filename, char **argv, char **envp,
     int retval;
 
     bprm->fd = fdexec;
+    bprm->src.fd = fdexec;
     bprm->filename = (char *)filename;
     bprm->argc = count(argv);
     bprm->argv = argv;
@@ -173,3 +180,86 @@ int loader_exec(int fdexec, const char *filename, char **argv, char **envp,
 
     return retval;
 }
+
+bool imgsrc_read(void *dst, off_t offset, size_t len,
+                 const ImageSource *img, Error **errp)
+{
+    ssize_t ret;
+
+    if (offset + len <= img->cache_size) {
+        memcpy(dst, img->cache + offset, len);
+        return true;
+    }
+
+    if (img->fd < 0) {
+        error_setg(errp, "read past end of buffer");
+        return false;
+    }
+
+    ret = pread(img->fd, dst, len, offset);
+    if (ret == len) {
+        return true;
+    }
+    if (ret < 0) {
+        error_setg_errno(errp, errno, "Error reading file header");
+    } else {
+        error_setg(errp, "Incomplete read of file header");
+    }
+    return false;
+}
+
+void *imgsrc_read_alloc(off_t offset, size_t len,
+                        const ImageSource *img, Error **errp)
+{
+    void *alloc = g_malloc(len);
+    bool ok = imgsrc_read(alloc, offset, len, img, errp);
+
+    if (!ok) {
+        g_free(alloc);
+        alloc = NULL;
+    }
+    return alloc;
+}
+
+abi_long imgsrc_mmap(abi_ulong start, abi_ulong len, int prot,
+                     int flags, const ImageSource *src, abi_ulong offset)
+{
+    const int prot_write = PROT_READ | PROT_WRITE;
+    abi_long ret;
+    void *haddr;
+
+    assert(flags == (MAP_PRIVATE | MAP_FIXED));
+
+    if (src->fd >= 0) {
+        return target_mmap(start, len, prot, flags, src->fd, offset);
+    }
+
+    /*
+     * This case is for the vdso; we don't expect bad images.
+     * The mmap may extend beyond the end of the image, especially
+     * to the end of the page.  Zero fill.
+     */
+    assert(offset < src->cache_size);
+
+    ret = target_mmap(start, len, prot_write, flags | MAP_ANON, -1, 0);
+    if (ret == -1) {
+        return ret;
+    }
+
+    haddr = lock_user(VERIFY_WRITE, start, len, 0);
+    assert(haddr != NULL);
+    if (offset + len <= src->cache_size) {
+        memcpy(haddr, src->cache + offset, len);
+    } else {
+        size_t rest = src->cache_size - offset;
+        memcpy(haddr, src->cache + offset, rest);
+        memset(haddr + rest, 0, len - rest);
+    }
+    unlock_user(haddr, start, len);
+
+    if (prot != prot_write) {
+        target_mprotect(start, len, prot);
+    }
+
+    return ret;
+}
-- 
2.34.1



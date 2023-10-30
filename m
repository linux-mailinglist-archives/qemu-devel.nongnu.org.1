Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEE67DC1B5
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:18:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZdy-00010x-FM; Mon, 30 Oct 2023 17:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdf-0000yo-Mw
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:37 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdb-0006Te-Ty
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:34 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc3bb4c307so11455875ad.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 14:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698700650; x=1699305450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzz2vrun9ZHolGGbK5hlMNaXrSfdtOTmji9iHcf/zms=;
 b=ZUyARYYZhZIEXBcQtRYoYz7BMknWUpaIeHPmVEXoOHFg6WDxABhQS0KdqbuYTH7reB
 waKhsYYcA1ZjirgIFaXNVj/hwHu3/20IT74JXgByUi9mFeN2fstATPDNODtiAKGnP+g0
 XQlvSJpHiJDGt/RG2pdMCCAwnwzP0oCuvTeQTpTQNRSyYGLnYqUzmw0ve33r2DmZLbd4
 8nt54jHe4XNFLTf4Yr7VoPOKe7K4Xy7qEbAHXXAj6ZSkydn3rxX/L+ZlYclkXKfMbWER
 eaUJgb/DlvqfTs3nUQl2PmFkRE0rWVUbaCGWAAGeQ5BjBtBv6U1huTHbqeO6cI8jzQKB
 w6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698700650; x=1699305450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yzz2vrun9ZHolGGbK5hlMNaXrSfdtOTmji9iHcf/zms=;
 b=IWMH3n51roHpgT6Lj4q1XgR1B4SWTEbB84XKTj5fkLGM4NbW8maeDybNmNeHXBhVmm
 vU5eR+hUz4kxZgW1b/kCDw1ZLdjteU65c+SQ+njyImWvNm+SbE/6feSiomWk3Y10Mmmq
 L38wysjs5JtsluzcocH7KVTa2KcHNWs2B5B8o013vFOYUj5YfeIvErYQ6uKlx9SwXKcZ
 gsMA+LxHY+wc2nOBl6ja6pDo4G4gnhqwegB2MMfKwjalIwJZvVIenAWTN8p1gJHQ0Hc6
 K04mHFoboMuBt3aSaA8588R6rYtlr3bdc3egYRKgc1qirl/gdy2b0o+YtO+Yy5cOMQTD
 1Bqw==
X-Gm-Message-State: AOJu0YzXYypPvPaAx4cDQEZ+BiEG1ZM7cuN2Ib28O/WXFlsAp0HsLpwK
 0X3p7iDWvpMkWD6/uU5gOjrsBhlckvzEv07kVvQ=
X-Google-Smtp-Source: AGHT+IFv0qxogegFSuXnxqBNJqh0HT7vCQXkWOUaLi0DCDF2ch4q5JT5g0JY8WFCnPwhul8chPaB0w==
X-Received: by 2002:a17:903:32d1:b0:1cc:3bc9:b924 with SMTP id
 i17-20020a17090332d100b001cc3bc9b924mr4169483plr.25.1698700649894; 
 Mon, 30 Oct 2023 14:17:29 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf2-20020a170903268200b001cc32261bdfsm4670350plb.38.2023.10.30.14.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:17:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/21] linux-user: Introduce imgsrc_read, imgsrc_read_alloc
Date: Mon, 30 Oct 2023 14:17:08 -0700
Message-Id: <20231030211727.165090-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030211727.165090-1-richard.henderson@linaro.org>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h    | 61 +++++++++++++++++++++++-----
 linux-user/linuxload.c | 90 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+), 9 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 324e5c872a..da6591fff0 100644
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



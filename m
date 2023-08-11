Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C317877953A
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:52:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUVLp-0005jM-UV; Fri, 11 Aug 2023 12:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLm-0005iW-6R
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:50:58 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLk-0001LT-EK
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:50:57 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-26b2beae166so336328a91.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691772655; x=1692377455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KVQEaJs3GbLkjPKeCbXH/uHTPUARwUrZn+9U7CYMhDA=;
 b=coulX4Zk/tPnaJCY66nmv6HKKr2oCY8JBGdd5H0Xb2S2Vtyh1MAG+eDNYB49nMzbcM
 ZUDbTxiuAnzwtCafEyGpG0afBPYRsifCohFCrWR+VV6eOu4Qj93tBRO7bpr+bcMTpmkY
 EvEAPlDfJpigNVPnzqhTZp3htK1CVVCjhe/jVHsEUIG+h+e7Q7SEBQmb+F9kqD9B0/Li
 ccS5iHno/QRDfkgQXsRWMfQtoADhf0Z3hU4ihh0EWNq4uNwo2qkS+7zGHxvKzhdy/p5O
 QQL342L2g9H1zdhgIzciBZIClx07Spd4I/LSNsuHKyUYgGRfhgFPkrmxoGwcElVpyIiU
 x84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691772655; x=1692377455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KVQEaJs3GbLkjPKeCbXH/uHTPUARwUrZn+9U7CYMhDA=;
 b=S2fhTrCg7drguPlQCZCXQELdqE+kXOWFiI8Ko00BBC26WTtAtyemGwqkS0XrU2vJTt
 N/sGVBQQCxQx62k9qdugxoz1kbtA3wxLAR23LOVTIENyg0HhyhvtAz981h/BKxDS7CaN
 m2j9urme674PHEBfQvObs7H+dqsl2MRo87B2fd0isv80WjTY0YWg/vBW2GlAKX3E0tjl
 tuoBssu8M8dy9/5kOXGZNBRhbX5HvNcKNXDcKy31CUP37BVwgL/zI2V390GDuo2Pl2Ea
 axqA60eVhFQrMfNIHrt6PVecvUk9c2tOPU51HKPApclxubCBR/2rheB4u2XWOhTWZXfK
 xJHw==
X-Gm-Message-State: AOJu0Yz8GCBgkR/XrbeTgzat2cIhd0SP9ZiURURaR5U2Z6HgnBaMdU1B
 o4Rf5Ey0uSP0WYGf6jWmiNiCPw4fv1X2444oP/4=
X-Google-Smtp-Source: AGHT+IGOcBFLVozj+tn+/juMa1bzNnM1OtZ3WAcmtUrCLbFsTqoggZlGeRPNP6bXRuGSeoZVjDE5tg==
X-Received: by 2002:a17:90b:144:b0:263:9e9b:5586 with SMTP id
 em4-20020a17090b014400b002639e9b5586mr1637454pjb.44.1691772654995; 
 Fri, 11 Aug 2023 09:50:54 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 22-20020a17090a19d600b00263d3448141sm3803713pjj.8.2023.08.11.09.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:50:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH v3 01/15] linux-user: Introduce imgsrc_read, imgsrc_read_alloc
Date: Fri, 11 Aug 2023 09:50:38 -0700
Message-Id: <20230811165052.161080-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811165052.161080-1-richard.henderson@linaro.org>
References: <20230811165052.161080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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



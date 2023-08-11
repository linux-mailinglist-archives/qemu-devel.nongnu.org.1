Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A14F779495
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:29:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUV0A-0006MO-Fk; Fri, 11 Aug 2023 12:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qUV08-0006KQ-6t
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:28:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qUV05-0005EH-E3
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:28:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fe167d4a18so19898645e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691771311; x=1692376111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0uq95LEssCksJywB6tkgBjETgh3jj8wLZB4MC0pmpaE=;
 b=aEhsemw4TfNpoFlrrcepUj25C3961mZIRJ3ht6DEGyU1ANAJYx5eoeeJYA8SxRljBL
 kn9qlc0T/PtEevmIhV2OzFQihCPRvHsa4vCJfptpxtTlncTbwSiMQvN1YEZ5ZCLa23aQ
 uPjSfI+UvrPTIGeuzLtwNw7EVPdnwEWgd8PRyamsYxq5ssGrzE7ezNkMlYwPqoAuefWc
 3v1zEzwa/Z5MGjO6C/XFcRIIavfRS/ib8Zmob3Btmd39SeT6b0GA5U2RVa6OCIFMXlDw
 0oV/C6qM5nB+o57lhhNH9+vAV+CIoU74TxuqI7fGcCF46IbVC4FoqCzeZzUCtqRX0VM/
 buaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691771311; x=1692376111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0uq95LEssCksJywB6tkgBjETgh3jj8wLZB4MC0pmpaE=;
 b=Mub3QM+oxRmJn0ank4UtBEelU0ORdnnS1/sedU6TRqPdwjJcmQqsJ7l5L9jIvLskLZ
 CPLknrfyQllvNgI1n9YcsWA3I/Btomw03fhiQ6jXWh2weyTWfxZFnp1FMK5K0hVdkRE8
 1H7pG3n/TH7v+CerKIR2CfuJgQXI6cbfE70d74NSa1QBMD0VTNg9nuPfDQm7QzzSErtg
 iTUhzMJdEGy4JwgFC6emPiR9s79FIv385pAZm5DsGsqTIIavWP7p8lm66TIJoK7f5Ce3
 maCSqRKqFzKOdYJ62UYM5OGW5w7paRKimd2UsLXoF6r2Z8tZPr5sb8SALJcHtH75FaVD
 K9JA==
X-Gm-Message-State: AOJu0Ywl9LlniM4boIm+JhyEwRymmew24kpPfFRM5N7y3eHaT3fYiHmS
 t4tqm7DyaS4FiNwLsPGdrAFlqTZ9WMUlV6V73J8=
X-Google-Smtp-Source: AGHT+IF6R2Z7XdkUbmsEsIOmspvo7NYHrfP84iZAUjoZ4dTZ6JDKbcBqr//YQerGPlJjC8627K2b4g==
X-Received: by 2002:a5d:40ce:0:b0:317:4d79:1e45 with SMTP id
 b14-20020a5d40ce000000b003174d791e45mr1821109wrq.15.1691771311270; 
 Fri, 11 Aug 2023 09:28:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 j4-20020adfe504000000b003177f57e79esm5872855wrm.88.2023.08.11.09.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:28:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 718571FFBC;
 Fri, 11 Aug 2023 17:28:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org,
	Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 1/2] linux-user: implement some basic FD<->path tracking
Date: Fri, 11 Aug 2023 17:28:29 +0100
Message-Id: <20230811162830.2278032-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811162830.2278032-1-alex.bennee@linaro.org>
References: <20230811162830.2278032-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

This will be useful in later patches for tracking the paths associated
with mmap operations. This will be useful to the upcoming -dfilter
changes to track execution only certain libraries.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/syscall.c | 59 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9353268cc1..e191163c49 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8557,6 +8557,58 @@ static int open_hardware(CPUArchState *cpu_env, int fd)
 }
 #endif
 
+/*
+ * Handle non-intercepted guest open operations. This gives us the
+ * opportunity to track some information
+ */
+
+static QemuMutex fd_tracking_lock;
+static GHashTable *fd_path;
+
+__attribute__((constructor))
+static void fd_tracking_init(void)
+{
+    qemu_mutex_init(&fd_tracking_lock);
+}
+
+static int do_plain_guest_openat(int dirfd, const char *pathname,
+                                 int flags, mode_t mode, bool safe)
+{
+    const char * real_path = path(pathname);
+    int fd;
+
+    if (safe) {
+        fd = safe_openat(dirfd, real_path, flags, mode);
+    } else {
+        fd = openat(dirfd, real_path, flags, mode);
+    }
+
+    /* If we opened an fd save some details */
+    if (fd >= 0) {
+        WITH_QEMU_LOCK_GUARD(&fd_tracking_lock) {
+            if (!fd_path) {
+                fd_path = g_hash_table_new(NULL, NULL);
+            }
+
+            if (!g_hash_table_insert(fd_path, GINT_TO_POINTER(fd), g_strdup(real_path))) {
+                fprintf(stderr, "%s: duplicate fd %d in fd_path hash\n", __func__, fd);
+            }
+        }
+    }
+
+    return fd;
+}
+
+static void fd_path_cleanup(int fd) {
+    WITH_QEMU_LOCK_GUARD(&fd_tracking_lock) {
+        /*
+         * Assume success, if we failed to cleanup its totally
+         * possible the guest got confused and closed something twice.
+         */
+        g_hash_table_remove(fd_path, GINT_TO_POINTER(fd));
+    }
+}
+
 
 int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
                     int flags, mode_t mode, bool safe)
@@ -8643,11 +8695,7 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
         return fd;
     }
 
-    if (safe) {
-        return safe_openat(dirfd, path(pathname), flags, mode);
-    } else {
-        return openat(dirfd, path(pathname), flags, mode);
-    }
+    return do_plain_guest_openat(dirfd, pathname, flags, mode, safe);
 }
 
 ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz)
@@ -9355,6 +9403,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return get_errno(pidfd_getfd(arg1, arg2, arg3));
 #endif
     case TARGET_NR_close:
+        fd_path_cleanup(arg1);
         fd_trans_unregister(arg1);
         return get_errno(close(arg1));
 #if defined(__NR_close_range) && defined(TARGET_NR_close_range)
-- 
2.39.2



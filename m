Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3197478BBA9
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:44:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalrx-0003ml-Kt; Mon, 28 Aug 2023 19:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrt-0003lJ-Ei
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:01 -0400
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrq-0006kW-IA
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:01 -0400
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-79275d86bc3so137592239f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266117; x=1693870917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xbJD17By5G8l1NVxB3u7W0fI1sN/049DHukEFpqYia8=;
 b=uZXbwp4xJjfxjy3hVE9MmIw40HSjIXNJx/8OFWbl2tWah5G6PuNOkc5vG1e04Ffh15
 oXpNquvHU63GLZf5q5V8ovVa3fHsMGXqtAEcLNyTrYlhzpfyZWZqiZ6Bpqe5XZ2xlNcA
 vhPDHQVKKXEMqAyiL5+oHZoUzsIeMLBM4j2m5vUmAwvjwUwL0kSvkPBuwCwZzcpAVMV0
 sWAL2FgYGTRgsUYZEQFFO718YBp3BmOvYFXLMkwNwcDRcfa6KhVNGNx85qGD8H0w+OPT
 0eXeQRya3f6WNd8lHbjxCxv5gyjLxChukQ9/5RhLVEEEnx+t4+kK4/q1SeNsc8CzmngH
 B/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266117; x=1693870917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xbJD17By5G8l1NVxB3u7W0fI1sN/049DHukEFpqYia8=;
 b=C7SiEXqMgDgDttTPd0LeSJVXdRS/ebEul5/Gu5HrkchQonYN5jZfBDEs+/01AFELaF
 N2rvnJ5LJONIAP4rTIsOV7+kS0hj+EI5bVjEUsXH1azAaBKRZaBkraDbtvJznzUTy/DH
 eKkCELBaV+Hde3NCiV9WIkwACyrDo+e+61+CU7RCb451m1rxXzxshzeJNJ7iMJb0CADI
 Np0Q/rp14rq+2jg9cucWGqWqAN3V9LqOSA87IAueWlmv3YAA6iezn8soQsZL88LIqhrE
 a3Il97eVe6MYhrTjd3lebKzbW5GECrEEix3XR0gPhRgT3kxdXG7dr2t6s1cck2+PO42z
 TqOA==
X-Gm-Message-State: AOJu0YxjU9i5K0IXXmdqQuUu/ZxMzoievGSZ9/t96izv8528qnY6iQSE
 11B8EmbmjscjcwPH22kmkxjlyVuJEn2It2xTcrE=
X-Google-Smtp-Source: AGHT+IFhocWTAI6wkXuytXOeACMZynnNJv/yoe9N6UNdyVGUQTpyDdGSOaYQ2r0+IqpE935jIghxmg==
X-Received: by 2002:a05:6e02:13cc:b0:349:92d4:bfed with SMTP id
 v12-20020a056e0213cc00b0034992d4bfedmr15794350ilj.18.1693266116773; 
 Mon, 28 Aug 2023 16:41:56 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:56 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 20/36] bsd-user: Implement stat related syscalls
Date: Mon, 28 Aug 2023 17:38:05 -0600
Message-ID: <20230828233821.43074-21-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Implement the following syscalls:
stat(2)
lstat(2)
fstat(2)
fstatat(2)
nstat
nfstat
nlstat

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-stat.h | 130 +++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 bsd-user/freebsd/os-stat.h

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
new file mode 100644
index 00000000000..f8f99b4a723
--- /dev/null
+++ b/bsd-user/freebsd/os-stat.h
@@ -0,0 +1,130 @@
+/*
+ *  stat related system call shims and definitions
+ *
+ *  Copyright (c) 2013 Stacey D. Son
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef BSD_USER_FREEBSD_OS_STAT_H
+#define BSD_USER_FREEBSD_OS_STAT_H
+
+/* stat(2) */
+static inline abi_long do_freebsd11_stat(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    struct freebsd11_stat st;
+
+    LOCK_PATH(p, arg1);
+    ret = get_errno(freebsd11_stat(path(p), &st));
+    UNLOCK_PATH(p, arg1);
+    if (!is_error(ret)) {
+        ret = h2t_freebsd11_stat(arg2, &st);
+    }
+    return ret;
+}
+
+/* lstat(2) */
+static inline abi_long do_freebsd11_lstat(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    struct freebsd11_stat st;
+
+    LOCK_PATH(p, arg1);
+    ret = get_errno(freebsd11_lstat(path(p), &st));
+    UNLOCK_PATH(p, arg1);
+    if (!is_error(ret)) {
+        ret = h2t_freebsd11_stat(arg2, &st);
+    }
+    return ret;
+}
+
+/* fstat(2) */
+static inline abi_long do_freebsd_fstat(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    struct stat st;
+
+    ret = get_errno(fstat(arg1, &st));
+    if (!is_error(ret))  {
+        ret = h2t_freebsd_stat(arg2, &st);
+    }
+    return ret;
+}
+
+/* fstatat(2) */
+static inline abi_long do_freebsd_fstatat(abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4)
+{
+    abi_long ret;
+    void *p;
+    struct stat st;
+
+    LOCK_PATH(p, arg2);
+    ret = get_errno(fstatat(arg1, p, &st, arg4));
+    UNLOCK_PATH(p, arg2);
+    if (!is_error(ret) && arg3) {
+        ret = h2t_freebsd_stat(arg3, &st);
+    }
+    return ret;
+}
+
+/* undocummented nstat(char *path, struct nstat *ub) syscall */
+static abi_long do_freebsd11_nstat(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    struct freebsd11_stat st;
+
+    LOCK_PATH(p, arg1);
+    ret = get_errno(freebsd11_nstat(path(p), &st));
+    UNLOCK_PATH(p, arg1);
+    if (!is_error(ret)) {
+        ret = h2t_freebsd11_nstat(arg2, &st);
+    }
+    return ret;
+}
+
+/* undocummented nfstat(int fd, struct nstat *sb) syscall */
+static abi_long do_freebsd11_nfstat(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    struct freebsd11_stat st;
+
+    ret = get_errno(freebsd11_nfstat(arg1, &st));
+    if (!is_error(ret))  {
+        ret = h2t_freebsd11_nstat(arg2, &st);
+    }
+    return ret;
+}
+
+/* undocummented nlstat(char *path, struct nstat *ub) syscall */
+static abi_long do_freebsd11_nlstat(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    struct freebsd11_stat st;
+
+    LOCK_PATH(p, arg1);
+    ret = get_errno(freebsd11_nlstat(path(p), &st));
+    UNLOCK_PATH(p, arg1);
+    if (!is_error(ret)) {
+        ret = h2t_freebsd11_nstat(arg2, &st);
+    }
+    return ret;
+}
+
+#endif /* BSD_USER_FREEBSD_OS_STAT_H */
-- 
2.41.0



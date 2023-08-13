Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B480577AAEA
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:44:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzl-0007s6-Nm; Sun, 13 Aug 2023 15:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzj-0007rF-Ry
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzi-0002Pv-5u
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:23 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fe32016bc8so32837875e9.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955800; x=1692560600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+dm6ERbWnDuZOwPqGLPqR4XT6w3jbBV5vVVArlyMxbM=;
 b=Es+yWFRdE7Tg5C2sGUQQQgFNyKMLiEWTZP5gt5knfecmY8ceCb1zs2qkIHrbywh0ls
 3Ko3+5imTLwMmGgh9sEThlLi7bW/gMDPiA0Gg4fZdThoSVXhVDGHjI88ONqzf5awrRhs
 attVognwWDkj5/S8gaXG4hRX+hVIlByl7CBHYWLFaTbQvoMCQ1BEOaj1N6BU4shSVz3K
 s6aL7SE7Ojubq8uGXUrTkQJmXIf1flSPQ9o4hbURXKO+vdPXl2GT2CYQtN379D0tPtBn
 gfoLPa3jTLhAflIGn81mW7DbDCtJc3plJuag/XK+WRQyoKDrYWvkbRbWqnX6P/TAcOHo
 GJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955800; x=1692560600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+dm6ERbWnDuZOwPqGLPqR4XT6w3jbBV5vVVArlyMxbM=;
 b=HpOE0CtOs6yrAFf9Ua/+3/hK5tZX3jwEcMajpiYIB9/T1scLIRy/YH3zhsxKo96+9S
 uM7a3X/IR01ubTMpKF+A8h7xpFD0DCbPqnKImvxlk2VTjwUrsWMRDTb8EbxsfK51Scmd
 HCISx7xKSSIDoh+5eH9ATyl2PQH4gkbnoVdQObxXKpkck4n88KAd1RV1i27ZiTJ+LVR1
 EeSFESq5UZ3NanWKtIdY5tVuCSvBRnoR8Dd2eqnSksPsub8bVtP2d6JWy1e9lT7tsDqP
 96bipybjLoUPNJRp0El59paiTrt0yjgQZat1c4r0CXQozmOuUWuBOFIZDkxVBRMty/BA
 C9iA==
X-Gm-Message-State: AOJu0YxrAIZUaQGsimdHs2Q6GWZyi/qYYvrYJI4CpM2t7LN5DPOHXvIX
 18+WdZTtdcMFkykseqboFQ5YjxozJ9k=
X-Google-Smtp-Source: AGHT+IHjgC3xlxIsvrIY5w9WJmUZg3eRMOxgE5KFkrdGO2WzAr4GxiYH3118VS+/7LA8zeZbBZudwQ==
X-Received: by 2002:a05:600c:420b:b0:3fe:3521:d9ca with SMTP id
 x11-20020a05600c420b00b003fe3521d9camr5563403wmh.3.1691955800467; 
 Sun, 13 Aug 2023 12:43:20 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:20 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 17/32] Implement stat related syscalls
Date: Sun, 13 Aug 2023 10:41:38 +0200
Message-Id: <20230813084153.6510-18-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 bsd-user/freebsd/os-stat.h | 130 +++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 bsd-user/freebsd/os-stat.h

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
new file mode 100644
index 0000000000..f8f99b4a72
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
2.40.0



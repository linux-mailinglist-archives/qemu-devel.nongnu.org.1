Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9438077A6D7
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:19:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpt-0008Fy-S5; Sun, 13 Aug 2023 10:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpY-00089b-GZ
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:32 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpW-0000rW-Nr
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:32 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3178dd771ceso3218136f8f.2
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935949; x=1692540749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+dm6ERbWnDuZOwPqGLPqR4XT6w3jbBV5vVVArlyMxbM=;
 b=enN/G05wREslJztWvBXCepuj0hx6TKfD19DaatnHXUznvZeXgqZq1Fa6YT6kYnmmTD
 2xEwIB8ac6GC4rAaEx3mvRs488vyuXz1hIXR5tMhkoTZfH5bzoATciKieTtQpvjm2Lad
 dEWnUWRBdROmAVYzPWZ4Jo6lRnd/ifqj1ZcW8GPGqcNNBAzfZfTBkTpW9duL9PwFqKGF
 zwG+oeNH/iQLoYMn7fpwgWMa0agpOnUI8/syaxhM4fkY97ADUCr7FSzvvUFVUhUehIFA
 VW2Mx3gTWErjUMSY1+3H8CUPxO0kUsQtIK58QfMc8KHppEl5V+FJAiYSvgLNE4mwxkaQ
 uVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935949; x=1692540749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+dm6ERbWnDuZOwPqGLPqR4XT6w3jbBV5vVVArlyMxbM=;
 b=VDX5thX3jI49tT52dWLIB2D8x1HX3hvxETx0ZhueKBK6p96SyRbzz7My1QYw/epyUM
 zHVXDHQoPUmifqD3CRHgcL/kbBFx6BTbos3/vnjjtFHfztB119+m9aGs/9tTPhqI+4tD
 vd8h1zZ+eNBfpLxCbOztgBc2DcMiljFOP8uxmYtbCoZvFyALe6yH9su/L8vps5gRifOg
 BRf/D/NhN4vggUexuzGeIuzz/FCfbJNtjrAwJ76pN5xFfpxdVEW1fF/DFYtcoKWKTQfC
 pbY+Py+bClN7Ej9PszwvhIDwj+JDKjEAEQOPXHfru2Yi1mrPSvTX7m/XaRtpbdzyTWrl
 di9g==
X-Gm-Message-State: AOJu0YyR5EFu71DrP02NpbURCZ9e/XwYJtwLZ1h3j987RHz2+GBQX3PT
 bNHuQly0OXZ4LQlIV7WRhGwnNQ/hrAU=
X-Google-Smtp-Source: AGHT+IFjY0DTqC+I6G7w5oCRz1+PHgJUZrpdXeim2Fgyf5PUqf2aegdUtbrEpxOxVtj43mdvj8Ejnw==
X-Received: by 2002:adf:f04f:0:b0:314:3bd7:6a0c with SMTP id
 t15-20020adff04f000000b003143bd76a0cmr5155058wro.33.1691935949120; 
 Sun, 13 Aug 2023 07:12:29 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:28 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 17/32] Implement stat related syscalls
Date: Sun, 13 Aug 2023 05:09:58 +0200
Message-Id: <20230813031013.1743-18-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x433.google.com
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



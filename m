Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B12CC7A3DFC
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:43:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUr-0004ei-MU; Sun, 17 Sep 2023 17:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUi-0004cB-Ri
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:56 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUg-0004JO-RP
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:56 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4050bd2e33aso2274995e9.2
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986793; x=1695591593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SrhHSKh9Zy1jpJox1NZgc4ABlNUS27qhkUc+VlL02Mc=;
 b=JcT+dm04B2yUYJr6ztrnVU/2TExgFRg96IfUojtr6ebAWDH8RbAY82aj6lFMcVYqa2
 Meh3Stz1NFdU1/aYV4O+bIExtUIoE2xD0GgxRaSY+F9WPTW9DshLACXmJTzA35P9RKyc
 zOwgOOQXb+TVjaaotZJqu8yq6dNjTgJXBSBcmVpE02aAM2sO/MWHlyWoS4+2ccJqdVrS
 xSVd8igiQWDDjrkoB/d7Ym/9v7X0rcGjgA3TioUsT7LKt8q5ucmWr2IrRAjAd5qHSxEN
 AJtpEBU2ZcJMClQpuTKu/ZTphI146gFuJzGV3/Qnnzb2nkJQGBkXphKkMV6LdxX2P0kO
 hbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986793; x=1695591593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SrhHSKh9Zy1jpJox1NZgc4ABlNUS27qhkUc+VlL02Mc=;
 b=XM5Qvd9gBKk0P/WlqQDQk+6Q2KD008N7rGzSpEdvCNpbuPv1/HeWJz0Vt48IKSTZdK
 uv1qCSghj9iqPcxyNP4vNdfb64xB5MOkZW6MA16G1KNc8Rg/YMGnxnKpw9kP6xhvIFL8
 Fua04tptXRPZ9ry9+EAYUfIPGC6t/TwWFn8hwgLxhp60T5bqsNpoiLimilG/Ys5Yt3CQ
 e8fmxg30DTN4WUNViXSlhrfCQSUv21ODdeL31zXiu7lZ1F/PtLfh5zaGfdr7NjiRdFti
 MvOWSqSEmugoE0u00h+2swVOS9PMLwANyPYJ5gBv7RQgWM+7yVdY6YH1gaQ8iblfpg/J
 UsFQ==
X-Gm-Message-State: AOJu0YwtZ2JBViwhTcvJCs7GzgYaVl6tTSjnGD4GsvzDS5W4EPc3sxcZ
 2MLQeeZVd74me82Crg7NxOvsqrlWAnY=
X-Google-Smtp-Source: AGHT+IHCsLWO9Oom+NsaebJNx7WjKd0SvEIYLbPK6JIbYDwt+RVzgp5S5SXq8TSfSblSAY9YoWw08Q==
X-Received: by 2002:a7b:c38c:0:b0:3fe:785:abf9 with SMTP id
 s12-20020a7bc38c000000b003fe0785abf9mr6698691wmj.2.1694986793210; 
 Sun, 17 Sep 2023 14:39:53 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:52 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Karim Taha <kariem.taha2.7@gmail.com>, Stacey Son <sson@FreeBSD.org>
Subject: [PATCH v2 22/28] bsd-user: Implement execve(2) and fexecve(2) system
 calls.
Date: Mon, 18 Sep 2023 00:37:57 +0300
Message-ID: <20230917213803.20683-23-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-proc.h    | 49 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 11 +++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 bsd-user/freebsd/os-proc.h

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
new file mode 100644
index 0000000000..75ed39f8dd
--- /dev/null
+++ b/bsd-user/freebsd/os-proc.h
@@ -0,0 +1,49 @@
+/*
+ *  process related system call shims and definitions
+ *
+ *  Copyright (c) 2013-14 Stacey D. Son
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
+#ifndef BSD_USER_FREEBSD_OS_PROC_H
+#define BSD_USER_FREEBSD_OS_PROC_H
+
+#include <sys/param.h>
+#include <sys/procctl.h>
+#include <sys/signal.h>
+#include <sys/types.h>
+#include <sys/procdesc.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "target_arch_cpu.h"
+
+/* execve(2) */
+static inline abi_long do_freebsd_execve(abi_ulong path_or_fd, abi_ulong argp,
+        abi_ulong envp)
+{
+
+    return freebsd_exec_common(path_or_fd, argp, envp, 0);
+}
+
+/* fexecve(2) */
+static inline abi_long do_freebsd_fexecve(abi_ulong path_or_fd, abi_ulong argp,
+        abi_ulong envp)
+{
+
+    return freebsd_exec_common(path_or_fd, argp, envp, 1);
+}
+
+#endif /* BSD_USER_FREEBSD_OS_PROC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index b7bd0b92a6..515eaaf31f 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -36,8 +36,9 @@
 #include "bsd-file.h"
 #include "bsd-proc.h"
 
-/* *BSD dependent syscall shims */
+/* BSD dependent syscall shims */
 #include "os-stat.h"
+#include "os-proc.h"
 
 /* I/O */
 safe_syscall3(int, open, const char *, path, int, flags, mode_t, mode);
@@ -219,6 +220,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         /*
          * process system calls
          */
+    case TARGET_FREEBSD_NR_execve: /* execve(2) */
+        ret = do_freebsd_execve(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_fexecve: /* fexecve(2) */
+        ret = do_freebsd_fexecve(arg1, arg2, arg3);
+        break;
+
     case TARGET_FREEBSD_NR_exit: /* exit(2) */
         ret = do_bsd_exit(cpu_env, arg1);
         break;
-- 
2.42.0



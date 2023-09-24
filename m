Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFB17ACE4C
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:39:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbT5-0003cr-Bo; Sun, 24 Sep 2023 22:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbT3-0003bN-2w
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:37:01 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbT1-00008x-Bn
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:37:00 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31f7638be6eso5266741f8f.3
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609418; x=1696214218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vvWAJOaU9svMDhrs7MJr+20FyL1xi564pnSJRDac5w=;
 b=EoLs/QxyGt6ZpXa2b8noeXiO8n6hWBZnqVdqQNskjcjF8GsvECEsJWJno2e5faJ42K
 aoUMSF7h9J+GSWSzizM/C9YZDlmTLxaTMOgs4zlMNn4R/v24a0ovnVEhQunRW+uP063d
 O7WnwHwbZiwf24XWMO3pihiljlYOfDJ2VwZDtWSJpwkBXB9Dz6hhXwT6zcAO2zriLAP8
 r8CoP/lkPPiehABl/pHAqRmQ1GQRZHZEWbM5uc2vFRoN1OniXIp2jXM3MZovZ9bEJMWX
 1AgoEWJ29UXeysj0X0ct0eGRykNNv1Y/CGS+3WsCJoSK79cIKnMgmXfoDbJaEPBV0SYD
 6Btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609418; x=1696214218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3vvWAJOaU9svMDhrs7MJr+20FyL1xi564pnSJRDac5w=;
 b=gzbruqq9UzhWWKzU5lQRc10OaZo+FHFLME+ry2A6qbAXYQnrrTe9SCBWpnpdf0umPf
 P11uFJ6AmWJTpQiqEqF5axyiSCyUExsmVMP9vMYmL5lKud+KGlkYUymw7XwlkXZQUGZq
 JUammkQMo6b8g3Sf1lNJVm1LbkWxVT1sUQM2VlGzFKcDi71a0E7BXpKfZ9tv2zJGtLgA
 vDK8EiiPmbI/S1ZCVE0iopIFgsSYrDAmje/ynGyg7yQUxlT/apMKGI6wAtrRVtVzwTE9
 VcbqmyZoaQSqGJ3hWiGazO3KKGg12GpG+kO2zSZoEO/O15ReAZZ5n4n1+NmCqDp6APKi
 8NiQ==
X-Gm-Message-State: AOJu0Yz4UKnFA97fM+Eco2NCth62WwfjZD6RYyBlAG14VtbaRUhH1NL6
 vOZE2KghbKtt2sOqtBIcFhB9L1+lmvY=
X-Google-Smtp-Source: AGHT+IF/VivasxlEUN73XZHm1KKhmKJk6a5xDSxNbtFiYqb3SiTzEHOc7E7OiqX1swkVCEE+WmYBgA==
X-Received: by 2002:adf:feca:0:b0:320:4cf:5b50 with SMTP id
 q10-20020adffeca000000b0032004cf5b50mr5171013wrs.5.1695609417653; 
 Sun, 24 Sep 2023 19:36:57 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:57 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Karim Taha <kariem.taha2.7@gmail.com>,
 Stacey Son <sson@FreeBSD.org>
Subject: [PATCH v4 22/28] bsd-user: Implement execve(2) and fexecve(2) system
 calls.
Date: Mon, 25 Sep 2023 00:01:30 +0300
Message-ID: <20230924210136.11966-23-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
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



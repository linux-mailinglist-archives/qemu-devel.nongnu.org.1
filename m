Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7247778B942
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:12:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiaW-0005y4-BB; Mon, 28 Aug 2023 16:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiaG-0005i6-Cv
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:11:37 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiaB-0007pN-Vp
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:11:36 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b9f0b7af65so53943021fa.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253490; x=1693858290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bEN8JiRMi42PBjG91cv3MvhEwJ8nLtmK3KuWnVz9XHY=;
 b=qOwH4hmf95pSL5weELYzdHWc35ZgKJNJqh+y5s+ighgBMRxHRG+kcoXFhfY7Soxeq5
 7YJRT2B4j1NVh1GoWYLDJTmtj+FBkaYVahVkif9XVGCQEhDynUmvgH1OYniHcxQv9WdO
 k18jHfJ7DNYwqlmRD4AyC09cZT8a7Ih7k0fJpWXNvUKVJG5zvGbKJB8P7ygUAZ3xgSye
 Jsqxbsih8W4PGt0mU/7QKKDdSOsjBqktYKXv3L/9RWZU/2r2o8IROdnqx55Maa78D/xG
 jgLQywBWrycNm+kxrxueqy1SnQxMX/QfWPVDO2sGnKNUHA/1gW4dueOFhm6MGxdR1J5w
 hXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253490; x=1693858290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bEN8JiRMi42PBjG91cv3MvhEwJ8nLtmK3KuWnVz9XHY=;
 b=eKqIsMmBNo3zHZJ5fbfL3ohcNJPDziKtCYmbE6jNpkgKyNWITCp4WdOT+5OO4UCzuy
 rPsqnkIQ81O/4HnylRgr7erb88hJytTamKKvLFOz6ZMzduonSc49yNrjD/A1/ha9uga3
 xuyX/xMwx8nSgpXJup+vsyqWkddWA7+VNMUyI/xPiO5xzXy2KbczBgn4znwT5dFwoItz
 sfOfLJKdCPuGQwwWAYumvQWhnsLJyxl7gpXlKEL273KFqxbOU4oXgquBiFkz0x8Z6Sde
 b2Ai7gfqRZ9pGHT6APi+LIdrA4nmkujj6EACTN8/jNfOJHIF5k2sZmlV3O3IvRxpJpRB
 uYoQ==
X-Gm-Message-State: AOJu0YyWlzGOo/Yzcgqd+VFgwvDD484KqsmxMmAQDzU0XGqoUVq3FDUf
 68xYpK4JgY+0SjmzXJwe58BO3/wN/8q2AQ==
X-Google-Smtp-Source: AGHT+IENsScygEyWx6g7u6/CN8rdSs+9SOeX21jBFbVqTlxZ0DGbJH8W35cr6mur/MsMNfdX8nsU+Q==
X-Received: by 2002:a05:651c:96:b0:2bc:c557:848a with SMTP id
 22-20020a05651c009600b002bcc557848amr14529880ljq.50.1693253489671; 
 Mon, 28 Aug 2023 13:11:29 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:11:29 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 26/32] bsd-user: Implement execve(2) and fexecve(2) system
 calls.
Date: Sun, 27 Aug 2023 17:57:40 +0200
Message-Id: <20230827155746.84781-27-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-proc.h    | 49 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 10 +++++++
 2 files changed, 59 insertions(+)
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
index 43f4561301..3f3ca96752 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -36,6 +36,8 @@
 #include "bsd-file.h"
 #include "bsd-proc.h"
 
+#include "os-proc.h"
+
 /* I/O */
 safe_syscall3(int, open, const char *, path, int, flags, mode_t, mode);
 safe_syscall4(int, openat, int, fd, const char *, path, int, flags, mode_t,
@@ -216,6 +218,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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
2.40.0



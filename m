Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B527A3E84
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:27:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0C0-0006dP-TX; Sun, 17 Sep 2023 18:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bz-0006cw-C4
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:39 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bx-0002xp-GT
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:39 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31ff1f3cde5so2480310f8f.2
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989475; x=1695594275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SrhHSKh9Zy1jpJox1NZgc4ABlNUS27qhkUc+VlL02Mc=;
 b=RLpqYpEn/HBJRyU0bO8PBrjJEGiK3uDHlN6n5ebXnRWItv4Ujsv53cFqbZU/HhBC6r
 LNLhKFDFo1FSIKN/8FmfnKRoQpO79n4TRa0tDqeT7a0Z36aUxwLlN4BSkFUN6n6SiWBf
 yHDmrnsxrsWrEIGSeASOZwC7HVf8scC3wY7Kd/SVgWQSOOBg5T9YOYiiCNCG1oGcww1U
 SIKC2iP1S2Al64dxVsotw9MbtAEiOunazFDG4ZE8sbBmHC9QGdRHWL3Rhw0gTZVnzqAp
 RPzvzXKo7YPCyaz/fA3F2rPkkbbpgaIFbSi27vgKs97ay+WBBnRXSiPFixKpEkDGq7I4
 U1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989475; x=1695594275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SrhHSKh9Zy1jpJox1NZgc4ABlNUS27qhkUc+VlL02Mc=;
 b=bCTx7VwETVcyG5PNJfoDo6CpSseoWEaq/2z0PeoGQvhPAdvX4RA3xMWAqKqaalgs4t
 eAxXHNmuyXG0sJ3LW3U4hzXHOw+8f4p/KKgiXlKtmAXtw3dG6xA77NnH8yB6hjd8E3f5
 CGTvmrik0F45G45KPm0L53D08YC+6d5Lu0GSm5Csu5hVImWMJmWZrChhf+VWFSGfoA09
 igKVf6qK8HFjG5iXRZs4S2GfEeuW3/iAv1n2SisYaqRC2U8bgZKUE0n+00FHOE1X50nZ
 OYLqUcSxria9/xXEwVTgcKZDOmnph1T4ynccwpM8B0HoJSA2oH/phrT5ayJkCTOcfJjm
 eN3Q==
X-Gm-Message-State: AOJu0YzzpkRhYm1QmVIb5/811I7b/RkuZLRxg6B90cWcMxgOejQVVcoO
 dBG1lD3TqH4QvqQcltyAiHT+vwqQnKk=
X-Google-Smtp-Source: AGHT+IEDYTZbR4c66IHuyPCZtQWE47fsIjDkk9vqNZ/J5yJa/xFLztR8WkCRmNKWMOfTSj61yI08Pg==
X-Received: by 2002:a5d:69d0:0:b0:31a:d9bc:47aa with SMTP id
 s16-20020a5d69d0000000b0031ad9bc47aamr6772815wrw.67.1694989474799; 
 Sun, 17 Sep 2023 15:24:34 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:34 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Karim Taha <kariem.taha2.7@gmail.com>, Stacey Son <sson@FreeBSD.org>
Subject: [PATCH v3 22/28] bsd-user: Implement execve(2) and fexecve(2) system
 calls.
Date: Mon, 18 Sep 2023 01:22:39 +0300
Message-ID: <20230917222246.1921-23-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x432.google.com
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



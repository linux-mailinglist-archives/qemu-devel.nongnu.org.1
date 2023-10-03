Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CC47B7563
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:44:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovT-0004DN-V3; Tue, 03 Oct 2023 19:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovN-0004AZ-PR
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:33 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovI-00077q-CZ
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:33 -0400
Received: by mail-io1-xd41.google.com with SMTP id
 ca18e2360f4ac-79fa7e33573so58985339f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376127; x=1696980927;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khpHNEzdfaCxbzIOhGKqgUaYTgRrgL4oE446jB+w2fk=;
 b=jEHKqPNNid6cj37tjHV71FKm/wBiTNCwcgi1EDvdqJEmdeyjkU8Vn7eX+cGSCjM/dz
 wMMU+rQvqPe3S3z/SGHLZwQuIeqU0XSZkdOnsar77bubHLxEOxF9a5ftACE92tIhbMno
 tP6CkDbfUUO2KL5b4fbXa3bJ3y0j/gmofqBr1m6olVGzBcQ0/aXhm3GoCTLLmGX/lZnv
 GyV0YhQ7spuCCndnm3DRs8yzS0Syn1/jFFKPArajVc4yYMj1iK0kL3LxGWWBeepZsFwW
 8BwKWLNrlpFfsJ5E8DLypu6atW9Qtu3SEzfoFiXEcPssfhHHNELFfhlmOM6KoPSIq9Qf
 d7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376127; x=1696980927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=khpHNEzdfaCxbzIOhGKqgUaYTgRrgL4oE446jB+w2fk=;
 b=gKGpWcEEYoj4ZYkOG19v98ShWUE4fk0Wf2rKPJ+f/gXO25Rr+PnzUONrlyLc0tNT8o
 ekJokhm851R8TAeJhQQAaD2XzG+g+odfvznFp1J05TXZwrLsPQxibfyTy/5x/3oRp/q+
 1Cv65Flxrq63W8BbnCbCVzIQtMaO+sxQJQXbw3FHfXObk9tFGFeYbqrARmXHytCYgjU/
 1F6q7UXCOqW9vK4S9CN6sm2lNCw9VykjAf6sRc+N7Yf2HbA1tJRRwgP64fCbPLVF9Ry/
 UYHq/WBg8yH6rwxfcg6H2u2d8ovyEtnB5ebYpaCJquSFrRrfED4ri/y/KnNrP0TH+WzW
 1QzQ==
X-Gm-Message-State: AOJu0YzaGpg9r315Lb/grWkRqiB5gdfc9kAyngsr7PeNCHiPqH/mmOAc
 /8v16c8AVO/YsEQz12dZ2tKFjR3YrJSweprMbjD95WqQ
X-Google-Smtp-Source: AGHT+IEPv+LwyuqopHtCwJPkJmaoe6ylMiGdwKP7pV7r3B7QYlLzRXCazGXaRgnZ+XsSe231hKzOsA==
X-Received: by 2002:a5e:dd0d:0:b0:786:7100:72de with SMTP id
 t13-20020a5edd0d000000b00786710072demr895056iop.16.1696376127036; 
 Tue, 03 Oct 2023 16:35:27 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:26 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Stacey Son <sson@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 22/51] bsd-user: Implement execve(2) and fexecve(2) system
 calls.
Date: Tue,  3 Oct 2023 17:31:46 -0600
Message-ID: <20231003233215.95557-23-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d41;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd41.google.com
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

From: Karim Taha <kariem.taha2.7@gmail.com>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182425.3163-23-kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-proc.h    | 49 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 11 +++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 bsd-user/freebsd/os-proc.h

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
new file mode 100644
index 00000000000..75ed39f8ddd
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
index b7bd0b92a65..515eaaf31f1 100644
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
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FFD7B7560
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:44:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovL-00049W-L5; Tue, 03 Oct 2023 19:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovJ-00048T-UD
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:29 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovI-00071Q-4Z
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:29 -0400
Received: by mail-io1-xd41.google.com with SMTP id
 ca18e2360f4ac-79f915e5b47so59904339f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376124; x=1696980924;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vv+aIku3DmAqisUQxx9HbMj8tI0pAJwZVGFoGM6lqnw=;
 b=kokjwctmR6dOZXx8mqR/7KOyarl6r7QTq5FaSo6N9kkW+CzVtjqd7LjVAsW11xLePW
 Mi+6X9kdkMLWt7FmLCsAJRaNEWf9bqgS6x5O3pEFuXt2tbAjYDIUhcKaScaZzyuVJ7yo
 Ms6XPwLl1/2g0n9GpBgihIL6wvodm4ore9L8QXln0SphV2EhACCBXbNK3yRbB3/JjH0H
 hGfRPRwI2UNODPd4yNMwPYjhRjdUG+l86zPqjz+rmtBDdlTBPmMIrEVxMNm3okq3BrRg
 J9eJ2sogXFEUlkL49Pp+ai21oUxk9aGduWI9Te8NppKLW/gbYFyaNLs1zt5BPnp0iBo3
 ZkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376124; x=1696980924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vv+aIku3DmAqisUQxx9HbMj8tI0pAJwZVGFoGM6lqnw=;
 b=C1zdKnyHieWmca/LwzSlJELQR3r/9g4q40UhbImWMV6cmGFHoB2mS+EKsKdUQxxmMu
 1mbqhw+WgLdQVFt6Pf4WVWuJbqr2essTixXP5JPsBGEkSJLmTVAS2PJzMbyWgxV0GJAh
 b8aXTNAM3c1AY2wjFLm133oQyUsHnL1huUPr4WZ0ea+irx8fBe/pZQ49U/glnkjg/zQn
 AB8ttyZpMK0dyKRbrh9vkdNPnnSYDP/eWcSKMAiN9b7Zl+1ZUjt4jrlB6a0Rx7YOZtWr
 GUZQAJk0leoiFBnJ8GMCgaFQT5DE72qLdwgWxa6slLFBWG5+03pg7eKzeOO9K/3TsB99
 kHWA==
X-Gm-Message-State: AOJu0YwPGz4ky4bixA9Q4wpoZyOWI76Pc/vdmgWIIDrZY8Sj1aHpdKxn
 cUWuwc+omUSwVTiLh1DqvjQ0IJK3W/QsTH01wygelhpZ
X-Google-Smtp-Source: AGHT+IFw4OoDwo4flJGVdNrfgTtXrScqPpMtqyLxdUBmxMbcaRVLolhNc8uhX597cfLvsI7THGuRbg==
X-Received: by 2002:a5d:9943:0:b0:79f:9eb4:3ea1 with SMTP id
 v3-20020a5d9943000000b0079f9eb43ea1mr1019417ios.3.1696376124287; 
 Tue, 03 Oct 2023 16:35:24 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:23 -0700 (PDT)
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
Subject: [PULL 19/51] bsd-user: Implement get_filename_from_fd.
Date: Tue,  3 Oct 2023 17:31:43 -0600
Message-ID: <20231003233215.95557-20-imp@bsdimp.com>
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
Message-Id: <20230925182425.3163-20-kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/meson.build |  1 +
 bsd-user/freebsd/os-proc.c   | 82 ++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 bsd-user/freebsd/os-proc.c

diff --git a/bsd-user/freebsd/meson.build b/bsd-user/freebsd/meson.build
index f2f047cca31..8fd6c7cfb82 100644
--- a/bsd-user/freebsd/meson.build
+++ b/bsd-user/freebsd/meson.build
@@ -1,5 +1,6 @@
 bsd_user_ss.add(files(
   'os-stat.c',
+  'os-proc.c',
   'os-sys.c',
   'os-syscall.c',
 ))
diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
new file mode 100644
index 00000000000..2603c5c6538
--- /dev/null
+++ b/bsd-user/freebsd/os-proc.c
@@ -0,0 +1,82 @@
+/*
+ *  FreeBSD process related emulation code
+ *
+ *  Copyright (c) 2013-15 Stacey D. Son
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
+#include "qemu/osdep.h"
+
+#include <sys/param.h>
+#include <sys/queue.h>
+#include <sys/sysctl.h>
+struct kinfo_proc;
+#include <libprocstat.h>
+
+#include "qemu.h"
+
+/*
+ * Get the filename for the given file descriptor.
+ * Note that this may return NULL (fail) if no longer cached in the kernel.
+ */
+char *
+get_filename_from_fd(pid_t pid, int fd, char *filename, size_t len);
+char *
+get_filename_from_fd(pid_t pid, int fd, char *filename, size_t len)
+{
+    char *ret = NULL;
+    unsigned int cnt;
+    struct procstat *procstat = NULL;
+    struct kinfo_proc *kp = NULL;
+    struct filestat_list *head = NULL;
+    struct filestat *fst;
+
+    procstat = procstat_open_sysctl();
+    if (procstat == NULL) {
+        goto out;
+    }
+
+    kp = procstat_getprocs(procstat, KERN_PROC_PID, pid, &cnt);
+    if (kp == NULL) {
+        goto out;
+    }
+
+    head = procstat_getfiles(procstat, kp, 0);
+    if (head == NULL) {
+        goto out;
+    }
+
+    STAILQ_FOREACH(fst, head, next) {
+        if (fd == fst->fs_fd) {
+            if (fst->fs_path != NULL) {
+                (void)strlcpy(filename, fst->fs_path, len);
+                ret = filename;
+            }
+            break;
+        }
+    }
+
+out:
+    if (head != NULL) {
+        procstat_freefiles(procstat, head);
+    }
+    if (kp != NULL) {
+        procstat_freeprocs(procstat, kp);
+    }
+    if (procstat != NULL) {
+        procstat_close(procstat);
+    }
+    return ret;
+}
+
-- 
2.41.0



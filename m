Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3987A3DF8
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:42:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUn-0004cO-Ge; Sun, 17 Sep 2023 17:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUf-0004ar-6i
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:54 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUd-0004It-Gd
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:52 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31c65820134so3426157f8f.1
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986790; x=1695591590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=si5dpHlVizbBUEmC1yaur7aiNcqM1wSFje2BFdDGY6c=;
 b=hPGZBvlMu9a4taknKvqqSzYVzRmqSX7UYEUVoz4TigItkilL9z0YhiG7xIyrG1pBZP
 ySjmR00TqaCS/5faSgVF/dgaim97TQ8w5hHj6XFr115ogfd3gNFqRIXh4jTQcxti7Aw6
 g0MVjGtmxLN39jjOHyo5TxyKvc6npiAE5vU8fqGYngKBEjQe2Ij8v1Yrch28vawfgBNQ
 PCU4FGoiJ7PEqnIzCnNve6nZFkLfwxTLsJiZEXiRLxU/fefOQ/jMlQK64mDH1U87Jl/y
 qEceXsEVKyLN5BHN8v+3ZQS4P93gDYOcWGHTiJRwpc2O2G9cDLowQYpTLMOU0u5g6QQi
 E5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986790; x=1695591590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=si5dpHlVizbBUEmC1yaur7aiNcqM1wSFje2BFdDGY6c=;
 b=VuK0Yt/mIzNWTZ1kryfJ80TGaroUjICOonvvorPlAZ3P+fbcWwMP9odAHcjnyU8NrJ
 orK2uaKYxpEn038SdUfvrX9UuFYXu5RJ7SSASkOVnOI6LQbIyYPtXESTymszqvQjbVPu
 rM9GO9qbe0JlYAmb2Pf5HJALrxOkNtLYZY3WfATdCQKOpo3UyLxGCY+dBwxHs3USPVEY
 LntnhhuMYh/kTmlfQFv5Z9fnP+SZGxxOwOW849t5inUAHI1t8KCzMIMfZH/grDg6f5ra
 TWGXmVeJ72qlqoF5XFkrtolq+pXh/B6eBeBOV29OF5Ys4HAnwUIQ0vfNcFyZlCOo2l5F
 Hrcw==
X-Gm-Message-State: AOJu0Yzs09VmNWNYUYHAwEsQQGdruh+U1tarsUhB6HUmsaGI+J9JWVQH
 SMz5MVS/p0qC8jxPt0u5YtI41NoT0BI=
X-Google-Smtp-Source: AGHT+IGHeknOgZkr+GGEY/Unc01du6fnSnjPuRBC/KVAxW8xPV+Zl6fwhjtnaCoZU5XCqEzrqrMmKw==
X-Received: by 2002:a5d:69c2:0:b0:319:8bb3:ab83 with SMTP id
 s2-20020a5d69c2000000b003198bb3ab83mr5537151wrw.66.1694986789711; 
 Sun, 17 Sep 2023 14:39:49 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:49 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Karim Taha <kariem.taha2.7@gmail.com>, Stacey Son <sson@FreeBSD.org>
Subject: [PATCH v2 19/28] bsd-user: Implement get_filename_from_fd.
Date: Mon, 18 Sep 2023 00:37:54 +0300
Message-ID: <20230917213803.20683-20-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42e.google.com
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
 bsd-user/freebsd/meson.build |  1 +
 bsd-user/freebsd/os-proc.c   | 80 ++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100644 bsd-user/freebsd/os-proc.c

diff --git a/bsd-user/freebsd/meson.build b/bsd-user/freebsd/meson.build
index f2f047cca3..8fd6c7cfb8 100644
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
index 0000000000..cb35f29f10
--- /dev/null
+++ b/bsd-user/freebsd/os-proc.c
@@ -0,0 +1,80 @@
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
+static char *
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
2.42.0



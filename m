Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C34B78B92D
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:11:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiZT-0001O2-Qh; Mon, 28 Aug 2023 16:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZR-0001Aq-Ft
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:45 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZO-0007l7-7Q
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:45 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52a250aa012so4855851a12.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253440; x=1693858240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7UpKos6Sxr5kN6Czip5qxzC0d38rC3L1LguZr4TDVG0=;
 b=niCss6crqHs9OgaM/o6ByjbfbEebIepthFawHXfDzbD8pIJupCi3FJZ+bdwk+nsMHD
 qEQ1ek3rEjoWZaT7Y8rRb1PplamFZ4d5KEkEOMEFy/yaR8KuBzjdG1PPAoRoG7apoAvF
 wZvlTWH13cUvMbl+zqnpuzH1fxNhhtMNR+Vb19GP3SdZ6fU+mDYSTwwZ4K3+22kGkj4p
 BqvW93XfHH6pih/WKphGhlNxsS9K+d9CvTRbAKPROq7lUEpOAb2eRgKqMbtll7cls2/8
 f9EhvmQM55BQGIlLEVO2Y86S4AS0MduZl3AnuQQYKNxeEm94b29XnqKVdr7e2wYrG0pM
 gJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253440; x=1693858240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7UpKos6Sxr5kN6Czip5qxzC0d38rC3L1LguZr4TDVG0=;
 b=KJ1PSegpTBEH1AAF4oRoC3MGqQ7VHc/tqsGNqz0v9WteOjF671mbpB1fA3k3IduH9f
 gFeuuH2LUn88DT828RzrvIJlAKOPb7fZU9ycnSba9FV+N0jDCOrHEYkn8ezd6fdGDZoe
 opuboUZ04KwmCyvr7DO16GWSe+vgu2ZXyWuumBLmOu8WJKRR/tzzSP3kcny5pLhblc17
 HN9kgWz1njv6jmkOnYlL7QY1KB/BU2TfYDrdCjDwaZF/vn1fRSmA0cuL6jVwnr48KX9q
 0jbcIU91qH4SXGOvI3WlTldLImYVnEM1wJN12Bziv1CMljApTwwgF8BGPwOPBoJ2Ltgo
 XKeg==
X-Gm-Message-State: AOJu0Yyn062YNkG3v/j7DQIxgaaWzUKm+jzrf+WX/ncP7Dig+ja9sQOf
 +Mb43WmMeOTt3eHw2dDj2uJbERPhI2q4qQ==
X-Google-Smtp-Source: AGHT+IEVrGP9lXyNk9HrkvNLUrc1iPKQCZe6zxuK2Ui71VPx3/lb3OCiW4fHZrPIK5MS868z5Vshfw==
X-Received: by 2002:a17:907:a07a:b0:9a1:bd82:de30 with SMTP id
 ia26-20020a170907a07a00b009a1bd82de30mr13046240ejc.2.1693253440010; 
 Mon, 28 Aug 2023 13:10:40 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:10:39 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 21/32] bsd-user: Implement get_filename_from_fd.
Date: Sun, 27 Aug 2023 17:57:35 +0200
Message-Id: <20230827155746.84781-22-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-ed1-x52b.google.com
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
 bsd-user/freebsd/os-proc.c | 74 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 bsd-user/freebsd/os-proc.c

diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
new file mode 100644
index 0000000000..5cd800e607
--- /dev/null
+++ b/bsd-user/freebsd/os-proc.c
@@ -0,0 +1,74 @@
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
+    if (procstat == NULL)
+        goto out;
+
+    kp = procstat_getprocs(procstat, KERN_PROC_PID, pid, &cnt);
+    if (kp == NULL)
+        goto out;
+
+    head = procstat_getfiles(procstat, kp, 0);
+    if (head == NULL)
+        goto out;
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
+    if (head != NULL)
+        procstat_freefiles(procstat, head);
+    if (kp != NULL)
+        procstat_freeprocs(procstat, kp);
+    if (procstat != NULL)
+        procstat_close(procstat);
+    return ret;
+}
+
-- 
2.40.0



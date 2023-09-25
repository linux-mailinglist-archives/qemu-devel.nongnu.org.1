Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 458DC7ADEAC
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:27:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHp-0001MR-Ba; Mon, 25 Sep 2023 14:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHm-0001Lz-Gd
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:22 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHi-0007Q6-8j
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:22 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-405621baba7so41375905e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666376; x=1696271176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TztszCQiHOclcaF2WsULwVYzhpKz4VJgE5PYB7dlSh4=;
 b=PoEH5hAXNPMdreso3L8IwdGeT1ipZaKe+hQyAz8PPn2RP+GtJpPqnITrSPdrXRzUwk
 pvzC6/Kcw/Tec3EiDqQRSyjNvQPYqh5KVrdz6B+f9gblAOCs7bRIzeS5ZfhzuyE3lDoY
 k7HuGEE/Ko0Tc/ggFwdZlvehhhXlNQX0rkoAj9gHJ7s1wTRBCEYP4eJZjUKL8J9BT8+2
 +K4wmQpkf+g9bA5v+E+Im2/kweSxP8oXvNxpkBE1H2zANxOFAGJm81d5HmHAvCmnTN4j
 vRG1aMoqe1H00BFRqJxDfPhcfk8Dyj9UlmCQeBWDXB9ESFPPz3PBQQms8djh0saJI4py
 WSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666376; x=1696271176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TztszCQiHOclcaF2WsULwVYzhpKz4VJgE5PYB7dlSh4=;
 b=WZfMRc+kxrXd1HNewx4mk6swy4MuW6DHajbYsvSo0Rn02dzxcm65oFnurpUjs9HxId
 tBsrL9oZ3tUwQAFbzqd/Jlactvd8z9PceSr5tj5gK5/zyAeNZALHA7sCGb4COZkCLawg
 qxAA1Muapdq1c7Gtvjl+jG6OXAQJPenWAisrXH0PLf4phph2RVZij0b+USCEJo2/NWlY
 mi89P5yCyejBeaay1ZMwCAVyWC5g/6FW1pvHiLZocUOiYYdi5A0bG2fghZLJjIQFSfy+
 FLI03j76NFTQbMWebRvBGLn4k92hhtXCOUlxD5qDVZChtwQ3rudbo+xX8SY5YWdCMOKn
 Ecig==
X-Gm-Message-State: AOJu0Yx5GN3cbR3i7F99ruali7YZlGscF3hc0vScRrO6qVXSBWFBwfzw
 BBpwT3f8JXaQfofimTB9am3bQg1MVvw=
X-Google-Smtp-Source: AGHT+IGMLFyMeRt/bN5gIpIlO3/hRpIwDcF1U89Tju3GHhtSjBJF86KSrld7MOUnro78phOcKO5Vow==
X-Received: by 2002:a05:600c:2254:b0:401:d947:c8a9 with SMTP id
 a20-20020a05600c225400b00401d947c8a9mr6985891wmm.19.1695666375218; 
 Mon, 25 Sep 2023 11:26:15 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:26:14 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Karim Taha <kariem.taha2.7@gmail.com>, Stacey Son <sson@FreeBSD.org>
Subject: [PATCH v5 19/28] bsd-user: Implement get_filename_from_fd.
Date: Mon, 25 Sep 2023 21:24:16 +0300
Message-ID: <20230925182425.3163-20-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32c.google.com
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
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



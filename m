Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE29C7ACE45
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:38:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbT1-0003ZY-Ex; Sun, 24 Sep 2023 22:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSz-0003Y7-3D
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:57 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSx-000083-6t
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:56 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3232be274a0so212637f8f.1
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609413; x=1696214213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TztszCQiHOclcaF2WsULwVYzhpKz4VJgE5PYB7dlSh4=;
 b=m7JB1IhAPdMEp1HkD6OVBLBe3mjZd5zq2De+shiCNMPNeygDIASFwrLSbUYucRFMBt
 wd8I+NWv6OkaJk4U0rjgkyPX1XMbPl4kkw9qRWXoL0gsU62WF2VODvmxBO2nxvTdOrsu
 MrLRn7uHUtY7AB2wYCTcIlKt8KaO74/MaESrLdTFxkkftiugNIoi0kGFjKdDNJekvBjh
 G3xFmh+QCGhSupsR8DLf8TbaEMncsZY5epy9QLP8pirNSskTxQpGox3TFK1mgZ2SjVr3
 jcQVsUJkPxaSdq9h+2cmBC2W53XETRsBBZvMc86D50g23/sktsrs8lIYdFc/mrgr1KoG
 neOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609413; x=1696214213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TztszCQiHOclcaF2WsULwVYzhpKz4VJgE5PYB7dlSh4=;
 b=bxBuyhUg/qCY9F1vgfW90Mclikermno4a+MJ1OcqxsK1JbKc6QBYfqtNi1vS/7ZVQ6
 1w7mNgFYYPOQT9xWBp60m16wl7x8opWHM05jQ7nsqqQshYfUKv8PJlyS9Ph5VPLVlY0W
 j76yXztDWLvTKj1bACss6yKUASGtsGN8gJUIr62AkblVWL6H0AMZh1zvMuPrP3/b6tkz
 6UzlI1TEm2Md0TKgFiefWoTg7iGzWRf/NKqdT/6bNw0f1aNesqeGKFVGarwAGRHMtV7W
 3NU5UOxPJFimBB2etACEbuJPxVvlMz7KxJRPTWMUI3oaewLqvV9cbfpYNl3PzPodl23d
 WZgg==
X-Gm-Message-State: AOJu0YzFh8iSxeVlBsojx1pIZEtYWrlbEdkwh14YBiTWopXwvyw1LIVd
 QmtDS5qarKPelK1ZHT2UlayP3MMKOq0=
X-Google-Smtp-Source: AGHT+IErIMyUPsx2nwBVYXMyigAHyHhnHd4TKbyKeO2x9wtFQI2OcCQ757lq2KSbhC+W3oYPJ5tpvw==
X-Received: by 2002:adf:cc8c:0:b0:320:2b29:7041 with SMTP id
 p12-20020adfcc8c000000b003202b297041mr6539361wrj.24.1695609413407; 
 Sun, 24 Sep 2023 19:36:53 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:52 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Karim Taha <kariem.taha2.7@gmail.com>,
 Stacey Son <sson@FreeBSD.org>
Subject: [PATCH v4 19/28] bsd-user: Implement get_filename_from_fd.
Date: Mon, 25 Sep 2023 00:01:27 +0300
Message-ID: <20230924210136.11966-20-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x429.google.com
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



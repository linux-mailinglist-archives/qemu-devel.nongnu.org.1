Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A17227A0F21
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:44:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtAi-0003Fn-2l; Thu, 14 Sep 2023 16:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAc-00038l-8Z
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:40 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAa-0006Ji-L9
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:38 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-401d6f6b2e0so16374875e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724154; x=1695328954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A4cB5XU1wHkue/WY2K/nTLg+N/2Q1Zd6Xjuos7I4bgs=;
 b=coZ1dppTgfXqlXL8QOtoHAGR7EgkQ9wNev39r3HtUXPUkvlXFRiOJnHy8OkPtJnKHQ
 Dt7as5vv088aQkmPiPXDHh+Etpt32NyIwr66KWwn7UNMj/aNv05fBgRxXcapQ5udLud1
 Mw5BuDLdn8WAci2b2HNJYeoU5yl4ym7nAL4xCvXAzFzOCspHzCb1eR9sns9zRt1zov1D
 lC0ffKl3ISTMYqDMDk6i3Dh+/ilx8CieG0D4ELd1KcMNsBzwskwUIew/otMaTALaPB2X
 GulV7gdaXKE9v196b00PCsAqGwPQKGtsCpSV3CakTQIjQLbvXrAgOqP0K7OhWv9AjspT
 tnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724154; x=1695328954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A4cB5XU1wHkue/WY2K/nTLg+N/2Q1Zd6Xjuos7I4bgs=;
 b=vU6KHFSCznq0xCp6FKJ3mlu6YLRrGOtzDVxKv95MoOxa+FVssDI6FRtL4FVlrP+Q4i
 QgpZEdhTYv4LoMUA6f0CTHUEsEKDxyW9GjCLL3P34a0jyLAUqKAgRDpdVaDNB7tkmpn3
 J4w46XhDYq/bHfBNoiVMGBa1AyAwxIkbKSM2nt+A2c9WFb2huqL08mgS3getHr+h7eQ5
 ypcMPKFYMWj88zan8CccUwald4beyoObTWh4/rxP6mOtnldOa4K9duP2RZa2dmHZ0nG0
 Ug7UiMUuT7B2egDYRg/LjL10cYpq9KSoGPXx4lzAc34wmiQvt7kNrtkVOuOWscXgZbbb
 AZ+g==
X-Gm-Message-State: AOJu0YyfnF8QVuXA0y5Oavdv9yWk+6dxaWUdtmtff+FjABn53Awb/8JW
 fQKk4BX9idlme95Gye/dGoAm0+QfuHU=
X-Google-Smtp-Source: AGHT+IH3vJAXq/MUxfyNyRqn4ko9TbB1IaNJ6cTSHv2YfF0rDoDrSuIg1vq9l3Z4n621NjxdbWSjJQ==
X-Received: by 2002:adf:fe10:0:b0:31a:cca0:2f3a with SMTP id
 n16-20020adffe10000000b0031acca02f3amr2424326wrr.0.1694724154115; 
 Thu, 14 Sep 2023 13:42:34 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:33 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Karim Taha <kariem.taha2.7@gmail.com>, Kyle Evans <kevans@FreeBSD.org>
Subject: [PATCH v5 05/23] bsd-user: Implement shm_open2(2) system call
Date: Thu, 14 Sep 2023 23:40:49 +0300
Message-ID: <20230914204107.23778-6-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-misc.h    | 42 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 10 +++++++++
 2 files changed, 52 insertions(+)

diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index 8436ccb2f7..6b424b7078 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -24,5 +24,47 @@
 #include <sys/random.h>
 #include <sched.h>
 
+int shm_open2(const char *path, int flags, mode_t mode, int shmflags,
+    const char *);
+
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
+/* shm_open2(2) */
+static inline abi_long do_freebsd_shm_open2(abi_ulong pathptr, abi_ulong flags,
+    abi_long mode, abi_ulong shmflags, abi_ulong nameptr)
+{
+    int ret;
+    void *uname, *upath;
+
+    if (pathptr == (uintptr_t)SHM_ANON) {
+        upath = SHM_ANON;
+    } else {
+        upath = lock_user_string(pathptr);
+        if (upath == NULL) {
+            return -TARGET_EFAULT;
+        }
+    }
+
+    uname = NULL;
+    if (nameptr != 0) {
+        uname = lock_user_string(nameptr);
+        if (uname == NULL) {
+            unlock_user(upath, pathptr, 0);
+            return -TARGET_EFAULT;
+        }
+    }
+    ret = get_errno(shm_open2(upath,
+                target_to_host_bitmask(flags, fcntl_flags_tbl), mode,
+                target_to_host_bitmask(shmflags, shmflag_flags_tbl), uname));
+
+    if (upath != SHM_ANON) {
+        unlock_user(upath, pathptr, 0);
+    }
+    if (uname != NULL) {
+        unlock_user(uname, nameptr, 0);
+    }
+    return ret;
+}
+#endif /* __FreeBSD_version >= 1300048 */
+
 
 #endif /* OS_MISC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index fa60df529e..74146d8c72 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -33,11 +33,13 @@
 #include "signal-common.h"
 #include "user/syscall-trace.h"
 
+/* BSD independent syscall shims */
 #include "bsd-file.h"
 #include "bsd-proc.h"
 
 /* *BSD dependent syscall shims */
 #include "os-stat.h"
+#include "os-misc.h"
 
 /* I/O */
 safe_syscall3(int, open, const char *, path, int, flags, mode_t, mode);
@@ -592,6 +594,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd_fcntl(arg1, arg2, arg3);
         break;
 
+        /*
+         * Memory management system calls.
+         */
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
+    case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
+        ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
+        break;
+#endif
 
         /*
          * sys{ctl, arch, call}
-- 
2.42.0



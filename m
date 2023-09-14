Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C46E7A0EBC
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:07:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsZW-0002tG-Ok; Thu, 14 Sep 2023 16:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZU-0002sO-Hq
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:16 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZR-0001Tv-Uc
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:16 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-404773f2501so4660015e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721852; x=1695326652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnXmZkbpo6/SgIptieBsKXVrN3AJvzb8K8opqiPzen8=;
 b=VA1icu4wg1bBFUoj3fePH7EI9X+x7aeuhDc0WwQH5wnVGhb26OhJ5Iba9+BOH4IZY4
 yVRXWvcyz3fbajYtRGPeWzkq+xHvuxFFZSz5Z/S+z1AoahSPBKv4Yx0iD2fX1NyVPCsw
 aCLI3K8KhpT1fuqFXbkSRE2INTZB7W6Lj8tYF7KIytdR5LNyjyBHM/B8B1TQiT6uiuUL
 4XisNNoSKxpHo/qGPfulePmHT84tsJ4GkWkxkCspUtuo1VT6j0zce+BmG2Fp/RkkYd+n
 dwD7LItkNcdhY7Q9fG/lJUXGtHJbPNEQAkqWOgt7tqCE8Kp0KeFSwO9OsceaDLIghsfq
 S13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721852; x=1695326652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xnXmZkbpo6/SgIptieBsKXVrN3AJvzb8K8opqiPzen8=;
 b=TqkjsuFXkO2XXkeMprAGPS9YgeBBRzdGfQOkydjWED/QPU/iye2rf3pKR4tiDdnnnS
 +JvMB599FeogWPxi2MsIvjhHDeKJzMsWP1h2KXEXlefS02Ogg3PhKiHLauVKL/zZME2n
 W/MBNWOPC2KCXRur4CwJ21eCiHEdQcaKEtXn9BsXwT3p9Kut6dxLCdX+sWewujqUAWu9
 QOovHOJ86UlFQFroJ8D+e7wRsC1cqBib3c4mkwL4AZ1JGktyCzMc1FXybJnK1+g+kLXR
 q/Wg+K+hVCVO+iCJYfOT1xxEcfMW86u7dsy31BbqTeh2cBUK/NHNw1gVjT7GnXVHfpNg
 0Ahw==
X-Gm-Message-State: AOJu0YxlIOVg5muOBq2HqScbPh/f9kx6eIqDvDCnnM9sPkcT2ioEoDIv
 Gv9aKmGGeepUliNEZuxaQzIArzLx3v8=
X-Google-Smtp-Source: AGHT+IHHfNuDG6FLW5I+VlBFPvFbGeLrNnK6zKvcV3nnsgy3+2B8+KPDX91vNpUgkeUE0fMiIDZxAw==
X-Received: by 2002:a7b:ca47:0:b0:3fe:4cbc:c345 with SMTP id
 m7-20020a7bca47000000b003fe4cbcc345mr5675551wml.41.1694721852301; 
 Thu, 14 Sep 2023 13:04:12 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:11 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 05/23] bsd-user: Implement shm_open2(2) system call
Date: Thu, 14 Sep 2023 23:02:24 +0300
Message-ID: <20230914200242.20148-6-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
References: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x333.google.com
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

From: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-misc.h    | 42 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 13 +++++++++++
 2 files changed, 55 insertions(+)

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
index 2224a280ea..b4311db578 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -33,9 +33,13 @@
 #include "signal-common.h"
 #include "user/syscall-trace.h"
 
+/* BSD independent syscall shims */
 #include "bsd-file.h"
 #include "bsd-proc.h"
 
+/* *BSD dependent syscall shims */
+#include "os-misc.h"
+
 /* I/O */
 safe_syscall3(int, open, const char *, path, int, flags, mode_t, mode);
 safe_syscall4(int, openat, int, fd, const char *, path, int, flags, mode_t,
@@ -482,6 +486,15 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_undelete(arg1);
         break;
 
+        /*
+         * Memory management system calls.
+         */
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
+    case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
+        ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
+        break;
+#endif
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.42.0



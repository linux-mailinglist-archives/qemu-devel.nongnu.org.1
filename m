Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E33EF800207
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 04:23:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8u6X-0002xB-KP; Thu, 30 Nov 2023 22:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3X1FpZQMKCtgM6QAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--scw.bounces.google.com>)
 id 1r8u6V-0002wy-Sz
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 22:22:11 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3X1FpZQMKCtgM6QAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--scw.bounces.google.com>)
 id 1r8u6U-0002hH-8B
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 22:22:11 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5cfe0b63eeeso30219467b3.0
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 19:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1701400928; x=1702005728; darn=nongnu.org;
 h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=51XLYpmadR/yFErptaAwZRJFyAyQ9e208pyzDLJGMCw=;
 b=JpzxLoGzGHe1Mdbwctviv0WvIErQjZyOTFuVImBV3DDcHCQvoAm8/guryfDAOU2u41
 mG9qc48QxXPowKqHcPaJOXqGrcYiXnnqjP8JHsS9rYVRDotvPrqc146jYtAnkf2O03pN
 x/Fe7SKiTOTvjeezvt5TzXhuATCE2tI7MEGg69dW213FhcFnWsvdTBrmZwiZjnh+0hhp
 ol/yiuuMB+7BEhT8LuTqDT/9tRbN/9L1R+UHUpLFOoy/nqcVSJVA9cLG3oXkyvHk1mUX
 9R2pvCTdIrBmOL97ddLZbWJPQc7kE3lB4dFswb0Fyhc054GcY5Aqtl3l6jf61nxqYo/l
 3L7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701400928; x=1702005728;
 h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=51XLYpmadR/yFErptaAwZRJFyAyQ9e208pyzDLJGMCw=;
 b=fGop2+N3lfwblY115XpL+EU3AvlYYR8kHWGrI+9AOgWVfg6S5EiXF1Be66PPfgWLWU
 imcP28faqFJA+WmEKakZhuzL+BDn3VgCOg2scbWZZuFqqhyolsf+ZEcxWb1W8Kpku2zV
 Djht3hrG7ikHh8jRuZY7Yr6OmtfKLavBCnbdCYNTR0q5ptm84lj3PcMfHn60qBhNi5Xx
 MryOLAC368roAF2qFA6EB1g+otE0VwnZLglsvGdcrZWOGi/Vzi8K4k3R0lX4vRwEqCPB
 V1WSyqA+zRed4/aYAaADqcZDYFglhkqMQ+emjoZaMKUilD5rGLYU898gtxF935W6E6IZ
 Z/Tg==
X-Gm-Message-State: AOJu0Ywmj6kLFXTj3MP4y55oT2LDyszHKyeqplkGsN2KqNLV+vLLYqSX
 dimxKz3kqG6SS15F3AcR3alPuZ4/uPTY/s5olXQAnGsmGEx5YJyVVDd4jmvBBy8kIlggEqVzWTE
 HugZNmRGLu2E9Zl7UqbYoO27M453EoLpZ2QuGyTIhhZwdepV7JTh+
X-Google-Smtp-Source: AGHT+IEGMC6Glz+2p+GzbJfZHMYK/AKaec8yADZ0Bd/fJuUgvHAIKCWPqL3+YO8tMI4CNiE/uSMiXBY=
X-Received: from scw-glinux.svl.corp.google.com
 ([2620:15c:2d3:205:73b4:ef07:4b25:48e5])
 (user=scw job=sendgmr) by 2002:a05:690c:340b:b0:5cb:73ab:3e4d with SMTP id
 fn11-20020a05690c340b00b005cb73ab3e4dmr681976ywb.6.1701400927960; Thu, 30 Nov
 2023 19:22:07 -0800 (PST)
Date: Thu, 30 Nov 2023 19:21:40 -0800
In-Reply-To: <20231201032140.2470599-1-scw@google.com>
Message-Id: <20231201032140.2470599-3-scw@google.com>
Mime-Version: 1.0
References: <20231201032140.2470599-1-scw@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH 2/2] linux-user: Fix openat() emulation to not modify atime
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Shu-Chun Weng <scw@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3X1FpZQMKCtgM6QAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--scw.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Commit b8002058 strengthened openat()'s /proc detection by calling
realpath(3) on the given path, which allows various paths and symlinks
that points to the /proc file system to be intercepted correctly.

Using realpath(3), though, has a side effect that it reads the symlinks
along the way, and thus changes their atime. The results in the
following code snippet already get ~now instead of the real atime:

  int fd = open("/path/to/a/symlink", O_PATH | O_NOFOLLOW);
  struct stat st;
  fstat(fd, st);
  return st.st_atime;

This change opens a path that doesn't appear to be part of /proc
directly and checks the destination of /proc/self/fd/n to determine if
it actually refers to a file in /proc.

Neither this nor the existing code works with symlinks or indirect paths
(e.g.  /tmp/../proc/self/exe) that points to /proc/self/exe because it
is itself a symlink, and both realpath(3) and /proc/self/fd/n will
resolve into the location of QEMU.

Signed-off-by: Shu-Chun Weng <scw@google.com>
---
 linux-user/syscall.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e384e14248..25e2cda10a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8308,8 +8308,6 @@ static int open_net_route(CPUArchState *cpu_env, int fd)
 int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
                     int flags, mode_t mode, bool safe)
 {
-    g_autofree char *proc_name = NULL;
-    const char *pathname;
     struct fake_open {
         const char *filename;
         int (*fill)(CPUArchState *cpu_env, int fd);
@@ -8333,13 +8331,39 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
 #endif
         { NULL, NULL, NULL }
     };
+    char pathname[PATH_MAX];
 
-    /* if this is a file from /proc/ filesystem, expand full name */
-    proc_name = realpath(fname, NULL);
-    if (proc_name && strncmp(proc_name, "/proc/", 6) == 0) {
-        pathname = proc_name;
+    if (strncmp(fname, "/proc/", 6) == 0) {
+        pstrcpy(pathname, sizeof(pathname), fname);
     } else {
-        pathname = fname;
+        char procpath[PATH_MAX];
+        int fd, n;
+
+        if (safe) {
+            fd = safe_openat(dirfd, path(fname), flags, mode);
+        } else {
+            fd = openat(dirfd, path(fname), flags, mode);
+        }
+        if (fd < 0) {
+            return fd;
+        }
+
+        /*
+         * Try to get the real path of the file we just opened. We avoid calling
+         * `realpath(3)` because it calls `readlink(2)` on symlinks which
+         * changes their atime. Note that since `/proc/self/exe` is a symlink,
+         * `pathname` will never resolves to it (neither will `realpath(3)`).
+         * That's why we check `fname` against the "/proc/" prefix first.
+         */
+        snprintf(procpath, sizeof(procpath), "/proc/self/fd/%d", fd);
+        n = readlink(procpath, pathname, sizeof(pathname));
+        pathname[n < sizeof(pathname) ? n : sizeof(pathname)] = '\0';
+
+        /* if this is not a file from /proc/ filesystem, the fd is good as-is */
+        if (strncmp(pathname, "/proc/", 6) != 0) {
+            return fd;
+        }
+        close(fd);
     }
 
     if (is_proc_myself(pathname, "exe")) {
@@ -8390,9 +8414,9 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
     }
 
     if (safe) {
-        return safe_openat(dirfd, path(pathname), flags, mode);
+        return safe_openat(dirfd, pathname, flags, mode);
     } else {
-        return openat(dirfd, path(pathname), flags, mode);
+        return openat(dirfd, pathname, flags, mode);
     }
 }
 


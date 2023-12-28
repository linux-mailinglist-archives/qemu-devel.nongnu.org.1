Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7558081FB81
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 23:18:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIyhp-0007Ov-HE; Thu, 28 Dec 2023 17:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3J_SNZQMKCnoqauemmejc.amkocks-bctcjlmlels.mpe@flex--scw.bounces.google.com>)
 id 1rIyhn-0007OX-8B
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:18:19 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3J_SNZQMKCnoqauemmejc.amkocks-bctcjlmlels.mpe@flex--scw.bounces.google.com>)
 id 1rIyhl-0007gI-GU
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:18:19 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5d12853cb89so113037597b3.3
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 14:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1703801895; x=1704406695; darn=nongnu.org;
 h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=0LggNekTo5+1TUWwnR81y8RD/l2PY1NK6D4/tU2HiLc=;
 b=mZDbiCqeh2l+CVHybd2nlnrJBACKbFNzudeYSLBx87QQi/4W8XZxYX6TO5Yl7RSQrL
 pC2GM4nzL2w4u4kzEGqYHDyrFbvDF4yf0/ZYIPNxQF8FEcZn7Bbyo/4ggaLNRgAILJCh
 BSqBOnPuWuHYCsA8qETgjBBUUgXKcjLVX7a10c/i3MOgdCzk2vL1Mw5dsW9Ks32Arg2V
 52+7fEGzGeV4J618C8uLAcQ54gkB6hoYyNvxQDed7xlx7gSr0chx+pwCGrI3shDky8bM
 0rPd/DpEH552Iz8UuwE7u6ArBA/noLm6SuI1nZmAJisuSfZPrQebBn8ZAeJ9nYl+gkmh
 rAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703801895; x=1704406695;
 h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0LggNekTo5+1TUWwnR81y8RD/l2PY1NK6D4/tU2HiLc=;
 b=s68bBIomZ0tPP7Sd3eKLnc357yehug6WFfUwZXb/ByYE3IidnY7Dgk0/xvSHMumwT7
 sc74TMw/S+MIkd6ULjfmF0PSaTAT65W3K5iFi347wMaXiF3iIh6pa3C/YZ0a0J5K0Wd2
 nx+ov88r8kby2XaEz3lmYFwM2yebHsTs24E+WZn1ZEEgbW81bIgtKT6qSjBGc8br55qe
 sdhvZTbGpeHuKoxKIoFwdXBVHWML+HBT1ytO93sQaWr5cuTE9hcGxExJ2WvhClryONXO
 l/ygRItnHDdp+KFHhoozO/VZtBkU5DNiATqJADT7fVyGheTpUq0xdYASG0hc8yKj6PiL
 6h+A==
X-Gm-Message-State: AOJu0YwrA7w6QKtgeprprFG3wDrlpOau3e2y8AU5vmrNZ8GWU143e+Kd
 TFqIcPsJqhnIUG6psZUK1LR0nWAfPFo76LAo6lvwsaVgpCDT+RFc+vbjoKZNmW6mQD+PIhn0k2t
 JE1kwmepymQz43/u09YjbnIawK7KbcF0X/WAfNB1OzNzWDOyR9ZHpfDjHzEE=
X-Google-Smtp-Source: AGHT+IG4Hp/5QuvqX3lQ26EmZGtX/FJpawfsAVtrcxDuhe+yX2CVGB5pvGzRrNXPMh7sh0wFYtEL76g=
X-Received: from scw-glinux.svl.corp.google.com
 ([2620:15c:2d3:205:ed19:b942:6cb6:d8bc])
 (user=scw job=sendgmr) by 2002:a05:690c:c0e:b0:5e6:468e:fea0 with SMTP id
 cl14-20020a05690c0c0e00b005e6468efea0mr5729823ywb.0.1703801895172; Thu, 28
 Dec 2023 14:18:15 -0800 (PST)
Date: Thu, 28 Dec 2023 14:17:59 -0800
In-Reply-To: <20231228221759.2839009-1-scw@google.com>
Message-Id: <20231228221759.2839009-3-scw@google.com>
Mime-Version: 1.0
References: <20231228221759.2839009-1-scw@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v4 2/2] linux-user: Fix openat() emulation to not modify atime
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Shu-Chun Weng <scw@google.com>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3J_SNZQMKCnoqauemmejc.amkocks-bctcjlmlels.mpe@flex--scw.bounces.google.com;
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

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2004
Signed-off-by: Shu-Chun Weng <scw@google.com>
Reviewed-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c | 50 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e384e14248..2fa56f3dc6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8308,8 +8308,7 @@ static int open_net_route(CPUArchState *cpu_env, int fd)
 int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
                     int flags, mode_t mode, bool safe)
 {
-    g_autofree char *proc_name = NULL;
-    const char *pathname;
+    g_autofree char *pathname = NULL;
     struct fake_open {
         const char *filename;
         int (*fill)(CPUArchState *cpu_env, int fd);
@@ -8334,12 +8333,45 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
         { NULL, NULL, NULL }
     };
 
-    /* if this is a file from /proc/ filesystem, expand full name */
-    proc_name = realpath(fname, NULL);
-    if (proc_name && strncmp(proc_name, "/proc/", 6) == 0) {
-        pathname = proc_name;
+    if (strncmp(fname, "/proc/", 6) == 0) {
+        pathname = g_strdup(fname);
     } else {
-        pathname = fname;
+        g_autofree char *proc_name = NULL;
+        struct stat proc_stat;
+        int fd;
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
+         * `pathname` will never resolve to it (neither will `realpath(3)`).
+         * That's why we check `fname` against the "/proc/" prefix first.
+         */
+        proc_name = g_strdup_printf("/proc/self/fd/%d", fd);
+        if (lstat(proc_name, &proc_stat) < 0 || !S_ISLNK(proc_stat.st_mode)) {
+            /* No procfs or something weird. Not going to dig further. */
+            return fd;
+        }
+        pathname = g_new0(char, proc_stat.st_size + 1);
+        if (readlink(proc_name, pathname, proc_stat.st_size + 1)
+            != proc_stat.st_size) {
+            return fd;
+        }
+
+        /* if this is not a file from /proc/ filesystem, the fd is good as-is */
+        if (strncmp(pathname, "/proc/", 6) != 0) {
+            return fd;
+        }
+        close(fd);
     }
 
     if (is_proc_myself(pathname, "exe")) {
@@ -8390,9 +8422,9 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
     }
 
     if (safe) {
-        return safe_openat(dirfd, path(pathname), flags, mode);
+        return safe_openat(dirfd, pathname, flags, mode);
     } else {
-        return openat(dirfd, path(pathname), flags, mode);
+        return openat(dirfd, pathname, flags, mode);
     }
 }
 


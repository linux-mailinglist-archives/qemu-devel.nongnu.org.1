Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1145D80AFCD
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 23:43:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBjY4-0007X0-TI; Fri, 08 Dec 2023 17:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3x5tzZQMKCv4yi2muumrk.iuswks0-jk1krtutmt0.uxm@flex--scw.bounces.google.com>)
 id 1rBjY2-0007Wq-SD
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 17:42:18 -0500
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3x5tzZQMKCv4yi2muumrk.iuswks0-jk1krtutmt0.uxm@flex--scw.bounces.google.com>)
 id 1rBjY1-0007fG-3a
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 17:42:18 -0500
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-db401df7735so3344453276.3
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 14:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1702075335; x=1702680135; darn=nongnu.org;
 h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=hORNguViAH2pi6vCqEVU93XiVqEJHtPxd3z4YqE/QaQ=;
 b=P9x9KsWVJiVAkHePxu1Qa9F/69QVstj4mYdxnmBLNK3AZzuD8ozq0TD7CCQv5QRVqq
 /91+joxczUsu9sx438TUdop4rkOQIRW8vMA2fNM7+6NVJ0+CwcKRR+siMakrNhOKt5+S
 KOTfAqDbp24UW9A3sMIRMSBgoUHiTqgqETqJ58UMDgt/XTOT6tzhjJif6t6OPVHvTVL3
 0eUcOqbb7LhHEqF2SVufws3vRyTm5jBc1OnQuczon7g+aw0BBbOtsdW8HzwchzlsUiqd
 A5USjwoQpjKzNKY8irOY4T+Hs7ROUnV35Ny3IhH30VP46ojjZeQQApx0Vi6XY4m78pQ5
 G0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702075335; x=1702680135;
 h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hORNguViAH2pi6vCqEVU93XiVqEJHtPxd3z4YqE/QaQ=;
 b=t9P2MdZXe1cphP3937LWLog0GfQ+ciUlkyusnnJlvAgfWiPkFoI8Bg2axMFzz3JPge
 KxQW6IF5QwwmNUUYUXwPsHL8mq6fnCBthHvp33HFTYWJiFqxtk7+uc0eg3Jnmv+f3QLA
 o33N+9d05ZbViFAhfCDYnRinY68qDl8hN0V+LY+fPSTor2+lgCgAXXMDiS8gvI+Pbp06
 6X9O+g4fWfl7yzie5XBy59CHGmzTkR4CZNld6CopmUm9OdGPxxpaHd2lHNy8Q28uE40z
 0+dWDDWoH/qrLgKqle06he3ms64zfxdC1m8SaUtp5vCXr9+nR5foVqQX4kDGWQYzr+2m
 7Dyw==
X-Gm-Message-State: AOJu0Yy38pmx0066wsvZIs9XIuEcz989F71z+Mi06E+iLIW5gCgK2t07
 x49bfu8gWKuUxfPkRMu3mS+bpye8A9cv3jCqYE//Da+wMlBpGyEbxeJ1QGUvZF28nrSEfz0ghGj
 zLu2tn0cZ5aaFbdLaI9KVlVuHG4bEt62tNANumu7TGY8cV8ozK0EZ
X-Google-Smtp-Source: AGHT+IGusCdAGzcnnYfdTqQzZgJBRtVBKWbOQpE5xGXoD+pt7dcA+ZjSfXEDSao/EyMBO2WTjHtT9go=
X-Received: from scw-glinux.svl.corp.google.com
 ([2620:15c:2d3:205:37bb:5740:1ec:48f2])
 (user=scw job=sendgmr) by 2002:a25:7489:0:b0:db7:dce9:76d3 with SMTP id
 p131-20020a257489000000b00db7dce976d3mr5355ybc.9.1702075335616; Fri, 08 Dec
 2023 14:42:15 -0800 (PST)
Date: Fri,  8 Dec 2023 14:42:07 -0800
In-Reply-To: <20231208224207.613445-1-scw@google.com>
Message-Id: <20231208224207.613445-3-scw@google.com>
Mime-Version: 1.0
References: <20231208224207.613445-1-scw@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v3 2/2] linux-user: Fix openat() emulation to not modify atime
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Shu-Chun Weng <scw@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3x5tzZQMKCv4yi2muumrk.iuswks0-jk1krtutmt0.uxm@flex--scw.bounces.google.com;
 helo=mail-yb1-xb49.google.com
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
---
 linux-user/syscall.c | 47 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e384e14248..7c3772301f 100644
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
@@ -8334,12 +8333,42 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
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
+        pathname = g_new(char, proc_stat.st_size + 1);
+        readlink(proc_name, pathname, proc_stat.st_size + 1);
+
+        /* if this is not a file from /proc/ filesystem, the fd is good as-is */
+        if (strncmp(pathname, "/proc/", 6) != 0) {
+            return fd;
+        }
+        close(fd);
     }
 
     if (is_proc_myself(pathname, "exe")) {
@@ -8390,9 +8419,9 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
     }
 
     if (safe) {
-        return safe_openat(dirfd, path(pathname), flags, mode);
+        return safe_openat(dirfd, pathname, flags, mode);
     } else {
-        return openat(dirfd, path(pathname), flags, mode);
+        return openat(dirfd, pathname, flags, mode);
     }
 }
 


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D17180AE47
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 21:51:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBhnh-000129-Ei; Fri, 08 Dec 2023 15:50:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3g4FzZQMKCoY2m6qyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--scw.bounces.google.com>)
 id 1rBhne-00011v-2c
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 15:50:18 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3g4FzZQMKCoY2m6qyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--scw.bounces.google.com>)
 id 1rBhnZ-00065e-9k
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 15:50:17 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5d3a1e5f8d6so31422857b3.3
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 12:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1702068612; x=1702673412; darn=nongnu.org;
 h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=hORNguViAH2pi6vCqEVU93XiVqEJHtPxd3z4YqE/QaQ=;
 b=VpNFZT//S1RPHedFKr/0SXHsnm8qSCYWup2SPCiES9l8Kb5aXktlHlqvFm6fs7LhQQ
 er+krOi5z9yRfCavdAfpjNR/JCbULdyTNgeUCLjmyh0kYjYihhkT2Zk+nhepGiddjXfq
 ekr0RjUZ1jzZ04B8/iDWmuWxNkshPgZgLakQjoIO1as0Pppys96RMW0DOY/YcuFzH+Of
 jgqn31X//ihu/oEgwmvoL0z4GPj/L9i3BtA//tiJyUYxk0J0zwE/UA+nCbLVhJFdmiYk
 6gFGksZBFS3TqoW0FTCxhhBwe5HpBLAs5P/ZdGYkn47EaS3G2DqvGoi+qRq5YCnyUp6z
 ZHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702068612; x=1702673412;
 h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hORNguViAH2pi6vCqEVU93XiVqEJHtPxd3z4YqE/QaQ=;
 b=oPS5nVhv99x4aJdZMiBkTZj2rTzV0qEHYDQakXDL13KinljQRaGAhvD3VbMcYvjvv4
 KTFwc3MH5vZBCsXMg77TMWJLs3jmtn71maLdbXK7Q72k/NgINjDHJ8/2UWTYD/4auepm
 gfmQLaaVuYu5S5uckJMe0pLPa5equqlW7uaBqXMtOktGI2FFp2EvzNNR2zgtF2u8Mwpt
 ZpHbsxptcsFZJwtgnbY2f/peYoX+IdSageyKGo4gs5ASqE1iNo2q3+IUNZuKVI5ADpFk
 bW3uZ3jxmC6IPt0NO9yx3aWQ0v6N5DMmFLY4oWUtttEBG8aq42vVSJ34e42o07ltMGFN
 gkPQ==
X-Gm-Message-State: AOJu0YzQ7PSFAR8GK5y99gYoYyVVsLQPLJT2M03XjTxUHuWWC4chKzsb
 P6wVgzkRale0IOXmeeTODZjEjgkXFya4o4vMWTpKBOTqnC5GpRi5JUWkepRXaSiTl5L+VETrGDU
 E82vqL4nVmBnekohHlcTnbgf8RSRzL/EvXvq/an31RXVYOPXO1d3i
X-Google-Smtp-Source: AGHT+IF8BcSUjwziu5ubuBgSfhIMos2gmZlRsdFBQXbeXNuMslMPNfj0q95FrVg6L1Ja9Cjx7I0Qzw0=
X-Received: from scw-glinux.svl.corp.google.com
 ([2620:15c:2d3:205:37bb:5740:1ec:48f2])
 (user=scw job=sendgmr) by 2002:a05:690c:891:b0:5d8:eec5:f57c with SMTP id
 cd17-20020a05690c089100b005d8eec5f57cmr8141ywb.4.1702068611881; Fri, 08 Dec
 2023 12:50:11 -0800 (PST)
Date: Fri,  8 Dec 2023 12:49:51 -0800
In-Reply-To: <20231208204951.552837-1-scw@google.com>
Message-Id: <20231208204951.552837-3-scw@google.com>
Mime-Version: 1.0
References: <20231208204951.552837-1-scw@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v2 2/2] linux-user: Fix openat() emulation to not modify atime
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Shu-Chun Weng <scw@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3g4FzZQMKCoY2m6qyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--scw.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01,
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
(e.g. /tmp/../proc/self/exe) that points to /proc/self/exe because it
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
 


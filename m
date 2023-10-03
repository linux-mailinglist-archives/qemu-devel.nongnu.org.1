Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC30F7B7541
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:40:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovK-000489-M3; Tue, 03 Oct 2023 19:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovE-00042z-4i
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:24 -0400
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovC-0006uU-13
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:23 -0400
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-79fe87cd74eso59103939f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376120; x=1696980920;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qie3M6dlAyV2pYetlYDOFKB5joUdVo7JudFsExcH3bA=;
 b=HYmlepfJtwsGATV4Wpa3oLA7H+74P+y5vWQoIt3YS8/nEsHzknmRGchVY5jtZ1LL9j
 5bh4pBSnQ27pqKF2Jy8Qptee1Z/I9awolLxt8wyo/H8jZ4XNliIHUzKSagNKPVpLHNcC
 4DbENKNxaP6T200Wqo0Rmwes+TWiAUuuaGBoRegncxxhHKJV4wnUghrSDZ++/HxcICnm
 pnqa6w2dKQAbONLqfwGfnSSRClJ4awZ4D3SHcL3eeR4JqryRe3rl5blupQE7vA8piw/S
 59YUfGR7g6+dBlugHQJxGZC2gaWt7HCkKH2JWwoCG1wGyhYHal2dgnHkQyystYHlyy3w
 d4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376120; x=1696980920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qie3M6dlAyV2pYetlYDOFKB5joUdVo7JudFsExcH3bA=;
 b=hEnYjv8E8/i5gfzGfQomO+mW1JBkxMqWOA0MWdBgAhykrNw7L8GYR7Bx9qwXb+L6b+
 T2988/0ZSGJMjuaq+WoeKAVvEH+t42kuQUSGJ5cqVdpsXTbnlS4sbkknX+Jelp4mBplE
 9ht0V4UhSxRMZ7/fRSwNu66gkvZaC9b8alLQNZ1MYl2ERPHGZRQqWSTwMr3vh22Cb0d/
 xdZOUa14QRqEBpJIHmwsNDFte4nAnusWqZ2uu4Uq59SWfa8c6gtttK0jlLtnlhYHndlT
 ysvaGdY0HgghtM3K6FYuzIQ706gYvyiUaCCgcIa8ARegZKro/annEQNbstrT0nzJGFLg
 SdEA==
X-Gm-Message-State: AOJu0YxXgE4jCydB3OyoA1q4Y25sj46GzbChWZ/fJbKkWFcnpXUK4BdM
 5LUl210nlZmieAJZxrOY/+oaUTZaV/IcgAfRlkRq4A==
X-Google-Smtp-Source: AGHT+IGnUKk3qHhAD7F8kJABbW+kQnQ2d/TyJbQes9WuZRm/PbGT/kUry6eUuNu/gFn769V2Ss/i9w==
X-Received: by 2002:a6b:6f09:0:b0:79f:ca2f:9198 with SMTP id
 k9-20020a6b6f09000000b0079fca2f9198mr816906ioc.2.1696376120636; 
 Tue, 03 Oct 2023 16:35:20 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:20 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/51] bsd-user: Implement several get/set system calls:
Date: Tue,  3 Oct 2023 17:31:39 -0600
Message-ID: <20231003233215.95557-16-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

getpid(2), getppid(2), getpgrp(2)
setreuid(2), setregid(2)
getuid(2), geteuid(2), getgid(2), getegid(2), getpgid(2)
setuid(2), seteuid(2), setgid(2), setegid(2), setpgid(2)

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182425.3163-16-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-proc.h           | 90 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 60 +++++++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 38d1324034c..6ff07c0ac36 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -196,4 +196,94 @@ static inline abi_long do_bsd_setrlimit(abi_long arg1, abi_ulong arg2)
     return ret;
 }
 
+/* getpid(2) */
+static inline abi_long do_bsd_getpid(void)
+{
+    return get_errno(getpid());
+}
+
+/* getppid(2) */
+static inline abi_long do_bsd_getppid(void)
+{
+    return get_errno(getppid());
+}
+
+/* getuid(2) */
+static inline abi_long do_bsd_getuid(void)
+{
+    return get_errno(getuid());
+}
+
+/* geteuid(2) */
+static inline abi_long do_bsd_geteuid(void)
+{
+    return get_errno(geteuid());
+}
+
+/* getgid(2) */
+static inline abi_long do_bsd_getgid(void)
+{
+    return get_errno(getgid());
+}
+
+/* getegid(2) */
+static inline abi_long do_bsd_getegid(void)
+{
+    return get_errno(getegid());
+}
+
+/* setuid(2) */
+static inline abi_long do_bsd_setuid(abi_long arg1)
+{
+    return get_errno(setuid(arg1));
+}
+
+/* seteuid(2) */
+static inline abi_long do_bsd_seteuid(abi_long arg1)
+{
+    return get_errno(seteuid(arg1));
+}
+
+/* setgid(2) */
+static inline abi_long do_bsd_setgid(abi_long arg1)
+{
+    return get_errno(setgid(arg1));
+}
+
+/* setegid(2) */
+static inline abi_long do_bsd_setegid(abi_long arg1)
+{
+    return get_errno(setegid(arg1));
+}
+
+/* getpgid(2) */
+static inline abi_long do_bsd_getpgid(pid_t pid)
+{
+    return get_errno(getpgid(pid));
+}
+
+/* setpgid(2) */
+static inline abi_long do_bsd_setpgid(int pid, int pgrp)
+{
+    return get_errno(setpgid(pid, pgrp));
+}
+
+/* getpgrp(2) */
+static inline abi_long do_bsd_getpgrp(void)
+{
+    return get_errno(getpgrp());
+}
+
+/* setreuid(2) */
+static inline abi_long do_bsd_setreuid(abi_long arg1, abi_long arg2)
+{
+    return get_errno(setreuid(arg1, arg2));
+}
+
+/* setregid(2) */
+static inline abi_long do_bsd_setregid(abi_long arg1, abi_long arg2)
+{
+    return get_errno(setregid(arg1, arg2));
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 5cb60862303..7565e69e76d 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -255,6 +255,66 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_setrlimit(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_getpid: /* getpid(2) */
+        ret = do_bsd_getpid();
+        break;
+
+    case TARGET_FREEBSD_NR_getppid: /* getppid(2) */
+        ret = do_bsd_getppid();
+        break;
+
+    case TARGET_FREEBSD_NR_getuid: /* getuid(2) */
+        ret = do_bsd_getuid();
+        break;
+
+    case TARGET_FREEBSD_NR_geteuid: /* geteuid(2) */
+        ret = do_bsd_geteuid();
+        break;
+
+    case TARGET_FREEBSD_NR_getgid: /* getgid(2) */
+        ret = do_bsd_getgid();
+        break;
+
+    case TARGET_FREEBSD_NR_getegid: /* getegid(2) */
+        ret = do_bsd_getegid();
+        break;
+
+    case TARGET_FREEBSD_NR_setuid: /* setuid(2) */
+        ret = do_bsd_setuid(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_seteuid: /* seteuid(2) */
+        ret = do_bsd_seteuid(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_setgid: /* setgid(2) */
+        ret = do_bsd_setgid(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_setegid: /* setegid(2) */
+        ret = do_bsd_setegid(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_getpgrp: /* getpgrp(2) */
+        ret = do_bsd_getpgrp();
+        break;
+
+    case TARGET_FREEBSD_NR_getpgid: /* getpgid(2) */
+         ret = do_bsd_getpgid(arg1);
+         break;
+
+    case TARGET_FREEBSD_NR_setpgid: /* setpgid(2) */
+         ret = do_bsd_setpgid(arg1, arg2);
+         break;
+
+    case TARGET_FREEBSD_NR_setreuid: /* setreuid(2) */
+        ret = do_bsd_setreuid(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_setregid: /* setregid(2) */
+        ret = do_bsd_setregid(arg1, arg2);
+        break;
+
 
         /*
          * File system calls.
-- 
2.41.0



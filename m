Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 957407ADF03
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:36:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHh-0001KY-FL; Mon, 25 Sep 2023 14:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHd-0001JL-Uq
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:13 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHc-0007LJ-5u
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:13 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4053d53a1bfso58994465e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666370; x=1696271170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+e4yFlvYdu/hYdNO+o3b9LtvOAePOEZiwqvJAYO+t24=;
 b=J4vW5JbB9w0ezf8PyPBgJuvfgW7Oo7buoMrqqf148JG5LXO5xjBfIU+U76fXeHhpX0
 V5up92XM3UoY7XJRHLh8YkjbpIsuSD+tFysKilbaY85lFRWCPxpr/P03iGmMvd1bRgsP
 xZ87xmP7MpsDs7aj0tGN5hHYWdiclJWb41yNZGylLNNJbb7ZZyH8kthL5dueRprssqbW
 gkZnAXhPiAUFk5bqEi3TfkDtA8mo/YI40B9sO7Wf20+VO5ehNjG2vp35+yZwHatVSCkl
 cFUk2AruWWAeVdqweX7thR7FzJk+9mmaM3QwIUNP3AuRJXD7m7xcghz0c0Z7wVQXWMiq
 Ko4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666370; x=1696271170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+e4yFlvYdu/hYdNO+o3b9LtvOAePOEZiwqvJAYO+t24=;
 b=O4uDyKKZ/x7iq298LlEVkRjgAtHviOu3ZocqlIsQvsCxr7yCCvKArYrTl/f71NoR0w
 OyjtNAZWxfRFXj1vPyklxpeh46FKqyy0h0XRvKTSXvwVNCg9Bhc9UT3ELX+BdoEmp4z/
 hNEfShdAC/0PoQM+8JkS3eonaald+FGY9Jcank27nEQZgu1xmQ7Oy4JdXFKhb8KjlTON
 hAxLVs7AkwE5WL49AsTow5MVHLvW7umZfNsu04v1GNkWhkvRW/h6HURroc8WG6/hgVoj
 TCbehjvZCk2E1+uKb713ejLL8EtF3YOm+I+W4b6PA+RewT1rGFib4urQANJcaW4/1/d0
 lYGQ==
X-Gm-Message-State: AOJu0Yzbjdoh/cJhXChKOAbrEEtBVwLUdukqlg1uXMr+nj0QgvD8gfTd
 PlCdjcHeO5G4elbFgOvgLj187JIcBdE=
X-Google-Smtp-Source: AGHT+IErLCkzzfphTceps2SLpibn8bI7BSNAnHLgeYYC7sndT6BqbEywdb6MCWv8GXHO4xAkaaplmA==
X-Received: by 2002:a7b:c456:0:b0:405:4c3a:796f with SMTP id
 l22-20020a7bc456000000b004054c3a796fmr7088676wmi.2.1695666370192; 
 Mon, 25 Sep 2023 11:26:10 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:26:09 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 15/28] bsd-user: Implement several get/set system calls:
Date: Mon, 25 Sep 2023 21:24:12 +0300
Message-ID: <20230925182425.3163-16-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
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

From: Stacey Son <sson@FreeBSD.org>

getpid(2), getppid(2), getpgrp(2)
setreuid(2), setregid(2)
getuid(2), geteuid(2), getgid(2), getegid(2), getpgid(2)
setuid(2), seteuid(2), setgid(2), setegid(2), setpgid(2)

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-proc.h           | 90 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 60 +++++++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 38d1324034..6ff07c0ac3 100644
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
index 5cb6086230..7565e69e76 100644
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
2.42.0



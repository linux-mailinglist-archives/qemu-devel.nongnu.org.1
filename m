Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0367F78B91F
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:11:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiZK-0000dV-0T; Mon, 28 Aug 2023 16:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZD-0000Dd-6s
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:32 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZA-0007hv-LA
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:30 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2bc63e0d8cdso53699211fa.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253427; x=1693858227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FfDO/oLREWOgvChfreFQXRNc1C18wUr8pkfeiWN8VI=;
 b=jpCrcsPY5hVRUwIqq4jQRbqCBIfKjSiu3o88+sJhjpkmVjXtxwUI2thQvObrlGTdJc
 SAp6m1j9IUnEsc/6+LUP9j9lrKZAMj8x+EU6jrd3zK5gvBdQ0VnwLsYEAbrx2ZsuXWq7
 r9srfBNERfblEldOTUVEtnpAuDw9E+JH3U3pzCag5dIPdlpSKoBvk/thNaEQ6XEOsVeB
 zRMlE9YiELSXs9ZlGlDOFKKp60cGVWAN2nfcylfKwOnQAcDVk1szMldxLGqRz1WUwZg0
 9s6eGcdmmWSUVY2DUaIHXN030y6XqpYLgN698azY1k4f8WcCIG1przHYtlspyOShdRwm
 VR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253427; x=1693858227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+FfDO/oLREWOgvChfreFQXRNc1C18wUr8pkfeiWN8VI=;
 b=gR2GrBpOk1ZXP0ccU7jVl/nmGrKLuCGvVaSWhWiUtJwbQ5lEVAMMG378ly17FKJCUI
 8UAVpAxtmTWXQH5YI1WCCAdApF3qnbvqdzi9w8DLrcY6PP/jCWv+Q94iAROO4ZRUqR0l
 FpJDHU120ReTQlm5WN1zx25ae3LjevBgqqchPrYkHq0aTMJyoyeWAC+OBfcWmzMxA9Ai
 XfNAoP4N3gvqwAv5OC5PoJZNrUoYrCHPadTe/JGMYvwSGVTNpl3AFD/tmRZNLAhArMyB
 9kUsY+UaIPUKhMFyCNx+HtAr5OXTeusvgGTGQhdQB88e8nmagMAAS50Qp9dS6HZ30wvj
 KShQ==
X-Gm-Message-State: AOJu0Yxm6ql4TOx+U7SyW3oKg6v6u6ioUBfc8mSHeyD75b/VeFl7Lnqd
 vPojNLsTKrHiWCi3w8mehNzI2ory7esHHA==
X-Google-Smtp-Source: AGHT+IEkT2JXnI2KqwYxR2vn+N1qILBUtPvQJdEctPEbean7FBovJ7es+jx9sKBwtLSzyi4n+V9YFw==
X-Received: by 2002:a2e:9c1a:0:b0:2bc:b224:98ac with SMTP id
 s26-20020a2e9c1a000000b002bcb22498acmr19066298lji.31.1693253426622; 
 Mon, 28 Aug 2023 13:10:26 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:10:26 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 16/32] bsd-user: Implement several get/set system calls:
Date: Sun, 27 Aug 2023 17:57:30 +0200
Message-Id: <20230827155746.84781-17-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
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

From: Stacey Son <sson@FreeBSD.org>

getpid(2), getppid(2), getpgrp(2)
setreuid(2), setregid(2)
getuid(2), geteuid(2), getgid(2), getegid(2), getpgid(2)
setuid(2), seteuid(2), setgid(2), setegid(2), setpgid(2)

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-proc.h           | 90 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 60 +++++++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 2c225b12bc..98be0be2b9 100644
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
index 5467cb2341..af3aff778d 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -252,6 +252,66 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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
2.40.0



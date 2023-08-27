Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 378D178B939
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:12:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiaY-0006lA-Af; Mon, 28 Aug 2023 16:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiaK-0005qs-Ls
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:11:41 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiaI-0007q9-C2
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:11:40 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2bcb89b4767so55162891fa.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253496; x=1693858296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YmMYl0lwlsytwxMprOyvw1gSSdgBh5EwqBMU6oovPxw=;
 b=iI3QE1mnpTwP7PGiyWn9SleUwA8vhgy/tYQjSUIz+pDDyGudhniaRup5LNWUaQrkuk
 AT2GJaZk5RHIJxM5ekfUZKWuMrkGecKZlNlbXoljqxLuAYtiGOq6HGLXB/Y9cXN+Ioyn
 1qHb+2v0W48odFaGrKPHpgqahcd820XO0/yGnu81GcSiJdojkAtKFi0LNsTC7tdx3lSm
 /A2qzvrVQk2y9cRxztYIKJnZ6B6rEq4mEb74bKfoFJwbtV0rAFsufJMkJX+2sPrG1+pb
 iZjvC+qwP13S9Tdy62XSpZyfSXFPGgNU+5crF0G720YsNNkKmUWBbroMjWjbyloRhhfS
 3Gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253496; x=1693858296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YmMYl0lwlsytwxMprOyvw1gSSdgBh5EwqBMU6oovPxw=;
 b=iMj0YBI76tm9KYRxRUWvTH/yZX4UIzsgx7Biv41ndLLOHDCanGL28MxU6r7kG1Jo52
 G16/l9kWbQt7dv/n6MzSMoGTMvjiZJM9nIoWzLayZbUNPwALE1pFoOy6kf33bSGtAxDT
 6GYHuw/OMVmclqlJO6crL86frenJ4p2PYuzz5OrJqNVpAbzmy+Q9Tno+WUbTUloounJt
 Jwves3YQsoIjKEPLPU7Z8F7bOPiNb7zBls1cLpGRlUHC8+CXUKJZpF3VsI/CGjXeyM4c
 Va58Tx7WH6o7dk8eRYQih+gp08RfvvS8fZd3jZmSdhxJ21uh53bdSpilHg9YWgHjldxZ
 hCyw==
X-Gm-Message-State: AOJu0YyBMKbYbOm7aW/zBGaAS5+h1mVBVVbrH4Z742brbCBTrdHFxo0U
 it+n8XYe3DF4Cs0pfpaswUcJh2wONZQ1VQ==
X-Google-Smtp-Source: AGHT+IF8EieRj90GmQOBnAJCY7nuU989NQZ/qviLV92O1XFWaUYwHAZ6muv5lrjyhgQCMgtSYA5MIg==
X-Received: by 2002:a2e:9c81:0:b0:2bc:c3ad:f418 with SMTP id
 x1-20020a2e9c81000000b002bcc3adf418mr19295984lji.20.1693253496156; 
 Mon, 28 Aug 2023 13:11:36 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:11:35 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 29/32] bsd-user: Implement pdgetpid(2) and the undocumented
 setugid.
Date: Sun, 27 Aug 2023 17:57:43 +0200
Message-Id: <20230827155746.84781-30-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-lj1-x234.google.com
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-proc.h    | 23 +++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 7d26d09148..bfd72c726c 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -34,6 +34,8 @@ pid_t safe_wait4(pid_t wpid, int *status, int options, struct rusage *rusage);
 pid_t safe_wait6(idtype_t idtype, id_t id, int *status, int options,
     struct __wrusage *wrusage, siginfo_t *infop);
 
+extern int __setugid(int flag);
+
 /* execve(2) */
 static inline abi_long do_freebsd_execve(abi_ulong path_or_fd, abi_ulong argp,
         abi_ulong envp)
@@ -153,4 +155,25 @@ static inline abi_long do_freebsd_getloginclass(abi_ulong arg1, abi_ulong arg2)
     return ret;
 }
 
+/* pdgetpid(2) */
+static inline abi_long do_freebsd_pdgetpid(abi_long fd, abi_ulong target_pidp)
+{
+    abi_long ret;
+    pid_t pid;
+
+    ret = get_errno(pdgetpid(fd, &pid));
+    if (!is_error(ret)) {
+        if (put_user_u32(pid, target_pidp)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
+/* undocumented __setugid */
+static inline abi_long do_freebsd___setugid(abi_long arg1)
+{
+    return get_errno(__setugid(arg1));
+}
+
 #endif /* BSD_USER_FREEBSD_OS_PROC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 63e6c6d478..52be71546a 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -380,6 +380,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd_getloginclass(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_pdgetpid: /* pdgetpid(2) */
+        ret = do_freebsd_pdgetpid(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR___setugid: /* undocumented */
+        ret = do_freebsd___setugid(arg1);
+        break;
+
     case TARGET_FREEBSD_NR_utrace: /* utrace(2) */
         ret = do_bsd_utrace(arg1, arg2);
         break;
-- 
2.40.0



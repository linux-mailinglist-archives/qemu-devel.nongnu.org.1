Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3317ADEAA
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:27:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHz-0001S6-J8; Mon, 25 Sep 2023 14:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHt-0001OQ-Jt
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:30 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHq-0007SQ-Ut
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:29 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-404314388ceso76770205e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666385; x=1696271185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ApAZc94aZDAcSIMEKeIK9l509Mfqm71ecKv5+mWNoME=;
 b=ZBfivFyWTUlQpM+Z5j2mb6vt7xR8RxuFXpRQ1GBghGAqHL/UxZ5yy496h8mVfAOGyn
 bvw5AmZ5rvJkcL0EbYLzc4DdQPdIh3OLjHA0cDCYQObMmT2dQlSOGZ9v7FpBEMfVaLdv
 p7wQD+PkXi/1ncavn0aXT99SqSfyHcKjD0cG3KlCAOco85Y5pwuxKBKT/6BLOlPuEZNc
 jtV62bHOmpPbEElkL39tb0XUcVsn2CyZFWLzA4oIAl8ckCdNpTeVwp/Py2Fq907SecgI
 qIoVvPKIkwe2SGMRn+A+pAbYT+p793Vap+wAYtI+xvd83fiqW5e4tjJo9bZMMlk7CwSD
 DmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666385; x=1696271185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ApAZc94aZDAcSIMEKeIK9l509Mfqm71ecKv5+mWNoME=;
 b=UpAIfRrh7cQVWoNAiN63y5jVv7Bq3jFFvTteGTIh9yTY2SEx/ngJNipEP79nD+HWHX
 H4emu4qDgfm2WCLMKQiQ42BnXimZRa1dxnv81AV/UFafC0x7KnlkGWuys2/TmaLPXzoT
 biDod9RR/MV47bf+rc8Fit5xagiK/nkPPK7xzy2c7uMHJAHS6nmIceoZq7X+SQ2b88S1
 Pgg2ikxnr+oPCWRVCZI1eulu64KjnTgDRYXAZJE80asOfI4Db/UHVX9Gx7vL/fgVQnPK
 /CiCebz3Oe1lkcEkXiwSVw7kMS8phfulPNGSUh8VnMbH1MDlpUfrmw8PCbleoNznCIUN
 dyHw==
X-Gm-Message-State: AOJu0Yxr5wUra4uqSljr8AepvCLhJb4U8fKh5q9oVbzuQp8M9uPAlK4Q
 kGT1J4brdnm0Oj9+C3XPQaIscDurT1s=
X-Google-Smtp-Source: AGHT+IFzIrpeSgOnqMf+3eXVlAdHWULE0WFf0PYt0UpUl5IdObGLvVmFoQunz06W35QEKHB4tXiTJA==
X-Received: by 2002:a7b:ce10:0:b0:405:3d04:5f4c with SMTP id
 m16-20020a7bce10000000b004053d045f4cmr6470151wmc.38.1695666384933; 
 Mon, 25 Sep 2023 11:26:24 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:26:24 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 26/28] bsd-user: Implement fork(2) and vfork(2) system
 calls.
Date: Mon, 25 Sep 2023 21:24:23 +0300
Message-ID: <20230925182425.3163-27-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x329.google.com
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-proc.h    | 34 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 42 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 42bdd61904..7b2e6a9f79 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -185,4 +185,38 @@ static inline abi_long do_freebsd___setugid(abi_long arg1)
     return -TARGET_ENOSYS;
 }
 
+/* fork(2) */
+static inline abi_long do_freebsd_fork(void *cpu_env)
+{
+    abi_long ret;
+    abi_ulong child_flag;
+
+    fork_start();
+    ret = fork();
+    if (ret == 0) {
+        /* child */
+        child_flag = 1;
+        target_cpu_clone_regs(cpu_env, 0);
+    } else {
+        /* parent */
+        child_flag = 0;
+    }
+
+    /*
+     * The fork system call sets a child flag in the second return
+     * value: 0 for parent process, 1 for child process.
+     */
+    set_second_rval(cpu_env, child_flag);
+
+    fork_end(child_flag);
+
+    return ret;
+}
+
+/* vfork(2) */
+static inline abi_long do_freebsd_vfork(void *cpu_env)
+{
+    return do_freebsd_fork(cpu_env);
+}
+
 #endif /* BSD_USER_FREEBSD_OS_PROC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 99af0f6b15..cb9425c9ba 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -226,6 +226,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         /*
          * process system calls
          */
+    case TARGET_FREEBSD_NR_fork: /* fork(2) */
+        ret = do_freebsd_fork(cpu_env);
+        break;
+
+    case TARGET_FREEBSD_NR_vfork: /* vfork(2) */
+        ret = do_freebsd_vfork(cpu_env);
+        break;
+
     case TARGET_FREEBSD_NR_execve: /* execve(2) */
         ret = do_freebsd_execve(arg1, arg2, arg3);
         break;
-- 
2.42.0



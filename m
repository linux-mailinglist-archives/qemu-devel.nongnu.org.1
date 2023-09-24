Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F402A7ACE36
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:38:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbTB-0003kM-EM; Sun, 24 Sep 2023 22:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbT8-0003fi-54
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:37:06 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbT6-0000AB-Mn
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:37:05 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4053c6f1087so45543315e9.0
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609423; x=1696214223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ApAZc94aZDAcSIMEKeIK9l509Mfqm71ecKv5+mWNoME=;
 b=cYpjw2zaJ1/CVeW9Kb969Nx8ZBkXqRPuCrA5UgtSvoAvOAvmOZpVXQkPW/t+n+zuFJ
 P73oAukdMaT2blgqfLIpVuZ3V2l5NypRBBv3sM1lkkzJuoHOAeWYKyO9nQiEeqVMQVKK
 D4CorKXnxQXooqL9H4kz3vADHcWyp92PQUyaV3n256k9Kjt5OdKvUdXxr2KQC+KECogk
 Rw5e3tg1jrUrLkjblxZrmL5kjzV4eV/zir9umZXcKBaL5MZ5pWYLL1SyJ0+/M80crPkA
 0HsOtC2ahUlxnjaExhPOuImrgSxc1F0Epgk/D5H6SROeQwcf5ihBQngK7E01VQQ7Rkbx
 NZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609423; x=1696214223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ApAZc94aZDAcSIMEKeIK9l509Mfqm71ecKv5+mWNoME=;
 b=N4tvc/zPrHbH3KypvFvgQiDRL9RxNdgAPuK13ewNEHy/q8Q12lTcKikSYOTGbxq6Sm
 ptvvgOE7WUMfroxLamzMqflmdY9Q2diRQuObInxFLOKENUd4gmCk/Q9uqzLdsaRKraGt
 amrKmqUB68ah3eXx1b3Koqil329Mf/vs4isTfjcQSXv7O2q0c9Ex6LbwY1LtuxnyHk/J
 Fa0XQaloX13BqHmWn1NL5GEO9MaI3nOMDE6CmXOOjAERIesUvGFevcQWmx2YRq+wbErm
 shuBaacePQz2gFiIUOBN26qsQQbZ6jFApEhxGzd080vsOiRAxKCXgNR5vUwviKebGnrH
 cUUw==
X-Gm-Message-State: AOJu0YwDuAMo90UdtM1oSLQlYzR+RiSk9AAZUBO3x/aKKuhkpTMAUOps
 T9NwI3mWohU/TO+3PULOFHlRjNUvqFA=
X-Google-Smtp-Source: AGHT+IG5D1I3wdq9PU6/gcEpbemyqpBgzbYNBEsZCz9g2C/uKM1Dpm06hxBQ2+uwFyxZH/xYDCV8YQ==
X-Received: by 2002:adf:f4ca:0:b0:31a:dc58:cdd9 with SMTP id
 h10-20020adff4ca000000b0031adc58cdd9mr3843686wrp.60.1695609423098; 
 Sun, 24 Sep 2023 19:37:03 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:37:02 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 26/28] bsd-user: Implement fork(2) and vfork(2) system
 calls.
Date: Mon, 25 Sep 2023 00:01:34 +0300
Message-ID: <20230924210136.11966-27-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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



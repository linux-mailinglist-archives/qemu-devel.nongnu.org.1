Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 320107A3E7E
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:27:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0C5-0006fC-PX; Sun, 17 Sep 2023 18:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0C3-0006ej-IK
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:43 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0C1-0002ye-V8
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:43 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31ff2ce9d4cso2441776f8f.0
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989480; x=1695594280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2S8FXSzNKMQIuGGPJ7n1TKh338FdyhommirmsIYSgdk=;
 b=i7gEGDC7FPc1omTlYN9GVi5hTFpd3FnW0qy1EwvLQ5XRPcoM2cLy1/ozhWR8olZd95
 HaaoXN4FOfB2CgDMEj/e2XaIZR+KBXcElFg0JQiUafvmPWJaGFygQ8zDNORA9Zg43sjb
 U0Qaq5QXJGMrjw3nVU4vI6KXKvYRezXFrXf0WbG9+hD7nMo6X3JuwP8TAyIn4qqr4P4j
 8XKCfnaoSjhAEJN3+D+d7VuZuOWftAjO40DTolS/n8XmNaV/GFyIcP2UYyO+CCcSGbFj
 +bP+0gW8sB5iqB96DrNtAWN24lISdgtPmnN65NzkIae048VR4GUWw3aOEmBVsySsmL2R
 UCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989480; x=1695594280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2S8FXSzNKMQIuGGPJ7n1TKh338FdyhommirmsIYSgdk=;
 b=g3mwJzD4LiqzeOinp5XeC4qCICns/vsWLijLofeFZ7AwSxDQx/j08yMqz5ZvJVV3j6
 qjFcODJlmBksdzsZsPxpm2oFd6tePC7YocKDDhlmB5YWbyez5th3/E1CEAsPEcc2Ml5p
 Q+PCUBvk0nMjscyqOX8NhqlrhGh/bO5p3W6KgJUE6ykgw0S1SPBwsHmvv1kprYW00Ph8
 ukNgfU77Y5piM8Yh5FyvPSaZB4hcyK853Qm/tdwLhukr6g4lOuKFI93XQYSi3Nok1Zx1
 iffs+V2ZSA0DTk+8h04De7h0liRN8lJHjKppI9wjYR2C3y+p5Z4ymdptQEuf6EqVRzJv
 2y6A==
X-Gm-Message-State: AOJu0YzI1+JPxh/3PmDMtyR4wtfEuqUVEI5DcsmhgtvfG2zU3q3EPWLK
 BevM0gKPVTPw8OdChk9WuhFBjd8rBMs=
X-Google-Smtp-Source: AGHT+IHtTRyz6ECq3MI3zw2MXcDkTYXlZjk1IBPTMKGpLfjGliOv1nLy+bKYHwmoV/vs+iMKknCXNQ==
X-Received: by 2002:adf:a30d:0:b0:31f:fa38:425f with SMTP id
 c13-20020adfa30d000000b0031ffa38425fmr4509152wrb.9.1694989480123; 
 Sun, 17 Sep 2023 15:24:40 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:39 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 26/28] bsd-user: Implement fork(2) and vfork(2) system
 calls.
Date: Mon, 18 Sep 2023 01:22:43 +0300
Message-ID: <20230917222246.1921-27-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x431.google.com
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
---
 bsd-user/freebsd/os-proc.h    | 34 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 42 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 964be4ad87..23b2f77a73 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -178,4 +178,38 @@ static inline abi_long do_freebsd___setugid(abi_long arg1)
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



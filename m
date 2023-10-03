Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6B47B7547
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:40:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovU-0004Da-Ql; Tue, 03 Oct 2023 19:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovQ-0004CE-JY
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:36 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovO-0007LN-W0
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:36 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-352a22e1471so3963935ab.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376132; x=1696980932;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DTFZRe9LfB18mFM3p+ZpT+MrPqZPyJHc23fZZDwLdFE=;
 b=D9T2BYTxt++7e/53rwE4X5T4bRkeX2DG+cYF8aMVKm0l57r5c97iBFo62ohLy5aWIP
 S3+BtSlh1fl3ue7bybbwHFjRnkxTNJeEQaM2NPPswvtOB8n27BkO6ltDjCKkkeT44XtD
 yYZerYQzNp2gS69oX0Zod88G5V4UFMjnrigKdkjN21VOHCtUoNwJ7DorfjvfWEh6tVSv
 rr+Pp9LP2+SNEK3FqsV47945HqURnMDvA9DNuThDG6jsRl9nvoS8kd7B0mPPl07oCzh5
 WCSfAuTCnQRgYAQnJKqw83yrTdPwEwWlXHKcemLX1ZB3zFu8C2xVWm+h10S+kggjS9tf
 Qm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376132; x=1696980932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DTFZRe9LfB18mFM3p+ZpT+MrPqZPyJHc23fZZDwLdFE=;
 b=ORUx0Yyl7iILL2cpYWuSoYnWlGm2Er6j3GI959rgmxbHVRNaWX5HDPi/Oj2UHQdqJ8
 hg7tN58hLI92MxuEMoFXiojp1nR+Yrwy+sfbDVe5ADuwUPq42bplNUzq8Qy/JSBVQu61
 OVlJJAd+rkP3ZxO+y1emLvAefKRs4N/0VsEhiDZNmS4BMBGItu42OAbI0nCkOsUX5lAW
 COpTD4TTEkK7kOqV1TCXQylILfuUsDZb1x4axKQ1S5HoGY/bnx8dxVoZZGe41k0obhKc
 ZcmsvrF+9OGL/9ZiKX3hbbCPeLsxaobKfsHsW4vY/iCCKcOgYU8HxMkMJ94PrWXJHA5L
 +XtA==
X-Gm-Message-State: AOJu0YyFxrvGvzzITj6/XG+FPZ3uroGDg7aBe3V+hpsKOs8Hp4Q1aLXC
 QutQUBhgNCWAzC5DFh4VrqwG2Pg4vvYDKSA7eFvxPA==
X-Google-Smtp-Source: AGHT+IGvTmrSLkZuJjT+BfaWx+ag3NAfOIblLqYg1kSir8JnTT+It79ypmJyGEaw4Is9GC25EJlUtA==
X-Received: by 2002:a05:6602:3351:b0:795:16b8:8601 with SMTP id
 c17-20020a056602335100b0079516b88601mr911418ioz.0.1696376132452; 
 Tue, 03 Oct 2023 16:35:32 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:32 -0700 (PDT)
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
Subject: [PULL 28/51] bsd-user: Implement pdfork(2) system call.
Date: Tue,  3 Oct 2023 17:31:52 -0600
Message-ID: <20231003233215.95557-29-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12b;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x12b.google.com
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182425.3163-29-kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-proc.h    | 32 ++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 36 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 0a3cd0ef57c..d6418780344 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -258,4 +258,36 @@ static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
 
 }
 
+/* pdfork(2) */
+static inline abi_long do_freebsd_pdfork(void *cpu_env, abi_ulong target_fdp,
+        abi_long flags)
+{
+    abi_long ret;
+    abi_ulong child_flag;
+    int fd;
+
+    fork_start();
+    ret = pdfork(&fd, flags);
+    if (ret == 0) {
+        /* child */
+        child_flag = 1;
+        target_cpu_clone_regs(cpu_env, 0);
+    } else {
+        /* parent */
+        child_flag = 0;
+        if (put_user_s32(fd, target_fdp)) {
+            return -TARGET_EFAULT;
+        }
+    }
+
+    /*
+     * The fork system call sets a child flag in the second return
+     * value: 0 for parent process, 1 for child process.
+     */
+    set_second_rval(cpu_env, child_flag);
+    fork_end(child_flag);
+
+    return ret;
+}
+
 #endif /* BSD_USER_FREEBSD_OS_PROC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 4c4e773d1d3..d04712f0a7e 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -238,6 +238,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd_rfork(cpu_env, arg1);
         break;
 
+    case TARGET_FREEBSD_NR_pdfork: /* pdfork(2) */
+        ret = do_freebsd_pdfork(cpu_env, arg1, arg2);
+        break;
+
     case TARGET_FREEBSD_NR_execve: /* execve(2) */
         ret = do_freebsd_execve(arg1, arg2, arg3);
         break;
-- 
2.41.0



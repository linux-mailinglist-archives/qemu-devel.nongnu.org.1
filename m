Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E207A3E70
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:26:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0CB-0006h4-QP; Sun, 17 Sep 2023 18:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0C5-0006fe-WB
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0C4-0002yy-Au
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-404314388ceso41531385e9.2
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989482; x=1695594282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lHrLm3D+56wj1h7VzyOPMu3lSfb2xouAbdsbSwPc/XM=;
 b=d0ACD9wawtQb5fpyPPAV5LNLc/GMcVSGskhI5Xgx0ZYe3amzm3ljeTV7vSJLgnF9Fw
 s8caqei4s+ACxUifaTy5li0LlyhwlcDhZWhyxkMMMkqEJQBwkd7tplHiF7PgQ+AwPJgn
 0/M3FDNpQja3Lkj9XULi72BOGdMk13XTm8W2RBSMZSCUe+RcGlR+HnrWoE1WgIyTAqJc
 sTrHPLSxHgKs8C25ZUWdC5t/7mPKDOLQlXcxhdyjHfJr2At2d1Xw1XM1NAbEU8zP4+rS
 gEVRWpQ88biQqS6iAfzrXT/JuSYHwt16qrIynjHL91Wf5aSDJAeQti3HB8mNw86LNvz1
 O8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989482; x=1695594282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lHrLm3D+56wj1h7VzyOPMu3lSfb2xouAbdsbSwPc/XM=;
 b=rEG5UYRbHA5m2rwCMtVM0kXbcBTd1Zq60burCtKGE6Onqyfbkk4+ykfG4/ZMBd0ie3
 Np9Uh/mU0ShNPbDpNy54liko5nZGQ1omK26k2vhUbuIsZBr5VKbVVriE1LqvJUY5QBZ9
 Htrk/ZiFy3DikU4lspyWGaJHbmM3jfncGALras3TlYK98ahLLs5YyxKVIQANbbVGPMDs
 Atr92IrYvXI88abGnxaUZu9BBl5PQBOc7I8vc+/3cer462/R5aP8Osaq8/btqWSxAwNO
 N1INOOD8ogiLTkprpTzDXp35ADKsIa6LfHDUeoxsHCzisv3u/iRSV9LUByMvQzymReM1
 mvww==
X-Gm-Message-State: AOJu0YyKNl/o2/puOMo9aN+1s/VEKwAXVmJ3Iv+q3SaHqIS+iqyxSLg0
 LiY1jYIba0AAGsCEh1yVTw3giJwcTVs=
X-Google-Smtp-Source: AGHT+IFbgUmLJKzd4mtrkhSMjOChWcCvmfAdBNqlHcoUDrcyKQYJUEvHvOz1Zgjv5lWBkO7514uLHQ==
X-Received: by 2002:a05:6000:68c:b0:31f:f72c:dfa3 with SMTP id
 bo12-20020a056000068c00b0031ff72cdfa3mr6689122wrb.68.1694989482591; 
 Sun, 17 Sep 2023 15:24:42 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:42 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 28/28] bsd-user: Implement pdfork(2) system call.
Date: Mon, 18 Sep 2023 01:22:45 +0300
Message-ID: <20230917222246.1921-29-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x332.google.com
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
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-proc.h    | 32 ++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 36 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 6121af9efd..57ee20a93f 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -251,4 +251,36 @@ static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
 
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
index 4c4e773d1d..d04712f0a7 100644
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
2.42.0



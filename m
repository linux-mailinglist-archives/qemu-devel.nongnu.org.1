Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8A77B7542
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:40:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovR-0004CL-FN; Tue, 03 Oct 2023 19:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovO-0004B9-GK
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:34 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovM-0007Ia-SK
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:34 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79fd60f40ebso14549639f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376131; x=1696980931;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQQ6DsBUp3HuF6Th08+OwRbSNoljuWJ7IZ0BaPOPKuU=;
 b=DgMx/F4TzGh65v5iKlAazAvWIRffmccsifR9+eFmpK95Rhne8l9me1SMAptN3+KJsZ
 Nef9JW9Xd8gLqZhVbtYzSHiH1R8TOppuNXwM1JI0Zpa02PgQ8UgIkF1qI4SYq6cH/3lF
 bfyyL6/+c32aqmHzEhBOCd1MFGnC9TjoFqkDEZgSRozC+eRoG1PaUUAIBVm1rHr4xR1t
 0HYALDI3WXHxMaQQEonHRhuJHlQPLZEsyA3fu4/rUP/3TwxBjRrSM95gH5Zl67GBo7+a
 7tG1GPDf4WgPoA8BuyMVJelS8uYQKAXjAjnj8IUfJK/KEwqT2tkHbqSJJWGWrbOuuIEJ
 QPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376131; x=1696980931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SQQ6DsBUp3HuF6Th08+OwRbSNoljuWJ7IZ0BaPOPKuU=;
 b=eix8awYOhUe7YKShxAnnC+BRFCcUn5XpZ6pdg7zw79EFwlIyMwcwvFI1c+Vu47MgKF
 ZrF6JH111EAKoQm02L6bWHqo7LzPm5TxsPEdAHCG7LbeyBCOoTYM6HsuNaIqn3pvXgti
 7VTBIFKtTBGhAI26Ai+p0U6/O+aK8O9wW7M1bn7gEjO3FLzBDTymY1boy5xcYL0a8aXj
 rAkStXZQQ3CQ/wkAMEdFlMcOMcPXm1rUsw3AUMFFiyUCEh6qJvgW9EcCTWpxcYTDi+Jn
 6XlZz/jpSS7xZu7CqBUGgnN02eq6Di7r3jwriqa8N89KYeBWQ65Fb8f6uPxtVpHGWvvv
 Rg3A==
X-Gm-Message-State: AOJu0Yxdl4OiEja9Mblln9+30bVFR/igwOMQBbqjGa8mN8Gx+iR9g6F/
 AFz06Y1ir1d/bW1jyqjkYcBKQdgLPC+LUJf7/ntgwQ==
X-Google-Smtp-Source: AGHT+IHA0YZegynhPVgC+6AGqr0VQC9nz2t1IK9PjcbvwxDyW+15XF3/FcgWRvrwJUUGliAbuaz/hQ==
X-Received: by 2002:a6b:7f4a:0:b0:79f:88af:500c with SMTP id
 m10-20020a6b7f4a000000b0079f88af500cmr543723ioq.4.1696376131531; 
 Tue, 03 Oct 2023 16:35:31 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:31 -0700 (PDT)
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
Subject: [PULL 27/51] bsd-user: Implement rfork(2) system call.
Date: Tue,  3 Oct 2023 17:31:51 -0600
Message-ID: <20231003233215.95557-28-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d30;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd30.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182425.3163-28-kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-proc.h    | 39 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 43 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 7b2e6a9f796..0a3cd0ef57c 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -219,4 +219,43 @@ static inline abi_long do_freebsd_vfork(void *cpu_env)
     return do_freebsd_fork(cpu_env);
 }
 
+/* rfork(2) */
+static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
+{
+    abi_long ret;
+    abi_ulong child_flag;
+
+    /*
+     * XXX We need to handle RFMEM here, as well.  Neither are safe to execute
+     * as-is on x86 hosts because they'll split memory but not the stack,
+     * wreaking havoc on host architectures that use the stack to store the
+     * return address as both threads try to pop it off.  Rejecting RFSPAWN
+     * entirely for now is ok, the only consumer at the moment is posix_spawn
+     * and it will fall back to classic vfork(2) if we return EINVAL.
+     */
+    if ((flags & TARGET_RFSPAWN) != 0) {
+        return -TARGET_EINVAL;
+    }
+    fork_start();
+    ret = rfork(flags);
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
+    fork_end(child_flag);
+
+    return ret;
+
+}
+
 #endif /* BSD_USER_FREEBSD_OS_PROC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index cb9425c9bab..4c4e773d1d3 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -234,6 +234,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd_vfork(cpu_env);
         break;
 
+    case TARGET_FREEBSD_NR_rfork: /* rfork(2) */
+        ret = do_freebsd_rfork(cpu_env, arg1);
+        break;
+
     case TARGET_FREEBSD_NR_execve: /* execve(2) */
         ret = do_freebsd_execve(arg1, arg2, arg3);
         break;
-- 
2.41.0



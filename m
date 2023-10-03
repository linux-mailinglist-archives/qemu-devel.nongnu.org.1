Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ABC7B7515
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:36:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovP-0004Bo-Nn; Tue, 03 Oct 2023 19:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovN-0004AU-K6
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:33 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovL-0007F7-Sx
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:33 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79f915e5b47so59907139f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376130; x=1696980930;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wO4tVRw6GlbIQ1GG5INdJAgQnEIiQn4ZKOXZr2a9REg=;
 b=SLvtC4hncjChD5ZpgsuOqTHaOFzcl1QsOEl+C+FppjndkAUmYTplzr/SIVM1wa1aL8
 /HuDqwx1yg494D8m1HAtrIeBBzl1nKmpuxxh+0ZCdYYbinPiti3FpmWujMS5F+OAPZmo
 9/PfjCANLqm83OlWD+b2UHJVPkJecCzsetiV/x0A8Vo18GVrAIGujyxwGBVWuBkzglNX
 4o0kpHSbIEMoWnk5jFWXduFk6p1aJ8RCrORoQj9D2WhecxhhRY3tEuVHBSEOaqzKSq0N
 P+CCUxX4BwiVjWpEmKSUWsghfyhnbp8P9GfcvavZooXLDqmIUFfd5m99ByC9rVifP6Qx
 h6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376130; x=1696980930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wO4tVRw6GlbIQ1GG5INdJAgQnEIiQn4ZKOXZr2a9REg=;
 b=XMsuhXT69VdNkCzJEYJFNPkTGfgizxDn7y3rnFgS0HsMS0z6vd3mI0o/HfEfNleUec
 ciCkv/mp2FREDXMW+WPTDXyl4knj5m3l3lwHGtmDo7354sR7mklzJvhE+buptNzwowXM
 Aj2FF9L+R8Q9ufZL74U73+01/uFgvWMkL6Af0T06pxX17LXP5nNgnzCrUBr8OTas4VjO
 nJSuItbon7oF3HqMDPNmm0MnTs3vDN39NxYFEsf4VLaD/odhLYb3BttqJGAIetNNses6
 K6Mvu1vDG2nriA/dhGsQ+Ky4fnGonp6iWKQ8FFpjsfSnTpRkz44llTQ3m8miTpfdNwoL
 h2fQ==
X-Gm-Message-State: AOJu0YyJeos6Ow0Yi2wMRyRhq16OABuCkHWm8tqb9WGw+DPMYZ5Z4tPT
 qz/bGrYB/Xc9qVCHL/rUPmQXiu3aMw4ANNEgliVFcQ==
X-Google-Smtp-Source: AGHT+IGy6my0ZZD3fR0/wBbzmX+GSQs9ow4UL5S88V2q6PF3OzIxSy9z7nR/MitvADImGLqJT9UXkw==
X-Received: by 2002:a5d:9c1a:0:b0:790:fa58:69d2 with SMTP id
 26-20020a5d9c1a000000b00790fa5869d2mr958587ioe.20.1696376130604; 
 Tue, 03 Oct 2023 16:35:30 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:30 -0700 (PDT)
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
Subject: [PULL 26/51] bsd-user: Implement fork(2) and vfork(2) system calls.
Date: Tue,  3 Oct 2023 17:31:50 -0600
Message-ID: <20231003233215.95557-27-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d35;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd35.google.com
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
Message-Id: <20230925182425.3163-27-kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-proc.h    | 34 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 42 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 42bdd61904b..7b2e6a9f796 100644
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
index 99af0f6b156..cb9425c9bab 100644
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
2.41.0



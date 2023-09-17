Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5497A3DE7
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:40:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzVF-0004fS-42; Sun, 17 Sep 2023 17:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUq-0004dv-Fz
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:40:04 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUn-0004KA-GM
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:40:02 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4050bd2e33aso2275465e9.2
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986799; x=1695591599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H227gA3OyYFvq4OxqZqbzoLKSUHlAdHUEYmn3BUB/W8=;
 b=elyLhH9tRC7oEQqHgl/+b8Pn9fWIL5MfZPzCY5f5s7ejKkECwNqJxMx5Sm52sKJ6bT
 /T754jBox2jPomG0GmWfbS7bXSuRMFGOXCX+Ri/eeDxb+8KDv2JZKGR+YRXuRAJhzEHX
 fdUbBcR5HxF7T28vA5FoKGAoiDRaXntrthKhQdNjX7s+4pUkcI3xnQWZF8Nrptd7x3fE
 TJzUW7aaVTgXjkGhNU+Boyd7RaT8xQV4WRX5ohZWHsE9fKgw34JX/2OZT/DIHQOrHhgw
 AdbhG7RWYcGBLQN9Ex8Zhqj9DCbgYYGllWdhdE/Bwc/I9yOZqR52DqeRKdzm8w4SJ/+h
 72iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986799; x=1695591599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H227gA3OyYFvq4OxqZqbzoLKSUHlAdHUEYmn3BUB/W8=;
 b=TxWRJ+yOT5TJgju7RTOunAKHLJ3xKp6LNvCzmxlDIM9BgmMxyJhvD0Cykm8IQQXKGd
 b+s/kGzGyP38wtOmOOlU6w1C/nhhE0UtL7yxANmJVScf428aMLNRVtWDqQygks1IkHfW
 O7Js/s7Ec9Ur1VUIQThx9EUvJT7MMu4coVsYbxgDRXUcDtYosS8B78tPpGU1isKGFnTP
 KDXE8Aj4e7Z2qJPWoykCWoTFN81oBmF10/t3IADVdsc5GgvY4UpOL/IE/D725PwAiNdE
 qvfXLC5U+pKfy8CtJmf/4f0OeuMm3noHc4auqTE6jeB9VHFzgoaIH/KxbM0hirgU9RTn
 XEjg==
X-Gm-Message-State: AOJu0YyS7Et4h/WMtpxsy5cfxhjcxwSpMHBIfgCmWjCotd0ngKSGY+Jh
 RRJJYgyxtAjGvXZEwTcR7kLn6eCW6xI=
X-Google-Smtp-Source: AGHT+IHhya36nlo0eZ/k/DQIHNZFY6KJWPRGYuO+1MeJT8sPegaCiapvUALgy6HufICXuZ7cZq5BQA==
X-Received: by 2002:a5d:5e89:0:b0:321:52fb:5703 with SMTP id
 ck9-20020a5d5e89000000b0032152fb5703mr575766wrb.13.1694986798851; 
 Sun, 17 Sep 2023 14:39:58 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:58 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 27/28] bsd-user: Implement rfork(2) system call.
Date: Mon, 18 Sep 2023 00:38:02 +0300
Message-ID: <20230917213803.20683-28-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
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
---
 bsd-user/freebsd/os-proc.h    | 39 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 43 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 14478d4bb5..a406ef7db8 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -212,4 +212,43 @@ static inline abi_long do_freebsd_vfork(void *cpu_env)
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
index cb9425c9ba..4c4e773d1d 100644
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
2.42.0



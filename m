Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2687A3E86
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:27:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0C6-0006ff-ER; Sun, 17 Sep 2023 18:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0C4-0006ey-Ol
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:44 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0C3-0002yr-5d
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:44 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31f7400cb74so3427773f8f.2
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989481; x=1695594281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mw8oJ6RJMLfyGngcXE7kSkbQnhvZ0mfQP6CsE/YxQqI=;
 b=cIOih3pA1Xci/pxeSmNjtpubMGxCsGLqlmTyneQZAw2HEwctryU27awFSDBj3T30pM
 p/3gw9m3he9tAFhCv+IYN54uP98doT073brqB/OvV7+OjgG7JPbqSZQD05ivsv5GBG+l
 WaeuTna5QOAKGIunvfJezEhm5rA14utYv5FwPzy73jyWo53NF61rz3rBiD4CIYhOPHil
 qlJDUTumfoKWYPfI5D+fFh7YatlwLD0FV4FusdrCbqoGjUxg2GvSbIzY/ygvHp8X+DjZ
 4mXCgtmzTxm0JL/20gC7IcdlIAFN/FM9YCTpB4Auo2xyMQ8OmB2diYMgd8aB8uqL5PUr
 7Afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989481; x=1695594281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mw8oJ6RJMLfyGngcXE7kSkbQnhvZ0mfQP6CsE/YxQqI=;
 b=YbPsDyglUbQPX7t7+K+3ur1UnCVKMCE648OnrFVBaAdBArXEGHRNiaYZXlH32TyNCD
 Pi9zVTMShJaFKZOD0v02JT4YFxz+EQH1h8WFZLE2C8VX2Z0Ckepw6r3jNJDb+J1kdNVv
 P+IUVhiGO2gradCJFgh7NhNbEWR4bi9PLnhFztQ6bavILo7VFeWmkAoUM8HNBG/o5AOM
 Zji0D7oufP++5yDirSSwSATvi33ORHdmI6MknHJzpsd0QfkTbZMsf3wvwEjP95c9xhFe
 x4p0aYVDA65+Q7r4RxE3Zb/J08BZSe0MwpmGFySchKAWE/bhICQZhja7a22i5zmQKdXW
 k88g==
X-Gm-Message-State: AOJu0YyfJLRBInhFnYN8XAzZsdtlNbFmAWm7Hz7CjAcIByZg3YWd1yic
 C7bWUMV6cYPFdGpIgYF1JaRbCnUa6ZI=
X-Google-Smtp-Source: AGHT+IF+G8VdYiZ8iqkIWwojTqGMATZ2pqg7P2MBu6dFL8igNNzVYeydKyDmql9K4h2T+6SwxIqjeg==
X-Received: by 2002:a05:6000:1f9b:b0:31f:fb63:12d8 with SMTP id
 bw27-20020a0560001f9b00b0031ffb6312d8mr5090792wrb.44.1694989481363; 
 Sun, 17 Sep 2023 15:24:41 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:41 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 27/28] bsd-user: Implement rfork(2) system call.
Date: Mon, 18 Sep 2023 01:22:44 +0300
Message-ID: <20230917222246.1921-28-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x434.google.com
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
index 23b2f77a73..6121af9efd 100644
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



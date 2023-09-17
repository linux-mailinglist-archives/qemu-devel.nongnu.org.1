Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C797A3DF7
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:42:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzVN-0005Dz-97; Sun, 17 Sep 2023 17:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzV5-0004sl-4U
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:40:28 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUm-0004K4-0V
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:40:16 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-401d80f4ef8so43414585e9.1
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986798; x=1695591598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VpDK27XFYFlUK18Xjk609Zfh0efzDinwgtTC93pyvcY=;
 b=eRb3Tw1PeS5O6Bh0gyVt9sowuUA6LPS7x4k2ANby4VLQstrvue+Uzekh2HpGwBQmAS
 7SK7XIt5gWftc2R3jLpj0JpQthdvq9gPn9mJPDeMqsU3Q52YtfFXKXol3n+jSCCc7fY5
 fCS3U6GftRUjw4Cgc7MzGDAVhD+JcHgT6kiLJTaqVdq5WObMCi6glINusErfz58Prwbn
 MlpSAGbJ0yOvB3+f6Z8NQkhbI94oopN+hszrrkqmomCbUt8Q0LEuGZ/Jqhk/qsE02wwK
 B/NBrJQyr4Ov0+NZoKCjLv/0Kx3LtQe36fRGvoNJELkqPifr2L0ISGFxRwxq6990liRt
 emvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986798; x=1695591598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VpDK27XFYFlUK18Xjk609Zfh0efzDinwgtTC93pyvcY=;
 b=c6Jci2zaKrGC8KrgTTp8qji7BQ7LcuZLkrRUdS+J4JPxBJ2OqOh9GtOTZegSKAS4rS
 Ssfku7uyFSuCLnktsX6ETrmEi6nGud8jCXxZ0EfSzIRbyGArQlNdKbigs9OftXpOrejk
 iRNsxPM88UGCojUpl5SVQ1sm2uTqWjUbUkjv+iz8WmdHyhHSIy7MikZIorCMZfuEiEdM
 G7oSvCVpGtHXkDxcPGGKWQ/hpZyK/ZzbQboSOg8lptfzqcXXH1n0wwrgnMsHBWQXu5z8
 /AcaLruGjwSRm75oX/f+gpHudkch215LfdSL7hfTvZZqYNmCJWlk3q4QJXYIL2uUBdSn
 uhjw==
X-Gm-Message-State: AOJu0YxKjFUBDMgM96N6tPxT+vetXWCYyyq7Kbfi7/qocqmBD91b9iyV
 zdK2VxYSpiVuj4+VbymikGNXQRb+zHc=
X-Google-Smtp-Source: AGHT+IGWJWbNamVJ0TJeNIcRyuGlI3ut/Bcnc+BjWDXkpk7VWpeVuf4WVKMuW0ulmDnHVa9HcaJjQQ==
X-Received: by 2002:a05:600c:3657:b0:3fa:8db4:91ec with SMTP id
 y23-20020a05600c365700b003fa8db491ecmr6508351wmq.10.1694986797793; 
 Sun, 17 Sep 2023 14:39:57 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:57 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 26/28] bsd-user: Implement fork(2) and vfork(2) system
 calls.
Date: Mon, 18 Sep 2023 00:38:01 +0300
Message-ID: <20230917213803.20683-27-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 47bcdcf8a3..14478d4bb5 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -178,4 +178,38 @@ static inline abi_long do_freebsd___setugid(abi_long arg1)
     return get_errno(__setugid(arg1));
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



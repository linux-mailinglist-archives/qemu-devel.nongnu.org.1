Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 345EA7A3E82
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:27:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0C4-0006ev-SR; Sun, 17 Sep 2023 18:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0C2-0006eI-5J
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:42 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0C0-0002yR-LS
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:41 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31c8321c48fso3166030f8f.1
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989479; x=1695594279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xjcglx42m077TGloI0lQeBHtAEx4Slew3pydhCw552E=;
 b=ZDbpma3aNebRo4riZQi9Cz6RvQt1B/2El6kCbfRwcxCri9aUve9GAFbtSsy7eyeRoA
 BL9IZY+F3QnenZpYr7Y/7RMCkKZd2mIv4b5emFzUUaHPJKkoGFs9ZhzT+E2uQinOC9ZH
 Nj5jA0Cu4yqTLADfcwQY5ccWzPo7h+Pv+l4ThJeWeP7Q8mW5F36XG78G/k8szo+0ncWN
 tE+/3xjJqrZn/qQNs1fwH6FFXheXtnv7Cr4XwgLWlQqdk5V32uyPL8l+MTGgJvtpvj7b
 IacjSjeLtu/pA3mYON0QsnLeKHE69vkMNK6P1lHMgnGdQKEz5F4N+YM9I+B4DHQ/p1HY
 nXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989479; x=1695594279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xjcglx42m077TGloI0lQeBHtAEx4Slew3pydhCw552E=;
 b=nlddtS6sXvR3wu9CmBtEcYajd/qWOB/0ScWsuE5U8QvnwrRayLyLmJ4misQmH2MKej
 FEVhvKRf69I81QP7Ut4YQvZXKxOZmKam39rHwKB30re2PGXv062oOXhmOJp8dE8pOINI
 oi4rIWqNm1lmCFquew0mcCDXW1PVPfgVyBdQKrUESSGE7Oz1JLRZS9Pe7kdClOVN67ch
 yzp2v4MKrdH7YvqhhKIca4jwexPsJJWZ92yBX3DTvQWahRv5RQ5s91JdDsBQPWijpS5n
 eRYZKwAZ7nGYWARQadb3e4G3Rd6ydrmokGSkWYS3hYoU4pf56GkriP6hvBNN6qR0jlCL
 e4jg==
X-Gm-Message-State: AOJu0YwKD26UOncPGXxHjvAZkf7I3ftzFe+J9a8fdoR1vC9P9xSm/Vxk
 eQwZmLh5XC7vvy6VGBekvNTjjqB0cWY=
X-Google-Smtp-Source: AGHT+IFdJTnkLWzdqU1eOmVmIBTFI4Q5QI4JSjoFuWx494YnX+dRidQaVzH3tgyytxLRzIMXgYSP9Q==
X-Received: by 2002:a5d:6ac8:0:b0:317:6734:c2ae with SMTP id
 u8-20020a5d6ac8000000b003176734c2aemr7986441wrw.11.1694989478988; 
 Sun, 17 Sep 2023 15:24:38 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:38 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 25/28] bsd-user: Implement pdgetpid(2) and the undocumented
 setugid.
Date: Mon, 18 Sep 2023 01:22:42 +0300
Message-ID: <20230917222246.1921-26-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42b.google.com
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
 bsd-user/freebsd/os-proc.h    | 23 +++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 1866f0b2d6..964be4ad87 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -34,6 +34,8 @@ pid_t safe_wait4(pid_t wpid, int *status, int options, struct rusage *rusage);
 pid_t safe_wait6(idtype_t idtype, id_t id, int *status, int options,
     struct __wrusage *wrusage, siginfo_t *infop);
 
+extern int __setugid(int flag);
+
 /* execve(2) */
 static inline abi_long do_freebsd_execve(abi_ulong path_or_fd, abi_ulong argp,
         abi_ulong envp)
@@ -155,4 +157,25 @@ static inline abi_long do_freebsd_getloginclass(abi_ulong arg1, abi_ulong arg2)
     return ret;
 }
 
+/* pdgetpid(2) */
+static inline abi_long do_freebsd_pdgetpid(abi_long fd, abi_ulong target_pidp)
+{
+    abi_long ret;
+    pid_t pid;
+
+    ret = get_errno(pdgetpid(fd, &pid));
+    if (!is_error(ret)) {
+        if (put_user_u32(pid, target_pidp)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
+/* undocumented __setugid */
+static inline abi_long do_freebsd___setugid(abi_long arg1)
+{
+    return -TARGET_ENOSYS;
+}
+
 #endif /* BSD_USER_FREEBSD_OS_PROC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index d614409e69..99af0f6b15 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -383,6 +383,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd_getloginclass(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_pdgetpid: /* pdgetpid(2) */
+        ret = do_freebsd_pdgetpid(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR___setugid: /* undocumented */
+        ret = do_freebsd___setugid(arg1);
+        break;
+
     case TARGET_FREEBSD_NR_utrace: /* utrace(2) */
         ret = do_bsd_utrace(arg1, arg2);
         break;
-- 
2.42.0



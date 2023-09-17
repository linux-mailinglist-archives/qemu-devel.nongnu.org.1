Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1957A3DE4
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:40:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUj-0004by-LM; Sun, 17 Sep 2023 17:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUd-0004aH-Pz
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:51 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUc-0004Il-AY
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:51 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31ad9155414so3649466f8f.3
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986788; x=1695591588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGH2XqlCKs+v6ITttHKED17bHsAug7I+bG1RPQmNFlY=;
 b=JNM1OY+vUGpU78wREiAQTBNKOWaWbELgC/MIg6wamsjTPUDMdO/QcGrrD9uMtVaWvl
 bUMUK9l2wLc5YhuMOZrLYcZtYTEyHN/HomR5w4hQgQk6zB3S4TcvZTWCQLlqBimPeicw
 QkKf5Q/HqlaBl8Wxp8IZSkTUspJWrPGD0Vl76bY0098OgDZIqWHU0s+ibmfQlSMPSVnA
 aHPHyEFf8wAlh3rmDkYWfzl2PLpSQhF3TpcAh+yX4si91bTBVkJJhFR897/1gj2aASAr
 zhEUjRSopZ8RurIbRNKOh4dkgDfkD6R/5s6g+CjsWq3fX2QPMt9G61oZ80Bxmug/GlCL
 AyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986788; x=1695591588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TGH2XqlCKs+v6ITttHKED17bHsAug7I+bG1RPQmNFlY=;
 b=ZHyLF6GzgeNZt01+l3NA/fWcZyZwizdD/C2n5kGruwreKR3Pog8PnFMPSEqqdUOqdI
 qcoILMTMx3DrC1FushKtZ9x4ywJdO0omOkUlLj4S4TQ5Xs3V9TM5wTJq0wAhGCe5tPGo
 DifC0XTx5H4ku2n+UFp+VAzND99GRiLYSL31/O6apbdqzFwQHjc5c7+3O7ZuHPgP69pt
 WcCkIq3zVFsOAOa2k8d8znkFtG8BgO8eb3pO8QNasYfqy1AXJOhWjk0nYuK9bBB1i2GM
 lc1tX3rPsxGv+uqfai4wpAYml7aAr7W0o1aT0ElzzP7mdHzAOxr/V22E/9s0PgE7TO1P
 AX0w==
X-Gm-Message-State: AOJu0Yzu0Uikv4OIr0upncHVQ1b2dkn3fgGBLd0B4ygDBosxbuqKhV3E
 tbeh/POjxOTzgejKf/1fxNIOTtLSj7Q=
X-Google-Smtp-Source: AGHT+IEVX3FSQYSmJq9LrKp6LgWy1m836NJ7oci6NsKg/5kJegMApluvNf09BuVfXXJeWZNUklybrQ==
X-Received: by 2002:adf:e40c:0:b0:31f:e80a:33aa with SMTP id
 g12-20020adfe40c000000b0031fe80a33aamr5848015wrm.27.1694986788522; 
 Sun, 17 Sep 2023 14:39:48 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:48 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 18/28] bsd-user: Implement getpriority(2) and
 setpriority(2).
Date: Mon, 18 Sep 2023 00:37:53 +0300
Message-ID: <20230917213803.20683-19-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42a.google.com
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
---
 bsd-user/bsd-proc.h           | 24 ++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 32 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index fff1d4cded..89792d26c6 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -390,4 +390,28 @@ static inline abi_long do_bsd_ptrace(abi_long arg1, abi_long arg2,
     return -TARGET_ENOSYS;
 }
 
+/* getpriority(2) */
+static inline abi_long do_bsd_getpriority(abi_long which, abi_long who)
+{
+    abi_long ret;
+    /*
+     * Note that negative values are valid for getpriority, so we must
+     * differentiate based on errno settings.
+     */
+    errno = 0;
+    ret = getpriority(which, who);
+    if (ret == -1 && errno != 0) {
+        return -host_to_target_errno(errno);
+    }
+
+    return ret;
+}
+
+/* setpriority(2) */
+static inline abi_long do_bsd_setpriority(abi_long which, abi_long who,
+                                          abi_long prio)
+{
+    return get_errno(setpriority(which, who, prio));
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 1a760b1380..71a2657dd0 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -359,6 +359,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_ptrace(arg1, arg2, arg3, arg4);
         break;
 
+    case TARGET_FREEBSD_NR_getpriority: /* getpriority(2) */
+        ret = do_bsd_getpriority(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_setpriority: /* setpriority(2) */
+        ret = do_bsd_setpriority(arg1, arg2, arg3);
+        break;
+
 
         /*
          * File system calls.
-- 
2.42.0



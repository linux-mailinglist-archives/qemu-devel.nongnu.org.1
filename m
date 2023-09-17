Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 094E17A3E6F
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:26:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0C2-0006e4-99; Sun, 17 Sep 2023 18:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0C1-0006dm-21
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:41 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bz-0002y8-9f
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:40 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3200bc30666so681052f8f.2
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989478; x=1695594278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLSK2Vy19+HO7TG5se0ovaw+QVTaNOOf92Nr5xgAdD8=;
 b=Cwrut0NeuHfLcoM/O79BshsZtrPYHH84BE8tSXwDWEkzIL+TqUqy0rYX8aQHL1+9K/
 EUEYkkdLXgu93tld7HgxrzG+6w/QO5dCqjoK8w3/+wFVWkNljJXTjOtugtBLXRXyqvBk
 CufBsJbyFvD+HP8EyFNdMBeMcEkMyNEbbCwCkU0CKYDnUrg63lSd6TqRLwIef0iNjko6
 AEwyzp0YqAqZBN2mPpwLAmK0xzT/Rsqt3p5Bd/XatS2a7/pJAhOeE8Fg0wP9/+o5F7XP
 TCcROG65i+vqesv0eTKQS213cS1zyzeAcJfipB6eAJyve63T9T4zszFR3f0fsR1msIlZ
 HVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989478; x=1695594278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DLSK2Vy19+HO7TG5se0ovaw+QVTaNOOf92Nr5xgAdD8=;
 b=UMYXV9/67BlxblDohA4Xw3efClEJDd5GPOszwvTmlnqxhnc3cNaUhkyioFSJ7xAFXI
 5WnunchY9VvOHiF+Q6d7conYzojAD6kPtUNkOdcm/OJXVZ8D8fZJSjKxkqKXqCG3LHN0
 nJyRwxZPQH0WCBx+157yNsHhgIIU3fgyKjvYwcL2xFrOUYarerjkATxJLjNLdDT54NnL
 dXaodj1MZdMfHJ4KEBI2/aYABkOxom2KE7bNPlc4sBt2HqSnQFE8xns07Q2UnbJ10IZg
 D5XTiHIIITNw+NCc/6ILiz6S5H7PN/clbu09euv850br+OqvjTqq0fWjZwNPmZDlRLmy
 xkzw==
X-Gm-Message-State: AOJu0YyRiHc6Ny6dXSlek+po/KHEhzqOAcc901DUAw1uEgcQ5ysiq4ls
 2WcyUNT0njIJ57R7uOoNQB6aEeytgFw=
X-Google-Smtp-Source: AGHT+IGa3s2N3/AGt+KFHxUWrVEwuT3M8+dilECL/fAGSiF0LYHrNfnnbjTZMkk1b0wRA8RrccZBQg==
X-Received: by 2002:adf:f54b:0:b0:31f:b138:5a0 with SMTP id
 j11-20020adff54b000000b0031fb13805a0mr6089452wrp.48.1694989477694; 
 Sun, 17 Sep 2023 15:24:37 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:37 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 24/28] bsd-user: Implement setloginclass(2) and
 getloginclass(2) system calls.
Date: Mon, 18 Sep 2023 01:22:41 +0300
Message-ID: <20230917222246.1921-25-kariem.taha2.7@gmail.com>
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
 bsd-user/freebsd/os-proc.h    | 32 ++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 40 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 8a0b6e25bb..1866f0b2d6 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -123,4 +123,36 @@ static inline abi_long do_freebsd_wait6(void *cpu_env, abi_long idtype,
     return ret;
 }
 
+/* setloginclass(2) */
+static inline abi_long do_freebsd_setloginclass(abi_ulong arg1)
+{
+    abi_long ret;
+    void *p;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(setloginclass(p));
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* getloginclass(2) */
+static inline abi_long do_freebsd_getloginclass(abi_ulong arg1, abi_ulong arg2)
+{
+    abi_long ret;
+    void *p;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(getloginclass(p, arg2));
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
 #endif /* BSD_USER_FREEBSD_OS_PROC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 55e68e4815..d614409e69 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -375,6 +375,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_ktrace(arg1, arg2, arg3, arg4);
         break;
 
+    case TARGET_FREEBSD_NR_setloginclass: /* setloginclass(2) */
+        ret = do_freebsd_setloginclass(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_getloginclass: /* getloginclass(2) */
+        ret = do_freebsd_getloginclass(arg1, arg2);
+        break;
+
     case TARGET_FREEBSD_NR_utrace: /* utrace(2) */
         ret = do_bsd_utrace(arg1, arg2);
         break;
-- 
2.42.0



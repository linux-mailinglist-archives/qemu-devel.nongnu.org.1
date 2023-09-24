Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 243437ACE60
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbSs-0003Ku-KV; Sun, 24 Sep 2023 22:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSq-0003Jl-1L
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:48 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSo-00006H-7z
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:47 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-307d20548adso4643531f8f.0
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609404; x=1696214204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BH2k0bQHStmKZhT8YGVTXBpS6n5Baw57rePQXzkWAzc=;
 b=ExBLZUJ0gAcmK9psQk0inIng6A5Q8r/Kx8vElozLCnafFwnqjRW6em6cIQ5fU37+tB
 KA02Js0cR+L2pYP6pp/IeZjn0RrYubRWV6jGDQLO5QBrwpZ7R7Zf0Fkotta+AsetRaeo
 nxzw7vOuYMRtfLhrzD5craTpdd5f57Vs0VD8yz81Teou1adw+mmNCw25rB6xm+2hqdSQ
 XjazYTzPRXvn66gq5WSZWh0EK36sTq3A/+s8Ea5Ql/y8/Dl0InJigm34U3/MJK2+QaDe
 bnI5Br3TDDjWjdXN8Ilh5KqIVm+0bs/q06yIDz1ztwG9MK3EtnzDQXn4F+mAPzxZbvTC
 DjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609404; x=1696214204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BH2k0bQHStmKZhT8YGVTXBpS6n5Baw57rePQXzkWAzc=;
 b=cslqeKJ24ZrYwVkY+gtpz96Aia8qeM1kCG2GVy0KWhum94gtElHEcilk3FY9z4oaXA
 rmCMhzssCi+d947AHqrstIw5eSxXvNMuJV3x4I+MZoahGsgnhi79V8Nm2n7SZVMJvwPD
 lE7SQa3CcVFZb0tu32Tpd3PImO2qP50AnbvyVhUB8Y7uqyTZAbABNGS9ePaw82sr2AmN
 3rNpI1qT/orLwlm0vb2CkVLxT0qifOgCxwdTlL7upEpuFBJisMZ7ZaTKmFzHEhoGRTIo
 cjCc9s8LNoSwDN3Q8OArI4yjgh2xbLg0teZUX8f3Facr8hHXaCihp1DgAnG+s4QCez5Q
 gx8A==
X-Gm-Message-State: AOJu0Yxp87df+uDE3LoF9wFl4vCcBDFfdn/DRMf2U8g3GFcsVtcaX3vU
 AFeS1cwIME3RGm5RoL4/lFwItRqFjwI=
X-Google-Smtp-Source: AGHT+IHS/IBnE6UkvyVQ1/YRBtir8G/pY9LH6hv1bWl5KOCRS166CUdFAXiiWhsI95GyNN4rC8iXyw==
X-Received: by 2002:adf:ffd2:0:b0:31f:e8df:bb52 with SMTP id
 x18-20020adfffd2000000b0031fe8dfbb52mr5027529wrs.7.1695609404301; 
 Sun, 24 Sep 2023 19:36:44 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:43 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 12/28] bsd-user: Implement umask(2),
 setlogin(2) and getlogin(2)
Date: Mon, 25 Sep 2023 00:01:20 +0300
Message-ID: <20230924210136.11966-13-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 bsd-user/bsd-proc.h           | 39 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 12 +++++++++++
 2 files changed, 51 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 7b25aa1982..cb7c69acb0 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -26,6 +26,7 @@
 #include "gdbstub/syscalls.h"
 #include "qemu/plugin.h"
 
+extern int _getlogin(char*, int);
 int bsd_get_ncpu(void);
 
 /* exit(2) */
@@ -85,4 +86,42 @@ static inline abi_long do_bsd_setgroups(abi_long gidsetsize, abi_long arg2)
     return get_errno(setgroups(gidsetsize, grouplist));
 }
 
+/* umask(2) */
+static inline abi_long do_bsd_umask(abi_long arg1)
+{
+    return get_errno(umask(arg1));
+}
+
+/* setlogin(2) */
+static inline abi_long do_bsd_setlogin(abi_long arg1)
+{
+    abi_long ret;
+    void *p;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(setlogin(p));
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* getlogin(2) */
+static inline abi_long do_bsd_getlogin(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+
+    p = lock_user(VERIFY_WRITE, arg1, arg2, 0);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(_getlogin(p, arg2));
+    unlock_user(p, arg1, arg2);
+
+    return ret;
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 535e6287bd..44cbf52f08 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -231,6 +231,18 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_setgroups(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_umask: /* umask(2) */
+        ret = do_bsd_umask(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_setlogin: /* setlogin(2) */
+        ret = do_bsd_setlogin(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_getlogin: /* getlogin(2) */
+        ret = do_bsd_getlogin(arg1, arg2);
+        break;
+
 
         /*
          * File system calls.
-- 
2.42.0



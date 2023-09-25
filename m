Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4877ADEA8
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:27:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHd-0001IQ-D5; Mon, 25 Sep 2023 14:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHa-0001Hb-Pl
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:10 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHY-0007KL-Vm
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:10 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40594697600so19231475e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666366; x=1696271166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kfhgSFFzN1XkrYqOz6DoCPBLs5/WucsM++tn8gnV0CY=;
 b=VHV8aPBSBghmQl1evEavf39+E0PN9uJO5yS2Uu6LSElcNdl1QMT1kTGkcdBVxh0vS+
 NRnOeTMxgnHoqeDrhVC5TVmOCezX6hBkPv/ZeIKsdY90i5xZzY8pBR0q0mYnUSqcplBz
 LHYWknrP59vNJaFqdVE38NtnJEKz0j8nS/cICpAb8SFWy+fm5LTk6IEWqTDyAp7HQr1L
 g41gfp0mWT89is02VUA7Ju4q/wJfpYfbiITW9DvTg4JZWa4O4OdgZFTEFS9cUKVCGR0T
 Jtmwa6UY3NP7ypE8FkMiFfhS3NRMsF+SBmC7gWqdLnhFtwbwLLklpKE3+GB5itcuov10
 QmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666366; x=1696271166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kfhgSFFzN1XkrYqOz6DoCPBLs5/WucsM++tn8gnV0CY=;
 b=cY47W1JlIzncGGVjTYk189j0RquVpsXl5UGNpWqITHw1hCE83Wmoh+SNNphWI6GQVQ
 Tr9AgYCVw/ScwZaBX5ktLToU7pTh/QUWRscQSp1N/+hFUJ4yQDeb2QGRgWZO5XO3aGsm
 pjXhMElq54bYdDl1i3RoyuI2XW71PoVUUp81XIplnj8cLBXcpLXx51XfIVHk+sHUHRe6
 U7dmdA2aGmgELqyWrwvWQo8iRqbYBbEltyeocukWIl30FS/ydGXO5FZS4yp2gSSgJgr/
 Foz0i6E+T0ZQpciFhNzSuiuwkg68Hp1vF2zIRPlYykN/ABncMWzmJYxbUm6NAH0/OQb9
 Xspw==
X-Gm-Message-State: AOJu0Yzxq9HkpZ7JMeBZztaxzE6F0A81WJ/uw8mRF2uCxU720jTce+Fo
 1c1HA7BZVB5FaxR1Qwmu2oXowMVEePI=
X-Google-Smtp-Source: AGHT+IEVvz2C4JggdJANvsTtC1PG6AGwpMzyqy6n465iETm9FqZc3JchSIIrdYYcMepWm/Q/C5JXpQ==
X-Received: by 2002:a05:600c:20d4:b0:402:e68f:888e with SMTP id
 y20-20020a05600c20d400b00402e68f888emr6435170wmm.4.1695666366353; 
 Mon, 25 Sep 2023 11:26:06 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:26:05 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 12/28] bsd-user: Implement umask(2),
 setlogin(2) and getlogin(2)
Date: Mon, 25 Sep 2023 21:24:09 +0300
Message-ID: <20230925182425.3163-13-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x331.google.com
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
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



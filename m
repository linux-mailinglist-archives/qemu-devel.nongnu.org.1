Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8886A7A3E8B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:28:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0Bm-0006Xc-EC; Sun, 17 Sep 2023 18:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bl-0006Wq-8q
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:25 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bj-0002vz-J0
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:24 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-402cc6b8bedso44712695e9.1
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989462; x=1695594262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S2C+DXDFtElhsZcWyV9HhqsA3jXU6683RqCl1iGRJvU=;
 b=KEwD4LGz1lHnJW9O3p2dR6M5qIBqgw6gpQBDgtDOzkBDQc8rwbrBTTpNZ+hgWVmasw
 MjDv8PUjZhB6bE122AoGkcuN/QhCbVaJvgGpY3fOwPmmG8KcF3IKziu4HvqYXm76jntj
 la0kvqZuMLVEfMtlgaCeYnwSrz1sV30AzQraTL/gxIB/LspBn/GGXKYydIrpU0uUImX1
 3cSAH3toja3/i6GUDpckoRoxKIlRUdQPQ7+cGeZhNrZ6lyxvr6Y5As9BEbczzAT0y6lU
 Wj8OJMFq7CHDsHKaxTIiYAz5AcGUy7M9lyOXiwpGqxUibx5tE4ATsQOibH1F5rKkTpoJ
 bUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989462; x=1695594262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S2C+DXDFtElhsZcWyV9HhqsA3jXU6683RqCl1iGRJvU=;
 b=OhdMSaFSJsZnZedt5g2t8KGmUHUHKgVa11CpF2lB0LflrPQFe2SOKT/1ZbGfTItFO4
 YgIjuX32mawzCueRo5qqVhRzqyaWmZeqeN8JXxoTwnvJCzrALwHWqa07Gc9iWhHvt61T
 wb0gRz7HlaD2HQdmkZxYaZTEAS23ZP3RPc9OFO/MQuoDSrMTDV0nCSW+zJW7d/Ghm0aS
 ZevIDVHSF5TcEpJu0iNNgZne0g5UFdekHzeQTJcpq72rcsoRcQXTL3qph//MGF1vVJ60
 gU72lSsY0r6g9shJ870+jHfUFbC52+yiIPVvuuK5H6rhrLjQKsIbnsYQ0+8eef3t7obK
 L0Og==
X-Gm-Message-State: AOJu0YxS6D57CImvSphCHPGn734Ky6JwaDF8p1wKAVYYXm19UVV6NQuH
 RPgHRUwi9nQsHT4IPNAJ9PS0U9otOQw=
X-Google-Smtp-Source: AGHT+IF/Y7ZumRj/09OQhpI/O9k5QcZGeAkHVresbk0u1/OZHGnUqVl7zvzFFmywPhdtruTbHbnFRw==
X-Received: by 2002:a5d:60ce:0:b0:31c:82ad:a015 with SMTP id
 x14-20020a5d60ce000000b0031c82ada015mr7330349wrt.49.1694989461889; 
 Sun, 17 Sep 2023 15:24:21 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:21 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 12/28] bsd-user: Implement umask(2),
 setlogin(2) and getlogin(2)
Date: Mon, 18 Sep 2023 01:22:29 +0300
Message-ID: <20230917222246.1921-13-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32b.google.com
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
 bsd-user/bsd-proc.h           | 39 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 12 +++++++++++
 2 files changed, 51 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 7b25aa1982..fd05422d9a 100644
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
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(_getlogin(p, arg2));
+    unlock_user(p, arg1, 0);
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4D87A3DFD
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:43:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUY-0004Yg-9u; Sun, 17 Sep 2023 17:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUW-0004Y7-HY
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:44 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUV-0004GR-07
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:44 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31c5cac3ae2so3420638f8f.3
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986781; x=1695591581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S2C+DXDFtElhsZcWyV9HhqsA3jXU6683RqCl1iGRJvU=;
 b=QS+KudI+8LD5Y+v5v9MmCFSGL9Q9QzQgmKGPxWYfXHTawaK4dckv4JhYGtvemW8FmF
 FfzFK+snCPyasYcxBhzQov+Z8IIOL/ilrfKqFSC1UkkdlmNGOE3Rem8heZTR4mDH0+af
 NC0PNad7V5I/Eggd+GdqX/dAbFBkWa1njsuWCjWKK3BxqQ2G3dN395HoWA5LE2Jnj/iF
 yFl3W9YL8zY4ZnRZ+U24w4d+6JvYGP7JCNpPVJrfDSUpvSBMgIIVpnvKrgtw8bx60lXe
 RYP9NE3qeSFDQAcmieAnNn08M+khaTKc0VaKcRpKl2UVZdNcbHVolLxstFvyZcjhtQwI
 4bHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986781; x=1695591581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S2C+DXDFtElhsZcWyV9HhqsA3jXU6683RqCl1iGRJvU=;
 b=wwA6u3XW9rHiWnB7/KSAVL6Pa0+MaT7UzRJ3ZlXeUEF5GmXDHYx7TgmDwXmi7p1dK6
 Y+UxOeI+Gxe4SK5E50XoNXFeNagUMKujCK5SbHbRep1VbkmFk72Zcu061hjcC2csrvuW
 4ihCoF1k2M/zKr8ULx5ZJbOc0Ojd/5IZIoJCoQi09Ed3T3x7PTP5vvziDkxYuAkg9rdD
 6o1qOFNDyutLiJ55mPZhq1G+lp1uoKvpMpX0uUOhPOdAGiXUQ9uGrL4/F4FGlh9H5e0m
 z8ZTkkho9NDuzdTiUp3lA8nfnGgcHsQIolACqDJc9wj+ks4Sh9E2OWkv+qzdEIt4Fwgt
 Easg==
X-Gm-Message-State: AOJu0YzMoo5YxGCqFRgFK5k3ncLWYAtG9GAJ1sBOP8Fsq3avElQjSoNZ
 nK/xCF/NPSRjVfjQWp7jslaSyphV3z0=
X-Google-Smtp-Source: AGHT+IH9d4U+7aA6/EWtZcZ14rPVrmheDTgxTM7K637TsYfOHDoq7MDOAI7RYrHywTG5KHLFhDGr0A==
X-Received: by 2002:a5d:6952:0:b0:31f:a259:73c with SMTP id
 r18-20020a5d6952000000b0031fa259073cmr6234232wrw.27.1694986781497; 
 Sun, 17 Sep 2023 14:39:41 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:41 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 12/28] bsd-user: Implement umask(2),
 setlogin(2) and getlogin(2)
Date: Mon, 18 Sep 2023 00:37:47 +0300
Message-ID: <20230917213803.20683-13-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x433.google.com
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



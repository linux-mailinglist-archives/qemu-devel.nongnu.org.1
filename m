Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8893D7A3E00
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:43:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUs-0004fC-W8; Sun, 17 Sep 2023 17:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUn-0004cY-7H
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:40:01 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUj-0004Jl-Ge
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:59 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-404c023ef5eso20579105e9.2
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986795; x=1695591595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLSK2Vy19+HO7TG5se0ovaw+QVTaNOOf92Nr5xgAdD8=;
 b=ASdZV29QCvFvf0eA6Dg6EAgcMArrykOWYb7ne3v1otmikDYqOziU0eusVZdg7t0irY
 jRzarDLl4zBW2mcP5UUGf754kiLuGKMummHKuKTp9+hXJP75U2uD9GyJc6cgX2eE+2xN
 A0mNunwMF1liTLzs4XYB2fiJ+kZW5A/jgUphVjH1RzkFel8Z1yQWMcHeR5C/Seo5hrb1
 gyxFGXOyuNXci1SzKulEKiHVq5dRG3iSimQqu81tv2Szi9sORtvqtCe9w/bpuSZRBlFY
 agXDOWoZij6sxRb4jsksFIMyb43pJqjs+AYkcnzhNL8HqdnBKEr4Sug7IXHe+GUufaBD
 ZNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986795; x=1695591595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DLSK2Vy19+HO7TG5se0ovaw+QVTaNOOf92Nr5xgAdD8=;
 b=DQAAj4sZE8czvcsVmKg3HGrX0OMGXXXPFZU8YZv0Kc9p3S346s2Z652QD8IaTunRtz
 bjzhdkhwmNgMs0vQ1Q42VNJT9KvSv/n14lpls91aoLL7MwC4Os9gro30sKpilWOwEebZ
 z6ibdFJM6BUaZIw0z2mZf7N1JdtwTdZkCT0LZzwhLeZ4yVLY4CrZ/7yng0KXR2bh6F+6
 F5O5lUnUlq1Z/cud+PmMcGL8Fads7Q6/mPIWP/CG482/tw++uV9/ztvMY8AvPG3shBra
 NjvGFLInG9n9aaophXOir5zFaAimMNdRCTiSRhpS9Zwk/gzJrJ9i3Tz5L3Bw1hHn0f5w
 oAqw==
X-Gm-Message-State: AOJu0Yy5we2LKVaMBSxhixRku9NKULj/Y/TKxZicwqwrExzRUD3ZfzEw
 +W99XfAxa37FzBXidp3Q5FLP7NM9OO8=
X-Google-Smtp-Source: AGHT+IFff72HxFYvxMBtHL+iDjhTajulkUwIjO3fkh3AYHZxMQ51skFTAHlZ4UHclNVEehRDH8LTag==
X-Received: by 2002:adf:e5cc:0:b0:31f:ddee:d216 with SMTP id
 a12-20020adfe5cc000000b0031fddeed216mr5961809wrn.69.1694986795520; 
 Sun, 17 Sep 2023 14:39:55 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:55 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 24/28] bsd-user: Implement setloginclass(2) and
 getloginclass(2) system calls.
Date: Mon, 18 Sep 2023 00:37:59 +0300
Message-ID: <20230917213803.20683-25-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32e.google.com
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



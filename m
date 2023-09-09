Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5E7799A9A
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:40:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3n9-00060G-2D; Sat, 09 Sep 2023 15:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3n6-0005zs-Di
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3n4-0003F4-4F
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:48 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-403004a96a4so9302015e9.3
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694288324; x=1694893124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wVHZ2gTKJUTTUFCrTx1jb9XTLg6fK+kTZHzI2+VVFKw=;
 b=Bg//YAXowLUbGREkRw73qTrvl3gPhkferhDKB+cELbPPCIkDzsFkUyUb8bCw2ablb0
 wLH5YiW9CS3xWOapLYcCkrkq6d/AwbbcLwkpaeMBgeMzkngNQiOmU54+3ownYsZ/74Ka
 K9cesOEJZv2cdI+HQvGJjEVkZKef8Y2vym121Hhv0VjYRd29jYAmy7RN+aS1/2t87a0N
 bt/aWTRFjL4b0xvcXGWrXeHAl03TQYRrpvPi5CRtdOLoj8mn8sMaTIvyGBXoiiLm+OF3
 C6owj1MBLvhgwsStnPYszp75t6i2Uh35bag6DCorGqaFQAEml9jZUgL8TyUB7AJPE5+e
 2l4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694288324; x=1694893124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVHZ2gTKJUTTUFCrTx1jb9XTLg6fK+kTZHzI2+VVFKw=;
 b=FgUuMtBUkIu0dCK0utPyzzD2rz4YKsAHZeX6vSoA/U/miUS8xFp/fEADy2zynEGIZ/
 5uC0S+8FPfgLXUU9ieIemZuzmZR1QDFLxtlyf/B10ABSb/AnIXS2VLxk5WaKMJwZdX3Z
 2dWvppflEuqKUvOGVr3Fs+IRiLRwslCsvImXeBbg8MCLzDZLZSBKkobocUTmrCOW3xCL
 C/bYPhV+gC3NsRDGUAtJP21FNR5zXAmo5TlS0PzRLJAR7rjQmJAbeQmDbdybbkGwuxwZ
 pH1tUw/P7qrIsgRAU1yxdb0vApoKvvfReKoaj3PwPI6tBWdj4i3Jpc1YJXovdgbfsZ9P
 be4A==
X-Gm-Message-State: AOJu0Yynve6M9LwnnsCg41kGn17Np1JOWIo70z1v2vDEHvtyQxPBPDrM
 kV14mBoNd5vzX6e/S1zRBXj6o67CSew=
X-Google-Smtp-Source: AGHT+IFlWu+Q2QR13kbqrXs7wYLmy+p/vJY3kzbaPMArG8cL4ykMAioxQYY7hutVMyxHRkgOPiCLsQ==
X-Received: by 2002:a1c:4b19:0:b0:3fc:3e1:7105 with SMTP id
 y25-20020a1c4b19000000b003fc03e17105mr5251956wma.24.1694288324117; 
 Sat, 09 Sep 2023 12:38:44 -0700 (PDT)
Received: from karim.my.domain ([197.39.250.27])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm8612812wma.31.2023.09.09.12.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 12:38:43 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 16/23] bsd-user: Implment madvise(2) to match the
 linux-user implementation.
Date: Sat,  9 Sep 2023 22:36:57 +0300
Message-ID: <20230909193704.1827-17-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x332.google.com
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

Signed-off-by: Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 53 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 +++
 bsd-user/syscall_defs.h       |  2 ++
 3 files changed, 59 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 16c22593bf..0e16051418 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -129,6 +129,59 @@ static inline abi_long do_bsd_munlockall(void)
     return get_errno(munlockall());
 }
 
+/* madvise(2) */
+static inline abi_long do_bsd_madvise(abi_long arg1, abi_long arg2,
+        abi_long arg3)
+{
+    abi_ulong len;
+    int ret = 0;
+    abi_long start = arg1;
+    abi_long len_in = arg2;
+    abi_long advice = arg3;
+
+    if (start & ~TARGET_PAGE_MASK) {
+        return -TARGET_EINVAL;
+    }
+    if (len_in == 0) {
+        return 0;
+    }
+    len = TARGET_PAGE_ALIGN(len_in);
+    if (len == 0 || !guest_range_valid_untagged(start, len)) {
+        return -TARGET_EINVAL;
+    }
+
+    /*
+     * Most advice values are hints, so ignoring and returning success is ok.
+     *
+     * However, some advice values such as MADV_DONTNEED, are not hints and
+     * need to be emulated.
+     *
+     * A straight passthrough for those may not be safe because qemu sometimes
+     * turns private file-backed mappings into anonymous mappings.
+     * If all guest pages have PAGE_PASSTHROUGH set, mappings have the
+     * same semantics for the host as for the guest.
+     *
+     * MADV_DONTNEED is passed through, if possible.
+     * If passthrough isn't possible, we nevertheless (wrongly!) return
+     * success, which is broken but some userspace programs fail to work
+     * otherwise. Completely implementing such emulation is quite complicated
+     * though.
+     */
+    mmap_lock();
+    switch (advice) {
+    case MADV_DONTNEED:
+        if (page_check_range(start, len, PAGE_PASSTHROUGH)) {
+            ret = get_errno(madvise(g2h_untagged(start), len, advice));
+            if ((advice == MADV_DONTNEED) && (ret == 0)) {
+                page_reset_target_data(start, start + len - 1);
+            }
+        }
+    }
+    mmap_unlock();
+
+    return ret;
+}
+
 /* minherit(2) */
 static inline abi_long do_bsd_minherit(abi_long addr, abi_long len,
         abi_long inherit)
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 6eaa705cd3..f5d60cf902 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -519,6 +519,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_munlockall();
         break;
 
+    case TARGET_FREEBSD_NR_madvise: /* madvise(2) */
+        ret = do_bsd_madvise(arg1, arg2, arg3);
+        break;
+
     case TARGET_FREEBSD_NR_minherit: /* minherit(2) */
         ret = do_bsd_minherit(arg1, arg2, arg3);
         break;
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 074df7bdd6..76f4856009 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -95,6 +95,8 @@ struct bsd_shm_regions {
 /*
  *  sys/mman.h
  */
+#define TARGET_MADV_DONTNEED            4       /* dont need these pages */
+
 #define TARGET_FREEBSD_MAP_RESERVED0080 0x0080  /* previously misimplemented */
                                                 /* MAP_INHERIT */
 #define TARGET_FREEBSD_MAP_RESERVED0100 0x0100  /* previously unimplemented */
-- 
2.42.0



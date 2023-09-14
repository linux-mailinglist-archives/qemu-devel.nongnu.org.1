Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 542E47A0F2D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:45:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtB0-0003Yb-JA; Thu, 14 Sep 2023 16:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAq-0003M1-VS
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:52 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAo-0006OL-8r
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:51 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso1220107f8f.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724168; x=1695328968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1y3QJ3NO1OpevaAaEL6gS3rKqXE25lyRwf0WEycZtJA=;
 b=YgP4J+sxoeaonFjv+/VjbGZKf9CovZACCK9QJe1hzHR78nNMm6t9Z/+QNTxc2IbNL+
 0EMzt+rCx1WSxX3/5pgmMvXknGaj2cYh3EoVIG3UdVCEFLXOZRo84ceiT4nn+R55wCll
 /cqi4t6ExufOLIjw48ajTYMBJJoqpZWcxme105/3Dg2NdyF/Zd7bZGU4K+BIEUZylDVe
 9nzHVmm1RZi1YGEdDX/PElzjPGmhfbxlv0I9+jkLAUYyXGwnfvsS9U5Dpqg9fL/J2Tmz
 b5yIsjvbT5TxwjUTjLyi/QXtox82axTCAz5kkdsJOocZk+qnqGdcmTXXOh2PT/IPhMof
 cstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724168; x=1695328968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1y3QJ3NO1OpevaAaEL6gS3rKqXE25lyRwf0WEycZtJA=;
 b=cHWNL2J3GMdV38QuX30OfQePTGMpEG+Zql+2M/LIvW847RkiWdSz3nHXvxgWGQsXxg
 z6+0sycgDgnGcA0K6TQd+6KBleYKmqnrt3rRnjQa9Oa0MaHNx44JcNGHmgNWaOM4VTuY
 86/+zobosg7VqXjxT6Oo4sbv2iPuhJjFsdoeYVCF/MquMy8ej7mVm5IYcDKMZvh7/NgK
 Ifdl9u1HvXmLkjluyjRT3a04wuSIm+ExdAkqmcwsxHIcBSUvt5zD7USuw/X3yZBQtRN9
 LfVyoJPjBECW+HSEqs+eWB40rg3AxvjSvLozlNGG3buA0eOh5gyRll0zoyDd5gIbiVok
 4Vzw==
X-Gm-Message-State: AOJu0Yz9nau/InOIlYQv4o0fcCsCIn5A2m6F3TQVNq5WdoE5GfPiBdLf
 Yv/x2WX/4/hoSuGZrl50jWDG45mZDq0=
X-Google-Smtp-Source: AGHT+IHAX17EPH7hp2FS1tBf7QpWDoUVTXZtPrWRo1vqEAgtbyhQCQqCKVM7/M00cG0xvyHQUko27Q==
X-Received: by 2002:adf:f78b:0:b0:317:636b:fcb1 with SMTP id
 q11-20020adff78b000000b00317636bfcb1mr5977598wrp.27.1694724168239; 
 Thu, 14 Sep 2023 13:42:48 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:47 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 15/23] bsd-user: Implement mlock(2), munlock(2), mlockall(2),
 munlockall(2), minherit(2)
Date: Thu, 14 Sep 2023 23:40:59 +0300
Message-ID: <20230914204107.23778-16-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42e.google.com
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
 bsd-user/bsd-mem.h            | 37 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 20 +++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 5e885823a7..16c22593bf 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -99,4 +99,41 @@ static inline abi_long do_bsd_msync(abi_long addr, abi_long len, abi_long flags)
     return get_errno(msync(g2h_untagged(addr), len, flags));
 }
 
+/* mlock(2) */
+static inline abi_long do_bsd_mlock(abi_long arg1, abi_long arg2)
+{
+    if (!guest_range_valid_untagged(arg1, arg2)) {
+        return -TARGET_EINVAL;
+    }
+    return get_errno(mlock(g2h_untagged(arg1), arg2));
+}
+
+/* munlock(2) */
+static inline abi_long do_bsd_munlock(abi_long arg1, abi_long arg2)
+{
+    if (!guest_range_valid_untagged(arg1, arg2)) {
+        return -TARGET_EINVAL;
+    }
+    return get_errno(munlock(g2h_untagged(arg1), arg2));
+}
+
+/* mlockall(2) */
+static inline abi_long do_bsd_mlockall(abi_long arg1)
+{
+    return get_errno(mlockall(arg1));
+}
+
+/* munlockall(2) */
+static inline abi_long do_bsd_munlockall(void)
+{
+    return get_errno(munlockall());
+}
+
+/* minherit(2) */
+static inline abi_long do_bsd_minherit(abi_long addr, abi_long len,
+        abi_long inherit)
+{
+    return get_errno(minherit(g2h_untagged(addr), len, inherit));
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 5aebb18805..553578708b 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -611,6 +611,26 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_msync(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_mlock: /* mlock(2) */
+        ret = do_bsd_mlock(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_munlock: /* munlock(2) */
+        ret = do_bsd_munlock(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_mlockall: /* mlockall(2) */
+        ret = do_bsd_mlockall(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_munlockall: /* munlockall(2) */
+        ret = do_bsd_munlockall();
+        break;
+
+    case TARGET_FREEBSD_NR_minherit: /* minherit(2) */
+        ret = do_bsd_minherit(arg1, arg2, arg3);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.42.0



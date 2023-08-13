Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5035777AAF7
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:47:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzu-0007vX-Vh; Sun, 13 Aug 2023 15:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzs-0007uZ-Tz
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:32 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzr-0002Sv-CS
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:32 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fe4a89e8c4so33541525e9.3
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955810; x=1692560610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVHCLZbghf3dGGNPrTbCLPgQNA7m08ZBl/Dqb3D8Ozc=;
 b=gIM80ICvWWkSqZzTWtn68TdW4FDnfzPtXAXWX+4l8v1MOesCBREB6ABRUU+yQuq2VJ
 lcpGaozQhGWyJvVvs1gmxPaAkpIIzusrWILPoMsvVEEFdgZ0+0pWHog4ReVx4XqPAquH
 /cZpby/bO/UqB8SojN66vtoL1LGbsf7Kufa4RMTskYJ+OlNAUGzwuatsTZwbPhn7tK2v
 Rup4M4uLQ7X0tFiw4jQfP6M5IL2eOctj0M4ZtvaIF5YviwN01BzaVwwc3xuNTl4ESClP
 pgcqAjriBLBwW4MRG9bcx8A9A7d1Xt4NJw33EBsd1HwLzh8cRRniLTnq+scbdL3DtmB2
 37ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955810; x=1692560610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bVHCLZbghf3dGGNPrTbCLPgQNA7m08ZBl/Dqb3D8Ozc=;
 b=IlieFIiy0bSEGp/SO7rLb9hsIHqYO46xB7ZP3zJtglLjCnI/Mt/GO/edE8ODlRglFH
 2DjqnsY6wvHfEkRwMBb1miroX5zKyQ/a1cE9CezW1mpwkO8pll1ikdrY1a6gLrOUOJ2u
 pdxRAixP35Qxz6q+/ayC0EKEHqNoo1qyhmt9Lb6RbknV4NwiDjlpbbIHS/J4P44SYnjh
 k0r7okSO2nodXvxgdatsudKI6ZkNQg1F67+0a0PzWk5VKppXJPV1hgeG2OL4AYP1fsY9
 5BIo6g5//VKy4lWPeFK/GDIjCMnLm8HK9/3pqHJ5+n6dBujUJZRDjx81PXL9Zn1m0DqQ
 Yi8g==
X-Gm-Message-State: AOJu0YzVdkGagw9g3id2qnK63vF9FGrMSjW5VtQNUOX6qHC+rfVy6KY7
 v6Iby+8YUIC1Jo5PaCCEkJuTySDnhwU=
X-Google-Smtp-Source: AGHT+IHjTxgx7laaEdMWH6B/deM6yXtTZl3PaQgz1eyz64WoHL3aWqiy742qPbFOQr2sA8aoCJAybg==
X-Received: by 2002:a7b:cd02:0:b0:3fe:21b9:806 with SMTP id
 f2-20020a7bcd02000000b003fe21b90806mr5758654wmj.0.1691955809836; 
 Sun, 13 Aug 2023 12:43:29 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:29 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 25/32] Implement freebsd11 stat related syscalls
Date: Sun, 13 Aug 2023 10:41:46 +0200
Message-Id: <20230813084153.6510-26-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
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

From: Michal Meloun <mmel@FreeBSD.org>

Implement the freebsd11 variant of the following syscalls:
getdirecentries(2)

Co-authored-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-stat.h | 44 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index 04a61fabd1..26909af455 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -41,6 +41,11 @@ __sym_compat(statfs, freebsd11_statfs, FBSD_1.0);
 int freebsd11_fstatfs(int fd, struct freebsd11_statfs *buf);
 __sym_compat(fstatfs, freebsd11_fstatfs, FBSD_1.0);
 
+ssize_t freebsd11_getdirentries(int fd, char *buf, size_t nbytes, off_t *basep);
+__sym_compat(getdirentries, freebsd11_getdirentries, FBSD_1.0);
+ssize_t freebsd11_getdents(int fd, char *buf, size_t nbytes);
+__sym_compat(getdents, freebsd11_getdents, FBSD_1.0);
+
 
 /* stat(2) */
 static inline abi_long do_freebsd11_stat(abi_long arg1, abi_long arg2)
@@ -468,6 +473,45 @@ static inline abi_long do_freebsd11_getdents(abi_long arg1,
     return ret;
 }
 
+/* getdirecentries(2) */
+static inline abi_long do_freebsd11_getdirentries(abi_long arg1,
+        abi_ulong arg2, abi_long nbytes, abi_ulong arg4)
+{
+    abi_long ret;
+    struct freebsd11_dirent *dirp;
+    long basep;
+
+    dirp = lock_user(VERIFY_WRITE, arg2, nbytes, 0);
+    if (dirp == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(freebsd11_getdirentries(arg1, (char *)dirp, nbytes, &basep));
+    if (!is_error(ret)) {
+        struct freebsd11_dirent *de;
+        int len = ret;
+        int reclen;
+
+        de = dirp;
+        while (len > 0) {
+            reclen = de->d_reclen;
+            if (reclen > len) {
+                return -TARGET_EFAULT;
+            }
+            de->d_reclen = tswap16(reclen);
+            de->d_fileno = tswap32(de->d_fileno);
+            len -= reclen;
+            de = (struct freebsd11_dirent *)((void *)de + reclen);
+        }
+    }
+    unlock_user(dirp, arg2, ret);
+    if (arg4) {
+        if (put_user(basep, arg4, abi_ulong)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
 /* getdirecentries(2) */
 static inline abi_long do_freebsd_getdirentries(abi_long arg1,
         abi_ulong arg2, abi_long nbytes, abi_ulong arg4)
-- 
2.40.0



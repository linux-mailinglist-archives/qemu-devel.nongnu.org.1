Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5566C77A6CB
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:16:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpw-0008GJ-DI; Sun, 13 Aug 2023 10:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpj-0008CN-6Q
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:44 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpg-0000uB-Le
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:42 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3179ed1dfbbso3171036f8f.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935959; x=1692540759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVHCLZbghf3dGGNPrTbCLPgQNA7m08ZBl/Dqb3D8Ozc=;
 b=ZzWVkwKAJkIldJg5AKYV9zk7bfMnXqhCW5JPCX6WlJLqlv6m3mWqd1hRb1PaEDilyf
 ePAHVi3br56h0jT5G94ou6WpCsKZRjZx4xE2+hbigS3cGOb9wDiKrgxaGnKFMP3vQQqj
 CTbWYhwRQa4HW88X4Sxy8vkWPc5zZLN3dAdjXt5eOsytPEGXwtHLuCTWmVycmfulcg8L
 N5dpzsJhEg8E0m1E3SUEZ4kMciB1JaRX+E2MVsTmtCbY1qIe2JP9j91WP1LW6v4UsaOd
 233r7Tzb3gVVkJZDeEWrp+X6CMuCwhBt9J6PcC6RtfJFslWzgVz74JN0qx4mJwCuj9eV
 VUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935959; x=1692540759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bVHCLZbghf3dGGNPrTbCLPgQNA7m08ZBl/Dqb3D8Ozc=;
 b=isB8VD4/P7BVLya6qVin8CPC84V8ENY0tq6mbKV92QdftQElf0xFmJP8nOuxxauK6S
 OXjW21LOvMu4knpbUeGhBSRWkrVMrZ/w9+IBcIfs5oG4+WBRmrPpPPAJYYIn6TbilSsL
 wQGocR4ZuSXfjAGuaXRr1Yg0hYw3lhlQmIoBSFBOV7DZjrQ6K+BS5vYB3yh3w7j8ACxn
 v9eczZSKj5taMZWbE/OkE6kQSFkOpyoWVbKx2DZ8yuLwyyvDk2yXryodne568ghna9Gk
 nEsyMjrocsv3mRl7Fd0AupAwCZfKx2Nq+WT+KnkDxgUA9uhbzpVGUxkr5I8fig/PamPi
 4kAw==
X-Gm-Message-State: AOJu0YwPD8ELuy4Ca0BGJ+/6+8JaCayS1X1qB64k4WOAMpU9OpuhyjCn
 U/k4qdYOyqb4h/tT2NAXl81ftM07ev0=
X-Google-Smtp-Source: AGHT+IFGkWAkHq1eQk7C73kyitEct2L+QMG+/ufGzJlwD/y6C4ZoVXlttnERKrnEnwWjRN4xwnRkiA==
X-Received: by 2002:a05:6000:1051:b0:319:6e91:eb43 with SMTP id
 c17-20020a056000105100b003196e91eb43mr3140106wrx.31.1691935959078; 
 Sun, 13 Aug 2023 07:12:39 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:38 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 25/32] Implement freebsd11 stat related syscalls
Date: Sun, 13 Aug 2023 05:10:06 +0200
Message-Id: <20230813031013.1743-26-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x434.google.com
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



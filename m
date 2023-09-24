Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7DC7ACE37
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:38:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbSr-0003Ks-UG; Sun, 24 Sep 2023 22:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSo-0003Im-M7
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:46 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSn-000062-5P
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:46 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32320381a07so1360602f8f.0
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609403; x=1696214203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+y7I+dQizuXGTfyfswmuzENo8FjWt4FJ1ZjkqfWpTI=;
 b=YBiEUlhl43KGxD+GlRWYhiEOwf4jO3IBxlDrIFkeeUJXeI+e2nqJjse9+p2mEM7U/n
 MUXGgSPQA0yu6T9um9e4qdnskcn2bcwXfn4eOre2A0htO828bLUG7/DqwVu6miCeHIBn
 audlHACyp+RzM8o/vHCJRu668/y4HhkBfrPP/sgjjBfUouKD29+w5u4OT/lK2DyisT9R
 Htwpp33KMJNqHq/JQSUoZetIomAM3kpWyAHwJnehated2NIDbL0gSxRNnYLBD/SauneK
 X2diJWNXyIYSM+Z1Lc6p9pZLcOJ0i7qnkjeTzWw3cOOYsYNNdnGeuNHqp8iCbX+ZcW6E
 M55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609403; x=1696214203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c+y7I+dQizuXGTfyfswmuzENo8FjWt4FJ1ZjkqfWpTI=;
 b=EqtWoWKgc+17gPMN48oWliKKWcFkPIRRZnWo4E1ajBuGk7xF/T0dlGOBKuRNOddsR5
 9DRVI4MYiMCLby670r6l9/jhS+yXcMyYFrvIuzk7tEBlQR3KiM8u5Xd10o06mwc/We3v
 w78RZJU4MBLk7JmuYumFSbNMkQfuWvhoav99U/jK7oT+SUMAdQTtMiwXc1IhprQSv1u7
 fY6QoDKlzcIydeZIEe54WnRuuKA0ewLfwpqf6Ik5rU+cK7wzX3MUcVmCiHNtm1to95R7
 QJtOtEbnWo8t1amS9SIvWmWZLHJr6cxPPQe4EAfncp+fkApIDJgX2LJINrZjtplH554q
 72Dg==
X-Gm-Message-State: AOJu0YwGS3dLJxZfDOm26iYqPNj4MmtHi7lBIhz/t/6KGenv3uwUZTra
 tqsdUVp98yeVqTryt/SbxXTooSMWINA=
X-Google-Smtp-Source: AGHT+IEl7upApJ2GmTlp/8FUF32PelCCrObpvn95+ZdAeAEE9ad2i4vvQG7HjFjWPHF/Wa8dXQEMIQ==
X-Received: by 2002:adf:cb8e:0:b0:323:22d9:4930 with SMTP id
 q14-20020adfcb8e000000b0032322d94930mr1580625wrh.33.1695609402938; 
 Sun, 24 Sep 2023 19:36:42 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:42 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 11/28] bsd-user: Implement getgroups(2) and setgroups(2)
 system calls.
Date: Mon, 25 Sep 2023 00:01:19 +0300
Message-ID: <20230924210136.11966-12-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x433.google.com
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-proc.h           | 44 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  9 +++++++
 2 files changed, 53 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index b6225e520e..7b25aa1982 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -41,4 +41,48 @@ static inline abi_long do_bsd_exit(void *cpu_env, abi_long arg1)
     return 0;
 }
 
+/* getgroups(2) */
+static inline abi_long do_bsd_getgroups(abi_long gidsetsize, abi_long arg2)
+{
+    abi_long ret;
+    uint32_t *target_grouplist;
+    g_autofree gid_t *grouplist;
+    int i;
+
+    grouplist = g_try_new(gid_t, gidsetsize);
+    ret = get_errno(getgroups(gidsetsize, grouplist));
+    if (gidsetsize != 0) {
+        if (!is_error(ret)) {
+            target_grouplist = lock_user(VERIFY_WRITE, arg2, gidsetsize * 2, 0);
+            if (!target_grouplist) {
+                return -TARGET_EFAULT;
+            }
+            for (i = 0; i < ret; i++) {
+                target_grouplist[i] = tswap32(grouplist[i]);
+            }
+            unlock_user(target_grouplist, arg2, gidsetsize * 2);
+        }
+    }
+    return ret;
+}
+
+/* setgroups(2) */
+static inline abi_long do_bsd_setgroups(abi_long gidsetsize, abi_long arg2)
+{
+    uint32_t *target_grouplist;
+    g_autofree gid_t *grouplist;
+    int i;
+
+    grouplist = g_try_new(gid_t, gidsetsize);
+    target_grouplist = lock_user(VERIFY_READ, arg2, gidsetsize * 2, 1);
+    if (!target_grouplist) {
+        return -TARGET_EFAULT;
+    }
+    for (i = 0; i < gidsetsize; i++) {
+        grouplist[i] = tswap32(target_grouplist[i]);
+    }
+    unlock_user(target_grouplist, arg2, 0);
+    return get_errno(setgroups(gidsetsize, grouplist));
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index fa60df529e..535e6287bd 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -223,6 +223,15 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_exit(cpu_env, arg1);
         break;
 
+    case TARGET_FREEBSD_NR_getgroups: /* getgroups(2) */
+        ret = do_bsd_getgroups(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_setgroups: /* setgroups(2) */
+        ret = do_bsd_setgroups(arg1, arg2);
+        break;
+
+
         /*
          * File system calls.
          */
-- 
2.42.0



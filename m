Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A3F799AA4
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:41:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3nE-00062n-Cn; Sat, 09 Sep 2023 15:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3nB-00061v-Ph
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:53 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3n9-0003GP-Iu
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:53 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-401b0d97850so34745955e9.2
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694288330; x=1694893130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cp3taIBurVzkEpdhqs0MIuww8hVBnsMUiwg0Wyyn+94=;
 b=I9Z/kh6DVB/0KPUJ5nv7eYNOotefGDiN8fF6W+7/oEabYxMLuD8PYt8dN4GHfgGwpA
 Oz1oxSz4V4WedxkOo9Clc3jeAbWjHiVO3CN6rcOpTZGAqbnT9dhUKaJS0qREKQcWXTco
 /9mSJyKWur2BDlo4dY/P7fmRN/gUlZWwHR+h9HQLnVTh7UAUZLcsjKRfCPDXz6uks1Cc
 mIneQPX+PL5qolViPo+Gr4HYVo2TLaLgwGy3cIbv+OQWMu9FTwhQ8eKxqSJ/IDAK5GMS
 +7UEPO000M3xp9ju97kEkaCAgdPP07m0H5lKiOlxE30jSfr1jFj5348NhJ7SnqBi+hip
 4xRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694288330; x=1694893130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cp3taIBurVzkEpdhqs0MIuww8hVBnsMUiwg0Wyyn+94=;
 b=eG5CBhtI3CKDmnA7kmmvabeCr1d4Njz7PkEybwqhmF98+mMjyKMXeBQgZMQ0bH3lMO
 9lrRsAwKcHCcybaLGvt9TrduDTveSKyZARdEeY2nEl+DwuHFzdlcOOo16O9IznvedVqT
 6a0V8UGNjQbrsL5eHu/VYCplcg1o7/gQaU8R7d7ekYqe8f4RgeHY51Br5/gyOXqdjF+u
 O9FnnLe8KdgYY2DnZ/qCksThMNIQdrQ5gmpWQ/TzAuHYy5SzSjzK2sngvIsJ20sRFNEg
 iYYoEb4de6TQLW99AcLRdf7+pFz480aQ7bevdPmjSE8ILt4Ie33hvOwTxbj3MksmPI2L
 8zLg==
X-Gm-Message-State: AOJu0Yy8qJv5BDspwvnk0cOkKLG3ozmFJpUQ+LPj2uGEwqA3tbrVN8ma
 vRWDIl+Xl/IQWb022t0r4ZrwLDXjKyM=
X-Google-Smtp-Source: AGHT+IFPiSrZWrvMIbzvVUs8O6ikhzcvLHG+YVDJCuIqCkb9jkf+UMh0n2osfBKNONGSKRz3BjJMKg==
X-Received: by 2002:a1c:4b0a:0:b0:401:bd2e:49fc with SMTP id
 y10-20020a1c4b0a000000b00401bd2e49fcmr4871230wma.24.1694288329844; 
 Sat, 09 Sep 2023 12:38:49 -0700 (PDT)
Received: from karim.my.domain ([197.39.250.27])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm8612812wma.31.2023.09.09.12.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 12:38:49 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 21/23] bsd-user: Implement shmctl(2)
Date: Sat,  9 Sep 2023 22:37:02 +0300
Message-ID: <20230909193704.1827-22-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x336.google.com
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
 bsd-user/bsd-mem.h            | 39 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 43 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 27d4e7f079..68f34b5d36 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -304,4 +304,43 @@ static inline abi_long do_bsd_shmget(abi_long arg1, abi_ulong arg2,
     return get_errno(shmget(arg1, arg2, arg3));
 }
 
+/* shmctl(2) */
+static inline abi_long do_bsd_shmctl(abi_long shmid, abi_long cmd,
+        abi_ulong buff)
+{
+    struct shmid_ds dsarg;
+    abi_long ret = -TARGET_EINVAL;
+
+    cmd &= 0xff;
+
+    switch (cmd) {
+    case IPC_STAT:
+        if (target_to_host_shmid_ds(&dsarg, buff)) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(shmctl(shmid, cmd, &dsarg));
+        if (host_to_target_shmid_ds(buff, &dsarg)) {
+            return -TARGET_EFAULT;
+        }
+        break;
+
+    case IPC_SET:
+        if (target_to_host_shmid_ds(&dsarg, buff)) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(shmctl(shmid, cmd, &dsarg));
+        break;
+
+    case IPC_RMID:
+        ret = get_errno(shmctl(shmid, cmd, NULL));
+        break;
+
+    default:
+        ret = -TARGET_EINVAL;
+        break;
+    }
+
+    return ret;
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 52cca2300f..35f94f51fc 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -555,6 +555,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_shmget(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_shmctl: /* shmctl(2) */
+        ret = do_bsd_shmctl(arg1, arg2, arg3);
+        break;
+
         /*
          * Misc
          */
-- 
2.42.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC7F7A0EC5
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:09:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsa6-0003XC-SQ; Thu, 14 Sep 2023 16:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsa2-0003NS-5T
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:50 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZo-0001dH-Fi
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:40 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40413ccdd4cso7371515e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721874; x=1695326674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gaDpwPGKdn8R1xLqNYgEvaWAh41f4zZe7AF+G8lPpzs=;
 b=egITy+79LiUQvV7Wa9X3UJTbOWbJ09R6BKMZamg4cd/d4Ho5m8pJcOg1Ll84+z0ja7
 aE/HGKwwc5itD2WkTecmG2s6BZTXBMs1RVMkyV27RWd3xrF90WZ6ANdYZ5Zd32ajKWze
 QCFRBBgMYfT/BNz28z7SkHIssEVfu16Kz4BiKe/W2c25rAS733UZ3bf0a4UFcU8zg0QJ
 gD9E+txp3nxw2YWxesaD/tzVoazyWHtDTnbDivzdDX1v7bDIG4CtQWrBNwF6+/OiJ1m5
 lzw0XQ/9CDIN8jcCXNsEcqPFfQBJ5GJGwvOmXKrIW/ztXTMZh9rdu0mnHwTRmoro56f4
 0+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721874; x=1695326674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gaDpwPGKdn8R1xLqNYgEvaWAh41f4zZe7AF+G8lPpzs=;
 b=he9fmMmzx0LZdY4YPZHBJSJFYf9NopowXQbsVUeBfBpOIgA/8HFjZ2Jikm2b0jxYgz
 BTKoPQ7mkgA0zNxUh0aAwUFYg2m9Qj7/UDKENPHrsjui4U2VHzFOeRrKr4mrjjv7gqXX
 EXIybQMoU1Kzj7n/6OFs2/K7q3cPrXDfKly7vgZkAsjDUVIGV/MtrB9aphELnZl8yzB1
 CoLnSQhMI3j2GMW9mJrcR7NFXbVHg+CaiXmGO/Q18AxWIH2E9ljIzJOV1z4KD5hjx2PX
 9f41GjJkomNTaCZM9CBbq9lKBZZYZRn9j63LtZHr2LfrnOdbxyiq/QjERq2IuacjMjBX
 d3cQ==
X-Gm-Message-State: AOJu0Yw95Qc4xQ6VRb1uOVR54eNa3KOjVSezjwYUBJKwi0+pxbi91Wyv
 1wPZlgICALRekWxWAepFKJiNB+tyH+k=
X-Google-Smtp-Source: AGHT+IEESf78nalxTLaWV/be9wmI8p39z8Vufg9B0PBS++9vEizu97b38oqCLKAlfsdww72MLTiSww==
X-Received: by 2002:adf:f48d:0:b0:31f:a09e:e951 with SMTP id
 l13-20020adff48d000000b0031fa09ee951mr2099179wro.25.1694721873829; 
 Thu, 14 Sep 2023 13:04:33 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:33 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 21/23] bsd-user: Implement shmctl(2)
Date: Thu, 14 Sep 2023 23:02:40 +0300
Message-ID: <20230914200242.20148-22-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
References: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
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
 bsd-user/bsd-mem.h            | 39 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 43 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index c362cc07a3..b82f3eaa25 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -305,4 +305,43 @@ static inline abi_long do_bsd_shmget(abi_long arg1, abi_ulong arg2,
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



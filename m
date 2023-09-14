Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 696C27A0F29
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:45:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtB6-0003k6-QY; Thu, 14 Sep 2023 16:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAz-0003Xb-7Y
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:43:01 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAx-0006T2-6s
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:43:00 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40078c4855fso14907475e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724177; x=1695328977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OlFBXfrUelyZD113NpgkyEi3DkcrK5mWFFpJAPBaArs=;
 b=skUURppCpu2PrGXYCfF42x4e+dcBwaoLELKFK+PBfpsxLAylMPCcLmpEScd17o3E7d
 +K+zE7ijE6QDRiXZnMrXVYW5nkkSStHPHIq2yY+bCvml+bSPe5jPW3FcYdUakuBpKRoX
 Y4s/m4Gq28oGduDbPYpN19SVXpUv3Dcm6hixpiCUT0n1Csu7k88lkS3Vx2rV76uDZhcE
 WbxLUt2ZL06zHaVA5DP5O4shM1kDzpZG/e5DsSM6jnKthcriF72ESH4Rn3gRIQCuZN1O
 8vrYfd7Z3HKlH04DFjdo7BJ+WhQg6/ZIFkNrJj6CyPegtqyPGCtRUFiDFsmln7xhwBm7
 bYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724177; x=1695328977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OlFBXfrUelyZD113NpgkyEi3DkcrK5mWFFpJAPBaArs=;
 b=oeV7jurRT5uSLw9cI512sQh4C091UoQxZDyUcnuu1E9FFhnNx63Brlm9o7b1lZJXI1
 CzmVP+RKyNegouvnIttpfSWVz4v+N3xp0CQ5JLcZlJjpmtMeJkt/k+6gC15QkCMm/bQN
 OImeQKaKoUcs3mjRs68aGagJVf351AusIq8+su+2Iq83q0ASl0zVByjWcZxX7EfCa2cB
 48uYEHLR6TTJsvz2NCOIZETLfWuFMyFyCbCRyIFVKUXEe4VqZ3KLckwew4e8i5M9oxpW
 dL5cpN+ZB31royiykBHrhjkbm0mpBLYmihS7bJClPwV9KPma7xse3tnPZ7Ym/lQIs8Cg
 SsOw==
X-Gm-Message-State: AOJu0YxEgXamqPa0LstYGL7fX1sP56R5M0omeLDTFNdmOwP8lMHWgnyh
 OYAQLJlwo6WHxntzM4E71IRkGyxoqFU=
X-Google-Smtp-Source: AGHT+IH1a+vYG1ClGLjlv2hvVHnwgE/bwbbHvRKUyQuFNHGfxqwxWU4ltmE1ujgcaE+Aet6krU8nOg==
X-Received: by 2002:a05:600c:364b:b0:401:b2c7:34a8 with SMTP id
 y11-20020a05600c364b00b00401b2c734a8mr5797241wmq.7.1694724177366; 
 Thu, 14 Sep 2023 13:42:57 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:56 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 21/23] bsd-user: Implement shmctl(2)
Date: Thu, 14 Sep 2023 23:41:05 +0300
Message-ID: <20230914204107.23778-22-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
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
index f0ccd787e5..664b8de104 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -663,6 +663,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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



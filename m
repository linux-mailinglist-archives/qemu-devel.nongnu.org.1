Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9817ADF10
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:36:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqK4-00084Y-7l; Mon, 25 Sep 2023 14:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqJz-0007x4-5V
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:39 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqJx-0007j9-H3
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:38 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3226b8de467so5744410f8f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666515; x=1696271315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRkHnja7nexQbKWQ5sBDhgIEYNSvl8qtBM9POpCGcAI=;
 b=Q6Qovr9S4nhEWYwNRVgBzOHWCc7DIBX9Pv/xJwDYRCG1uE+msXcI3cSDi2XQuvuepa
 ACWDdeBsOGg02XBLbGTPw1AW0r+dYUE86AN1m0PpVtUUOxelmIkgblN12k5kDFOBFS3o
 bYKeWQMcm1Xwm2RKuuK0jx31JLjQbk1O7V3O5W+egwyV0p+Ht6JHR+/yH5UXeYR+u1eh
 tPZIZiilUP/v1XUyUvVHDVUbzyLSp0x1eER+DiGaNgRL7AOUiwWH6A6u+OEVPhzP52BK
 xFFdwF0wHzRhasLRKlDF4Pfvt3wfs6SYcu/1oo5sX0pvM+PSWNRXnitansVMA8aeP6/U
 j8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666515; x=1696271315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gRkHnja7nexQbKWQ5sBDhgIEYNSvl8qtBM9POpCGcAI=;
 b=CYmNWxCtffqnOifWmufJRfUQY9E/ZYd7RrV2XAYctBGw5v+uULD9FoSdyTufttIaJZ
 kNdCBfNXe7wGopm+DVsoDdftxXSLjv5VaWQpC8fjagEy5tY/OgYNR4C47DCy/3IF6lk0
 o6M6JaeYd4p0cTshFSeMI7hXrKfXhazMcfUfFH81D3i2Z8yCKPhAsl7w5FXLDZzFyHTa
 5rKssvKIsifCy+qLid7kYbUoP5YbRJvRMxfra4DubPMTuWX+Uj340kfbYP2K6/nKmvGU
 965O9clezppMPv3aAGPe/u9IchWGXSqTRDunG1Q5/aB7xEn1x4OXiI5J6mFlSwGZi+OJ
 C02w==
X-Gm-Message-State: AOJu0YwVK7KaeFrFAu2b5TxIKIsk0aw6rjwZlvIoP1syvvsilwgduUCa
 qTmmCzIepz2GoKXkbk0UNG4uYew/TgY=
X-Google-Smtp-Source: AGHT+IH5yUau2s6NVt8t3XffovWW54G/Os2vJc+COdqH1WOoJAYnq06ZYCPqBMoAlcwYVAUXDnA/KA==
X-Received: by 2002:a5d:6044:0:b0:31a:d7ce:927a with SMTP id
 j4-20020a5d6044000000b0031ad7ce927amr6360386wrt.3.1695666515078; 
 Mon, 25 Sep 2023 11:28:35 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:34 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 02/23] bsd-user: Implement struct target_shmid_ds
Date: Mon, 25 Sep 2023 21:26:48 +0300
Message-ID: <20230925182709.4834-3-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
References: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42a.google.com
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 4deb4fed35..f4a5ae2a12 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -72,6 +72,26 @@ struct target_ipc_perm {
 #define TARGET_IPC_SET  1   /* set options */
 #define TARGET_IPC_STAT 2   /* get options */
 
+/*
+ * sys/shm.h
+ */
+struct target_shmid_ds {
+    struct  target_ipc_perm shm_perm; /* peration permission structure */
+    abi_ulong   shm_segsz;  /* size of segment in bytes */
+    int32_t     shm_lpid;   /* process ID of last shared memory op */
+    int32_t     shm_cpid;   /* process ID of creator */
+    int32_t     shm_nattch; /* number of current attaches */
+    target_time_t shm_atime;  /* time of last shmat() */
+    target_time_t shm_dtime;  /* time of last shmdt() */
+    target_time_t shm_ctime;  /* time of last change by shmctl() */
+};
+
+#define N_BSD_SHM_REGIONS   32
+struct bsd_shm_regions {
+    abi_long start;
+    abi_long size;
+};
+
 /*
  *  sys/mman.h
  */
-- 
2.42.0



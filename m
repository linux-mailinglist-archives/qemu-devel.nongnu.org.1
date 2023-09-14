Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 004077A0F2A
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:45:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtAo-0003HE-Da; Thu, 14 Sep 2023 16:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAa-00037p-9B
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:36 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAW-0006Hd-FW
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:34 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31fa15f4cc6so1305372f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724150; x=1695328950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRkHnja7nexQbKWQ5sBDhgIEYNSvl8qtBM9POpCGcAI=;
 b=dIqJfjPBgH1bF8K/uE14lhVIxICyXvCHAyKAcwF4Q2pNwGVtP4rrDIXNuw956Z0Li5
 JdKhM+ua6t/4qWAlpLTJk+e+Tvy3nzRN4854p0Cda4TpSVYBMdCR9raDH/u2Pcz8qCKm
 emqVv8BS4zOFwo1C4jfsMXhOGxpVrMjjnLp+T+GCXf/zZv2nyn6hfFGihNZOm0ibq6qW
 dQNakBR2cOvhwyhlO3fdWMdxDW476i3qy48ny3zk6YFbPoSB/BomU0IenNQ9WM7wRP9f
 fdEt+giSv+zxn+E4VyZEMc/sWIBi/uTqUYfh/+5aDf1mplD/1EslwGDVs3VWBLPu3ETk
 HubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724150; x=1695328950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gRkHnja7nexQbKWQ5sBDhgIEYNSvl8qtBM9POpCGcAI=;
 b=W5xJk4YN+kw2QwVqzDXNW+oE68PbNAREt6YVBd5t6iDbCm/NSK/5F0L91TLxCdm97d
 9WjYe3MstcT78EpYoInISb+SaQZOwSZ6q7KqmlmwkgJ+J6HskO3XW4kiFCOkumaaBa7t
 Uv9QmbjI6TW7Qm5aVrJx6GVmVhMhxrNJ+b6jesVUrMyd/Wwz617i6nUESo4+l2c5mtba
 0vBkB2OE1PaME6Czw32UY8odoRAMkuqP7lMjefiXsuULOAPcCvnrjpsigWVnOP7UROYg
 5+fHTxbH7C18PCCD5uNo7l3XUHcfyqQfjPDiDZnTB/TH46ZeHE5s/aoEGOokG6h/EqiR
 P63Q==
X-Gm-Message-State: AOJu0YyLaYGdWy3XQF169GvbpoBqW8CUo2LCEeoOUNehefOq2MPvzNpC
 en/8UQXrqeonKESljd+agChZKgvh/Jo=
X-Google-Smtp-Source: AGHT+IEFEkYVh/o/6hyNZnDsVU9uovnJyyOwT8/CAQP6Aym6LKhanVWNfyCgOAO6lhBfNd0yglvQsg==
X-Received: by 2002:adf:f84c:0:b0:31f:8999:c3fe with SMTP id
 d12-20020adff84c000000b0031f8999c3femr5840502wrq.69.1694724150127; 
 Thu, 14 Sep 2023 13:42:30 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:29 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 02/23] bsd-user: Implement struct target_shmid_ds
Date: Thu, 14 Sep 2023 23:40:46 +0300
Message-ID: <20230914204107.23778-3-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x434.google.com
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



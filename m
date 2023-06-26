Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D3073E17B
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:03:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmny-0008CM-3a; Mon, 26 Jun 2023 10:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDmnw-0008CD-0h
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 10:02:56 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDmnu-00006d-6g
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 10:02:55 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fa96fd79feso11876535e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 07:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687788172; x=1690380172;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/Mw+q7U4ve19xzorCmqQmX4CCo2lwVfTBj0rm2i9dkM=;
 b=lkEpc8V34pbq2vfM54kkrsxheDRXSuB2W147JIibkriyEwut92XSJSRpp+VNqiARhX
 VTmkKsJEyMQCdgivbCHlSiGmJdyVe9wvFisMG1jGMcjYAbb83kYwhxVWpm04Qt1wNODc
 9Uh7BTLWlrFlMbU9NttlVbQh2H7cYMVJoLZIPJ8JMyPGZIEvwkDPaWFeue3HlB/Mn/j9
 ch7OYxjd+RN+VPX91KQ77OHesVN7zBeRraWhMU7rjT9SKLgW0BVFmdXxS9VG/3E92FE9
 pNsWBE7yrujWq6n94YHoKlUO2Yu6NmbslmG1SF8Fl5zVt07RsA/tAoSqTPODIxD1HwZs
 Z9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687788172; x=1690380172;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Mw+q7U4ve19xzorCmqQmX4CCo2lwVfTBj0rm2i9dkM=;
 b=OTwAVY0WFzeUTbt5QPqpRIrgd+U1nJOG9XlBbEiQt6MwxaLRB18mnIxCp2V7tK/ohU
 YnsCwGIpcWxuSzEbRpRDHfIon9cSD6zxRA756BIA+iG4EpKwXGGFmO4RadRjr/pRJ98I
 ULY7NxAJEK9nIt5vOziFNMkMzF1ylDaGpJC+SS+0333Jyonvz0iFzWpnQ2ZTmVS3bE8X
 ZY0+aMcPku28R1LxbYK/Mc0YK3AaBt0zDFHDcg3gwuhFX0PwzjxhbKjnAMV3lHltNJME
 /z4kEMXrcC31CQ4IoUW8suRlWEqYbijWU2IZhwwmL48TCEHGApmrbuqjrkPR8e43mMKE
 pDCQ==
X-Gm-Message-State: AC+VfDwAJGCRYpbo/ZeMb/ST70zr0ECFln/DYqPLslazUn/ijdXEbplP
 8eFWqnLvoiaAkXAabg/N11VvVraNG23j7CVc4V0WcuSk
X-Google-Smtp-Source: ACHHUZ6X3Di2L9CC8I2DzMuKMV8HTUGnu922C7la/8k6cUePLFTR3vqVHaYZrobkgsmWjZBXGFMKJQ==
X-Received: by 2002:a7b:c453:0:b0:3fa:7176:9590 with SMTP id
 l19-20020a7bc453000000b003fa71769590mr10283241wmi.38.1687788172498; 
 Mon, 26 Jun 2023 07:02:52 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 i6-20020adffc06000000b00313e421c620sm6684822wrr.54.2023.06.26.07.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 07:02:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng,
	laurent@vivier.eu
Subject: [PATCH] linux-user: Fix do_shmat type errors
Date: Mon, 26 Jun 2023 16:02:50 +0200
Message-Id: <20230626140250.69572-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The guest address, raddr, should be unsigned, aka abi_ulong.
The host addresses should be cast via *intptr_t not long.
Drop the inline and fix two other whitespace issues.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f2cb101d83..59b530547a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4528,14 +4528,14 @@ static inline abi_ulong target_shmlba(CPUArchState *cpu_env)
 }
 #endif
 
-static inline abi_ulong do_shmat(CPUArchState *cpu_env,
-                                 int shmid, abi_ulong shmaddr, int shmflg)
+static abi_ulong do_shmat(CPUArchState *cpu_env, int shmid,
+                          abi_ulong shmaddr, int shmflg)
 {
     CPUState *cpu = env_cpu(cpu_env);
-    abi_long raddr;
+    abi_ulong raddr;
     void *host_raddr;
     struct shmid_ds shm_info;
-    int i,ret;
+    int i, ret;
     abi_ulong shmlba;
 
     /* shmat pointers are always untagged */
@@ -4591,9 +4591,9 @@ static inline abi_ulong do_shmat(CPUArchState *cpu_env,
 
     if (host_raddr == (void *)-1) {
         mmap_unlock();
-        return get_errno((long)host_raddr);
+        return get_errno((intptr_t)host_raddr);
     }
-    raddr=h2g((unsigned long)host_raddr);
+    raddr = h2g((uintptr_t)host_raddr);
 
     page_set_flags(raddr, raddr + shm_info.shm_segsz - 1,
                    PAGE_VALID | PAGE_RESET | PAGE_READ |
@@ -4610,7 +4610,6 @@ static inline abi_ulong do_shmat(CPUArchState *cpu_env,
 
     mmap_unlock();
     return raddr;
-
 }
 
 static inline abi_long do_shmdt(abi_ulong shmaddr)
-- 
2.34.1



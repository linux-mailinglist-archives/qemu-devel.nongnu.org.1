Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDEF7902EB
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 22:44:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcAzF-0007DD-RN; Fri, 01 Sep 2023 16:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAyx-00071n-9V
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:43:08 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAyu-0001yY-St
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:43:07 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68c3ec0578bso2056881b3a.2
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693600982; x=1694205782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AcFXIYDDmm3o3vQOz6x04+Y31c6savnmQ0Pt4q+vdFI=;
 b=LQ+Quwj+eTG47JAGkz/UcfPvbmtEJV7evBaoVg7wgX33IDjSlFhzQbLNf5RvjqAB/O
 vY75tXpK8sP7qDPkMCiHgCYVsG3xkcEtImFoxCfbcx9R1W0n7wxUHL1nlqhLg2kuiF2Y
 ZxP9lazUitF4H4JiNXRsyhya5tmfmaKdgN4PjLxJSamN3gUF2NsltEKKYWo9cd9Xvke/
 7NIzjQq03Uxbj+g20iPTdMDkQSE6JWuNa9A7Av+4Nd6qxENRPAr9VFQDjy7d2bQRa9vL
 Q7muW7i3PGhcAEZYebFeGeg+Y/I202RkbO9d+uftk4woJ+fi8faWFaoKCKB2vJs9ccpB
 VZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693600982; x=1694205782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AcFXIYDDmm3o3vQOz6x04+Y31c6savnmQ0Pt4q+vdFI=;
 b=KY95V9+p/niKKzxpF2nyipHzHtMx0cVuDIJP9Wq3+jVTc2qpnjSQyZaqfQIaAkfiRc
 82FhW8FBbPfmKyEwgjHtNIj4UHOy8EDHs23mDtzFuq0kxAUFC2dxvVMuLQpmuDWYnoan
 61CB+TMO7JbH44pZ51dO5dxgLQXBtxfybrGEFZYguT/Ai6WwtDhb0L+ljH5SD8CJtP+S
 ZeEaBT6nKsYJrzELeMwjvP5E71VpqkPOgNUriVSR2ggn5fs3K4uDMINMbGqpzcuNKGuD
 27FJeFsqkMrv6CyABHbpGJCo1EuOuJdLer782o5kXWokxpBUUun2hwi96oIXtAN2SOX5
 nkDg==
X-Gm-Message-State: AOJu0YyrynhncUw87dLyCbiAkhfmCU+AvcIU8TtWGSh90ix5ufl2iX91
 7k/X2Z6JYysL8K6wzhrvuWRdyCfpw1Hcha5vosY=
X-Google-Smtp-Source: AGHT+IE3+1H255BAvc/p616rxvJuxhZlApeuDHO/fWYHKIJYg+3W89BjsdbPZ4wThyLMRUyNk/AclQ==
X-Received: by 2002:a05:6a00:2e0b:b0:68b:c2c7:a8ce with SMTP id
 fc11-20020a056a002e0b00b0068bc2c7a8cemr4069095pfb.17.1693600982583; 
 Fri, 01 Sep 2023 13:43:02 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j15-20020aa78d0f000000b0068c97a4eb0dsm3320666pfe.191.2023.09.01.13.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 13:43:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 11/13] linux-user: Use WITH_MMAP_LOCK_GUARD in target_{shmat,
 shmdt}
Date: Fri,  1 Sep 2023 13:42:49 -0700
Message-Id: <20230901204251.137307-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901204251.137307-1-richard.henderson@linaro.org>
References: <20230901204251.137307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Move the CF_PARALLEL setting outside of the mmap lock.

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 98 ++++++++++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 52 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 3aeacd1ecd..f45b2d307c 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1017,9 +1017,8 @@ abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,
 {
     CPUState *cpu = env_cpu(cpu_env);
     abi_ulong raddr;
-    void *host_raddr;
     struct shmid_ds shm_info;
-    int i, ret;
+    int ret;
     abi_ulong shmlba;
 
     /* shmat pointers are always untagged */
@@ -1044,7 +1043,43 @@ abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,
         return -TARGET_EINVAL;
     }
 
-    mmap_lock();
+    WITH_MMAP_LOCK_GUARD() {
+        void *host_raddr;
+
+        if (shmaddr) {
+            host_raddr = shmat(shmid, (void *)g2h_untagged(shmaddr), shmflg);
+        } else {
+            abi_ulong mmap_start;
+
+            /* In order to use the host shmat, we need to honor host SHMLBA.  */
+            mmap_start = mmap_find_vma(0, shm_info.shm_segsz,
+                                       MAX(SHMLBA, shmlba));
+
+            if (mmap_start == -1) {
+                return -TARGET_ENOMEM;
+            }
+            host_raddr = shmat(shmid, g2h_untagged(mmap_start),
+                               shmflg | SHM_REMAP);
+        }
+
+        if (host_raddr == (void *)-1) {
+            return get_errno(-1);
+        }
+        raddr = h2g(host_raddr);
+
+        page_set_flags(raddr, raddr + shm_info.shm_segsz - 1,
+                       PAGE_VALID | PAGE_RESET | PAGE_READ |
+                       (shmflg & SHM_RDONLY ? 0 : PAGE_WRITE));
+
+        for (int i = 0; i < N_SHM_REGIONS; i++) {
+            if (!shm_regions[i].in_use) {
+                shm_regions[i].in_use = true;
+                shm_regions[i].start = raddr;
+                shm_regions[i].size = shm_info.shm_segsz;
+                break;
+            }
+        }
+    }
 
     /*
      * We're mapping shared memory, so ensure we generate code for parallel
@@ -1057,65 +1092,24 @@ abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,
         tb_flush(cpu);
     }
 
-    if (shmaddr) {
-        host_raddr = shmat(shmid, (void *)g2h_untagged(shmaddr), shmflg);
-    } else {
-        abi_ulong mmap_start;
-
-        /* In order to use the host shmat, we need to honor host SHMLBA.  */
-        mmap_start = mmap_find_vma(0, shm_info.shm_segsz, MAX(SHMLBA, shmlba));
-
-        if (mmap_start == -1) {
-            errno = ENOMEM;
-            host_raddr = (void *)-1;
-        } else {
-            host_raddr = shmat(shmid, g2h_untagged(mmap_start),
-                               shmflg | SHM_REMAP);
-        }
-    }
-
-    if (host_raddr == (void *)-1) {
-        mmap_unlock();
-        return get_errno((intptr_t)host_raddr);
-    }
-    raddr = h2g((uintptr_t)host_raddr);
-
-    page_set_flags(raddr, raddr + shm_info.shm_segsz - 1,
-                   PAGE_VALID | PAGE_RESET | PAGE_READ |
-                   (shmflg & SHM_RDONLY ? 0 : PAGE_WRITE));
-
-    for (i = 0; i < N_SHM_REGIONS; i++) {
-        if (!shm_regions[i].in_use) {
-            shm_regions[i].in_use = true;
-            shm_regions[i].start = raddr;
-            shm_regions[i].size = shm_info.shm_segsz;
-            break;
-        }
-    }
-
-    mmap_unlock();
     return raddr;
 }
 
 abi_long target_shmdt(abi_ulong shmaddr)
 {
-    int i;
     abi_long rv;
 
     /* shmdt pointers are always untagged */
 
-    mmap_lock();
-
-    for (i = 0; i < N_SHM_REGIONS; ++i) {
-        if (shm_regions[i].in_use && shm_regions[i].start == shmaddr) {
-            shm_regions[i].in_use = false;
-            page_set_flags(shmaddr, shmaddr + shm_regions[i].size - 1, 0);
-            break;
+    WITH_MMAP_LOCK_GUARD() {
+        for (int i = 0; i < N_SHM_REGIONS; ++i) {
+            if (shm_regions[i].in_use && shm_regions[i].start == shmaddr) {
+                shm_regions[i].in_use = false;
+                page_set_flags(shmaddr, shmaddr + shm_regions[i].size - 1, 0);
+                break;
+            }
         }
+        rv = get_errno(shmdt(g2h_untagged(shmaddr)));
     }
-    rv = get_errno(shmdt(g2h_untagged(shmaddr)));
-
-    mmap_unlock();
-
     return rv;
 }
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E6678646D
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 03:05:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYykR-0000VQ-MI; Wed, 23 Aug 2023 21:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykN-0000CX-L5
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:51 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykL-0000SO-6T
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:51 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68bec436514so343635b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 18:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692838968; x=1693443768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y+pbl/I8yc9+qiiBx4oS2dhGsqACGwpE/srodEThD5g=;
 b=r9+NLgS5S+LsSI8suNS7NKaI1yjI4AM4dEypvxowmk4J2Hf00Z55sm826uPo7EgaE7
 DhQxxuXVpvp6hb5jp3IFn7Ud9AM2VZFrhOAGVhsaBt6RnK5P6f3Mq8bBne12FyrneVKo
 4RP11syEagwVy9u8Tnk8bTVW/gevxmgeqLbbGQ687RKJ31ILit6tZTPcW+NSRlhe5YAr
 OD1A4/MY6j7SDmeVXVK8yUs5r6Zseb+D2CwaNaqcAD5/Mfe9KNe3kS9lgjpjm9Q6faPH
 w7DjOk+3uJKT+8ZCIYOWLlQBbjcam9OCFL8GbMQLHSW8O4WZzsEPqedpznyp8GQr5Qqb
 XXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692838968; x=1693443768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+pbl/I8yc9+qiiBx4oS2dhGsqACGwpE/srodEThD5g=;
 b=MzTEJpqLO2IwEP1LoR73VldEA3uUyyKuS85moyxvAycQjEQx7+mRw4S4hDyCLHbX7S
 98BlmqNniPbGvS+F/VuLly1QsUDxYBLfsfRLo7JmX5b/90eZl36+ajO3Ho6/6f4bHgEw
 LsQoDiUysoSUbV3VVOXOIv4LVSH18eMrdr1RpQhR69fg/dAQhaLB/dfqP5CDj186Su66
 +9KSgVhosZJp/DwWU36CqGFABso84VAHm3JaibJXEPeE8btMwxGiCLWC35tyafIs/rtb
 nhQOcrQgztfwNZWgCgz3UVhqoC3eGYDWP7ZUtb/wmzT41FWFkMd6YBLg8QQAuCSAikOs
 nhhA==
X-Gm-Message-State: AOJu0Yze3MV9U7gcLH86nfCB6lXlYukR78IBOD2rMDOSR+1wJhapTH6m
 rG5m4FxUtzD8E5SF/KOwduan74mDgpq4QCx13Iw=
X-Google-Smtp-Source: AGHT+IH/qQDTknwDu5Myvas91exk3C6vOG58/duVL5Q8quUx7krY2EM5JdZpiSmGCJCBOhjxfl/YHQ==
X-Received: by 2002:a05:6a20:9381:b0:140:48d4:8199 with SMTP id
 x1-20020a056a20938100b0014048d48199mr15332400pzh.24.1692838968004; 
 Wed, 23 Aug 2023 18:02:48 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 c10-20020aa78c0a000000b006875df4773fsm2050789pfd.163.2023.08.23.18.02.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 18:02:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/13] linux-user: Use WITH_MMAP_LOCK_GUARD in target_{shmat,
 shmdt}
Date: Wed, 23 Aug 2023 18:02:35 -0700
Message-Id: <20230824010237.1379735-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824010237.1379735-1-richard.henderson@linaro.org>
References: <20230824010237.1379735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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



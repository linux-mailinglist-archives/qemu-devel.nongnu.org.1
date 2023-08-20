Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01883782005
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 22:45:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXpHW-0004y7-Oz; Sun, 20 Aug 2023 16:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXpHU-0004wo-0d
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 16:44:16 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXpHR-0007kQ-Ef
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 16:44:15 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3a85b9c6ccdso216947b6e.0
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 13:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692564252; x=1693169052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+pbl/I8yc9+qiiBx4oS2dhGsqACGwpE/srodEThD5g=;
 b=EZ/ByEThr2TXyaggw5E8gnyMRfZU7/PAzpvzHWpiTU4RWB62j4M96vPVyEILfEAOwt
 25HUZSFGex1w06NTq4E5rObGyNdCel1IunzfvcpnUH9kM7FY/yAySFg6hXbewsgq9MrT
 duDUGxMVChEtMnIb3pJlr1z750/UlSoPr7CTgKO++YKPPB0FYkiL5JTYatfuJUnIL+QL
 xBs1XwdLtSkKzJd+LxIGSbR3+jUZGWShgO86SE56oqhOxlUvsBuLekZVaMnFnkUExRuX
 5SA67ETOiO1fG3m0gtr7jJ+HHbpjqBu4s9lmgtJrAl1NgkAEiQ0hrAwPg7YePg8hRi+x
 wNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692564252; x=1693169052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+pbl/I8yc9+qiiBx4oS2dhGsqACGwpE/srodEThD5g=;
 b=aq4Mzf8z3VaHij6qvRj1yGOp2tW5PgBt+PQYM4B3JpB/BWcntLqggkzRE15T4p4BTv
 yVvZmhqIaQoHL8p9VePbUzBbISlhC/3kCRsJ0OfCcDkFZT50voGjZbmjyDfqLTtHyU1H
 flZrMCYwZaGEg7DyJcscpcG0XFFLDyRXdxvW7lbh/p/OVwimvDwPo9DdNc3+XPAGNOeT
 hpp3Mknn7YEpX8TKCkO9CXRYAlisNxV1Atw0U8owU7r1Geu2+Hgy/v7FaG6h6demXZwI
 XzUNOOzxpYilTmPwMycVeD+sTu9y/gh0zm/RLNSadgFFSWaMvZzjw4sMDk/Q/RqdlRuO
 XtTQ==
X-Gm-Message-State: AOJu0YxVt5xJ2IDqcvcbEqQHg1BZln6lllOibaT8VRt3Q2UCJ6j/nTEI
 opJN4dhDNFyftrmM1My9IlyaqctnynlXBKICDXs=
X-Google-Smtp-Source: AGHT+IEUVFXDk33AXY0U77Vkx2mvakuaXSiQ83cyLOZCHaQ5FXhzcUQjrDVn5mGDWD45l9EgeKgc5g==
X-Received: by 2002:a05:6808:1a0a:b0:3a7:4b9a:43c2 with SMTP id
 bk10-20020a0568081a0a00b003a74b9a43c2mr8484408oib.13.1692564251908; 
 Sun, 20 Aug 2023 13:44:11 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 c7-20020aa78c07000000b0064fde7ae1ffsm1430149pfd.38.2023.08.20.13.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 13:44:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	imp@bsdimp.com,
	kariem.taha2.7@gmail.com
Subject: [PATCH 2/4] linux-user: Use WITH_MMAP_LOCK_GUARD in target_{shmat,
 shmdt}
Date: Sun, 20 Aug 2023 13:44:06 -0700
Message-Id: <20230820204408.327348-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820204408.327348-1-richard.henderson@linaro.org>
References: <20230820204408.327348-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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



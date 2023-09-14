Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C44D7A0F40
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:47:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtB4-0003eF-8j; Thu, 14 Sep 2023 16:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtB0-0003Z3-NX
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:43:02 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAy-0006To-W4
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:43:02 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-400a087b0bfso15000185e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724179; x=1695328979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0qCnBrmq8ElzL12pKuzE5cbfgMq8tTx5nwbXwHsBGr8=;
 b=Oo9C+ECqUuAtfwWxpvcRaaB07JtrcvUH9UjSbi7wfdo1B2MOTaWWM+FE4sTQcD1cNI
 8w9ZMd8cTX07xJ7jUl7L2HDZk8W/ekvwJs5ngEijnQKG50ocicYYqejVdvAZ47UAAI4g
 gizwHPvK/WYURMFbfJalXW6nTnvqoxPuv0/BvQgpia/0XzMO9W9wi/utn6RKYxkrepqQ
 LPjb7vktvvb5UaWDe7hdMpGGB5lJY9KzgWoyyot0XjazmICbAyu1wkKRrYau1oucti1t
 afQEkSG9zoemwKK+TJHZAA+ozxfCzb7jz6gFyKiSA9p+GEZmPFog1OeWoGT1XNQ60Ro/
 dReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724179; x=1695328979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0qCnBrmq8ElzL12pKuzE5cbfgMq8tTx5nwbXwHsBGr8=;
 b=plHX3GtR3lyM30KlT+DbpF51DXE5aIXVGOXsUtG65lcAufU0ymPKVQy28INcgysK8D
 YCjpVq1h0jWS9wk76Od+b5lDtoMqYDNxCuiIk4JVaJnauW0Y/jqIamQeNg/9/Eo9URWr
 HVeBlK5fFnNPhrPx8zEWu53xFCehRPQCWkV92umozFupDdmDtghMNRUsDRmQY/9BEF/v
 gIsUR9Qa/DLKfFX4ix+1E6vQe+pixHGkl/WSsad8sUO0ayLZUmA4gLrETxc575fMILi7
 6C9MjrXZfnJRTNt5Xi6DDFr1o478BSScai1p4W2n/9L7GbtSwQfQfnJJJJsit2Ldg87C
 lDWw==
X-Gm-Message-State: AOJu0YzFZ/JTtlQmrX+4KSQZ00m/MplcbWd9r+HQml3+NEuK2zi33Ni1
 axZx51k6XhdpXHb9gQC0anGwYUGzduI=
X-Google-Smtp-Source: AGHT+IFUvegifWG0mzXzleoU+GQ2/BTr6pHVUl8cV5h9oZAoxYxikU8714TDdiQubHMX5eBPcJ4Xzg==
X-Received: by 2002:a5d:648c:0:b0:31f:ddf2:d6fe with SMTP id
 o12-20020a5d648c000000b0031fddf2d6femr3040769wri.32.1694724178768; 
 Thu, 14 Sep 2023 13:42:58 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:58 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 22/23] bsd-user: Implement shmat(2) and shmdt(2)
Date: Thu, 14 Sep 2023 23:41:06 +0300
Message-ID: <20230914204107.23778-23-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32a.google.com
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

Use `WITH_MMAP_LOCK_GUARD` instead of mmap_lock() and mmap_unlock(),
to match linux-user implementation, according to the following commits:

69fa2708a216df715ba5102a0f98468b540a464e linux-user: Use WITH_MMAP_LOCK_GUARD in target_{shmat,shmdt}
ceda5688b650646248f269a992c06b11148c5759 linux-user: Fix shmdt

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 87 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++
 bsd-user/mmap.c               |  2 +-
 bsd-user/qemu.h               |  1 +
 4 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index b82f3eaa25..c512a4e375 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -344,4 +344,91 @@ static inline abi_long do_bsd_shmctl(abi_long shmid, abi_long cmd,
     return ret;
 }
 
+/* shmat(2) */
+static inline abi_long do_bsd_shmat(int shmid, abi_ulong shmaddr, int shmflg)
+{
+    abi_ulong raddr;
+    abi_long ret;
+    struct shmid_ds shm_info;
+
+    /* Find out the length of the shared memory segment. */
+    ret = get_errno(shmctl(shmid, IPC_STAT, &shm_info));
+    if (is_error(ret)) {
+        /* Can't get the length */
+        return ret;
+    }
+
+    if (!guest_range_valid_untagged(shmaddr, shm_info.shm_segsz)) {
+        return -TARGET_EINVAL;
+    }
+
+    WITH_MMAP_LOCK_GUARD() {
+        void *host_raddr;
+
+        if (shmaddr) {
+            host_raddr = shmat(shmid, (void *)g2h_untagged(shmaddr), shmflg);
+        } else {
+            abi_ulong mmap_start;
+
+            mmap_start = mmap_find_vma(0, shm_info.shm_segsz);
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
+        for (int i = 0; i < N_BSD_SHM_REGIONS; i++) {
+            if (bsd_shm_regions[i].start == 0) {
+                bsd_shm_regions[i].start = raddr;
+                bsd_shm_regions[i].size = shm_info.shm_segsz;
+                break;
+            }
+        }
+    }
+
+    return raddr;
+}
+
+/* shmdt(2) */
+static inline abi_long do_bsd_shmdt(abi_ulong shmaddr)
+{
+    abi_long ret;
+
+    WITH_MMAP_LOCK_GUARD() {
+        int i;
+
+        for (i = 0; i < N_BSD_SHM_REGIONS; ++i) {
+            if (bsd_shm_regions[i].start == shmaddr) {
+                break;
+            }
+        }
+
+        if (i == N_BSD_SHM_REGIONS) {
+            return -TARGET_EINVAL;
+        }
+
+        ret = get_errno(shmdt(g2h_untagged(shmaddr)));
+        if (ret == 0) {
+            abi_ulong size = bsd_shm_regions[i].size;
+
+            bsd_shm_regions[i].start = 0;
+            page_set_flags(shmaddr, shmaddr + size - 1, 0);
+            mmap_reserve(shmaddr, size);
+        }
+    }
+
+    return ret;
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 664b8de104..6b32d4df68 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -667,6 +667,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_shmctl(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_shmat: /* shmat(2) */
+        ret = do_bsd_shmat(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_shmdt: /* shmdt(2) */
+        ret = do_bsd_shmdt(arg1);
+        break;
+
         /*
          * Misc
          */
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 8e148a2ea3..3ef11b2807 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -636,7 +636,7 @@ fail:
     return -1;
 }
 
-static void mmap_reserve(abi_ulong start, abi_ulong size)
+void mmap_reserve(abi_ulong start, abi_ulong size)
 {
     abi_ulong real_start;
     abi_ulong real_end;
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index d3158bc2ed..09a8f9aed4 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -232,6 +232,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
 int target_msync(abi_ulong start, abi_ulong len, int flags);
 extern abi_ulong mmap_next_start;
 abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size);
+void mmap_reserve(abi_ulong start, abi_ulong size);
 void TSA_NO_TSA mmap_fork_start(void);
 void TSA_NO_TSA mmap_fork_end(int child);
 
-- 
2.42.0



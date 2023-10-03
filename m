Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4407B753F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:39:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovy-0004nf-RH; Tue, 03 Oct 2023 19:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovq-0004Vj-Aq
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:36:02 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovl-0007U2-EN
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:59 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79fe8986355so59690739f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376152; x=1696980952;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0xs6F3bQ3X0JBHAPx4Ith6fLrpCOwQaP480klykNHXU=;
 b=1jXBHGD/moKy7aVUCLb8K9wscR71p5HJndlfTLDp4jf5AORG6Grqq9ZJfZUtvJe/3g
 SLnvyw7LDJ2csQVUzqf8cBPrui4sDgTs7akMXyJRFQfRICT+Gh0C342bAX+rI9hTr3r4
 jZgVIveKPTZJR8HDXXrH3EabMaOzYWa7VVPSqkPNoP6YYuNHJVdtIXSTMtGf8RDl7QbE
 ufIp5cCilPf6eZDgYNdyfIF3Z3xYaK/ZK1e7xPZkEbGDLVXh8b2ubHT/Xa4H23QlSOwP
 reqIPpMiKcS57m5GkfYrHHwbK0CqYVAh3/m3RUUZfxCPiah0f6681nUAz9K4Dmqk9GYV
 truw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376152; x=1696980952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0xs6F3bQ3X0JBHAPx4Ith6fLrpCOwQaP480klykNHXU=;
 b=psTzFHjFsEKhNLwq5xMp/nb6QHB9Mp+n8ShDlvIPW021Lp6ytwfqPC2iif2sTDeJiu
 RNFKUeg+j7QnEdaE6P6b/kCazwfi2IJ5zsAVuHEfcZc7LNqwpoOaAmw/sw8+KOEwigeE
 dFhsW3Idgug1XM8zRUcMRdzx0BL305e2b2avX4s4lmvvSkdR0D2tKkG+76CxGz4CCD6d
 rCTT1ik/GikuQtRsc6ANvuOHZbF74gDxX6e6h44vP8wAgjK7bOum+NUt92iEsZqqPto6
 BlW+HmUOOciwpOj0ekt6XdjVfWIF1VZkSuPUyi9gr0OwVG0pXJzDSU/Y2poVul7dP6KL
 v+7A==
X-Gm-Message-State: AOJu0YxfmcseR/EijHX/SD4QeT2wZi8guwjAo9KB/Dw9nj98AKpeeOrg
 IMsh8Am4S4O6WgJ4fJ0+rVhnv7VfV8TbcdTcfq0miA==
X-Google-Smtp-Source: AGHT+IF8WUqyCpk83nfDn3hIHdJ5tPbzsXtgSwyPH/X++I1YLXERXzMqlKkSrChUGOHxIMFHnMIY7w==
X-Received: by 2002:a5e:8c15:0:b0:787:1472:3181 with SMTP id
 n21-20020a5e8c15000000b0078714723181mr1027873ioj.3.1696376152518; 
 Tue, 03 Oct 2023 16:35:52 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:52 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PULL 50/51] bsd-user: Implement shmat(2) and shmdt(2)
Date: Tue,  3 Oct 2023 17:32:14 -0600
Message-ID: <20231003233215.95557-51-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d30;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Message-Id: <20230925182709.4834-23-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 87 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++
 bsd-user/mmap.c               |  2 +-
 bsd-user/qemu.h               |  1 +
 4 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index b82f3eaa253..c512a4e3756 100644
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
index 0512d41db7c..39e66312da1 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -871,6 +871,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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
index 8e148a2ea3e..3ef11b28079 100644
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
index 6047805ae38..dc842fffa7d 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -233,6 +233,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
 int target_msync(abi_ulong start, abi_ulong len, int flags);
 extern abi_ulong mmap_next_start;
 abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size);
+void mmap_reserve(abi_ulong start, abi_ulong size);
 void TSA_NO_TSA mmap_fork_start(void);
 void TSA_NO_TSA mmap_fork_end(int child);
 
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A48799646
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:36:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepg1-0001Aw-7y; Sat, 09 Sep 2023 00:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfu-0001AJ-RN
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:34:28 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfX-00030M-Df
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:34:26 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-400a087b0bfso28349795e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234041; x=1694838841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hvIIhsiuBvf1kndCBMcjJtgubDA4YhP3ZHmk+jfqh6c=;
 b=A3ObypMhVqpGOoE92M5Wd8u8gLA/A/qok3ZRJdvqaVkfkZDi8SZjlk06vI0KH8Xr6o
 puPFRJ/2n9NtUAODQ0OkxpmMnAXIcNxQdqrdvXGgbcePAD8I2BTrTOVZaJr7GFKITNnq
 FW6SZJvTgIUKXGp8eakJdtcIDVxzeq2F489SbxCaCnwZ19C6rPWkSCIRzkRqx8E2Bpyy
 2nX0aDtulu6+sDkX8K52XvM+gw36HNFvO/MUk6DztCuRLqZY4hqo+aPuUGwA8K0XQBE7
 zn8s4lOEqzvLklbVQBN6GKUwSLik9mXheFWwp8Xla4By6PhY9GXxaOkeZplhxv3urxOQ
 H9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234041; x=1694838841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hvIIhsiuBvf1kndCBMcjJtgubDA4YhP3ZHmk+jfqh6c=;
 b=ZMTi9VDefZZfxCO9SZkFManT9XJgiTIX2K53ktLeK0k+LGFJKb7NlSDgyE6kNwnCBe
 X9dx5YRVQttgEAQU3fv4GOYcNGoEmUpj9b4bu/UdEYCLFhIgoyL8j+Zdec2uYaOvZaP7
 JlEt3GY7nBQeV6wmQsvBCJG/G7Kko0/nQ0UmlEus2TEl0mBdwZRYeopd49QI3FYeOPCL
 oNWl5iCZqclxcWk0mwo2txwxmYGd0BmSHumQEkCoaEH5aQhcFO0cqX6CMdWGTdkxb+7D
 1fjjVS0+ACjs+oblhh+oj1Uhq6nDx9ZVY7Q+TEikWns2hj4YqueVIw7+3t2o58CilAHS
 TnOw==
X-Gm-Message-State: AOJu0YwUUzFiAELRrfifMHENfQs75BdqyTKDLZfIoy7Yg1SQAZQ5Ycy/
 VjNsQ1UjUPl4Q2SAOmanDL7y74sGiTU=
X-Google-Smtp-Source: AGHT+IErZsCrUGciBlUi7O337nWE78kz1j/ssxA2xX4XLYI9hheG8o059gqnoodtVQiSmYbkvqWeUA==
X-Received: by 2002:a05:600c:3b8d:b0:403:31a:77b9 with SMTP id
 n13-20020a05600c3b8d00b00403031a77b9mr444107wms.37.1694234040953; 
 Fri, 08 Sep 2023 21:34:00 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:34:00 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 22/23] bsd-user: Implement shmat(2) and shmdt(2)
Date: Thu,  7 Sep 2023 09:43:01 +0200
Message-ID: <20230907074302.79234-23-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
References: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 bsd-user/bsd-mem.h            | 76 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++
 2 files changed, 84 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index dd506b8a15..c01b009326 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -337,4 +337,80 @@ static inline abi_long do_bsd_shmctl(abi_long shmid, abi_long cmd,
     return ret;
 }
 
+/* shmat(2) */
+static inline abi_long do_bsd_shmat(int shmid, abi_ulong shmaddr, int shmflg)
+{
+    abi_ulong raddr;
+    abi_long ret;
+    void *host_raddr;
+    struct shmid_ds shm_info;
+    int i;
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
+    mmap_lock();
+
+    if (shmaddr) {
+        host_raddr = shmat(shmid, (void *)g2h_untagged(shmaddr), shmflg);
+    } else {
+        abi_ulong mmap_start;
+
+        mmap_start = mmap_find_vma(0, shm_info.shm_segsz);
+
+        if (mmap_start == -1) {
+            errno = ENOMEM;
+            host_raddr = (void *)-1;
+        } else {
+            host_raddr = shmat(shmid, g2h_untagged(mmap_start),
+                shmflg | SHM_REMAP);
+        }
+    }
+
+    if (host_raddr == (void *)-1) {
+        mmap_unlock();
+        return get_errno((long)host_raddr);
+    }
+    raddr = h2g((unsigned long)host_raddr);
+
+    page_set_flags(raddr, raddr + shm_info.shm_segsz,
+        PAGE_VALID | PAGE_READ | ((shmflg & SHM_RDONLY) ? 0 : PAGE_WRITE));
+
+    for (i = 0; i < N_BSD_SHM_REGIONS; i++) {
+        if (bsd_shm_regions[i].start == 0) {
+            bsd_shm_regions[i].start = raddr;
+            bsd_shm_regions[i].size = shm_info.shm_segsz;
+            break;
+        }
+    }
+
+    mmap_unlock();
+    return raddr;
+}
+
+/* shmdt(2) */
+static inline abi_long do_bsd_shmdt(abi_ulong shmaddr)
+{
+    int i;
+
+    for (i = 0; i < N_BSD_SHM_REGIONS; ++i) {
+        if (bsd_shm_regions[i].start == shmaddr) {
+            bsd_shm_regions[i].start = 0;
+            page_set_flags(shmaddr,
+                shmaddr + bsd_shm_regions[i].size, 0);
+            break;
+        }
+    }
+
+    return get_errno(shmdt(g2h_untagged(shmaddr)));
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 35f94f51fc..fe0968773e 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -559,6 +559,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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
-- 
2.42.0



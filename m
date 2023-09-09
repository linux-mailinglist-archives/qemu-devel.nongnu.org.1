Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE59799AA2
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:40:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3nE-00062x-TI; Sat, 09 Sep 2023 15:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3nD-00062L-7R
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:55 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3nA-0003Ga-UB
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:54 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-400a087b0bfso33190105e9.2
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694288331; x=1694893131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+pHxixZTU2F4KP0CicWK9lX8+4X9piVzVmnI1BfMcAw=;
 b=XPa/xwPqEG3uSreDwIISvdVV7EKSjvSQH4YYp3oLy3XTTpPcEsEj09iv1lmE7pPp0z
 5z9pdWgZMKfDWIjTyY8SfJNmz8TvJ3SqxTjVNGx6eghTHvwkFBqHurvwYg1YpXf2rrvT
 Zx5fSUShS25sgfp8hNLNqNGPx7RSvvXdc6f8Q5ZSIfQFra3Yyxmjzy31p+7r64yfWaV3
 brJSExQSaPhMAqlZzkypO5TOrD3wnsogxfsOvC9l8UEJAAVU4Ih0nm0PhMQW4unzf2Bj
 AQ1iOf4cAp2+CE9cygZYlcVAJcP7C/j9a4b4cPgix7wvycN9oR+T9GjIrnThbK7hzOvE
 CayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694288331; x=1694893131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+pHxixZTU2F4KP0CicWK9lX8+4X9piVzVmnI1BfMcAw=;
 b=vijMyFfTlJ9ZoZLf+5hkqsSqwQy10Y4q3Dd6aVXm9eqMjD8uSxxU59YWsHaX1fk44J
 KK0XJoHhAsMDZtJUNkiwrE0WvJ2cqyh6uybPIASIYARoz6EcOo6QcjrvFMkFwbg27iuh
 jW7yUwDmwIOSO5TRs0qhbNUZ5WyPlfIiTLWCchSHWo44yQkHafjAxTU0UYGPOdFTqrPt
 +nFoDMnW9w2xK7WU5QUdPMK1Oafv2HchGVZQ0T7zjwTKf/AljxJX0TCuodsns8Bn+asT
 C8AtBedyO6DivDPsjqtjSum9k1QDPDdxvgwsQJOREX9F4XVpAAP0qhzuzofbS2uHDbmJ
 2ZSw==
X-Gm-Message-State: AOJu0Yy2kOUv2B9dDGt9YVfoTnWUePdO3H7jJUd5FAyX2HSSC2ESkQJw
 rQjVBHSd1ACu65H1CqZPjfjeJyMiPpY=
X-Google-Smtp-Source: AGHT+IGe56INP8h8UeEq2b2IRYnRM8fpzhP7Yzd2Q0yzC4XlxiWQxp4BGGpmH8eRJANub6+h+2BNYQ==
X-Received: by 2002:a1c:7508:0:b0:401:be5a:989 with SMTP id
 o8-20020a1c7508000000b00401be5a0989mr4644105wmc.23.1694288330988; 
 Sat, 09 Sep 2023 12:38:50 -0700 (PDT)
Received: from karim.my.domain ([197.39.250.27])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm8612812wma.31.2023.09.09.12.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 12:38:50 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 22/23] bsd-user: Implement shmat(2) and shmdt(2)
Date: Sat,  9 Sep 2023 22:37:03 +0300
Message-ID: <20230909193704.1827-23-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x335.google.com
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
---
 bsd-user/bsd-mem.h            | 76 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++
 2 files changed, 84 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 68f34b5d36..8e5f22da5b 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -343,4 +343,80 @@ static inline abi_long do_bsd_shmctl(abi_long shmid, abi_long cmd,
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



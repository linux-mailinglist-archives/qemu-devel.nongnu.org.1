Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 261687818A4
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:50:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIae-0001nX-9B; Sat, 19 Aug 2023 05:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIac-0001iD-3D
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:50 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIaZ-0004Vn-QF
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:49 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31781e15a0cso1510130f8f.3
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438586; x=1693043386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c81n0IuPWBObuKho74EdgZfgQ3nDUAJ4UIi37AKURKc=;
 b=rUl9bcXMWFoXJsW3TjwlV9KVakgFyZ8xwGTlRuKt6Cwc3iFcdX9FhLNJAMKqQrAumA
 pTyhdZ1P/jg9Ge03KRQeTQW7lIRU19L6sSxnWdHsqX0Qr7vyJ+sAKIMuNJdmErwpNv8H
 6T8T6bvp5krIPcpdd0ZOqKPDc/O+3UiZx7jxuw0EiscuCjk4vd/OCnHrPFpQw1a4xAsi
 eM7u8S078+PWmKWT/a+4XygOIGSq7ypL5GTDmzKeNPzPAyYjF/tkx+r6fD40NUZpFVSc
 8yO8E4OcK4RTnKeprSa7ipD3JUevx1OCwthlh6V1G068zRbgi1u7ylCmMEC9tA2APT8Q
 cbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438586; x=1693043386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c81n0IuPWBObuKho74EdgZfgQ3nDUAJ4UIi37AKURKc=;
 b=MF9RBPIAhbMX32lpQU+P10VPFTQDlUQir1+SYC82f5x28IcO/6A3oPcGtfNFwyZj4b
 cClnH7gFFEUn79pS+WL8xCps51zSMWwPMc7zo5K2hAQZfYWOI2vZyh/TiNSXztIqleRk
 S8LQwfcqU3zF2Y4hg+Ref36OV7vrnlnJF19dac/1ok5LQjIRspMexZ+KvEDrYBXNgUnp
 UDPXL21SkP7lirJLBtDQ41qdyYmXUWt6A5lkfV0EtPifUgEdizb22Hy7p4gE4Rx5+KL0
 9gS6jUbCvnKeULCV4Q7C5B/vyYe4n7jkgLm2Cr4iR0YUruJpMg8JUI0x0AtVB1oyCVC1
 OJxg==
X-Gm-Message-State: AOJu0Yyc3WJt8EEAU83iUSUPVAW4ROmAQ1uRrBwUzzG0HRJ+B2iYaWQd
 SCFDcdwS6wPUleUOg/w/wbZc7xP37/Q=
X-Google-Smtp-Source: AGHT+IHJ4NsPVPWpo1tsCP90BMHOCCasqcUc26h0Ln9J4x2CIPe5BkrnkXcloN3JSZwV6UcZdHixAA==
X-Received: by 2002:adf:a345:0:b0:318:1535:34fb with SMTP id
 d5-20020adfa345000000b00318153534fbmr1215984wrb.13.1692438586253; 
 Sat, 19 Aug 2023 02:49:46 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:49:45 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 21/22] Implement shmat(2) and shmdt(2)
Date: Sat, 19 Aug 2023 11:48:05 +0200
Message-Id: <20230819094806.14965-22-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x436.google.com
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
 bsd-user/bsd-mem.h            | 72 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++
 2 files changed, 80 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 221ad76d8c..f737b94885 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -335,4 +335,76 @@ static inline abi_long do_bsd_shmctl(abi_long shmid, abi_long cmd,
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
+                shmflg); /* | SHM_REMAP XXX WHY? */
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
index 9681c65ce9..f76bc1eb38 100644
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
2.40.0



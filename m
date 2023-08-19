Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 309847818A7
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:51:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIZr-00087k-Fi; Sat, 19 Aug 2023 05:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZN-0007sN-6B
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:48:37 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZK-0004Fi-JT
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:48:32 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so15861505e9.2
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438507; x=1693043307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r2sLzJuLOtqRS9NRWS2d6CNXqMRtiVWXEqDSCgmAwRY=;
 b=b/YF5gwLY+gL4s4XdeyJBjuVyjaK5ge4ww09MBh3FjVGM/KF8UOpq9HIj1QJOMGzZ/
 fDDnCjUJ+7oS84JsH9WTzfL8Ryx/GDhoUIa9H0SpBv8wxAOrqTCVtzefVABnyQgN18Gp
 G3+cmSGY+CMoNIxWbVFdRCPLlsxIyc5NcytzCmVMTi8VAazbC/fAVZ1U8x5/4ZejF8Hu
 kQnJ34WA2PEn9fDMygZIE8VGG3FICOTB01arUUdoA8WbJCM4uwUvSKKoJBJ0XFxQt65Z
 mII88j6GKqQiqayUEalZcjPXvOO93kdQQZIoJTJpl2FVYxBEaYiSLRZNeNuiRpPktp7D
 TkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438507; x=1693043307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r2sLzJuLOtqRS9NRWS2d6CNXqMRtiVWXEqDSCgmAwRY=;
 b=ATqacVm0t137CKpP0dUDjaIEas1EgFa6vqPmjcHUvOg0hbu6axwaHBhXSriIWWsKBu
 Omx9ovoDU3hXI+BVWhx1YhvW1CJxnNC9gsTbg2p1cUhWSXPAZPOkgKTbna35oXWVDmdC
 BjEkLPiCLFG8ImxDc0vAL5ISNyRr/upC117kYfaO+vr/sL/tNwIEogg3MTIuNOtUhoTN
 n9x3OmausUGaUTqlvjz9oMQoZmPay3UxA1U0suvKPEEf+eoXxDLrbbE9PXONmZXLacLs
 ovOQ17RNtPJwtGWasM9dhJkGOlxR5auolfpgMkQtRZBmItHHtWJJOQqB18Q2Vx3shLmT
 Q92Q==
X-Gm-Message-State: AOJu0YzqG6X3YVUuhcyBZqXCEVd+oD3LDySqVBliqMiaLkX/zKW13a6/
 aaAWp+vK2d/iKMVBt9+gx0W4yqqhScI=
X-Google-Smtp-Source: AGHT+IG5iCRuVL0ICvYvohgJTkJiRCciSkzc6aiiwixtmw9YJ/T+hyr1RPP/ASoW9+Z3Gz/XcDUgOg==
X-Received: by 2002:a5d:42cd:0:b0:317:6a07:83a7 with SMTP id
 t13-20020a5d42cd000000b003176a0783a7mr1233785wrr.38.1692438506989; 
 Sat, 19 Aug 2023 02:48:26 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:48:26 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 02/22] Implement struct target_shmid_ds
Date: Sat, 19 Aug 2023 11:47:46 +0200
Message-Id: <20230819094806.14965-3-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
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
 bsd-user/syscall_defs.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 39a9bc8ed7..074df7bdd6 100644
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
2.40.0



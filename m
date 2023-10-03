Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B677B754D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:41:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovU-0004DX-Ni; Tue, 03 Oct 2023 19:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovR-0004Cn-BN
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:37 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovP-0007PC-JH
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:37 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79fa5d9f3a2so57655039f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376134; x=1696980934;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ye1cEufpabX0kbmM/Z2tKJUqMwLD3um1kdO4giPewb0=;
 b=ztUoqKUqGlkrLPx8k+O3vpI4RgaqSp3OpwQgqRPMM0kxakIdX6H1zZKtpXUiRcv0wU
 yeoc2EhyoozLQOZ4BTeX/edfUWcefAaXp1/uPJcll09Us4kIbPmVz1u88nzAjcyId6qM
 mKVw49yXyT6qxYcHrZAO9jquBadYw1I0zn/Vy7crFWTOo96vh04wS0V/n7a/VfJx6RqH
 TEzU4qlzSICU5rwlJO4Qp/J5sa+Is5SfrrjKRZGe6uD1K2q+AoHKEQQf1iyYTXatGd2j
 lI91+pvw5fgVJO8ykf/xsVKbYFgEQq9KBhaIKWn+6tTlBfQjezq28HMl3mVyNZLGvG4R
 CBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376134; x=1696980934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ye1cEufpabX0kbmM/Z2tKJUqMwLD3um1kdO4giPewb0=;
 b=iw/m1XzHVDD4R60r1e8fJnkEx3Pvgf5OABZ13siLdP2jV3TORthfwpOXYi3CmRK4hs
 ftrjR/9QP9hY6/d4jHPVmSBfx0+KQgKtBjNzX/M5vJmhtt5Y4zw3CVui+OXqaZGf190n
 MnSDPYoFCGrjaGdCbIQI2nSPOIRHi94DBY66KmGTm3ZJJORsLIyEkDeFhfTAU3hZBz+8
 oZxyHlqYHz2z2p1LQiOA8SBSBQh3NS550/MJGi05BD/DuDd1htwp6t2p9iB2LYZ200vE
 jTgJ05YVdTby44jBSmLp1Xjy9Dc9gd+swP+bzObaljBLCktB1e/iweV56X76ZT9gjYEP
 F+LA==
X-Gm-Message-State: AOJu0Yycl6fzOA5/x0XSf984xF5vy8G8sZc4dfcd8dEKPrWz7CzaCQ4B
 sM15iXDOBtnq5DRtdF7NF5j6QrHnv/+S+ZFdCI/WYw==
X-Google-Smtp-Source: AGHT+IGeB6hdWA8FRXupStEbwSYbK7kOP4iMD8WJtFXxXJ6IGSRlpS8jwXaOXi+4eERcrvvF/X5RUQ==
X-Received: by 2002:a6b:e31a:0:b0:791:acd7:233f with SMTP id
 u26-20020a6be31a000000b00791acd7233fmr724119ioc.15.1696376134255; 
 Tue, 03 Oct 2023 16:35:34 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:33 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 30/51] bsd-user: Implement struct target_shmid_ds
Date: Tue,  3 Oct 2023 17:31:54 -0600
Message-ID: <20231003233215.95557-31-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d35;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd35.google.com
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182709.4834-3-kariem.taha2.7@gmail.com>
---
 bsd-user/syscall_defs.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 0e54d7df690..ff692814333 100644
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
2.41.0



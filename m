Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF9A799649
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:36:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepfC-0000xx-BJ; Sat, 09 Sep 2023 00:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfA-0000xo-AD
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:40 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepf8-0002vE-5x
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-401c90ed2ecso28586105e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234016; x=1694838816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q9qFiAhNG5T837+Dzxw5csScnLVFwBaQ3hHHc6XeSf8=;
 b=dq/yS08X5e349MN5hsOeli1L7RTR8HPpOY5HKT/zmXP/4lVAgvU1Df73lv2IMMmuPi
 8l18dw0rRyRzYPi+BudtqKz0Xwd6z5uPf9Tge7NAZh543XpOYww2GvlKpkBaPt1aPF6g
 TqWK1F8WakMY04p1Lwnvhq8K0Rx3o9G8uoWXjAm0vHgTfCY9QSG07xYkRtyWbwvnAC5D
 yNR6tydiT6T4hp554ss2hj8zTROlITz49odm1BRKIXvMPKnW5x3tIal2STK9+zeS69Gs
 zcmWEl9NGAkovcK08SLKsgbvgfMnrt3v+jgk0HCVzz1LHX9MmxYzEZSXfqpKiCeTST/O
 LKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234016; x=1694838816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q9qFiAhNG5T837+Dzxw5csScnLVFwBaQ3hHHc6XeSf8=;
 b=VHc4yXgI4lJgxvEqApsMCaITO4G1OmV0m84nEEPMzsRibk2Ughq1Z29+MpIiDAHshH
 9JEaW5AyAEedSNXoCHFyqlpteHZ1Lz0yyW5rjP2xZGef3fMS/0mKozo1g6G506Zf5ydN
 4nIyl1iaVaG3fwu9rwjnaV1A4Zm9MNPCHZ3+ELmsjL9Yb55WlDu2IKiKyZ4UqeQWfgQq
 uMTKEraMy7WpBS3uL9pFRFRS8I6BwSvnC+q86mLSFOxWtlMKakaQm8/4lLY5bTk2+KeP
 N3jwTGmuEC5uP+s2aIiD8neq6x3spRcfJdXi7ERCtxSMTdRF/DPmZ/Tp2fXikj6QefhK
 Yn9w==
X-Gm-Message-State: AOJu0YziImyZC3PTwCGyDpIMGf/8+uNYPpez76H9kFsD2j3uuBf/pzkQ
 61GBhCO3IBg8Ddgb1R4rQua0o/NDxqU=
X-Google-Smtp-Source: AGHT+IF0/+N4gnyk0kcx+RDWoHTr+2LVVAOdJs1zEnyVqn6rX3K9Zcz3V/sE5wig4b2nu/Xt3QcnYg==
X-Received: by 2002:a1c:6a14:0:b0:401:b908:85a2 with SMTP id
 f20-20020a1c6a14000000b00401b90885a2mr3357112wmc.23.1694234016238; 
 Fri, 08 Sep 2023 21:33:36 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:33:35 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 02/23] bsd-user: Implement struct target_shmid_ds
Date: Thu,  7 Sep 2023 09:42:41 +0200
Message-ID: <20230907074302.79234-3-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
References: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
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
2.42.0



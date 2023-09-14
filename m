Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D537A0EB1
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:05:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsZR-0002rU-0y; Thu, 14 Sep 2023 16:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZP-0002r5-Jj
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:11 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZO-0001Sw-3m
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:11 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-401da71b85eso14698505e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721848; x=1695326648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sSDh8eEaxRaw92d2xRzd0SmTES9unhbDo+y9Fa/SD2A=;
 b=SpExUwSGU4Hi5pbG/FznBvQcPyLE5e9FSZY4Nil1mumLTN7Td8l67y7MocQhrHpzIQ
 LCIgAZNKd5NmJ3SdRKILOb2ctySMGAr44cpCHKbV1AKokhlQAVYCIiXQvxgyrfBkcyaT
 SqKWHTlxr3r68lkTDiHRasQ+yWddInT2/R2WZwCovSt7hAAbnos7ulBQVjwTx8esSCNf
 is6PwsVO/5uYdazgefA383PgEwwfFa5Pvn5L+5D6faQTtN1d6FZwovgQnfTIYV2cQ44J
 4ORj7E7rbEKt4UWO/vcdLSlT/8+CZ1XL0WcyBoTRTsyJ+2Cti7pIaQF9kOOGNpSL/Dvc
 igQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721848; x=1695326648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sSDh8eEaxRaw92d2xRzd0SmTES9unhbDo+y9Fa/SD2A=;
 b=wEOKiLxctfGro/qEKuqiQWKlc9Smtc2koHeHKsLgjJJ5XmRboZPVzvIYM77QbOEWzq
 29N4hdCMMony+rlFX7QJRmLo98RsVgmGrBNdJGgtr7ZHO3PhoBqbz6/j72eGdZWoVYsj
 9PbrHN4B4kXZVrtWfjIsJg0YWXwlhX9cmEzLz8WmlRO72X4qegR0dqOQ1SM3qxedeo+t
 ypnLWfrDMCVb3ABkXoV4+mTcYDA6vJPPEAS1jIVberpaK2OWuzvaqveAJFf6Xs/V8XUi
 RlXeywhE+21pCl0fsRcaALJs+xqg6MV++7ADARgRYphZBfmtWC2ZTvVdyyICbuvUjFad
 fCBg==
X-Gm-Message-State: AOJu0Yy+cDrY9V4wC/MyKpjo+enIrw7IFDg6esG8/4cbC9HSKULeJgOd
 aIZUcySwbuak0Ox1n4Mr0wvS8c+xIdM=
X-Google-Smtp-Source: AGHT+IH6fGEmMq60YjRLJjPHALjOMzvL+nwdbFaIrkHzaUg//HJKdxoUMW6YR0lLjDL6jn+eX5TE+w==
X-Received: by 2002:a05:600c:3794:b0:3fe:785:abf9 with SMTP id
 o20-20020a05600c379400b003fe0785abf9mr5616060wmr.2.1694721848139; 
 Thu, 14 Sep 2023 13:04:08 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:07 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 02/23] bsd-user: Implement struct target_shmid_ds
Date: Thu, 14 Sep 2023 23:02:21 +0300
Message-ID: <20230914200242.20148-3-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
References: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x333.google.com
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



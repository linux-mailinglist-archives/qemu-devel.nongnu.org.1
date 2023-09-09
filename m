Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D964799AA8
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:42:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3mr-0005e9-5w; Sat, 09 Sep 2023 15:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3mo-0005ZF-QU
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3mm-0003CB-Ci
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:30 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-401c90ed2ecso33517795e9.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694288306; x=1694893106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q9qFiAhNG5T837+Dzxw5csScnLVFwBaQ3hHHc6XeSf8=;
 b=mT8dNUhxg9t/BJ5jc3vFacjcQzeAQMn0Nu9T8+ssbL83secd0fRlq9vA1OwpICKjDf
 Xi2H67hEs/+PeQqTU3qgAQ9GBkW1xJ+E27wexpZxD/nMB+lknOL+5vOY4YyrDzxs4ali
 8mhoPCQoS4ikFiy8XOTcjDibvqhTqBiqWjTcTia20u6xZ6R8RgPlWjTk86iScMXzw3F/
 I9AlaUApG0kLe3wT6CFeYpFT3BLeufvT4+dILhR9aUIgCCZD6ojYQw49WPHzfpKDu7XU
 pHzZuuPznUc9X+vWUm3SL0UABVgMpZeF3rIbRJz0rU+2ZT1fZTRQpeGetGumsij0k3qX
 gAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694288306; x=1694893106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q9qFiAhNG5T837+Dzxw5csScnLVFwBaQ3hHHc6XeSf8=;
 b=Jvl+URIoUnW1SAzkkSAlTKuJ6GpRwi7zDvpo/sFQaIPlAvmrHE1vpH1ItLt3qGDFuY
 YvZewvA4DJK9Dv23Mr2pPw/OnVxwdMDWHGVqBW0notOrBzy4SodvZ0tsR1TliHjmRJUG
 9Bt4md4i4/F0Ua8ilh/glf2E1F1Ci51+rvHCdAHYH7LGNfK7/kxVOh1+3KnTcFbUFzAW
 PjjvBMBD761XmTmyNJNewIGeFjNRSIULGowEsr6ODA0L/m8Wl+nbx2CMXrOvTUyJW5Yr
 wj1W6yCPEpFYcPH+77Ez27I3lc+cr7VRZyeurT7oZRRLPR+0t6XKqJDFUw4rTBgZUXew
 bxlw==
X-Gm-Message-State: AOJu0Ywh8hkAebMUQqHo4UmY+oYG+ZAvkRH1nQgXny0nASfLS+Oj7sTx
 RSVNfHijueHwXc5exAsqY4d64wi00qY=
X-Google-Smtp-Source: AGHT+IE8qsyQG1ubJHs9f+VaLs/qhSeYj/I/UdxVUkmqzZDO14qzt1u0PVnZnOFZXsrJigfx079Wug==
X-Received: by 2002:a05:600c:2196:b0:401:b493:f7c1 with SMTP id
 e22-20020a05600c219600b00401b493f7c1mr5048710wme.35.1694288306524; 
 Sat, 09 Sep 2023 12:38:26 -0700 (PDT)
Received: from karim.my.domain ([197.39.250.27])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm8612812wma.31.2023.09.09.12.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 12:38:26 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 02/23] bsd-user: Implement struct target_shmid_ds
Date: Sat,  9 Sep 2023 22:36:43 +0300
Message-ID: <20230909193704.1827-3-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32c.google.com
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



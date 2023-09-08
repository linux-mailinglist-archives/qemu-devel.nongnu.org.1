Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A95077981EA
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:09:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUed-0008Ga-QA; Fri, 08 Sep 2023 02:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUea-00083B-2a
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:41 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUeQ-0007gl-67
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:39 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bdc19b782aso13625395ad.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153248; x=1694758048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNko/n7sZ+Pauuo1Y0kdsEEem9IIq4A/xXv8veLPZZU=;
 b=ru7QXXje3TO7Invb/34bDMr8FvB3V42QYcAl8VoKg2XcSPeyVSn9zc2Op6Ow8StnfH
 T9Eia3O/nEDiYooAAQpsBO2C7l0gm3Jru6nEW1lGu2va6rc/OqOv/rwvXSd1rlaz+KzL
 I9AufhPaGUEeeu5Bjf68Kt8kLGS1Y+e5eOmuD1cRTkmpEy7+6fj6bhaG/MUfvg3ioIWo
 CqCU6SF6dBRS/eolB+bbB/RWY1civWznPpoc+//KGqLmrryFliEoeP0UFUX8SjF+xWEY
 LAw/C3B4APBkW3oxldRJ0M1y0aDun8CxAwQaMHG+UfaptZ6FHkzBeJLGQXhRAg1XP0xq
 KvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153248; x=1694758048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BNko/n7sZ+Pauuo1Y0kdsEEem9IIq4A/xXv8veLPZZU=;
 b=A8wZUpU/p2xlCKx6QSCcDQseVuNWdmEQwOZ5fQN5L8TfjNdgZJMetFjvNHkOi0YHeo
 HV+J/NlvB/4Xy60FDLJzdSFRUUdVr3rYqt9HBZieQpHBssh7lobM/2eDg0rs7Ji2E58K
 l2G+JiMqHFJZ4CCSx9poWHDZ4LzaUeX4683cXrXh1osTMSN+joP7g8tzzVBZmyU8h3jC
 7Am2QBvkaHM/Rim3nS9ugL6SZA41R8So2Kblp1uqr5N1HRXneLMErYvqmrEiFDLYl939
 KqpPq6r32UVDWd2VlV7ZRE/95/Y2BqXiZ9hpB23My2tyDN/h8nx3x9ik9QGtuCaz70JR
 DY3Q==
X-Gm-Message-State: AOJu0YwLuoxUbhie9bnqk3r7tYr7L0iy5edCPRF0J7W2mlBWlMcBpQfB
 KPXiSvcBvTzemfNGTUjt4I6u1BaIJxpjYCGp
X-Google-Smtp-Source: AGHT+IF+ctQ8LOrwMOuhn33LtjrZEYHZwQzW6W/JQ0wnXRQE/7TDhMnxRmHK+UmbGp7mbxPc2/MYYg==
X-Received: by 2002:a17:902:da92:b0:1b6:6b90:7c2f with SMTP id
 j18-20020a170902da9200b001b66b907c2fmr1685214plx.55.1694153248577; 
 Thu, 07 Sep 2023 23:07:28 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:07:27 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Robbin Ehn <rehn@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 40/65] linux-user/riscv: Add new extensions to hwprobe
Date: Fri,  8 Sep 2023 16:04:06 +1000
Message-ID: <20230908060431.1903919-41-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Robbin Ehn <rehn@rivosinc.com>

This patch adds the new extensions in
linux 6.5 to the hwprobe syscall.

And fixes RVC check to OR with correct value.
The previous variable contains 0 therefore it
did work.

Signed-off-by: Robbin Ehn <rehn@rivosinc.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <bc82203b72d7efb30f1b4a8f9eb3d94699799dc8.camel@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/syscall.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dac0641bab..3521a2d70b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8793,6 +8793,10 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
 #define RISCV_HWPROBE_KEY_IMA_EXT_0     4
 #define     RISCV_HWPROBE_IMA_FD       (1 << 0)
 #define     RISCV_HWPROBE_IMA_C        (1 << 1)
+#define     RISCV_HWPROBE_IMA_V        (1 << 2)
+#define     RISCV_HWPROBE_EXT_ZBA      (1 << 3)
+#define     RISCV_HWPROBE_EXT_ZBB      (1 << 4)
+#define     RISCV_HWPROBE_EXT_ZBS      (1 << 5)
 
 #define RISCV_HWPROBE_KEY_CPUPERF_0     5
 #define     RISCV_HWPROBE_MISALIGNED_UNKNOWN     (0 << 0)
@@ -8840,7 +8844,15 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
                     riscv_has_ext(env, RVD) ?
                     RISCV_HWPROBE_IMA_FD : 0;
             value |= riscv_has_ext(env, RVC) ?
-                     RISCV_HWPROBE_IMA_C : pair->value;
+                     RISCV_HWPROBE_IMA_C : 0;
+            value |= riscv_has_ext(env, RVV) ?
+                     RISCV_HWPROBE_IMA_V : 0;
+            value |= cfg->ext_zba ?
+                     RISCV_HWPROBE_EXT_ZBA : 0;
+            value |= cfg->ext_zbb ?
+                     RISCV_HWPROBE_EXT_ZBB : 0;
+            value |= cfg->ext_zbs ?
+                     RISCV_HWPROBE_EXT_ZBS : 0;
             __put_user(value, &pair->value);
             break;
         case RISCV_HWPROBE_KEY_CPUPERF_0:
-- 
2.41.0



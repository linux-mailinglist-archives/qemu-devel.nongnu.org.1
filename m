Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 231AB79F851
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:45:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcLa-0000cy-0L; Wed, 13 Sep 2023 22:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLX-0000cB-9c
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:47 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLS-0000f6-0b
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:47 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68fbd31d9deso411782b3a.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 19:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694659480; x=1695264280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPtop6+9023jYfdKcxCR4ut/c6RsJZSSNZqyh2/3hnQ=;
 b=FIHg1Nj3EJc2FjpgP16vd/083VFoORAmmvcbO2L2/cHkxxMon+xRHjDwBfhvp1lqLb
 K4KQcdPVE3fHjsQ7nbq2LH/WN8XWxqUw5qpskRdSPNEN5a9dGOEHdnprTV/Jy7CtM2nQ
 4RQEQoH4RGLD/LSIeDC7Tt1BhqjpkERi8TthooWhxDYFPEIzzEDfks+R5QnQvkwR/7YN
 KONUMGxoS+ycap+RPIqXnOCGSTfrrbvADSvgBrUW9FBPvcsirHzu0zC/P2mhMB6zApXN
 WA3A324VM/8ODDtKV7J0pkPAe3QbQ7U0TT1Ei8gIP1mLzrgAYbWawgUYpd15Pxcv8Uak
 BNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694659480; x=1695264280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jPtop6+9023jYfdKcxCR4ut/c6RsJZSSNZqyh2/3hnQ=;
 b=FnJ1BusuukO63MoaM22t+JSHUAjrmYYLtJWRf31SEctZVLgGIWhkjFaWalRMsGMhWx
 CDHWma6kIolEgXXm/MGC80W6U7KUVtivl7RavWC5LMkqcLO0+pHFZICKf+Pilm06V5CH
 FJX7Z+Sa4ivsJKlZRz8qD/UO1BXiqx+Q9lRHbpJZOP8Fkuw+47ledKSTfGKlhOFxJDwD
 oRzZSrxVHnpT/mlv5qe54lwFnwj7FxTDYkkGLx2oncPOrNGpEJbpEI513gzXxxzlILCt
 Jjt2AvTZKHf9tYhAo7udsazX7q1aRabeI4mY873PIImc6I7nRv14SL0IIzssurS/M+/t
 W6vg==
X-Gm-Message-State: AOJu0YwuOvJvbxNgdlE2S1pDC7zAgGUf873kTtcGYjsK4CukmXu+2V27
 gCrs2pjiKgwjgjh6zqrLzvwaLtgZxFhmSxIWMac=
X-Google-Smtp-Source: AGHT+IFIl/cEzIojVEKa+WkSsg8DwX2R71nsHekvq+3xS2tACe+iT0c6sUCJaSh250NqZ41kDzuT2A==
X-Received: by 2002:a05:6a20:548e:b0:125:517c:4f18 with SMTP id
 i14-20020a056a20548e00b00125517c4f18mr5092164pzk.8.1694659480732; 
 Wed, 13 Sep 2023 19:44:40 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x24-20020a170902b41800b001bbdf32f011sm304336plr.269.2023.09.13.19.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 19:44:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng,
	ale@rev.ng,
	philmd@linaro.org
Subject: [PATCH v2 04/24] target/*: Use __alignof not __alignof__
Date: Wed, 13 Sep 2023 19:44:15 -0700
Message-Id: <20230914024435.1381329-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914024435.1381329-1-richard.henderson@linaro.org>
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

No functional change, just using a common spelling.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c      | 2 +-
 target/ppc/cpu_init.c | 2 +-
 target/s390x/cpu.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b9e09a702d..906eb981b0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2440,7 +2440,7 @@ static const TypeInfo arm_cpu_type_info = {
     .name = TYPE_ARM_CPU,
     .parent = TYPE_CPU,
     .instance_size = sizeof(ARMCPU),
-    .instance_align = __alignof__(ARMCPU),
+    .instance_align = __alignof(ARMCPU),
     .instance_init = arm_cpu_initfn,
     .instance_finalize = arm_cpu_finalizefn,
     .abstract = true,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7ab5ee92d9..7830640f01 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7413,7 +7413,7 @@ static const TypeInfo ppc_cpu_type_info = {
     .name = TYPE_POWERPC_CPU,
     .parent = TYPE_CPU,
     .instance_size = sizeof(PowerPCCPU),
-    .instance_align = __alignof__(PowerPCCPU),
+    .instance_align = __alignof(PowerPCCPU),
     .instance_init = ppc_cpu_instance_init,
     .instance_finalize = ppc_cpu_instance_finalize,
     .abstract = true,
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index df167493c3..d9625bc266 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -363,7 +363,7 @@ static const TypeInfo s390_cpu_type_info = {
     .name = TYPE_S390_CPU,
     .parent = TYPE_CPU,
     .instance_size = sizeof(S390CPU),
-    .instance_align = __alignof__(S390CPU),
+    .instance_align = __alignof(S390CPU),
     .instance_init = s390_cpu_initfn,
 
 #ifndef CONFIG_USER_ONLY
-- 
2.34.1



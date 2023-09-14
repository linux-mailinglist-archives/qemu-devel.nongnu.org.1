Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BB679F86B
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:47:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcLV-0000b1-T9; Wed, 13 Sep 2023 22:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLU-0000aW-B9
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:44 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLS-0000fS-O2
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:44 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c1f7f7151fso3802495ad.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 19:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694659481; x=1695264281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+rxj4vSUoyP9SiOPZRqFJR21L7r1Zg14savQu0m1YxI=;
 b=avcp1IUAlDrFGa/3b4q5+emtCEyMxNU7q3pEZ6Iy3G3XTfHrqh21qJN62IL55mhDFL
 949NePfdZblxnkyfimEubEgRHhD3BXAa6ZhmuU/A+oNTIvfieLqMzqSGnPIpCZbkjwET
 4HeHaxRJVUwOuNY8o5oJTk2DG7+0E+uc6Z7evStkinAK42CXt4AWZruIssTSzlfn/Kg8
 g4ZdUofCgoOAKUmY6hvqG5rlCW83A6oEr/SOeMhlLaq7W/5mTw6v1mnXT3FEGSz32Ia6
 QiyF3l5/NB1C2OB0+0P7q+Q6LR+S05JGteNuVyKQD2aZZsIFzXqXGl9wEJFJ2KCl5Txo
 kQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694659481; x=1695264281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+rxj4vSUoyP9SiOPZRqFJR21L7r1Zg14savQu0m1YxI=;
 b=Nw+O3sMZ71Ot7mkLPqmrAe6e+39f8pG6C3nNjq6qSxk0INwWAF69HyHWtfPGkZZzT1
 RmZ9emV11CVzFJ0ANboWE73BSfldBReeQC+tN5kbQMHLSFfHu27FeAJYMAAncsj+x9+s
 tMG18QPJS47vJDah07HGF+IHtJSNRsuN9gRRfrmVq3LCx8xnoMvpwCKl01b8fCNeyt2e
 mYPO7wRNYUobtJ03sAbtG8++yNVoQD/zSdYyfnl5juFF5td6TKpLdPye3Ylmce38A39P
 Z4o9r8PrMVA1ABvV5QG4CZQrWNeuZ1v9w7fGG7ZA6nbhLQs7bnT9W3D0Byb4ZmRjZAfF
 07vQ==
X-Gm-Message-State: AOJu0Yx4daMNIltQBqGZZox4+QHT+cjJ5KjNJENQd82dva7h+ZqpHGy5
 6ximmqT16XjDOnW0pKAzzkHZOqI3yUCkLbG6qQw=
X-Google-Smtp-Source: AGHT+IGtTqwJPY7h0vWcztH3sBlHjvUwJoaMjgZKC37HQmVojpVTSs3CK+w5JkcVimVu4KmkvC80nw==
X-Received: by 2002:a17:902:e80f:b0:1c3:a396:259f with SMTP id
 u15-20020a170902e80f00b001c3a396259fmr5039457plg.26.1694659481407; 
 Wed, 13 Sep 2023 19:44:41 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x24-20020a170902b41800b001bbdf32f011sm304336plr.269.2023.09.13.19.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 19:44:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng,
	ale@rev.ng,
	philmd@linaro.org
Subject: [PATCH v2 05/24] target/arm: Remove size and alignment for cpu
 subclasses
Date: Wed, 13 Sep 2023 19:44:16 -0700
Message-Id: <20230914024435.1381329-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914024435.1381329-1-richard.henderson@linaro.org>
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Inherit the size and alignment from TYPE_ARM_CPU.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c   | 3 ---
 target/arm/cpu64.c | 4 ----
 2 files changed, 7 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 906eb981b0..d0f279b87f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2423,10 +2423,7 @@ void arm_cpu_register(const ARMCPUInfo *info)
 {
     TypeInfo type_info = {
         .parent = TYPE_ARM_CPU,
-        .instance_size = sizeof(ARMCPU),
-        .instance_align = __alignof__(ARMCPU),
         .instance_init = arm_cpu_instance_init,
-        .class_size = sizeof(ARMCPUClass),
         .class_init = info->class_init ?: cpu_register_class_init,
         .class_data = (void *)info,
     };
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index f3d87e001f..811f3b38c2 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -822,9 +822,7 @@ void aarch64_cpu_register(const ARMCPUInfo *info)
 {
     TypeInfo type_info = {
         .parent = TYPE_AARCH64_CPU,
-        .instance_size = sizeof(ARMCPU),
         .instance_init = aarch64_cpu_instance_init,
-        .class_size = sizeof(ARMCPUClass),
         .class_init = info->class_init ?: cpu_register_class_init,
         .class_data = (void *)info,
     };
@@ -837,10 +835,8 @@ void aarch64_cpu_register(const ARMCPUInfo *info)
 static const TypeInfo aarch64_cpu_type_info = {
     .name = TYPE_AARCH64_CPU,
     .parent = TYPE_ARM_CPU,
-    .instance_size = sizeof(ARMCPU),
     .instance_finalize = aarch64_cpu_finalizefn,
     .abstract = true,
-    .class_size = sizeof(AArch64CPUClass),
     .class_init = aarch64_cpu_class_init,
 };
 
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B55781195
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:21:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX39l-0005qZ-DF; Fri, 18 Aug 2023 13:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX39i-0005LL-Cg
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:21:02 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX39g-0001sv-3i
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:21:02 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52164adea19so1484827a12.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692379258; x=1692984058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/is4OP2bMjv02N4bH1oF/ePbIH9KS0BSaVmzaTcaDA=;
 b=dA5WUZ0S2vTnGslEVMRBUVx8KNBdTrZlqN6x0N26Np0kJQgNcU4UVvnJY7vIzAuX/p
 qCxXh5HjvHI6MeFX+tdEpPNXZInZIt/h7CFq627e2CnrKPZH4dDQLAbrwPu8GG2IKNcO
 DxSac0kvsiRip9kVMNMURH5MKQgNpfw8BrnsTAlux0A6mmg8vo8bG3yBPD40YxYvfdqm
 LTjsuId/Z1rxRxrMDHEOFYgE45JfWvF6KoO8z/CY6ZsNmZrjyhqUqBb7gOD60rDXXNy/
 KNHPLjyjtQ8gl8UUIqN/D1Lyr+ZPot7sttOUauq+jVS+L9HQwRDhpR1n4QaSz7Hjm0ue
 x4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692379258; x=1692984058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/is4OP2bMjv02N4bH1oF/ePbIH9KS0BSaVmzaTcaDA=;
 b=dQ+EHAWDH8Mwtz2JrsYl5ypI5rn0kQqoWk11V4OgTI97pfO4SMaDtjhx+hjGsX6PVO
 ZI2Jx8BefJ5PlPaqYg2gMt9gC6YpuaWB6OhXJkgqGXqDrDCbfX09RMfXVXGaIqdNbN9f
 uHovsik6ot5kw7H84XNrJGiOMNp0SMMXlUbu4UBYQzxqLKUbVHuxiRg1DwAVIXnl04Jj
 5FDyzEV6LMPXZE2wzmN5U/AfbaB39CVJEbPMuJqbBi0ZtROE2HxhCmvgfKHaHvYFltL0
 1LfvD5OMC11tFWXn21rRsH6z7SqEzW6UCQiJw8iB3X/soNYyWPv9fNb2VXgVub5nV0X9
 WR+w==
X-Gm-Message-State: AOJu0YyzRhIYcUL60ANlHz3gGN9BNPUfDaXfilE6qyglYdKW/ZEtBcu1
 BJpCbiO42wUcdD8zeQhkBw5DY+iPkny/mDmLZoQ=
X-Google-Smtp-Source: AGHT+IGMuYO09ODliCu7WuNcFjBMf4wysAZOg7iFopcb/HBQH4MvsvHzB3WfKciAptgxvStF3RL5XA==
X-Received: by 2002:a05:6402:104f:b0:525:65f7:60 with SMTP id
 e15-20020a056402104f00b0052565f70060mr2883752edu.29.1692379258514; 
 Fri, 18 Aug 2023 10:20:58 -0700 (PDT)
Received: from m1x-phil.lan (cnf78-h01-176-184-27-79.dsl.sta.abo.bbox.fr.
 [176.184.27.79]) by smtp.gmail.com with ESMTPSA id
 w9-20020a056402070900b00525683f9b2fsm1289223edx.5.2023.08.18.10.20.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Aug 2023 10:20:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jiajie Chen <c@jia.je>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 6/8] target/loongarch: Add function to check current arch
Date: Fri, 18 Aug 2023 19:20:14 +0200
Message-ID: <20230818172016.24504-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818172016.24504-1-philmd@linaro.org>
References: <20230818172016.24504-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

From: Jiajie Chen <c@jia.je>

Add is_la64 function to check if the current cpucfg[1].arch equals to
2(LA64).

Signed-off-by: Jiajie Chen <c@jia.je>
Co-authored-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20230817093121.1053890-2-gaosong@loongson.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index c50b3a5ef3..3235ad081f 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -132,6 +132,11 @@ FIELD(CPUCFG1, HP, 24, 1)
 FIELD(CPUCFG1, IOCSR_BRD, 25, 1)
 FIELD(CPUCFG1, MSG_INT, 26, 1)
 
+/* cpucfg[1].arch */
+#define CPUCFG1_ARCH_LA32R       0
+#define CPUCFG1_ARCH_LA32        1
+#define CPUCFG1_ARCH_LA64        2
+
 /* cpucfg[2] bits */
 FIELD(CPUCFG2, FP, 0, 1)
 FIELD(CPUCFG2, FP_SP, 1, 1)
@@ -421,6 +426,11 @@ static inline int cpu_mmu_index(CPULoongArchState *env, bool ifetch)
 #endif
 }
 
+static inline bool is_la64(CPULoongArchState *env)
+{
+    return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64;
+}
+
 /*
  * LoongArch CPUs hardware flags.
  */
-- 
2.41.0



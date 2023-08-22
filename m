Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CB9783A7F
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:11:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLXH-0002ED-0b; Tue, 22 Aug 2023 03:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLXE-0002E1-CY
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:10:40 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLXC-0002H0-20
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:10:40 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3159d5e409dso3251458f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688236; x=1693293036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3rrV84vf0KvDLl6SX1WoOdtWUazfK9wKjoL6Oup5qkU=;
 b=o0DJEZ3ZbcILe/mUyXV8pLMc89CYUZgNN0pVKfss1GbALAGuDWym5TId9QjU1/6apg
 0Wt7e0xoBmX1zg3eWbTgDb5lErKwUuOq2ebySYPcrf8/Sg3+iKIdD5i8jSartWLtam0I
 KVYM0UyhXG5P0hiUJU+zcx1cXinMK8v9aLEjv7ALMk1bR/a6DTzYwpcEH1yvr35byaSV
 HyUdGHcZlvY5Ler158XU7XMci1m7OxMTQl87uUGdtRtg9n/+7Q8KHw6NC35AZ8is+xhv
 3FuXvtiogxx3K4fTXYWudbufew0EKKhXyAJiVR7atUBS+ZWSEDNTb6dh1JviIhTnqCwu
 q3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688236; x=1693293036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3rrV84vf0KvDLl6SX1WoOdtWUazfK9wKjoL6Oup5qkU=;
 b=h0jLOqqpN5z04MBYaW8IN5RAA5KPiKqHi7h1WjD5TEAr0g/vmusrwj0R3TulVTNQw5
 +1faT/WVDc8RCsc8UjYnj9Pr44dM6R/l1bhi6+heecTezY+8I3rTITFRphy+4/Ki+Gog
 DjBdI5LKkb26l7RqVtP2uJ1IB7RsNgKBn1xin3SRh+Sfa39gsS2XljehhGiLfkDmvqRW
 aYrNiF88vPbWghddKe8WoE6uIABVmVDOYFzaLKDrnSflPlczaGGXHGQSmOJQCvX65lFL
 O1fNwKA/UAe29RCgRb5F5pz5O4Ad4jwE4oOxlTuflodP3KkqEfI/g0727xxQFczMuddu
 uE0Q==
X-Gm-Message-State: AOJu0YxQJfa1KM3+DAwzm8IAqpxQZ+Jj4QxxNcy1YK4cxN/t6ofsHH5F
 eiLHAIc1jJDXNVyY1LF87uLLt0RvuxQwq6a0tfLAfQ==
X-Google-Smtp-Source: AGHT+IGC63g8Iuh2EyKSzG9m4TEBb+gZXn5b3mibAuzt6qjlSPR/8JESgd2sjVJEinH6S1n7US2aCQ==
X-Received: by 2002:a5d:50cf:0:b0:316:fc03:3c66 with SMTP id
 f15-20020a5d50cf000000b00316fc033c66mr9299388wrt.3.1692688236252; 
 Tue, 22 Aug 2023 00:10:36 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a5d4e4b000000b00317b063590fsm14876710wrt.55.2023.08.22.00.10.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:10:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 03/19] target/loongarch: Support LoongArch32 VPPN
Date: Tue, 22 Aug 2023 09:09:56 +0200
Message-ID: <20230822071013.34884-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822071013.34884-1-philmd@linaro.org>
References: <20230822071013.34884-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

VPPN of TLBEHI/TLBREHI is limited to 19 bits in LA32.

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20230822032724.1353391-4-gaosong@loongson.cn>
---
 target/loongarch/cpu-csr.h    |  6 ++++--
 target/loongarch/tlb_helper.c | 23 ++++++++++++++++++-----
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index b93f99a9ef..c59d7a9fcb 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -57,7 +57,8 @@ FIELD(CSR_TLBIDX, PS, 24, 6)
 FIELD(CSR_TLBIDX, NE, 31, 1)
 
 #define LOONGARCH_CSR_TLBEHI         0x11 /* TLB EntryHi */
-FIELD(CSR_TLBEHI, VPPN, 13, 35)
+FIELD(CSR_TLBEHI_32, VPPN, 13, 19)
+FIELD(CSR_TLBEHI_64, VPPN, 13, 35)
 
 #define LOONGARCH_CSR_TLBELO0        0x12 /* TLB EntryLo0 */
 #define LOONGARCH_CSR_TLBELO1        0x13 /* TLB EntryLo1 */
@@ -164,7 +165,8 @@ FIELD(CSR_TLBRERA, PC, 2, 62)
 #define LOONGARCH_CSR_TLBRELO1       0x8d /* TLB refill entrylo1 */
 #define LOONGARCH_CSR_TLBREHI        0x8e /* TLB refill entryhi */
 FIELD(CSR_TLBREHI, PS, 0, 6)
-FIELD(CSR_TLBREHI, VPPN, 13, 35)
+FIELD(CSR_TLBREHI_32, VPPN, 13, 19)
+FIELD(CSR_TLBREHI_64, VPPN, 13, 35)
 #define LOONGARCH_CSR_TLBRPRMD       0x8f /* TLB refill mode info */
 FIELD(CSR_TLBRPRMD, PPLV, 0, 2)
 FIELD(CSR_TLBRPRMD, PIE, 2, 1)
diff --git a/target/loongarch/tlb_helper.c b/target/loongarch/tlb_helper.c
index 1f8e7911c7..c8b8b0497f 100644
--- a/target/loongarch/tlb_helper.c
+++ b/target/loongarch/tlb_helper.c
@@ -300,8 +300,13 @@ static void raise_mmu_exception(CPULoongArchState *env, target_ulong address,
 
     if (tlb_error == TLBRET_NOMATCH) {
         env->CSR_TLBRBADV = address;
-        env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI, VPPN,
-                                      extract64(address, 13, 35));
+        if (is_la64(env)) {
+            env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI_64,
+                                        VPPN, extract64(address, 13, 35));
+        } else {
+            env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI_32,
+                                        VPPN, extract64(address, 13, 19));
+        }
     } else {
         if (!FIELD_EX64(env->CSR_DBG, CSR_DBG, DST)) {
             env->CSR_BADV = address;
@@ -366,12 +371,20 @@ static void fill_tlb_entry(CPULoongArchState *env, int index)
 
     if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
         csr_ps = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
-        csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, VPPN);
+        if (is_la64(env)) {
+            csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_64, VPPN);
+        } else {
+            csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_32, VPPN);
+        }
         lo0 = env->CSR_TLBRELO0;
         lo1 = env->CSR_TLBRELO1;
     } else {
         csr_ps = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
-        csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI, VPPN);
+        if (is_la64(env)) {
+            csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_64, VPPN);
+        } else {
+            csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_32, VPPN);
+        }
         lo0 = env->CSR_TLBELO0;
         lo1 = env->CSR_TLBELO1;
     }
@@ -491,7 +504,7 @@ void helper_tlbfill(CPULoongArchState *env)
 
     if (pagesize == stlb_ps) {
         /* Only write into STLB bits [47:13] */
-        address = entryhi & ~MAKE_64BIT_MASK(0, R_CSR_TLBEHI_VPPN_SHIFT);
+        address = entryhi & ~MAKE_64BIT_MASK(0, R_CSR_TLBEHI_64_VPPN_SHIFT);
 
         /* Choose one set ramdomly */
         set = get_random_tlb(0, 7);
-- 
2.41.0



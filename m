Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 326F3783A71
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:11:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLXC-0002D5-RU; Tue, 22 Aug 2023 03:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLX8-0002CB-IB
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:10:34 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLX6-0002Cn-3m
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:10:34 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so3651833f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688230; x=1693293030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxHqKmOyuuNOftyTGwcwCJthKGUr1Tn3UywBr6PkJwE=;
 b=krITlh8T942g2eMS96hHB/szGA6NVhLUhSRHGN2v0bOeNGKsagALclrPPAoRo1gwto
 1nrhaSrIOSieU0B7nZWzmIQsCwxadDVNg6/6lnWuU4SHYqZU3vyJTOBaDo/O0P0cdpiU
 DnI1EGrFRnwgVn0w4ZfpOfm8D4mvQKMDItL7/TrByBRX8A76YSPG4upsffUtBj4JL/SX
 DbN4cruT7NJuZoJraUF1r+rUP9JAGJwR8Gb2c9RG/kzDJkFUl6gF2p92LipsH9PDYfS9
 N332W2xIIVvl3rmwq9xxCyZZe6n25ukhDS6QhA2Z4hpSs5JgxLXTudee74HgqPeANcqg
 e8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688230; x=1693293030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zxHqKmOyuuNOftyTGwcwCJthKGUr1Tn3UywBr6PkJwE=;
 b=ex3lI8iYFcf5PMAQxxRjvMcyzvn4ql/W/JT1jsyTmHoyzFhaA2i3Y+Tjhyvg5SDJFi
 qiW/4hsDVif7yJm0YMQQj2nUuulslxmyVCZDR8yw2ZVPs10Dy+jinJUgVtx4xEcb22JE
 aJM1zZPVIDdCiN7dnPDG4w1jQxeSgPi3euJDV9gXZX7Yl/1qBu6qbJ1OAE7y/R0RSNv3
 LzStx34Qh3zRNMw8Pc+tXQG9yucEAPCniwPCpxozSi6whP8inChb91j3VB0WSFnH3DwB
 CA6xIMG38oif5FIK9MH8YFG1CsFvxP6RekxZQQhg6bqO7qatuVXJwO/hdEbfYvqMQkeb
 lIqA==
X-Gm-Message-State: AOJu0YzIVwYRajLnbFMsq88iv6s9gkFz0hnytObuW47W9l2tJdIABA1m
 o+yoVQ9Kt2Mc7e/rDW0cjRuIFIudrctTGVg3EufbiA==
X-Google-Smtp-Source: AGHT+IGq9ikwmVVMuHgJjcNT6lmWXG+OPSan5BLuEd/udsApT6N+WtJWj6yQyR3ppT3FKu6Xi7XzYA==
X-Received: by 2002:a5d:5910:0:b0:319:7d83:7ace with SMTP id
 v16-20020a5d5910000000b003197d837acemr6615919wrd.35.1692688229921; 
 Tue, 22 Aug 2023 00:10:29 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 w14-20020adfec4e000000b003180822cf8fsm15095146wrn.1.2023.08.22.00.10.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:10:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 02/19] target/loongarch: Support LoongArch32 DMW
Date: Tue, 22 Aug 2023 09:09:55 +0200
Message-ID: <20230822071013.34884-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822071013.34884-1-philmd@linaro.org>
References: <20230822071013.34884-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

LA32 uses a different encoding for CSR.DMW and a new direct mapping
mechanism.

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20230822032724.1353391-3-gaosong@loongson.cn>
---
 target/loongarch/cpu-csr.h    |  7 +++----
 target/loongarch/tlb_helper.c | 26 +++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 48ed2e0632..b93f99a9ef 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -188,10 +188,9 @@ FIELD(CSR_DMW, PLV1, 1, 1)
 FIELD(CSR_DMW, PLV2, 2, 1)
 FIELD(CSR_DMW, PLV3, 3, 1)
 FIELD(CSR_DMW, MAT, 4, 2)
-FIELD(CSR_DMW, VSEG, 60, 4)
-
-#define dmw_va2pa(va) \
-    (va & MAKE_64BIT_MASK(0, TARGET_VIRT_ADDR_SPACE_BITS))
+FIELD(CSR_DMW_32, PSEG, 25, 3)
+FIELD(CSR_DMW_32, VSEG, 29, 3)
+FIELD(CSR_DMW_64, VSEG, 60, 4)
 
 /* Debug CSRs */
 #define LOONGARCH_CSR_DBG            0x500 /* debug config */
diff --git a/target/loongarch/tlb_helper.c b/target/loongarch/tlb_helper.c
index cef10e2257..1f8e7911c7 100644
--- a/target/loongarch/tlb_helper.c
+++ b/target/loongarch/tlb_helper.c
@@ -173,6 +173,18 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
     return TLBRET_NOMATCH;
 }
 
+static hwaddr dmw_va2pa(CPULoongArchState *env, target_ulong va,
+                        target_ulong dmw)
+{
+    if (is_la64(env)) {
+        return va & TARGET_VIRT_MASK;
+    } else {
+        uint32_t pseg = FIELD_EX32(dmw, CSR_DMW_32, PSEG);
+        return (va & MAKE_64BIT_MASK(0, R_CSR_DMW_32_VSEG_SHIFT)) | \
+            (pseg << R_CSR_DMW_32_VSEG_SHIFT);
+    }
+}
+
 static int get_physical_address(CPULoongArchState *env, hwaddr *physical,
                                 int *prot, target_ulong address,
                                 MMUAccessType access_type, int mmu_idx)
@@ -192,12 +204,20 @@ static int get_physical_address(CPULoongArchState *env, hwaddr *physical,
     }
 
     plv = kernel_mode | (user_mode << R_CSR_DMW_PLV3_SHIFT);
-    base_v = address >> R_CSR_DMW_VSEG_SHIFT;
+    if (is_la64(env)) {
+        base_v = address >> R_CSR_DMW_64_VSEG_SHIFT;
+    } else {
+        base_v = address >> R_CSR_DMW_32_VSEG_SHIFT;
+    }
     /* Check direct map window */
     for (int i = 0; i < 4; i++) {
-        base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW, VSEG);
+        if (is_la64(env)) {
+            base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW_64, VSEG);
+        } else {
+            base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW_32, VSEG);
+        }
         if ((plv & env->CSR_DMW[i]) && (base_c == base_v)) {
-            *physical = dmw_va2pa(address);
+            *physical = dmw_va2pa(env, address, env->CSR_DMW[i]);
             *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
             return TLBRET_MATCH;
         }
-- 
2.41.0



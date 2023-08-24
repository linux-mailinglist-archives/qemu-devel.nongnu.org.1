Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10767786C05
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:33:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6eT-0006PE-K7; Thu, 24 Aug 2023 05:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eA-00047t-Nv
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:59 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e3-00051O-H6
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:57 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31c63cd4ec2so2162097f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869330; x=1693474130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ul2FDB9YGpIRuxaGUK+qoMd3NhbINUDOFe0qhJJmN4E=;
 b=wdzK5mGkN2KE+uYwBS8Dutiza/oqKv0IFzKIpDi7f1u0O0/8JH5L6xJH84iymqRzuK
 3VvnoQQmReTrlN3z+cXIqc4h+8h9XRZTFZ8sKIA+nfaa/w67BDpbHkE+vUz2Z/6FFFcR
 ehDpDmixytppA5/nK1e83uAjibBu3ey7wBW9hN7WI8b3SXy7zWRybwmJqCppSWB7adDw
 INqRhRsFZfKDYViM88y4+gU9wyhEih1TNivNhIltdriKw2yJPgJNA5EEwJ1OjVEF7mme
 Qe07c+CmdMzUY9dn3N3R1KzpZCOnf2+J3ud4d97XhmJGCC57R5eGsFc5kElSFytRBGQL
 edEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869330; x=1693474130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ul2FDB9YGpIRuxaGUK+qoMd3NhbINUDOFe0qhJJmN4E=;
 b=hSiIvBTfC3zBD8aTqXZf6QTx/nNQgG90bYaw9sh2D/c738RAIdtakLqVH5Ho8K3W4r
 TIbkq5iESWMEin0PEM6YtX/OZlcYoTe7Xz8wSKm7TG7j22ym/z1YbKvNf8Eqd2OEJAZq
 6YUdCmIhk8VGKiML6FW+ZI7wPFprJK7mjQdqWHj/VCLmqmxhM6ycAvWrVmZaKuqLsI5l
 ek927+BClVmv2EJUfvQXX6ZiXctOWP/xLBSecy0xC2QrNVTOq7mx8t4gdspAiJQ8D0NV
 NGd3QAtuy4QPpknqfZ3JlSTQI5MQfK6FlDZGfM9efOdSnzeHXaQPQnZoiFKmSi5eLwFr
 Oj9w==
X-Gm-Message-State: AOJu0YyJ8Rq/pu0lQE/Txz6oSy9GJCuMLfy5om2Sm3WVr5JuA3l2Ou4y
 VLhNcwR/o00LkP4zQ+9qTDX7ppY691aLsz185Hk=
X-Google-Smtp-Source: AGHT+IGv0t3zSL3vpKW4OzeeolTdZOjIJ52DmFqcmhwmWE7UHg0PWTcHdMixmni+umQmdgyHSdAemw==
X-Received: by 2002:a5d:4246:0:b0:31a:b3aa:d19b with SMTP id
 s6-20020a5d4246000000b0031ab3aad19bmr10952692wrr.23.1692869330048; 
 Thu, 24 Aug 2023 02:28:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/35] target/arm/ptw: Check for block descriptors at invalid
 levels
Date: Thu, 24 Aug 2023 10:28:26 +0100
Message-Id: <20230824092836.2239644-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

The architecture doesn't permit block descriptors at any arbitrary
level of the page table walk; it depends on the granule size which
levels are permitted.  We implemented only a partial version of this
check which assumes that block descriptors are valid at all levels
except level 3, which meant that we wouldn't deliver the Translation
fault for all cases of this sort of guest page table error.

Implement the logic corresponding to the pseudocode
AArch64.DecodeDescriptorType() and AArch64.BlockDescSupported().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230807141514.19075-14-peter.maydell@linaro.org
---
 target/arm/ptw.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 7f217a31895..fbb0f8a0bf2 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1551,6 +1551,25 @@ static int check_s2_mmu_setup(ARMCPU *cpu, bool is_aa64, uint64_t tcr,
     return INT_MIN;
 }
 
+static bool lpae_block_desc_valid(ARMCPU *cpu, bool ds,
+                                  ARMGranuleSize gran, int level)
+{
+    /*
+     * See pseudocode AArch46.BlockDescSupported(): block descriptors
+     * are not valid at all levels, depending on the page size.
+     */
+    switch (gran) {
+    case Gran4K:
+        return (level == 0 && ds) || level == 1 || level == 2;
+    case Gran16K:
+        return (level == 1 && ds) || level == 2;
+    case Gran64K:
+        return (level == 1 && arm_pamax(cpu) == 52) || level == 2;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /**
  * get_phys_addr_lpae: perform one stage of page table walk, LPAE format
  *
@@ -1786,8 +1805,10 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     new_descriptor = descriptor;
 
  restart_atomic_update:
-    if (!(descriptor & 1) || (!(descriptor & 2) && (level == 3))) {
-        /* Invalid, or the Reserved level 3 encoding */
+    if (!(descriptor & 1) ||
+        (!(descriptor & 2) &&
+         !lpae_block_desc_valid(cpu, param.ds, param.gran, level))) {
+        /* Invalid, or a block descriptor at an invalid level */
         goto do_translation_fault;
     }
 
-- 
2.34.1



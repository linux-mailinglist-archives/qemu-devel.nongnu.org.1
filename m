Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCF6729769
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:49:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Zfm-0004HF-8e; Fri, 09 Jun 2023 06:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Zfk-000486-7Y
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:48:48 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Zfb-0001Wx-UE
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:48:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-30aea656e36so1131670f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686307718; x=1688899718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ucYYZHH6siGn2M12i6Z7RgILGAl0PK7nPTZjfgbgtYo=;
 b=cSWxQqx81LopFLR7kY+SDiJyMTfHLEMDcx/XXoTS8ZCM66GHvumalZxI5AP+VibPM5
 pQ5HFGR5sukmuIkEl53syX/bHwbx73rYS3lDKDrLEVkJ7JnctGOAaxCW49QFPjgw7+Hv
 uCVI4zhxyuR5bEhLPqT6Dpj9ahKe8XzRVOyXCUyLFyqeSw86tPQXn7EzjnYsJO1kjQAa
 Kk2eHBXB946eQzZhQkM3Nx1NPi0h4ViJyENzlYIu/dAQ4WcYsfZ9RFDeZsctBlnBGR6+
 ZVd+/IVioibNUrFnPwCy3Vbh2OzArayM+st+MsFoxTF9+N0JRDVck0a5dBe+E3Z7iunN
 zYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686307718; x=1688899718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ucYYZHH6siGn2M12i6Z7RgILGAl0PK7nPTZjfgbgtYo=;
 b=fOlqFULJP4HYIrgSZe6p2ugchM1xIze8VupPwP5ZMeabebJfirw1NhHoXkWD8/voMO
 w0Aj2xP7fBbvODyZBTq8r0tLp5dCj3LMOnvLmeFvyzSbcg9tS5tHb78OSulTD3y96Jt7
 EepNu4QWuHEcuVODCfsOiweAq7LfGrg0qZXN7lhW/8/hJgqPvvTsGFE4V2VrjEezBGhC
 mbZr9oWoH57BJqwqEMB9ER//Qi5NpJs5aYyEhcq7K+WW+Aehsrc0mj/1BPZEMtLB9uxB
 Is7VkQEljfFeo1A64w7ym1xPh7hz+R9F/9wnHRx89P10Zcgmeux5MQrbfKUfdCBP6fSx
 Zjxg==
X-Gm-Message-State: AC+VfDy58gtqnlu8BtWC9VSNoih5J+TXua+eHI4wB3Xon7rOfqMbSNV8
 9vGLL3+014BMMSoCzbOok5bear6EkT/WS83IYDv7YA==
X-Google-Smtp-Source: ACHHUZ5/oFSHeEFcOYs0v5muh3GWbkr/PQX2PO+SJInUh8SaxY7/zeA6s+Hktw2aPGEjWFnWkNPYUQ==
X-Received: by 2002:a5d:5509:0:b0:309:4ba8:86a0 with SMTP id
 b9-20020a5d5509000000b003094ba886a0mr609402wrv.17.1686307718257; 
 Fri, 09 Jun 2023 03:48:38 -0700 (PDT)
Received: from localhost.localdomain (23.171.88.92.rev.sfr.net. [92.88.171.23])
 by smtp.gmail.com with ESMTPSA id
 i7-20020a5d4387000000b003064088a94fsm4145250wrq.16.2023.06.09.03.48.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jun 2023 03:48:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/22] target/arm/tcg: Move neon_tbl() from op_helper.c to
 neon_helper.c
Date: Fri,  9 Jun 2023 12:47:07 +0200
Message-Id: <20230609104717.95555-13-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230609104717.95555-1-philmd@linaro.org>
References: <20230609104717.95555-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

neon_tbl() helper is only called by NEON files. No need
to have it in the generic op_helper.c, move it with the
rest of the NEON helpers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/neon_helper.c | 22 ++++++++++++++++++++++
 target/arm/tcg/op_helper.c   | 22 ----------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index bc6c4a54e9..0a4ab3e42c 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -1738,3 +1738,25 @@ void HELPER(neon_zip16)(void *vd, void *vm)
     rm[0] = m0;
     rd[0] = d0;
 }
+
+uint64_t HELPER(neon_tbl)(CPUARMState *env, uint32_t desc,
+                          uint64_t ireg, uint64_t def)
+{
+    uint64_t tmp, val = 0;
+    uint32_t maxindex = ((desc & 3) + 1) * 8;
+    uint32_t base_reg = desc >> 2;
+    uint32_t shift, index, reg;
+
+    for (shift = 0; shift < 64; shift += 8) {
+        index = (ireg >> shift) & 0xff;
+        if (index < maxindex) {
+            reg = base_reg + (index >> 3);
+            tmp = *aa32_vfp_dreg(env, reg);
+            tmp = ((tmp >> ((index & 7) << 3)) & 0xff) << shift;
+        } else {
+            tmp = def & (0xffull << shift);
+        }
+        val |= tmp;
+    }
+    return val;
+}
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 3baf8004f6..70a9c37b74 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -82,28 +82,6 @@ void raise_exception_ra(CPUARMState *env, uint32_t excp, uint32_t syndrome,
     raise_exception(env, excp, syndrome, target_el);
 }
 
-uint64_t HELPER(neon_tbl)(CPUARMState *env, uint32_t desc,
-                          uint64_t ireg, uint64_t def)
-{
-    uint64_t tmp, val = 0;
-    uint32_t maxindex = ((desc & 3) + 1) * 8;
-    uint32_t base_reg = desc >> 2;
-    uint32_t shift, index, reg;
-
-    for (shift = 0; shift < 64; shift += 8) {
-        index = (ireg >> shift) & 0xff;
-        if (index < maxindex) {
-            reg = base_reg + (index >> 3);
-            tmp = *aa32_vfp_dreg(env, reg);
-            tmp = ((tmp >> ((index & 7) << 3)) & 0xff) << shift;
-        } else {
-            tmp = def & (0xffull << shift);
-        }
-        val |= tmp;
-    }
-    return val;
-}
-
 void HELPER(v8m_stackcheck)(CPUARMState *env, uint32_t newvalue)
 {
     /*
-- 
2.38.1



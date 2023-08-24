Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B9F786C08
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:34:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6eu-0008E7-Jh; Thu, 24 Aug 2023 05:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eB-0004A2-E7
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:59 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e7-00051X-76
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:59 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31aeef88a55so4076427f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869331; x=1693474131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x2CxREWJG7MgeLcSqs2FqHmGhWzoHCJcynkCy/gC8pQ=;
 b=UBcs5oKCSv41A+i2hRKfjKx9jo16hZM2pQhv+JbYMKC8PUUCajaZORVQqh6l2YTsyI
 tdfDJlhvFh8quvSRo9O7toSCkrP3OuOwOR1tetVO0HvCtK1zuAB0ha+piMHk0LZV+bOW
 HppJAtfhfAFlNaoN3ctPxim3WSsupGxHTYbKCIiFpDbkrgwgzW0M2uZo37MQFAvHMuge
 DlW9XJISnXydKoqqgsxwqjoLttHzheI1iMFXp0o93EmqgaCVB65rdQm2eBGmrJYNtASW
 GJm1JzZ4foLKLAG0VkIzNZFi4ThWDlUvpjjTjaQA2L2eR1jxmvXLSn0sWeNNspfVzIyR
 QTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869331; x=1693474131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x2CxREWJG7MgeLcSqs2FqHmGhWzoHCJcynkCy/gC8pQ=;
 b=IHee1tTYiQpf/CQrfzd6SjJqDflDEXY+fsCw4AkpwWU9MiFE/6lB6bBjJO8Va2S5jq
 E4xzrPbwCjutVu6drmeTMXoqzFzdzGIn7wu0YPDJzNef5onK11wjqncUKCqMqA2Bv/Tc
 nWZbPLKmdpPveYy8qjuJAverDw7KMFv2eSbH95VM8CXPZLsALBh/wAgHXPr6Y7iAKykY
 YeX5NfFeM67bYo6uDuvX6auXMGKfDhsewoCDDDQgi6dsSzJIeL5OxkcWZKzN1lP6Ziak
 VRaOTy6dRwV874Xymc1LyAHDUTu4WsQRcjEYyRUmVLTqLSAdvCc7SbKQl30I2/1Z+YHU
 L52Q==
X-Gm-Message-State: AOJu0Yz9iLopPl3jRmRPl9myD73eSZJZ1U0jWW+/pQLQPng1gQnyd4Fn
 lX3HmRfFbJqvgwGEX96IOKNNQYFIEAKbt4szO5U=
X-Google-Smtp-Source: AGHT+IGCRN8uxAXbwwDUD96bUzeNicPs7ncUNvtYAroHcv983mv6+6e3CAXYfUARrIsCjJ2aIyGD1w==
X-Received: by 2002:a5d:62cd:0:b0:319:785a:fce0 with SMTP id
 o13-20020a5d62cd000000b00319785afce0mr11543150wrv.26.1692869330879; 
 Thu, 24 Aug 2023 02:28:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/35] target/arm: Adjust PAR_EL1.SH for Device and Normal-NC
 memory types
Date: Thu, 24 Aug 2023 10:28:28 +0100
Message-Id: <20230824092836.2239644-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

The PAR_EL1.SH field documents that for the cases of:
 * Device memory
 * Normal memory with both Inner and Outer Non-Cacheable
the field should be 0b10 rather than whatever was in the
translation table descriptor field. (In the pseudocode this
is handled by PAREncodeShareability().) Perform this
adjustment when assembling a PAR value.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230807141514.19075-16-peter.maydell@linaro.org
---
 target/arm/helper.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8290ca0aaad..da5db6d3ff6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3342,6 +3342,19 @@ static CPAccessResult ats_access(CPUARMState *env, const ARMCPRegInfo *ri,
 }
 
 #ifdef CONFIG_TCG
+static int par_el1_shareability(GetPhysAddrResult *res)
+{
+    /*
+     * The PAR_EL1.SH field must be 0b10 for Device or Normal-NC
+     * memory -- see pseudocode PAREncodeShareability().
+     */
+    if (((res->cacheattrs.attrs & 0xf0) == 0) ||
+        res->cacheattrs.attrs == 0x44 || res->cacheattrs.attrs == 0x40) {
+        return 2;
+    }
+    return res->cacheattrs.shareability;
+}
+
 static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
                              MMUAccessType access_type, ARMMMUIdx mmu_idx,
                              bool is_secure)
@@ -3470,7 +3483,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
                 par64 |= (1 << 9); /* NS */
             }
             par64 |= (uint64_t)res.cacheattrs.attrs << 56; /* ATTR */
-            par64 |= res.cacheattrs.shareability << 7; /* SH */
+            par64 |= par_el1_shareability(&res) << 7; /* SH */
         } else {
             uint32_t fsr = arm_fi_to_lfsc(&fi);
 
-- 
2.34.1



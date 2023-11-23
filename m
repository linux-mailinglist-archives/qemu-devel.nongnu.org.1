Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F05DC7F577B
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 05:44:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r61YJ-0006aH-9i; Wed, 22 Nov 2023 23:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Xy-0006O6-Uk
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:44 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Xv-0006BK-3Z
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:37 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b833b54f14so252086b6e.1
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 20:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700714552; x=1701319352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D8x3rER/p5grlbBE1M3ZzCDBILdBLJ5Jn1IStfGrw8A=;
 b=ajaaqxi503q8pxrYvS4AjHyPuoE+xRdCE6cg3oak8rIU0/rtj4lwHvnyPjEtMHmn/v
 um3P3/aTYQnG+PFGKPm6ZD73zENr/Qm+GTrJWNGdC4rjN/+vj+LRMHNYw/PCqcrfhdR1
 4Znc9Ftf3YhmZPKRhtq7WENMLjkYiRDrsCjQ2uJcs2OOk+gnorx2yQS/6D57fD9/KBOD
 c9RsZCznKhJ33yFs/yaPLAo6/lea5nS6gpgmv8L1g2CcOKtOfEgeIx0CtFTrbaVi+t7+
 JPa4uyNFovZ4kkXwZft38KLYKVryiVnhrYo8OrfSrvbpyT0bdwMy5KFNHbiIrjxHHKmW
 zmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700714552; x=1701319352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D8x3rER/p5grlbBE1M3ZzCDBILdBLJ5Jn1IStfGrw8A=;
 b=uqzbWVcxLpotnpBsV7FafD8VMdc2cBovOsqegFt0ZGIMLnHIdOC9PT0YEABerM6CPQ
 UAgoHdUk6sOIvvWSCuLZb4fMu3Zs9gNdJqH1BOXcmtsKbC/kevrjBOAKP93hr+Us/vcU
 BLY9/f/8Cpa6q6DBRLyWEtsXMfmwqVjEjCxBSM3EpETxW6VLmIJ70CsbeT3lhF0TrtZ0
 wpDfcHL6oAIoYf4A+7n12kSmYraUCy1vJ9fF4H5/eUTaeAFLWgw0CAfFVsk5a9ZhWga8
 skw/s2Fb++pq2qHOOVanEpMpL8O3h/Ez/bhG3HtFqPI4FThZa+/9oB4UHE9Scml7XjwB
 lvxg==
X-Gm-Message-State: AOJu0YxPC8Z0b1dCb9vaVaGwoZhBSU/XGBh7DwzYQq8uNzSMag9We2LW
 Vo1DcUgBECdMbmzEodtlc86hUK1s9SDJ4c4iafX+r81A
X-Google-Smtp-Source: AGHT+IF84xmWckQIK42u0YDdssY1cVTe633BMv2RbLEp2i3TaJ2XDPrix6BuNm6UknMVV1PnSv2TUA==
X-Received: by 2002:a05:6808:13d3:b0:3b2:e4b7:2af2 with SMTP id
 d19-20020a05680813d300b003b2e4b72af2mr857720oiw.6.1700714552738; 
 Wed, 22 Nov 2023 20:42:32 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 i7-20020a056808030700b003b8347de3c2sm73888oie.19.2023.11.22.20.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 20:42:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 11/21] target/arm/kvm: Use a switch for kvm_arm_cpreg_level
Date: Wed, 22 Nov 2023 22:42:09 -0600
Message-Id: <20231123044219.896776-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123044219.896776-1-richard.henderson@linaro.org>
References: <20231123044219.896776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Use a switch instead of a linear search through data.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm64.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 504526b24c..61fb9dbde0 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -361,32 +361,18 @@ bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
     }
 }
 
-typedef struct CPRegStateLevel {
-    uint64_t regidx;
-    int level;
-} CPRegStateLevel;
-
-/* All system registers not listed in the following table are assumed to be
- * of the level KVM_PUT_RUNTIME_STATE. If a register should be written less
- * often, you must add it to this table with a state of either
- * KVM_PUT_RESET_STATE or KVM_PUT_FULL_STATE.
- */
-static const CPRegStateLevel non_runtime_cpregs[] = {
-    { KVM_REG_ARM_TIMER_CNT, KVM_PUT_FULL_STATE },
-    { KVM_REG_ARM_PTIMER_CNT, KVM_PUT_FULL_STATE },
-};
-
 int kvm_arm_cpreg_level(uint64_t regidx)
 {
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(non_runtime_cpregs); i++) {
-        const CPRegStateLevel *l = &non_runtime_cpregs[i];
-        if (l->regidx == regidx) {
-            return l->level;
-        }
+    /*
+     * All system registers are assumed to be level KVM_PUT_RUNTIME_STATE.
+     * If a register should be written less often, you must add it here
+     * with a state of either KVM_PUT_RESET_STATE or KVM_PUT_FULL_STATE.
+     */
+    switch (regidx) {
+    case KVM_REG_ARM_TIMER_CNT:
+    case KVM_REG_ARM_PTIMER_CNT:
+        return KVM_PUT_FULL_STATE;
     }
-
     return KVM_PUT_RUNTIME_STATE;
 }
 
-- 
2.34.1



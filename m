Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BD979D347
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:08:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg410-0008OM-RB; Tue, 12 Sep 2023 10:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg40e-00088s-1D
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:05:01 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg40P-0003q5-7b
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:04:51 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31f7400cb74so4820171f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 07:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694527479; x=1695132279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q4Dgx+OSBmpEBFmVsndMXcNNk4c9tAUi91q/Iq2oNR4=;
 b=Gbo34vf/Wvsq5Ttl1uvcIEZ0nlxBsUoznL+ZrWoYBj2mcqV9Kf6iKugNsu3VJTKazx
 P2YuHPPShGEsBonJedmL6irDnxCDzaYhavnw4dPv4t+1iknCwUYKitVVnJ9iZW4lNamg
 rNL/Eq37/q3SabYLk68qLo5OSgLPCmnrjq025EDDWZNv/HzUh+/MvRGRuMOPJFDwuQTm
 IvemU4UhrCc37eSmKeOyIu/gBy4vhCQSI8y+Pql/hhdMyPfNaozNyPS/3VmbY+Qbdc0T
 VhS4AqfDMRlM1xXZlg98QZPKce5+HYvB3UbHxO4UdF51WSZj644VStk4WESy14bWboXl
 1HzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694527479; x=1695132279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q4Dgx+OSBmpEBFmVsndMXcNNk4c9tAUi91q/Iq2oNR4=;
 b=Xv/WyevJjYHYIcJgI3labo5g/RNHzBV0LsbmL7RA1NrnDqw/R+rFWYayAz8oNzHSbn
 3yDjO8Za7KHKPi6SU5e9CtxtqWVhjprzQ2IJAWVAlkJA6to0heq556sClStoj6skNxIw
 pxjeQvh+30ggZEPR/XJmtONnSBUyqH3htGxGQ9I5H6PAWT3wYocSZSXLd6bstUkn9T/I
 Ej6yxHrZSYeuM/KIRCKvNcm4lpnUljTrHu5EIDkh+zBHx++cg7nybsgaBAt+HKrOrHg0
 MEAhjLlHHycDkAMimNQGQLiT5xErg40weKAsPwPPN1d0CuTq+85EqeQPeBSh1fo8VFs8
 7qBA==
X-Gm-Message-State: AOJu0YzRhbQfG+qcDVdCr5MSjuMW7KM7h4JiDjS941TDxrBxIKy5Lecd
 opbQWF3fj7Bwvlip939tIKkzBgfrgEx/udHa7SE=
X-Google-Smtp-Source: AGHT+IENlpFxsyVVzEUcV+/UEA20DGtCMqeEuW6o+ys+DQ8jsooenWqKAfHdxj/gC6742HVKnGoyzw==
X-Received: by 2002:a05:6000:1d91:b0:31f:85dc:1114 with SMTP id
 bk17-20020a0560001d9100b0031f85dc1114mr9593544wrb.33.1694527478634; 
 Tue, 12 Sep 2023 07:04:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a5d4983000000b00317ab75748bsm12892672wrq.49.2023.09.12.07.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 07:04:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 04/12] target/arm: Define syndrome function for MOPS
 exceptions
Date: Tue, 12 Sep 2023 15:04:26 +0100
Message-Id: <20230912140434.1333369-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912140434.1333369-1-peter.maydell@linaro.org>
References: <20230912140434.1333369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The FEAT_MOPS memory operations can raise a Memory Copy or Memory Set
exception if a copy or set instruction is executed when the CPU
register state is not correct for that instruction. Define the
usual syn_* function that constructs the syndrome register value
for these exceptions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/syndrome.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 8a6b8f8162a..5d34755508d 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -58,6 +58,7 @@ enum arm_exception_class {
     EC_DATAABORT              = 0x24,
     EC_DATAABORT_SAME_EL      = 0x25,
     EC_SPALIGNMENT            = 0x26,
+    EC_MOP                    = 0x27,
     EC_AA32_FPTRAP            = 0x28,
     EC_AA64_FPTRAP            = 0x2c,
     EC_SERROR                 = 0x2f,
@@ -334,4 +335,15 @@ static inline uint32_t syn_serror(uint32_t extra)
     return (EC_SERROR << ARM_EL_EC_SHIFT) | ARM_EL_IL | extra;
 }
 
+static inline uint32_t syn_mop(bool is_set, bool is_setg, int options,
+                               bool epilogue, bool wrong_option, bool option_a,
+                               int destreg, int srcreg, int sizereg)
+{
+    return (EC_MOP << ARM_EL_EC_SHIFT) | ARM_EL_IL |
+        (is_set << 24) | (is_setg << 23) | (options << 19) |
+        (epilogue << 18) | (wrong_option << 17) | (option_a << 16) |
+        (destreg << 10) | (srcreg << 5) | sizereg;
+}
+
+
 #endif /* TARGET_ARM_SYNDROME_H */
-- 
2.34.1



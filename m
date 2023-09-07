Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6434797649
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 18:05:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeHU5-0000vn-Lx; Thu, 07 Sep 2023 12:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHU1-0000rq-Dv
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:03:53 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHTv-00020D-Dh
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:03:53 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31c8321c48fso1556034f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 09:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694102626; x=1694707426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VbgFxrI5Pu+ZzMN4ocrv32R/nWXAyOpPgKDHCPoXjBc=;
 b=P2gAF/H8wVmnjq3OwInBKs33uK/ARecc2OTLnNK7PFNK5zqZgzN86bWWDbY4UYQUVQ
 dKgfuY/wqN4j/tQlFd6FdHkmRzRHZYCzaHdDqLAs1fxCYb5a/mUkCE7X+K8Xyx+4shO7
 WfJECJqRk4CdZtd0BIh4c3rm5/RBeLwtHe+i1v/kxCGvtHYeDYrvVs545671q1eZqKUK
 EXyXis7ZJapOzw77nsomrGD7Hc9uPZR8vOZeQxqtDwSczIKJcDAu1FM6Q1qNW1Bpn5Vf
 cuo83R01+oe/JVUFKNN70OaYOtQV4+3Pqbkit/pAraZuqrjZO1K6bc0emWE+rLmavLYN
 FnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694102626; x=1694707426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VbgFxrI5Pu+ZzMN4ocrv32R/nWXAyOpPgKDHCPoXjBc=;
 b=Lz37vL0lNXzjV4N4gJBEASWbduZI3aqb8iXjI+KJ/xSr1BbOCllx1t1ghb+N7FDiVE
 HT8o2J4+VRu8srrxu6G6DeuFchb1PEhOpMP9olHjvJGXMNpXamJYU4lS+5WvBSkbgh7Z
 G+sPIaCcPULso3XGQKpOQh+yV3FLu1ZjadIClJp9uPazY3DHSZr8zgLt/4h2QKKmCx1n
 dcZrJNnjZKEA3uTRgdNNFapUXJei2aFWoP1DTBvAM/dKNIB5ckCm5113qiY1ASN6GtGl
 NIUFCglXlNowqxYyu7g82kqAzQc5XkhiS6CnQnUbPpALR1bd0ipRRfqZsgkgR08UM0yU
 sPRA==
X-Gm-Message-State: AOJu0YzvYcv1Q9la/G8vbejmQbseziZZGcuFN5e3qArcy29MlzPtPhoK
 YENF62ZYHF3T6GPHfFwCEngq+Q==
X-Google-Smtp-Source: AGHT+IGqxeOm5vI3Bzts51iFMqHPLM804TlRiVt/s9qOZioMwmYQpnlJFJA+OR6ADGOSzvs3cvnztg==
X-Received: by 2002:a05:6000:1808:b0:319:7537:b454 with SMTP id
 m8-20020a056000180800b003197537b454mr2263034wrh.28.1694102626087; 
 Thu, 07 Sep 2023 09:03:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adfa401000000b0031980294e9fsm20256241wra.116.2023.09.07.09.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 09:03:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/14] target/arm: Define syndrome function for MOPS exceptions
Date: Thu,  7 Sep 2023 17:03:32 +0100
Message-Id: <20230907160340.260094-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907160340.260094-1-peter.maydell@linaro.org>
References: <20230907160340.260094-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

The FEAT_MOPS memory operations can raise a Memory Copy or Memory Set
exception if a copy or set instruction is executed when the CPU
register state is not correct for that instruction. Define the
usual syn_* function that constructs the syndrome register value
for these exceptions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 62254d0e518..e1b419358dd 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -57,6 +57,7 @@ enum arm_exception_class {
     EC_DATAABORT              = 0x24,
     EC_DATAABORT_SAME_EL      = 0x25,
     EC_SPALIGNMENT            = 0x26,
+    EC_MOP                    = 0x27,
     EC_AA32_FPTRAP            = 0x28,
     EC_AA64_FPTRAP            = 0x2c,
     EC_SERROR                 = 0x2f,
@@ -327,4 +328,15 @@ static inline uint32_t syn_serror(uint32_t extra)
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D7D736A6D
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:10:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZEP-0006wm-AA; Tue, 20 Jun 2023 07:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDz-0006Rs-0P
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:39 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDv-0004SO-JG
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:38 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9889952ed18so348515766b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 04:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687259314; x=1689851314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D0I8unuNO+OjgsLA/5Ao4N4ndudI6wjx6PBNe+Du5WM=;
 b=H/355eKP2OudGaREb0Jf8k9xBqLbZssn38xZhnZVnrPhbtra2DVNG2Jt1pZ6bZl5qS
 42CvHW2GmSUIrIBR80eaVaFBTrAey1A7XCNpWCDlj1auIisZIXixWwSWwhJRzLHepGlY
 0nqsi8KeIIg5KLo+nnmzd8YB5wAJIZWmbR6V5+gR0p6FORLrgPkOf+nIf7aFGOgGFVcG
 UkKhkiEyiR4U58h4PI8iVEOdIkzZQAPGkOf0SOzOQ36UBq6HqEwOvh2vs2Tqrt86SuSW
 AqwORZXGJXFbcbDa/2RCOVqxIGx9+H02SUVpVZAmyRxV4yWa/mlZxXqDc2NAkvw/QvwQ
 EgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687259314; x=1689851314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D0I8unuNO+OjgsLA/5Ao4N4ndudI6wjx6PBNe+Du5WM=;
 b=QJ7ndqlHckqrDrWJCHEsF45mlAD8jNI2LvSojicpGmSZoMDt+Gs6LazSn9iO4V8+zW
 v9p1lgi8gF43+LZCPz2iaJomN3ts0QJoc1q1njCiEzIFjbuy0s8JedXe8ks86NXz163V
 HUFUqIiydm7e43qW84jw2cEpB1ljI002yeVx2xtaRm35h/A8qF+jLU7bElTu4RvWBsh3
 /SBTfTH5HEXNC4nMEYhzvVxPO09dQmo5gq3VgleIJvWbRheJ0sZJ/PZIc652CDeKC6b7
 Y9Azgx/S0hTJQeR8QLEBUEO3Omyts/TTEGuo5EKDhRzO8JmlQ9PjYpx1TzC1FKU8DR5b
 dvfw==
X-Gm-Message-State: AC+VfDzaPIZ3wjZhyfl2TgvRsp49R7B3mxnS17fkfN6671zweXOKYgh2
 jtRGPj5XNfSFvRD/oYJodc2r+buj48WKJBnBWPzdKhTQ
X-Google-Smtp-Source: ACHHUZ5UEmiVAEoYC76tH3s7Q1SQ5p11EBWuID5wwR/klp/Ik60fAwpCFsh6qA/3YAzyBAxIhKYHlw==
X-Received: by 2002:a17:907:844:b0:982:9dc1:a434 with SMTP id
 ww4-20020a170907084400b009829dc1a434mr11166400ejb.19.1687259314270; 
 Tue, 20 Jun 2023 04:08:34 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 x17-20020a170906711100b009884f015a44sm1170687ejj.49.2023.06.20.04.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 04:08:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 25/37] target/riscv: Use aesenc_SB_SR_MC_AK
Date: Tue, 20 Jun 2023 13:07:46 +0200
Message-Id: <20230620110758.787479-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620110758.787479-1-richard.henderson@linaro.org>
References: <20230620110758.787479-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This implements the AES64ESM instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/crypto_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/riscv/crypto_helper.c b/target/riscv/crypto_helper.c
index 505166ce5a..c036fe8632 100644
--- a/target/riscv/crypto_helper.c
+++ b/target/riscv/crypto_helper.c
@@ -198,7 +198,12 @@ static inline target_ulong aes64_operation(target_ulong rs1, target_ulong rs2,
 
 target_ulong HELPER(aes64esm)(target_ulong rs1, target_ulong rs2)
 {
-    return aes64_operation(rs1, rs2, true, true);
+    AESState t;
+
+    t.d[HOST_BIG_ENDIAN] = rs1;
+    t.d[!HOST_BIG_ENDIAN] = rs2;
+    aesenc_SB_SR_MC_AK(&t, &t, &aes_zero, false);
+    return t.d[HOST_BIG_ENDIAN];
 }
 
 target_ulong HELPER(aes64es)(target_ulong rs1, target_ulong rs2)
-- 
2.34.1



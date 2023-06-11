Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BCF72B2B6
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 18:02:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8NVb-0006Po-Lf; Sun, 11 Jun 2023 12:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUe-0005ox-G2
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:49 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUb-0000RQ-0t
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:39 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-30af159b433so3329081f8f.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 09:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686499235; x=1689091235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+rINJvFsN+oVD80Eh3osK1p8SBHtR21Dx7Bo1Xv1nvY=;
 b=YRcr2d3yuZ/IcB8tq+IMkrHwwlyX5WwRQArfK42t58w6cApfDQ0E+HYtMXZ6epNyTw
 jJgCiH1cBskj4v+DC1+JDPCUERaVRLedoud0HbIot6asLeX/jikNjOzK1+QU2XSTKEmr
 VQoeZVBz0xgYHFMnl3faflHibRKFJkp/wMW1RNSGfv/cIZhhqwZBdHiaNhHnwod8VyHS
 8kvUj8OD96mdMH8HxBCXBzSx0O1gkVlIjva8vit8z4Uupv0UZZ/moZ4KSd5spq2tm5iZ
 ORmRQUBcoK56+mH0GI5ikyXYbdrGWjKV3pM3/Z4o/LTXR+/vRjDEwiNtkLKn16QOtFnI
 vDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686499235; x=1689091235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+rINJvFsN+oVD80Eh3osK1p8SBHtR21Dx7Bo1Xv1nvY=;
 b=PfQlHMWxcrVq93+eoRcc+uQf3Q7G9zZDJlUk3QQJzqHcbbrnJeEIqOM67NES1q7qrP
 qiV1B/sZ+mLfGghptHM5Mh6KctWXho9fU+fQs4nCanrpVu3r7LIaQiFm3Gf9ALeTqndo
 cjvEpeqS4rIU3t4/5/ol39k3nLMxwyCl3PJkMCWrP3cGH9umFnU1xCFZ0iMc44TsZw//
 iAuIm/x7d+XAREF/uPqFXCh9XGjIkOP6OYKI4YYI8ENBNuSLbKaxf056fq9WSuH/zQld
 YtK2vq3F7PdAIbxsBruaqFMtEdL6xtflvmrwj7HAam+7fVmLHSeV6DmcidnX6UytUPfn
 6+qw==
X-Gm-Message-State: AC+VfDxwKccY6D59TyNWM38akbVVLmhahk18EhRIC6U9bQ50hriYwr16
 VKmhUSscWTLlKdVyrdz+e7xT+W+++6qEIREGRSQ=
X-Google-Smtp-Source: ACHHUZ66KF9IFzxhY2U4vA01+QjyfeEgK+Q/FFvk8yRnpIox3X4HbZdin9qvL9520/7HGffFRJydxw==
X-Received: by 2002:a05:6000:136c:b0:30f:c243:d7e7 with SMTP id
 q12-20020a056000136c00b0030fc243d7e7mr199984wrz.68.1686499235464; 
 Sun, 11 Jun 2023 09:00:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a056000008900b0030ae499da59sm9923022wrx.111.2023.06.11.09.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 09:00:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 03/23] target/arm: Pass memop to gen_mte_check1_mmuidx() in
 reg_imm9 decode
Date: Sun, 11 Jun 2023 17:00:12 +0100
Message-Id: <20230611160032.274823-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230611160032.274823-1-peter.maydell@linaro.org>
References: <20230611160032.274823-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

In disas_ldst_reg_imm9() we missed one place where a call to
a gen_mte_check* function should now be passed the memop we
have created rather than just being passed the size. Fix this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4ec857bcd8d..d271449431a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3226,7 +3226,7 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
 
     clean_addr = gen_mte_check1_mmuidx(s, dirty_addr, is_store,
                                        writeback || rn != 31,
-                                       size, is_unpriv, memidx);
+                                       memop, is_unpriv, memidx);
 
     if (is_vector) {
         if (is_store) {
-- 
2.34.1



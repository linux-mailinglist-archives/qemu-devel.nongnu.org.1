Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2FF7284F6
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 18:30:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7IW2-0007GK-GC; Thu, 08 Jun 2023 12:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7IVv-0007Fy-So
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:29:32 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7IVs-0006cf-Pv
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:29:30 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-53f9a376f3eso565785a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 09:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686241767; x=1688833767;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/I2fD9lYqNc2LRt0yhIdWFMH8fJB9xfZHNkFlVHjNtA=;
 b=A5otVEQ3cur3J3VGxXQdP3/MLZqjZfCvSALi4wLbbZPqbNagaLP45l3F8PZmQNAmV5
 PWygb7299/eeHtmkR/VvgkdTcN5D5lea5GtjEgU/vZYq78dNycRpDc1WExYvWcSU2jJF
 gV/IbOCtLDRdnTtoIL9rJIQUWGzcnlsmLDk1UV9eH7Fo6LsRe2Xk2UeIDCgSjfwZn+BU
 SrZk+t4zXq01oeqoab/XNQWYLole4N0dCYog2w15D1BN6r+4b3YyJ4kQqdEXQVEj/5ee
 /kaLeHmPFXOVXL4q4Se9wg7nrH+umB9FGFdnRhb/c+0v+9TOkt3BRd8D4wmx+UBIhS1O
 KcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686241767; x=1688833767;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/I2fD9lYqNc2LRt0yhIdWFMH8fJB9xfZHNkFlVHjNtA=;
 b=I/Ql1RZuFussFCvswbvaFjpQqQ50fE582EfASxq5eQGu/TxHGqGYQ9/p5MivVQ/+q+
 E6Z08sBGX0UyQ5ebQFAIW0caQVknIO0cjSVe55FHFfbTAP3t9RYyve2uuaZPrgKst1Eg
 GIHN3p7JYN6KO+0zE9AaZqmknnvo4QGjq772+pbGdJFG1iJBFelytuw+I/9LBPNfk6hC
 cRONGWid+MjWPO8vzjmm41Wd5K8tM7vVOKi7inR51fRC8cPvtssA9kLe3BTa9+f0/lMM
 V0rAKQZzgxqP2Dya7VPjyJ1QigrHDw6tT+pEYAU8obxsA1T5kYAVYwQcxr+PppSYSo7P
 pCdA==
X-Gm-Message-State: AC+VfDzFnJM0HPCDt8zXJmp1aPA6rNOYifZNLMVNjGBgXPbvq34KDD37
 EdAtDf45sd4Hvh/6zkpHyUZSlnOBRAuakvFwI+8=
X-Google-Smtp-Source: ACHHUZ4ziMHmklKKCnltpKYnHD35kIKR6sm84oYVn+Fg2JvWIRaUB5FSLWY0ajOeRh5Nct2CwomZTw==
X-Received: by 2002:a17:90b:486:b0:258:ddc3:3efb with SMTP id
 bh6-20020a17090b048600b00258ddc33efbmr7940901pjb.10.1686241767060; 
 Thu, 08 Jun 2023 09:29:27 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1ac8:15fb:bc3f:9b00])
 by smtp.gmail.com with ESMTPSA id
 b19-20020a17090a551300b0025023726fc4sm3253571pji.26.2023.06.08.09.29.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 09:29:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tcg/tci: Fix MemOpIdx operand index for 3-operand memops
Date: Thu,  8 Jun 2023 09:29:25 -0700
Message-Id: <20230608162925.677598-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Cut and paste error from the 4-operand memops.

Fixes: ab64da797740 ("tcg/tci: Adjust passing of MemOpIdx")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 0037f904f1..253f27f174 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -847,7 +847,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         if (TCG_TARGET_REG_BITS == 64) {
             tcg_out_op_rrm(s, opc, args[0], args[1], args[2]);
         } else {
-            tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, args[4]);
+            tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, args[3]);
             tcg_out_op_rrrr(s, opc, args[0], args[1], args[2], TCG_REG_TMP);
         }
         break;
-- 
2.34.1



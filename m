Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB127057C5
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:46:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Yo-0006je-0g; Tue, 16 May 2023 15:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Ym-0006j5-Lj
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:12 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yl-0002jW-5O
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:12 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-643a6f993a7so9345452b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266130; x=1686858130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5+dVuSBLTF8ePfEeAWZlWoNLu6H+GdqE/W0YcabdOx4=;
 b=a1bs5mhY0ROnk5///ulxqVXpro91VUTPz/6pBcL4Geuf4cjiJrBHDv3PyUfuzGcCWU
 SyvZDJ1EGhiVWYfc5WuvpPLw2Z+NKQyl0Mr/sv/MBr9x8FBexTqcr+Kz/BmNn54esiZN
 yDjTLsx3SG1AEvcFTqNifja3bskPV/wzbL1dosVK36DJDRmfTBMvgXgucGflG2yLe4Mp
 hODzD0r51r9VRT8XXTm2YWf1i0KuRR1r/t1eE/saHO5xbfFIMsWiQvNY9Cbr5CA3c1ZO
 69m2YtsGew5qHSmHW4wVHOVoP6Nu0u85cltAGCmVEQ/nd5lZE7LyKwy90jW6IcL22ePf
 ibjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266130; x=1686858130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5+dVuSBLTF8ePfEeAWZlWoNLu6H+GdqE/W0YcabdOx4=;
 b=YOrPV9rjvLLsCnZ3/oBmiPd8EQpiIzgK5sRDdlDDojaHskpuWDjDaeXVuZARxfVoR3
 zdnAuWO3abbOFsjW/UoCVzgQO7Klpb5HuKD/8vZpnk1iH0vEjQD4E0/69KPD8AXubd4y
 /1IWWJozGkZQmHZbNVcn7Bq39BGxbMV0WkK1Cv+NFoixoIvzezy0Xpmw1uRhx86mZYoR
 +/isJwHDKfhAJ6hyHAPETr1Os8t9UMAFx9FEFbKxQrYEZvxQKrIoJwFcvptLV0qkFNnC
 PuEQLwMLibIUEv4DpKNAGNefOaVDKQNJHY/5G6UehN6L1DUvLJ0nWUH4NK+2FZIKndsv
 IEuw==
X-Gm-Message-State: AC+VfDzRgMo2ms8y839T35G6PKfCI6xuAIuvxytHeWBFhcr16SNpstqQ
 YOVLrCoP2DeH+Tra/+IPUSzancEb6cGBOC4112M=
X-Google-Smtp-Source: ACHHUZ6cT7n+3y27e0ob23bPg6GjLl/B8rrXm49E+llBBj+ICW2GAG4jaeKZqrAjEn243LGu3dvbcg==
X-Received: by 2002:a05:6a00:10d2:b0:643:96bc:b292 with SMTP id
 d18-20020a056a0010d200b0064396bcb292mr41983348pfu.5.1684266130414; 
 Tue, 16 May 2023 12:42:10 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:42:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 26/80] tcg/sparc64: Split out tcg_out_movi_s32
Date: Tue, 16 May 2023 12:40:51 -0700
Message-Id: <20230516194145.1749305-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.c.inc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index e244209890..4375a06377 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -405,6 +405,13 @@ static void tcg_out_movi_s13(TCGContext *s, TCGReg ret, int32_t arg)
     tcg_out_arithi(s, ret, TCG_REG_G0, arg, ARITH_OR);
 }
 
+/* A 32-bit constant sign-extended to 64 bits.  */
+static void tcg_out_movi_s32(TCGContext *s, TCGReg ret, int32_t arg)
+{
+    tcg_out_sethi(s, ret, ~arg);
+    tcg_out_arithi(s, ret, ret, (arg & 0x3ff) | -0x400, ARITH_XOR);
+}
+
 /* A 32-bit constant zero-extended to 64 bits.  */
 static void tcg_out_movi_u32(TCGContext *s, TCGReg ret, uint32_t arg)
 {
@@ -444,8 +451,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
 
     /* A 32-bit constant sign-extended to 64-bits.  */
     if (arg == lo) {
-        tcg_out_sethi(s, ret, ~arg);
-        tcg_out_arithi(s, ret, ret, (arg & 0x3ff) | -0x400, ARITH_XOR);
+        tcg_out_movi_s32(s, ret, arg);
         return;
     }
 
-- 
2.34.1



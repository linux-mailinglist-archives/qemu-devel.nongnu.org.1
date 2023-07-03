Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D84A67459B3
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:09:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGS2-0003CH-FT; Mon, 03 Jul 2023 06:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRW-0002s0-6D
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:06:03 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRH-0005sv-64
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:06:01 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3141fa31c2bso3957675f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688378745; x=1690970745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lOYUQGr/W2hN41A+MbMW4B7XkhWFliC6iC1qe2q7c8=;
 b=FKuTLHWnU9cGz6omANfyTbx8zbAbdvn63Os5v9VbhwZhASRSUR2tyIvnBhtIFLYHDm
 Thf89+6pNW5dlV6I7QNZb4gEpoFGx9eGjUakyzPg2xxzZK2hq7uXH810IO+tS1cs3Zvf
 Tn7S3sgB3mQgCVEEI9v1wLzVn1KboVaifNSpwOuHKSjQG2378fvcz5nwDk+YA+3JKS+d
 x0vw0vnhKVZyanEFyHexz+E4upOvJ3W7xpSDOnuJiqj8b9DudL2rwjrML1fuqLCIIJEb
 MZXziao5U0bSHyWmnUIwlrLbLWSDfXu0tPblAUL7oxnK/2w8jfmDEN4NVW9/XuoY8cK5
 Ajmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688378745; x=1690970745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+lOYUQGr/W2hN41A+MbMW4B7XkhWFliC6iC1qe2q7c8=;
 b=HZkCZ5wT0pZzoa4pk80qjcVKTpVD0hrpx8wzab1ulqqEa8K/YHDssGKZ8xgzrJDLSx
 Fv7eBlmiDC7vaCjhvdA68V05FHgYfsbuMcIFWz+OAmhwUE+8UtQ7weQ3qidE3oBIIK8X
 iphWc9fHJ9qC9fUmhJ/s1i6JD/IQEhm1cyOb21/N+X/LahiJjHvCr/toOKEci4yrdx2R
 ziBAqnJRTKJk8JrDKifAxW+baMx++6yn2UBuf+T53j54w82eCG9rr+Yn22tqPPRvweIX
 W1YMcQ7IfHRcUOSM+7PXtLeb5x8pP9VBDz/fnVMGsPQUpaYSRyA9j5vCUe5C64oUANYv
 EV2g==
X-Gm-Message-State: ABy/qLaw6UrVsgSrV+I2KjiUYiz8Mq0G/dbo01c9rKEChyMSZL0uz7/i
 eMMvbCeDqsliuTqsmNHmovPtVLapGnvdoCRW716DOg==
X-Google-Smtp-Source: APBJJlG7MmNJ+XFAFY7OAEYCvWeKq/k/Oi3Gk1+mNc85Dt9XPLyocoRo4OIBoE9779WgLq/MNVphqQ==
X-Received: by 2002:adf:fdc9:0:b0:313:f399:6cea with SMTP id
 i9-20020adffdc9000000b00313f3996ceamr8276715wrs.4.1688378745288; 
 Mon, 03 Jul 2023 03:05:45 -0700 (PDT)
Received: from stoup.home (91.232.79.188.dynamic.jazztel.es. [188.79.232.91])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm18446562wrx.59.2023.07.03.03.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:05:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com
Subject: [PATCH v4 21/37] target/i386: Use aesdec_IMC
Date: Mon,  3 Jul 2023 12:05:04 +0200
Message-Id: <20230703100520.68224-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703100520.68224-1-richard.henderson@linaro.org>
References: <20230703100520.68224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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

This implements the AESIMC instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/ops_sse.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 0a37bde595..893913ebf8 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2215,15 +2215,10 @@ void glue(helper_aesenclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 #if SHIFT == 1
 void glue(helper_aesimc, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 {
-    int i;
-    Reg tmp = *s;
+    AESState *ad = (AESState *)&d->ZMM_X(0);
+    AESState *st = (AESState *)&s->ZMM_X(0);
 
-    for (i = 0 ; i < 4 ; i++) {
-        d->L(i) = bswap32(AES_imc[tmp.B(4 * i + 0)][0] ^
-                          AES_imc[tmp.B(4 * i + 1)][1] ^
-                          AES_imc[tmp.B(4 * i + 2)][2] ^
-                          AES_imc[tmp.B(4 * i + 3)][3]);
-    }
+    aesdec_IMC(ad, st, false);
 }
 
 void glue(helper_aeskeygenassist, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D58720D75
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 04:41:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5H7T-0001XV-C5; Fri, 02 Jun 2023 22:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6Q-0000T7-D4
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:34:50 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6G-0004mC-Ug
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:34:49 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3942c6584f0so2046750b6e.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 19:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685759679; x=1688351679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u69UQkBy31b+t/zyg2gVlBb3lh+xndEyIjHtbKZIvTU=;
 b=pWvCC9uQQxp9QIFTEsfnyKcJ00EqthHlH/bPANtGH3qmEF+6+kVSTbiHumeWYbky7B
 h1btG8baW59HZuI7EznMBCFaPhx76Zjpe0WBBiUtvr7NRfQ0oTD55o3bdgeS7q9+z/lU
 WnqNqRkFfC+yoOBPmSANLLq4MjxiFA1F9oSCCz3X7pnjObtCZDsUJr4+7/SJQ2CviIqZ
 JCyMEGR9WoIo+xg7SDJlpp3iMQatpPjKd7PBgb1hdYgH0OKs2ZTmNTNiKikD5oJZwoxS
 dT5MJzvzameFTkJATJZVzr//h3V39a1ccvj/vyIKgvfSS7BDJONUMoLQFoCFWfpsKR4E
 LDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685759679; x=1688351679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u69UQkBy31b+t/zyg2gVlBb3lh+xndEyIjHtbKZIvTU=;
 b=AehZj1GSEPanEydTJkKgqR2oKpyWg8U8Km+PVXzhMVoMR/jGI0S79rmhFyhPU/lisn
 ey+wcPOveCbuxM7jg9f80lDKcTj1Kg8mrwYBrx4yiTfqq2BbsvcDZ9Q/qsmP9boHOnDS
 BGP/E5B7XjCh0wt6qmfHFgizvPtzKobMBXZJR6WmzQ5kcNL6bYCHPYrpDy4njR60OLPA
 oCP4S1jzuTYaUJ07hhRA296TWu955dK7qB+4hGvCTN+gpDfZaCCxnAcuButbuKEkkmo3
 hBBokRazoDqKMLj+3nGm2MduV6HEfT693SSS1ElgPNwC097PKgD3zOqVoabhLFGqaNsS
 CBGw==
X-Gm-Message-State: AC+VfDw0Pzy8EySUSDweAU/lQeWCUDu0aRsFf+ySm9+KK9qef9ilpC8v
 sl0kX09PGj8optt3N2np/A6E5J4oZPnRy5Ctp4Y=
X-Google-Smtp-Source: ACHHUZ7r9IRsVMS9yA2yj0TeW8+gY2GeLrmqqaeWPJI92nKgHGOLBphGZm3sdAk7QfefIHztRJCEDA==
X-Received: by 2002:a05:6808:649:b0:396:63a:a715 with SMTP id
 z9-20020a056808064900b00396063aa715mr1698260oih.56.1685759679191; 
 Fri, 02 Jun 2023 19:34:39 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 e91-20020a17090a6fe400b002508d73f4e8sm3914289pjk.57.2023.06.02.19.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 19:34:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH 13/35] target/ppc: Use aesdec_ISB_ISR
Date: Fri,  2 Jun 2023 19:34:04 -0700
Message-Id: <20230603023426.1064431-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603023426.1064431-1-richard.henderson@linaro.org>
References: <20230603023426.1064431-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

This implements the VNCIPHERLAST instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index b49e17685b..444beb1779 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2979,13 +2979,13 @@ void helper_vncipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 
 void helper_vncipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
-    ppc_avr_t result;
-    int i;
+    AESState *ad = (AESState *)r;
+    AESState *st = (AESState *)a;
+    AESState *rk = (AESState *)b;
+    AESState t;
 
-    VECTOR_FOR_INORDER_I(i, u8) {
-        result.VsrB(i) = b->VsrB(i) ^ (AES_isbox[a->VsrB(AES_ishifts[i])]);
-    }
-    *r = result;
+    aesdec_ISB_ISR(&t, st, true);
+    ad->v = t.v ^ rk->v;
 }
 
 void helper_vshasigmaw(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2747C728DE3
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 04:27:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7RpA-00051y-8s; Thu, 08 Jun 2023 22:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7RoE-00034N-GU
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:25:04 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7Rnf-0005js-9l
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:25:00 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-655d1fc8ad8so1068900b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 19:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686277466; x=1688869466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7JP6u0tX67kSxwDAELDlJJkYXsAQIbSKpvhIf/W0vRc=;
 b=BAFaiSc3LngntDSxUcEja3J9+Fn+TlYkCW/cLky8eybc4cHAvaT5/SkWL67JqUBp9m
 AhHQ5ViRyBaDwnuwnc6GpEnX/rJOuLg1jUwN++/CgFEP9otUK8mo9qtdVJl1S2Oi5aAm
 VhGGC692BOfzSSSkw00KfpUg+YHO9YsVKLDALCbcjpAvFRm3ZNm1+RQ0aGxF/0wUxiWE
 EoKeFWSh+510fUtPIqUNktPbrH3Dwr+jG1xlTjfUqOlV5CCS8VhJZyZSTJZVT0ANYN1R
 dPbeb1+gp/GyuQJcxuCrby+sOtqOtr+655ZAief1A+TjMaRlrzwVOvlaGBhPkABKTrRL
 dkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686277466; x=1688869466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7JP6u0tX67kSxwDAELDlJJkYXsAQIbSKpvhIf/W0vRc=;
 b=BabbHRpHNLSdCKyKRhrRxWLd7nw4WTy1DDqE2gUBhcWmx4oob/FrQBF9kfyHaab/Bf
 cZAE46gWQ7nwKMpptpBum37uuL8NcBzXDsXLhyDmI6q7IP/66dpZqin8hyetWZ2dmnYN
 IB1tCajQ4xJ/8EkybXJyC2+5RteDJOBTy38CGMmAMngPx2C3W/b/rZvMsD+7jfKhuV+3
 //1dCWzStL9GGdmQEZYoFgXElie0ilOmsQD4dsUFpruPLk682pEXvuheI0WEPfsC/SIz
 8rl2Oyq+8jYQv1KXIACPJknVzV0II/raHhVjl4MwcjTihnUcHrRp/k1/Z0oD5j2HhMUc
 6DYw==
X-Gm-Message-State: AC+VfDxVGmMW8XhyvS6LVS+RbLY/S6rWJxj9s2fSVGUcZFRlvcYtKYtU
 HtgNaRAchoEji1nLdogN7F/c+WF4cc41RrBMuyI=
X-Google-Smtp-Source: ACHHUZ5dPavFuPh5eBflVFM1YXIPBs0Ywmc9T7VKtqYswH+VUFfutXVM4XZSNd9g5mq8l/rNk9bs9A==
X-Received: by 2002:a05:6a00:148c:b0:644:ad29:fd37 with SMTP id
 v12-20020a056a00148c00b00644ad29fd37mr8041865pfu.28.1686277466068; 
 Thu, 08 Jun 2023 19:24:26 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:b071:df63:5761:f449])
 by smtp.gmail.com with ESMTPSA id
 x25-20020a62fb19000000b0063afb08afeesm1686458pfm.67.2023.06.08.19.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 19:24:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH v2 25/38] target/ppc: Use aesenc_SB_SR_MC_AK
Date: Thu,  8 Jun 2023 19:23:48 -0700
Message-Id: <20230609022401.684157-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609022401.684157-1-richard.henderson@linaro.org>
References: <20230609022401.684157-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

This implements the VCIPHER instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 15f07fca2b..1e477924b7 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2933,17 +2933,11 @@ void helper_vsbox(ppc_avr_t *r, ppc_avr_t *a)
 
 void helper_vcipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
-    ppc_avr_t result;
-    int i;
+    AESState *ad = (AESState *)r;
+    AESState *st = (AESState *)a;
+    AESState *rk = (AESState *)b;
 
-    VECTOR_FOR_INORDER_I(i, u32) {
-        result.VsrW(i) = b->VsrW(i) ^
-            (AES_Te0[a->VsrB(AES_shifts[4 * i + 0])] ^
-             AES_Te1[a->VsrB(AES_shifts[4 * i + 1])] ^
-             AES_Te2[a->VsrB(AES_shifts[4 * i + 2])] ^
-             AES_Te3[a->VsrB(AES_shifts[4 * i + 3])]);
-    }
-    *r = result;
+    aesenc_SB_SR_MC_AK(ad, st, rk, true);
 }
 
 void helper_vcipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
-- 
2.34.1



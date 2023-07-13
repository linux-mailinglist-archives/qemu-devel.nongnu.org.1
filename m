Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F53D752C07
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:18:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3ec-0000Qv-2Z; Thu, 13 Jul 2023 17:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eO-0000KJ-4K
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:15:00 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eM-000192-Hv
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:59 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57dcso11897605e9.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689282897; x=1691874897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=66pSwadG/9AX/ZsrllJ7+T0lOcbfRbkA+50ErEBSa5M=;
 b=ydtfPoH97BucvQ0xFcFr5i9651XLHRcp0kx6dcqjIYeMAm6HE5S/souUKGmadIkajq
 wK6JerpNQQffnUCq3bfyQBmpzp7HEMKv1S6V1a2fZf2hsoQeSj51eNXsAoyETAffsIlE
 rBEgYvMlJSYJX3SxIk+VE+VUZEw86MUTEretoHC39NwpKiJc5Q+Xis8fvpKhnKNeQOtA
 vtc511LfSgcouccMDLr6gKmBhoha26WfsChsMPi1smu+h6gUXc/5GiP63G2tk9MFXhfu
 vjjuFDvblwRmKVFAP0Mga7fTpx0EDnZsXXGrpXpcNts2C64InzefeyBLaznFVvUDZDfU
 RwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689282897; x=1691874897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=66pSwadG/9AX/ZsrllJ7+T0lOcbfRbkA+50ErEBSa5M=;
 b=btLt8QZ5qfHz/hYVALc/AMN/iT3GJusgtV7DhN64nnXKeh4UQphctkMMeW1L6ryRqK
 uKhZJ/ws2DuVX+HagXPd/sfQHir+7SmvDMPWYx+jddeefvBvuk7gLo/YoQpOCZBzxODJ
 iies68MMruZI9vQBsjOnNwYzNNzoyN5vENOsT/jBqVbrbXdsLQ3eYBmaelmU7I+j47k9
 3z+DwU1eYjz+iFf4vJsWFm6nP6UbK/y+qASfDLHSbRtPv/hUaK/viJpis18Ia5T2cuYn
 A24LbG4vQNC65yRtLwKVN1wT0jOD9dfXYp+exYw9g94MgI76mxTtBtKtakHL4wLzRPQ0
 s8/Q==
X-Gm-Message-State: ABy/qLbid/pSMhb9a3zKAPKYMcCekU+yC//HMGOmNwWeudFmkc369saH
 iFOKit4aoaZdY337jajpaycEF7BLyrn7IwAesj/Zojog
X-Google-Smtp-Source: APBJJlH6HtolwlZl6kQA9SSEjK1ns5d/wMBpnnMGANYkAQlfe60suzoyNuaXPNj98DqCB6uFDV0PTQ==
X-Received: by 2002:adf:f30a:0:b0:313:dfb8:b4d0 with SMTP id
 i10-20020adff30a000000b00313dfb8b4d0mr2490155wro.66.1689282897123; 
 Thu, 13 Jul 2023 14:14:57 -0700 (PDT)
Received: from stoup.. ([85.193.156.66]) by smtp.gmail.com with ESMTPSA id
 n12-20020adff08c000000b0030ada01ca78sm8973747wro.10.2023.07.13.14.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 14:14:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH 16/18] target/ppc: Use clmul_64
Date: Thu, 13 Jul 2023 22:14:33 +0100
Message-Id: <20230713211435.13505-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713211435.13505-1-richard.henderson@linaro.org>
References: <20230713211435.13505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

Use generic routine for 64-bit carry-less multiply.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 828f04bce7..4e1fa2fd68 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1455,20 +1455,9 @@ void helper_vpmsumw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 
 void helper_VPMSUMD(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
-    int i, j;
-    Int128 tmp, prod[2] = {int128_zero(), int128_zero()};
-
-    for (j = 0; j < 64; j++) {
-        for (i = 0; i < ARRAY_SIZE(r->u64); i++) {
-            if (a->VsrD(i) & (1ull << j)) {
-                tmp = int128_make64(b->VsrD(i));
-                tmp = int128_lshift(tmp, j);
-                prod[i] = int128_xor(prod[i], tmp);
-            }
-        }
-    }
-
-    r->s128 = int128_xor(prod[0], prod[1]);
+    Int128 e = clmul_64(a->u64[0], b->u64[0]);
+    Int128 o = clmul_64(a->u64[1], b->u64[1]);
+    r->s128 = int128_xor(e, o);
 }
 
 #if HOST_BIG_ENDIAN
-- 
2.34.1



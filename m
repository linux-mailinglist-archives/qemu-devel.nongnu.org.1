Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F068F728E0D
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 04:32:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7RpQ-0007UX-PL; Thu, 08 Jun 2023 22:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7RoM-0003Bg-3k
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:25:13 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7Rnl-0005mj-95
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:25:09 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-55b3b3e2928so850858eaf.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 19:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686277471; x=1688869471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9vppTZ0kH0Xs3eiJ138RWwvuyXdLrdS2zldn9LG9Ak=;
 b=nJWCZtF3h06Cbsflk7UBEJ53FYknsNeRYR21bA0viRmaMSPCSgLHyjkoEoE2Bf2wYP
 KbzSyfnF3LD/3EUE0ouVmvcrenkgmsoRMPzwy2OIKXOgyZuG0quVryf6LigxPquoubdt
 1hzXyqNsssLr69USbkwjsNilL7DFL3SVTuMyaJMYq5qYeFho/0MZg/QH2EGuPLvZgjr6
 2fpaJ0ZyKZ9ubumQcPkrTXjseaWvy4I0irHsW1cYk79sO3U1Y+LUoRSqo9kFIvGL6MJV
 5rz/8h+iTgQ+kRCeKPEGKga9hocec0MFZT/d2uLqXBgSnacI3YnOEXPNiuh6zsVEBNaz
 0x3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686277471; x=1688869471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q9vppTZ0kH0Xs3eiJ138RWwvuyXdLrdS2zldn9LG9Ak=;
 b=cxbjPkB0X/wwAlmP5otS049kplE/I8JHxfa4qzjntfEONlBCCM4OY67ksMAeKRK+NI
 qLoV8cK9Hch+ywoX63fBuVHi2URHKYvBuXgUpqc+5HwAmbX1ezYE6+pfu0Z8wRDWUymd
 7NzXCW+xUqXo0Op1EAGoJCLAM4eLqYyt4LlSqagQtL8HgnHmJXG3X23bzJM/pf2/6C4a
 fXmZ5WHVh979cWjlB0m5muaYTT6BoDAU13APP0exCLmPRM3rmBBTTueMuJh+I3vHD6sX
 hOKpy6rj+oZKFHDfM/lw/L3dT0VnNt5N3l85RKq/HfQFJXp0fn2i6nIqI1g20ecRvCvS
 pTkg==
X-Gm-Message-State: AC+VfDwyhvgNu0zrmzCruULa18RJvechE8G9s0ZPNr2oXcHF14gOnOZ1
 Qoy5BV6CMcKtJxTGgd4pOed7cuywKjHYkRu1wJg=
X-Google-Smtp-Source: ACHHUZ5fgCoeyznpj6eTr74WM2ZMhMHV7lcz1mAQveDSkjtjhJqGXStwEB911vmV6YeFqF5hTKVoIg==
X-Received: by 2002:a54:4117:0:b0:39a:a9e9:38cb with SMTP id
 l23-20020a544117000000b0039aa9e938cbmr282605oic.22.1686277471442; 
 Thu, 08 Jun 2023 19:24:31 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:b071:df63:5761:f449])
 by smtp.gmail.com with ESMTPSA id
 x25-20020a62fb19000000b0063afb08afeesm1686458pfm.67.2023.06.08.19.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 19:24:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH v2 31/38] target/ppc: Use aesdec_ISB_ISR_AK_IMC
Date: Thu,  8 Jun 2023 19:23:54 -0700
Message-Id: <20230609022401.684157-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609022401.684157-1-richard.henderson@linaro.org>
References: <20230609022401.684157-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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

This implements the VNCIPHER instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 1e477924b7..834da80fe3 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2947,22 +2947,11 @@ void helper_vcipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 
 void helper_vncipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
-    /* This differs from what is written in ISA V2.07.  The RTL is */
-    /* incorrect and will be fixed in V2.07B.                      */
-    int i;
-    ppc_avr_t tmp;
+    AESState *ad = (AESState *)r;
+    AESState *st = (AESState *)a;
+    AESState *rk = (AESState *)b;
 
-    VECTOR_FOR_INORDER_I(i, u8) {
-        tmp.VsrB(i) = b->VsrB(i) ^ AES_isbox[a->VsrB(AES_ishifts[i])];
-    }
-
-    VECTOR_FOR_INORDER_I(i, u32) {
-        r->VsrW(i) =
-            AES_imc[tmp.VsrB(4 * i + 0)][0] ^
-            AES_imc[tmp.VsrB(4 * i + 1)][1] ^
-            AES_imc[tmp.VsrB(4 * i + 2)][2] ^
-            AES_imc[tmp.VsrB(4 * i + 3)][3];
-    }
+    aesdec_ISB_ISR_AK_IMC(ad, st, rk, true);
 }
 
 void helper_vncipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
-- 
2.34.1



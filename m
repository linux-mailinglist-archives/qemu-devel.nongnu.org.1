Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 142437459BF
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:10:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGRb-0002xF-2H; Mon, 03 Jul 2023 06:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRO-0002mP-9l
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:05:54 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRG-0005rf-84
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:05:53 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3141c8a6f30so4372649f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688378742; x=1690970742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQsBpcgKVgYp7fXYDQVN06TvKGcdOIek7QQgIG6AozQ=;
 b=mZ/IrUE6/4Sgc7ls67lO5hlJNFTZGJQuyK7rU1pjq5w4o6lmCQ3ZvRKgdkDTa3x8E2
 zm6IPnPCy7j0qoUidc0jppHp2jbFqqLg53fbc6cCyForMLD1L5PIDqSHUtlwvrvd8YTH
 p3CF1k2n7cAA51rQMEZS69yxqQIUSq0ck8zNOypaImnrozJ1CDylJ+XOhlWh9LLtgrdX
 NlVvFiRn/U0GzTKneyOGbBnNw4jzr63IrACpyibMdhdCmpwb/NXdKHtGeHBg1KuRQ4D2
 KwpXe65bd3x8PL9XHQ+A1Yyi3ioI6cruO19juWirqoUisX9Ub4ADWUWzNIulDxCQFS2O
 T8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688378742; x=1690970742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQsBpcgKVgYp7fXYDQVN06TvKGcdOIek7QQgIG6AozQ=;
 b=V+N/O1iRLAFhRSnTFvXNFvvr3zFJhmfua+dH+pZFeikW1VNsyAZYSP9tYhmMdUKe3c
 fr5p7tZ/US5o48kbFo4Hlh1uz9tiFi0Gso3Wb0KSWHGzm9CuR200lYqwE0medcV/skI8
 cNNok6Wcc18dHcv50VTlbytWjCQvP2GRm2oUdMbqKbHlSDBBeLHOPCFhtHCA7G1Qu+wa
 zwT3N2j5x66SLmd/UQgS1odaQLA8Na9hSnd/+CKiVWhkWrnbtg7BgefYIA0Y3nuIheJT
 6xGGfZnHncn5OuHvHaz52xshXBdCjnp133uC9ZkYDZhGuw9tSBYK/0922omRRxoNlHTi
 AlHQ==
X-Gm-Message-State: ABy/qLadYiWQjE/J9RXpouz6Ey8YvDZ81KndL50V5xyZ1mXM5x6fh1o8
 t0J+rCgs+ajQmFEQnUHonXRmSa8i0rfzsobJQ9hBTg==
X-Google-Smtp-Source: APBJJlGlYO37mRzpMB7XFRv1JL8DNCTK5e9dO0BjmamwoJjoWBF6pDhE7yy2DpftBSxQOWHFpv6ytQ==
X-Received: by 2002:adf:f14a:0:b0:314:96f:bb81 with SMTP id
 y10-20020adff14a000000b00314096fbb81mr7292123wro.22.1688378742155; 
 Mon, 03 Jul 2023 03:05:42 -0700 (PDT)
Received: from stoup.home (91.232.79.188.dynamic.jazztel.es. [188.79.232.91])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm18446562wrx.59.2023.07.03.03.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:05:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 18/37] target/ppc: Use aesdec_ISB_ISR_AK_IMC
Date: Mon,  3 Jul 2023 12:05:01 +0200
Message-Id: <20230703100520.68224-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703100520.68224-1-richard.henderson@linaro.org>
References: <20230703100520.68224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
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



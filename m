Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC817459A8
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:07:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGRN-0002jN-N4; Mon, 03 Jul 2023 06:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRI-0002eO-Ni
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:05:48 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRF-0005rR-0H
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:05:48 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3143b70d6easo206569f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688378741; x=1690970741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yB3KjFB+U9E0IGbPxBILX7NHTWOiWyWbVzWyod1A2Y=;
 b=joR4m/ClJeRpoob+t5+QnStkdNFoxeTqfQX2yViVC46KO8kYWovTf89P8V7IYr+Oos
 EvFwMsu2XhPCpfSYyOyj197LvUN+uyCBja2AyU9fy3uoIrlrnS4KRBC0izuUzOzHYgbm
 smVoL85LinnLzkiXD+MISmbYxQWwCe6bjaY81jTj2uBWzQXqHnorTvcc7i4CS7qx5iQx
 OoQ2GqgjtBUrJwRByW8dE1iDFMOBnuZcNz4kaO2RiClgTvzKykzFAEnfgWrJbFR2mg5t
 12oVanW9YC6tUBLRtS4MOWkZOPJTlweeCB+/D7QSfC/GHQi/rciO8hVKTc0Nx5POIjV4
 JuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688378741; x=1690970741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yB3KjFB+U9E0IGbPxBILX7NHTWOiWyWbVzWyod1A2Y=;
 b=i1rjH2EwaqaPcx7e14+6dD9Pe4whslcEBvUxHMVb8/JVnP2v2AAoKNGuzHV4/FYu1p
 8t63HE/GdHslYdDMjFdu/AgEA7orlLHKlLIKO84lrd3PuCt5BIpTgE7myz3oz6PfQrbm
 88c5u12xuDYt3Vphzo2JWg7UsmlDzIbtakWrASL4ejr6EKgdlrjtm9KrJiKBij5+Rlda
 yivmTeh+CuUU3xLFiEcbazXxH53r+IA1IgqXe+6RXybwo1Sj8XB1SGKfpCAdgzPQczk8
 o4c7BCwvcIpEGNrUDDCAQpBBTYPsSp28AT8reXsk2RH0xWWSjUofBOh3lhhHzFlmfhWm
 OhLA==
X-Gm-Message-State: ABy/qLZxcO4pKq9W4zC0NCEA2BSNysOdlnTyZfKSz8Z8ry1drg4QCaWS
 1Y4lNoorpFbt4NTMuivOs3kpyKOjprgbT4wocXTKrg==
X-Google-Smtp-Source: APBJJlHffpZ/OpXAg7uvfnKlL79jVR66Kr1p0PZ5UUI3MDUX1zaZmuOHzdNIR1rkyMBOUNq+40mtcg==
X-Received: by 2002:adf:fd43:0:b0:313:f5f8:a331 with SMTP id
 h3-20020adffd43000000b00313f5f8a331mr8284810wrs.34.1688378740035; 
 Mon, 03 Jul 2023 03:05:40 -0700 (PDT)
Received: from stoup.home (91.232.79.188.dynamic.jazztel.es. [188.79.232.91])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm18446562wrx.59.2023.07.03.03.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:05:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com
Subject: [PATCH v4 17/37] target/ppc: Use aesenc_SB_SR_MC_AK
Date: Mon,  3 Jul 2023 12:05:00 +0200
Message-Id: <20230703100520.68224-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703100520.68224-1-richard.henderson@linaro.org>
References: <20230703100520.68224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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

This implements the VCIPHER instruction.

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
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



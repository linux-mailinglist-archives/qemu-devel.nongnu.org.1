Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3B3736A69
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:10:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZE3-0006Zg-Ql; Tue, 20 Jun 2023 07:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDx-0006RB-M0
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:37 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDu-0004Rc-KC
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:37 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-987c932883bso520335966b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 04:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687259313; x=1689851313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yB3KjFB+U9E0IGbPxBILX7NHTWOiWyWbVzWyod1A2Y=;
 b=vIDZqQ+4qe8OfzkAge7xCSI/gHQxa6IjBuJ2+qDZVO1bE+E4n5NoZ0KruDEvQ/iu4H
 vqsE9jdY584U3DIW4vSlMxtm8XPltTRgLUdvLmLZ/sqsK9qvXVhhbwQEAig9P6m/NWp8
 uhzXLFSJ3deDlq/aanAN4OMHQyj/O5T2rOD+fU5eDi1qqE25XM+LGwERs8f85PXNDSPB
 aLAEwfL/p6/0/1tOAPrCz4z5NFo74oQWGj8iOrrniysdXeW0Hult1A8QBAjWsYaa9m/L
 Q8TKjkEX2PUtQRVUxQ6VBdkC6TGjtOj9nHGAuzw4aoVYev5Qe8gfUjYDgBa+Z3WngMEE
 WRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687259313; x=1689851313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yB3KjFB+U9E0IGbPxBILX7NHTWOiWyWbVzWyod1A2Y=;
 b=d98COWajZSMmOWMo21TpCNEMesk0S4vQNW5hcFUUtYpcl1z2HFQwioK+WrEaJb+xwq
 fBtzqafIQ/DuPM371uhfNQJxuc7DwbwXOZdHKh/zzDF8KUs9NPIx5/Pj8FacReDjvwqq
 2BcA7omds+NGNIem1r0aXx5qqZwSUT6P3lllip9NApe/c7XQTPYq+Q9nQx1/k2HbGkDd
 YNMf9WfnWmsgXqqHck1RCsmvHUPDPHm8BmxlRc+F/PREwNo3++ns1nA6TpwpV/DXsSVa
 jtOaRP2avc32rROFzeSuFjmiT2sTb2vel9BvgUYns40dcd6cTSQ8yh5zsewzY4vI21VU
 r5og==
X-Gm-Message-State: AC+VfDwxeePa8KJcLZj1le7aCFs00huNG+Lm2I7/IpJEHc8QMQxK7Ykx
 X8gTfuBECKOxH8pumFgH7u0fvdz2CqgQoNtQp2JailN0
X-Google-Smtp-Source: ACHHUZ7i5k36M/kTVM2zRCSGP7C3AxZz7lcgP7R3n/Uwu/qqfgPGYSPaQ5UnhxDLBZQOyoOmQs36Kw==
X-Received: by 2002:a17:907:7f14:b0:989:1f66:e44f with SMTP id
 qf20-20020a1709077f1400b009891f66e44fmr1620173ejc.11.1687259313240; 
 Tue, 20 Jun 2023 04:08:33 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 x17-20020a170906711100b009884f015a44sm1170687ejj.49.2023.06.20.04.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 04:08:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v3 24/37] target/ppc: Use aesenc_SB_SR_MC_AK
Date: Tue, 20 Jun 2023 13:07:45 +0200
Message-Id: <20230620110758.787479-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620110758.787479-1-richard.henderson@linaro.org>
References: <20230620110758.787479-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62c.google.com
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F46B7459BD
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:10:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGS0-0003BT-Mx; Mon, 03 Jul 2023 06:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRX-0002uc-Tx
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:06:03 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRH-0005sC-E2
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:06:03 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-313e09a5b19so3499828f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688378744; x=1690970744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vdmp9g0LETEOImAoeAZ0vz3CHG5eCYIT92dyMVPeN7s=;
 b=lIzVhNtoj5F6bRYtVeKVIjArwvK6p7enSfe9GQjPkN+NfKlT1zcL1UvFfCFN+izCFz
 cWoLsKc3Sz7bUS0s1wGImM+eKWSmqwB/JJDwOpO3oxgqvS+DkN1XjbdYrUQE0ujpdInG
 3Uz6YB9EMIcYsPNAUOa4zA+ztXge+Tac9FQVFERyZkpU2E24zaHscJMhd2SB2Py1PTHG
 N1Nehrc+LK7o7r2DzeYjDY9tkQKh58PFvJejUFXpxOSoZgrktPcqgk3oN6Jga0e1+n/Q
 z8fAnBu/xVCwsjN/mP4wiFRsjxGsxWaZD3r5oJTjHkLHywdXtAeFzC9EQ73G7kpLEG3K
 NMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688378744; x=1690970744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vdmp9g0LETEOImAoeAZ0vz3CHG5eCYIT92dyMVPeN7s=;
 b=DECnYmBP4WGEQRPTg51qIlCS6qAFmdcIkMu7RJQVACAIH4TwQYS/yT9GSCDvJuFV1U
 ezo4l6CVEBNuFo1t76NZljHr1Qv6p64h9W8EacUluo0wT/RAPNAKlUdne0eGS5rknRhw
 mZe87cNP6DXP45uI89QuKAoOKOr6jQ6wvaTXQj1vL7aQK3of8cRoNeD8KhBFognk5Frj
 c/8qWXg7mJoyHprwcUW5uLM/AbqGOImc0w3kY7YdbvuzuZ1gTdprplkx2+J3ndijGgrR
 bFbJe6anVOLSuPayb/7F9tzKM1MpK3AVp9JqK6w7TchG2+Gg5vtNkaMiShmavlixirVz
 EB9g==
X-Gm-Message-State: ABy/qLZJnrT3vji/O87Ubp/QoeeXDkLAVx5Jn5Rtu4ZJ57Cxnw29D+7t
 rOn2qVoA57OIwx3ickXzEfyqfPBZQ4mnZYqoTpR4tw==
X-Google-Smtp-Source: APBJJlEse5ck8aUfC8LmxRLx5Z3E2hvsQXNMv5ofp9reBryWphZa+Ky21MEAG5qCXNpXYc/cKrwV2A==
X-Received: by 2002:a5d:660b:0:b0:314:c6b:b9a2 with SMTP id
 n11-20020a5d660b000000b003140c6bb9a2mr9401053wru.13.1688378744098; 
 Mon, 03 Jul 2023 03:05:44 -0700 (PDT)
Received: from stoup.home (91.232.79.188.dynamic.jazztel.es. [188.79.232.91])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm18446562wrx.59.2023.07.03.03.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:05:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 20/37] target/i386: Use aesdec_ISB_ISR_AK
Date: Mon,  3 Jul 2023 12:05:03 +0200
Message-Id: <20230703100520.68224-21-richard.henderson@linaro.org>
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

This implements the AESDECLAST instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/ops_sse.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 63fdecbe03..0a37bde595 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2177,12 +2177,12 @@ void glue(helper_aesdec, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 
 void glue(helper_aesdeclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
-    int i;
-    Reg st = *v;
-    Reg rk = *s;
+    for (int i = 0; i < SHIFT; i++) {
+        AESState *ad = (AESState *)&d->ZMM_X(i);
+        AESState *st = (AESState *)&v->ZMM_X(i);
+        AESState *rk = (AESState *)&s->ZMM_X(i);
 
-    for (i = 0; i < 8 << SHIFT; i++) {
-        d->B(i) = rk.B(i) ^ (AES_isbox[st.B(AES_ishifts[i & 15] + (i & ~15))]);
+        aesdec_ISB_ISR_AK(ad, st, rk, false);
     }
 }
 
-- 
2.34.1



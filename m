Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E50C37459D6
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:13:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGRa-0002ws-3c; Mon, 03 Jul 2023 06:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRN-0002k9-2I
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:05:53 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRG-0005rt-3f
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:05:52 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbc244d307so49220025e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688378743; x=1690970743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fCbxuyj6w2doHmBool/Ak6eLq+V5O+przb+5Ur/gE60=;
 b=Dt/EC/uU7ECskHqfbxVRsmJj/DB5u2mG5aGX6ZEsCxE3kuWl/Fpg10kenXBGS0sBvP
 wg1EDXvuWX/FgO7xvuOst7WQcYzUDEBq23gGK+4pd11CFF/P0f/SX4155OoY609HfluI
 /DQ+Oz0HrECWZrKX/D0EbxOf15NKAWXhidKOiEe8VCCYMyKSUmDM5cHInH9VZMnkVJZR
 znobaGaw9OuD8aY+hgNI8dcmqaN+KBLbx2Tc+0vx60HNwH6OwS+8KCs8udU55yZVxNpe
 VAjEiYAZ20rwmKOyd0oAh9feZMMqmkUZt4X66RGZrOb6jrVy8Ke1XWeE92W1BsS65Wog
 D2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688378743; x=1690970743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fCbxuyj6w2doHmBool/Ak6eLq+V5O+przb+5Ur/gE60=;
 b=QwV5WC325UGlwKN2zoOWp5lCBrbrIHoKdPTC1lBDr3eoIielnYiWbiYBJp9kAWTDtq
 fQnRgUXX2H9Kven1n0znQ54Uomej8slRG8vWw7Ty6n96WYfkQw/JL8keF1tsmbbWqLO5
 1+EdlMEDZQ4+C5wyXfi/Pi8NHnVYeW2qxT6Kz8vLp+/g8NqZP7rZ3NKMOrBfVhUE1Jqr
 oClCpyuojP3kpGQ5inh/8BwOi4ijNkpECzdBsQePZ9IPLOjQiukqofMA37jIlhnYPhok
 t2NicGd13GIr/vg2msjmrbPP5A4z2nDddGztUPXGJJzFleS9VRPxDcEbcx4Bk+0ATHVH
 UIRA==
X-Gm-Message-State: AC+VfDzmmDaJ9tWKZ+vWDvazrLSybTjbAEgs6WLNdWXin33lzfPfBqpV
 sRDVqiO0guYcooPLcDP06KEZ475t3z8nMtFtwIfZJQ==
X-Google-Smtp-Source: ACHHUZ5GUFJHOeweeCXtCVa6V4ThFrA2gcoi0NIX9+l4Snpj/FyIaxmCJTz2MInnSTxH/hRKpy/KMQ==
X-Received: by 2002:a7b:ce94:0:b0:3fb:a266:3a34 with SMTP id
 q20-20020a7bce94000000b003fba2663a34mr9438164wmj.12.1688378743037; 
 Mon, 03 Jul 2023 03:05:43 -0700 (PDT)
Received: from stoup.home (91.232.79.188.dynamic.jazztel.es. [188.79.232.91])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm18446562wrx.59.2023.07.03.03.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:05:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 19/37] target/i386: Use aesenc_SB_SR_AK
Date: Mon,  3 Jul 2023 12:05:02 +0200
Message-Id: <20230703100520.68224-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703100520.68224-1-richard.henderson@linaro.org>
References: <20230703100520.68224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

This implements the AESENCLAST instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/ops_sse.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index fb63af7afa..63fdecbe03 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -19,6 +19,7 @@
  */
 
 #include "crypto/aes.h"
+#include "crypto/aes-round.h"
 
 #if SHIFT == 0
 #define Reg MMXReg
@@ -2202,12 +2203,12 @@ void glue(helper_aesenc, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 
 void glue(helper_aesenclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
-    int i;
-    Reg st = *v;
-    Reg rk = *s;
+    for (int i = 0; i < SHIFT; i++) {
+        AESState *ad = (AESState *)&d->ZMM_X(i);
+        AESState *st = (AESState *)&v->ZMM_X(i);
+        AESState *rk = (AESState *)&s->ZMM_X(i);
 
-    for (i = 0; i < 8 << SHIFT; i++) {
-        d->B(i) = rk.B(i) ^ (AES_sbox[st.B(AES_shifts[i & 15] + (i & ~15))]);
+        aesenc_SB_SR_AK(ad, st, rk, false);
     }
 }
 
-- 
2.34.1



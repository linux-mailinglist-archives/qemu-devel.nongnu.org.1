Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1EB78412C
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 14:48:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYQnz-0006I5-5K; Tue, 22 Aug 2023 08:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQnY-00068I-Mz
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:47:52 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQnI-0007oY-Ms
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:47:40 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31c479ede21so1920238f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 05:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692708454; x=1693313254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBpzt013+vp8Kmg/CJj+CKt+5qMLkjaonY59s06tes8=;
 b=yRNqcUCa7AkrXPdM2BolYheuqrp6sp9ldEw8W7xk21yT1ELqMcYf92yArcOmD+Hr7R
 4KTFBCue9V2r3qvte8E81INaZ1BGM3zcv3bR0GVRh30XAupzkChsuUQcocho0aBZ8sWh
 xc4GVKUXRl50UBYrFN/pyoqOiIb47EN+FEMTVWUggrS/nhD9Jge853ky3l7A0b5SFXX5
 noP2yE3Mt/goOUIHzObBtYu4307qQiA5UB8Gvm8hDB8RgdErj9MXP8lZPsY5aA/ZPQg8
 fe5aSZydJZxE95FjDgUb3EYZb1cK9EZFRo/g/b1GcYU8QERjhD2eCgOuqA2lvFjDdWuw
 Zjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692708454; x=1693313254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jBpzt013+vp8Kmg/CJj+CKt+5qMLkjaonY59s06tes8=;
 b=l1GrxrikDF+YQvev2H5Do1vXVZuTWOz0pkNU9Jdqr0NA+5J5EJwCS4Wx5sc7RkrZAM
 3zf/d461+SXzv4IuLRJ6u1ACkJX9wMLn8y0ePa+tSvzWFz0xwXuGaKwdgNZxOCfVbUoY
 cT4l57pv17A1UmNvGCNemvyb1iG9+OcdhSnlmW/CSwAtCMf1rJfvqUTXwcu/ID3sA+Th
 daLx85ZCfWvW3jdKu1I4bnoAXFWWrMLcmcprQNA+ZUIDZAsq92pMUvMuFB3WuLR/d1pl
 ACeHliMAHdsNP+UtgjmQ11MJ0ktauzksoCNv/9LPv+l/DdFL9hTzkLgYULBHZVIZ9lxm
 hVsg==
X-Gm-Message-State: AOJu0Yz19EQgVLqMUvUZ6qsj1BPvAUsx/XTB2Ki5VZq78yfzv9WEWYGK
 p7LxyNuumle0oS1gFD0+iCtCHH7XC3dRpo2ylQ6nug==
X-Google-Smtp-Source: AGHT+IEhJ2Mr63m9sNJBgrT+by1Msjx/0/r0zLDG8QgIRCnDK3lSyS2/AATwfhlzRiprhrje4nEDzw==
X-Received: by 2002:adf:ce82:0:b0:319:a24:8d6b with SMTP id
 r2-20020adfce82000000b003190a248d6bmr7119059wrn.14.1692708454656; 
 Tue, 22 Aug 2023 05:47:34 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a5d4b02000000b0031aca6cc69csm15865908wrq.2.2023.08.22.05.47.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 05:47:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Greg Kurz <groug@kaod.org>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/12] tcg/tcg-op: Add tcg_gen_hrev32_i64() and
 tcg_gen_hrev_i64()
Date: Tue, 22 Aug 2023 14:47:28 +0200
Message-ID: <20230822124728.54935-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822124042.54739-1-philmd@linaro.org>
References: <20230822124042.54739-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

tcg_gen_hrev32_i64() is similar to tcg_gen_hrev64_i64() but
only modifies the lower 32-bit of a 64-bit value.

tcg_gen_hrev_i64() can be used when we don't know at build
time whether to clear the 32 high bits of the value or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/tcg-ops.rst      |  4 +++
 include/tcg/tcg-op-common.h |  2 ++
 include/tcg/tcg-op.h        |  2 ++
 tcg/tcg-op.c                | 49 +++++++++++++++++++++++++++----------
 4 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index e8a2f8aacc..3a8104929c 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -496,6 +496,10 @@ Misc
 
      - | Byteswap each halfword within a 32/64-bit value.
 
+   * - hrev32_i64 *t0*, *t1*
+
+     - | Byteswap each halfword on the low bits of a 64-bit value.
+
    * - hswap_i32/i64 *t0*, *t1*
 
      - | Swap 16-bit halfwords within a 32/64-bit value.
diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index a9184caf9d..eb327ed964 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -562,7 +562,9 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
+void tcg_gen_hrev32_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hrev64_i64(TCGv_i64 ret, TCGv_i64 arg);
+void tcg_gen_hrev_i64(TCGv_i64 ret, TCGv_i64 arg, int is64);
 void tcg_gen_smin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index d63683c47b..3ac1d13b19 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -225,6 +225,7 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
 #define tcg_gen_bswap_tl tcg_gen_bswap64_i64
 #define tcg_gen_hswap_tl tcg_gen_hswap_i64
 #define tcg_gen_wswap_tl tcg_gen_wswap_i64
+#define tcg_gen_hrev32_tl tcg_gen_hrev32_i64
 #define tcg_gen_concat_tl_i64 tcg_gen_concat32_i64
 #define tcg_gen_extr_i64_tl tcg_gen_extr32_i64
 #define tcg_gen_andc_tl tcg_gen_andc_i64
@@ -340,6 +341,7 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
 #define tcg_gen_bswap32_tl(D, S, F) tcg_gen_bswap32_i32(D, S)
 #define tcg_gen_bswap_tl tcg_gen_bswap32_i32
 #define tcg_gen_hswap_tl tcg_gen_hswap_i32
+#define tcg_gen_hrev32_tl tcg_gen_hrev32_i32
 #define tcg_gen_concat_tl_i64 tcg_gen_concat_i32_i64
 #define tcg_gen_extr_i64_tl tcg_gen_extr_i64_i32
 #define tcg_gen_andc_tl tcg_gen_andc_i32
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 310acce410..75892e91ef 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1931,6 +1931,41 @@ void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_rotli_i64(ret, arg, 32);
 }
 
+/*
+ * hrev_i64: Byteswap each halfwords within a 64-bit value.
+ *           If %is64 is not set, the 32 high bits are zeroed.
+ *
+ * Byte pattern:  hrev_i64(xxxxabcd, 0) -> ....badc
+ *                hrev_i64(abcdefgh, 1) -> badcfehg
+ */
+void tcg_gen_hrev_i64(TCGv_i64 ret, TCGv_i64 arg, int is64)
+{
+    TCGv_i64 mask = tcg_constant_i64(is64 ? 0x00ff00ff00ff00ffull : 0x00ff00ff);
+    TCGv_i64 t1 = tcg_temp_ebb_new_i64();
+    TCGv_i64 t2 = tcg_temp_ebb_new_i64();
+
+                                        /*        is64=0      is64=1  */
+                                        /* arg = xxxxabcd    abcdefgh */
+    tcg_gen_shri_i64(t1, arg, 8);       /*  t1 = .xxxxabc    .abcdefg */
+    tcg_gen_and_i64(t2, t1, mask);      /*  t2 = .....a.c    .a.c.e.g */
+    tcg_gen_and_i64(t1, arg, mask);     /*  t1 = .....b.d    .b.d.f.h */
+    tcg_gen_shli_i64(t1, t1, 8);        /*  t1 = ....b.d.    b.d.f.h. */
+    tcg_gen_or_i64(ret, t1, t2);        /* ret = ....badc    badcfehg */
+
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+}
+
+/*
+ * hrev32_i64: Byteswap each halfword on the low bits of a 64-bit value.
+ *
+ * Byte pattern:  hrev32_i64(xxxxabcd) -> ....badc
+ */
+void tcg_gen_hrev32_i64(TCGv_i64 ret, TCGv_i64 arg)
+{
+    tcg_gen_hrev_i64(ret, arg, false);
+}
+
 /*
  * hrev64_i64: Byteswap each halfwords within a 64-bit value.
  *
@@ -1938,19 +1973,7 @@ void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg)
  */
 void tcg_gen_hrev64_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    TCGv_i64 mask = tcg_constant_i64(0x00ff00ff00ff00ffull);
-    TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-    TCGv_i64 t2 = tcg_temp_ebb_new_i64();
-
-                                        /* arg = abcdefgh */
-    tcg_gen_shri_i64(t1, arg, 8);       /*  t1 = .abcdefg */
-    tcg_gen_and_i64(t2, t1, mask);      /*  t2 = .a.c.e.g */
-    tcg_gen_and_i64(t1, arg, mask);     /*  t1 = .b.d.f.h */
-    tcg_gen_shli_i64(t1, t1, 8);        /*  t1 = b.d.f.h. */
-    tcg_gen_or_i64(ret, t1, t2);        /* ret = badcfehg */
-
-    tcg_temp_free_i64(t1);
-    tcg_temp_free_i64(t2);
+    tcg_gen_hrev_i64(ret, arg, true);
 }
 
 void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg)
-- 
2.41.0



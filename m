Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B34784105
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 14:42:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYQh6-0006KS-NR; Tue, 22 Aug 2023 08:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQh2-0006Iw-5O
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:41:08 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQgz-0005ZQ-J9
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:41:07 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so3895586f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 05:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692708063; x=1693312863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nsvUqHlFX1jn4aW9Gaw9PjawxbooLIqjbrbXDvQlkNQ=;
 b=MojuRq3FcpEf1spcBl2fm+knldksxR4XIvwkbCZDoW/kyW6EKK2Aq2JsjcSw4SsnGS
 3Ei0IW0w2y3nXhtD47WGgg5chYQMHz8JuUGVok00ftlwd2RA/AzKGgmpVRaQg/nH8mXS
 sfZJooNcH2Uf0albij0xzSD17WVUA+vGUOhdV3Mqt46lKc5kg2Vw+4bFsj3X97Z2qjG6
 TuNu0Tr4geaYFMjoFsUbDSuQtxinxoYM0SpGzzAUoNC1n0yHJAUcPw+p4rGp0Fr722YQ
 DKMj+PXIbDc73wqMsAKWaCugRD0i/UjJZ32GkP6q0VWfpew4ujfPWS5Wl/NR9FDe3WVr
 2GTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692708063; x=1693312863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nsvUqHlFX1jn4aW9Gaw9PjawxbooLIqjbrbXDvQlkNQ=;
 b=Y8fUrRswKqLYN6il18in6zj0zT30GnwGpBGC204whsDurlVKQ9Oly6X51+rbUVVrd/
 sRtUci/XUL8pLsU0ipbnJ0vo7Ds30aZQ0qp/6HX4jYho9+10TBJxw6HA3BPWcAmuOddy
 pyVUi+fASUPELQWj4F2dRAfrRaDE02uOrcASfbH8tFbVhCGp3CDnkG38511nMKXlbmgD
 vjWAVNWwhM/E38xq3Fg5BOhrHlXpX1Q5pJ/g7JAkZb0YQYn+Nqu6wniTs5RoMhRRWqGp
 1xC6ZahYUP6jfntGcXJAoTPpcrlIX+2EJM9WzvgLl6WEVJOugx3mBPijSn9Uah4P9Gii
 JHzA==
X-Gm-Message-State: AOJu0Yy2pwBH6QGP2dKpAXIph4x8hytexzTnfo/zisuPGbDnxUBo+wz7
 lk0B/xeZi9a2iwJAnLQeBN6RDfz9bbrsLFCQR2/5Rw==
X-Google-Smtp-Source: AGHT+IFXcp7PpI6NQt0baty1G8NK68D6J0m5F9ngxPegcQNZfqWiaXYFHOnDnY6pvA4cXo0m1x/y4g==
X-Received: by 2002:adf:f70c:0:b0:317:5af3:caa4 with SMTP id
 r12-20020adff70c000000b003175af3caa4mr7256713wrp.38.1692708063580; 
 Tue, 22 Aug 2023 05:41:03 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 r15-20020a056000014f00b0031ad5a54bedsm15923239wrx.9.2023.08.22.05.41.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 05:41:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Greg Kurz <groug@kaod.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, qemu-arm@nongnu.org
Subject: [PATCH 02/12] target/arm: Use generic hrev32_i32() in ARM REV16 and
 VREV16 opcodes
Date: Tue, 22 Aug 2023 14:40:32 +0200
Message-ID: <20230822124042.54739-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822124042.54739-1-philmd@linaro.org>
References: <20230822124042.54739-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/translate-a32.h  |  1 -
 target/arm/tcg/translate-neon.c |  2 +-
 target/arm/tcg/translate.c      | 14 +-------------
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-a32.h b/target/arm/tcg/translate-a32.h
index 0c8f408eea..6cc02c83b9 100644
--- a/target/arm/tcg/translate-a32.h
+++ b/target/arm/tcg/translate-a32.h
@@ -45,7 +45,6 @@ void gen_lookup_tb(DisasContext *s);
 long vfp_reg_offset(bool dp, unsigned reg);
 long neon_full_reg_offset(unsigned reg);
 long neon_element_offset(int reg, int element, MemOp memop);
-void gen_rev16(TCGv_i32 dest, TCGv_i32 var);
 void clear_eci_state(DisasContext *s);
 bool mve_eci_check(DisasContext *s);
 void mve_update_eci(DisasContext *s);
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 0e59b03ff9..9489dc0b3e 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -3528,7 +3528,7 @@ static bool trans_VREV16(DisasContext *s, arg_2misc *a)
     if (a->size != 0) {
         return false;
     }
-    return do_2misc(s, a, gen_rev16);
+    return do_2misc(s, a, tcg_gen_hrev32_i32);
 }
 
 static bool trans_VCLS(DisasContext *s, arg_2misc *a)
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 39a42611c6..4ebf04f4de 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -416,18 +416,6 @@ static void gen_smul_dual(TCGv_i32 a, TCGv_i32 b)
     tcg_gen_mov_i32(a, tmp1);
 }
 
-/* Byteswap each halfword.  */
-void gen_rev16(TCGv_i32 dest, TCGv_i32 var)
-{
-    TCGv_i32 tmp = tcg_temp_new_i32();
-    TCGv_i32 mask = tcg_constant_i32(0x00ff00ff);
-    tcg_gen_shri_i32(tmp, var, 8);
-    tcg_gen_and_i32(tmp, tmp, mask);
-    tcg_gen_and_i32(var, var, mask);
-    tcg_gen_shli_i32(var, var, 8);
-    tcg_gen_or_i32(dest, var, tmp);
-}
-
 /* Byteswap low halfword and sign extend.  */
 static void gen_revsh(TCGv_i32 dest, TCGv_i32 var)
 {
@@ -7578,7 +7566,7 @@ static bool trans_REV16(DisasContext *s, arg_rr *a)
     if (!ENABLE_ARCH_6) {
         return false;
     }
-    return op_rr(s, a, gen_rev16);
+    return op_rr(s, a, tcg_gen_hrev32_i32);
 }
 
 static bool trans_REVSH(DisasContext *s, arg_rr *a)
-- 
2.41.0



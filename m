Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35831784109
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 14:42:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYQhf-0006cC-Vs; Tue, 22 Aug 2023 08:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQhW-0006YH-8M
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:41:39 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQhO-0005j9-6q
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:41:34 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-317716a4622so4013273f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 05:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692708088; x=1693312888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xMymSiH1goSxgVN9+Y6AclUCQc+KR5ymy+nGsoSz5Is=;
 b=KQGYxXdM1kqQuEKU+AccY9G/3yCzuNZWnVjm7dnZokH6MYYqG6PYW9fNF9pZt6X+c2
 ZoyM4ccApJ+QnM+dKgL9vemOsLjwhfsMfj/642ApTN5fyaROVCpxWh3EslC5wOvAZSxj
 nLXTFy7bFW4rGgJatmUwBpkW9MQvQhHEa5SYP8QCN6e/Oo+r02ivLGkSKlLY3juH69B1
 mTw8PJ66Gs5bkilPhO8nkVvQNUOvxJLuf9YfxyGkVq8ycwrOPVKtHHrvIYZtm88ELVdR
 5//v+CxEZkFSVuutsbBQoDtvUob8J/9hL/9YpQiAH0PMuy5UhXcRZC48pr6pNzzTbOsI
 KD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692708088; x=1693312888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xMymSiH1goSxgVN9+Y6AclUCQc+KR5ymy+nGsoSz5Is=;
 b=LHRvi5spMOMhdvPpZkJeE3KjiwJEQbQCFz54iIPLfYcic8MiEbPmGsYgh9SIVBGYr6
 9LJf9vVDA4t0UMi8V7Jy8uxLguEbp77+E7ruVxOQWdsThE884Nscvr15rLAiokI4zh8o
 NFFhCNWnk6PLA+/eildg7qoBc8HMZVkvyVrosQfMRkYbWKgqe1pDvm15w5j+wvZk5ScB
 lWla38grmLKC7laR8VOKuEem4nHsPkFl+do34ejBcR+EPC++1V5ZXUKIGV+wTWtd+WX/
 VidLQrClZ/28jv6esrgUeZd+rMXNMK1y377cLZJee0A3aaxFEJJtTCMz945ek49BzsKQ
 /qxw==
X-Gm-Message-State: AOJu0Yyx+MF5LS3bi2SsEQ8MsS3H+CPjU8qRYxfr7jOIr0v3YTUE/cIX
 /7ujfSPVNJvwGeZxVK/7CTspeAYqJXTVL1Qcd/9SOg==
X-Google-Smtp-Source: AGHT+IFJTlYTZcUm1ZPOUb4GXKObf7c7mJlFUEB4CkskfMvMEXI48VczwKkoheD1Yn879pLae5qiQQ==
X-Received: by 2002:a5d:4691:0:b0:319:8bb3:ab8a with SMTP id
 u17-20020a5d4691000000b003198bb3ab8amr6663897wrq.52.1692708088283; 
 Tue, 22 Aug 2023 05:41:28 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 21-20020a05600c22d500b003fee777fd84sm10913972wmg.41.2023.08.22.05.41.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 05:41:27 -0700 (PDT)
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
Subject: [PATCH 05/12] tcg/tcg-op: Factor tcg_gen_hrev64_i64() out
Date: Tue, 22 Aug 2023 14:40:35 +0200
Message-ID: <20230822124042.54739-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822124042.54739-1-philmd@linaro.org>
References: <20230822124042.54739-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Similarly to tcg_gen_hrev32_i32() for 32-bit values,
extract tcg_gen_hrev64_i64() for 64-bit ones.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/tcg-ops.rst      |  4 +++-
 include/tcg/tcg-op-common.h |  1 +
 tcg/tcg-op.c                | 29 +++++++++++++++++++++++------
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 17965faa03..e8a2f8aacc 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -492,7 +492,9 @@ Misc
 
    * - hrev32_i32 *t0*, *t1*
 
-     - | Byteswap each halfword within a 32-bit value.
+       hrev64_i64 *t0*, *t1*
+
+     - | Byteswap each halfword within a 32/64-bit value.
 
    * - hswap_i32/i64 *t0*, *t1*
 
diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index bb515dfd51..a9184caf9d 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -562,6 +562,7 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
+void tcg_gen_hrev64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_smin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b1b5d9b45b..310acce410 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1876,12 +1876,7 @@ void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg)
         TCGv_i64 t2 = tcg_temp_ebb_new_i64();
 
                                         /* arg = abcdefgh */
-        tcg_gen_movi_i64(t2, 0x00ff00ff00ff00ffull);
-        tcg_gen_shri_i64(t0, arg, 8);   /*  t0 = .abcdefg */
-        tcg_gen_and_i64(t1, arg, t2);   /*  t1 = .b.d.f.h */
-        tcg_gen_and_i64(t0, t0, t2);    /*  t0 = .a.c.e.g */
-        tcg_gen_shli_i64(t1, t1, 8);    /*  t1 = b.d.f.h. */
-        tcg_gen_or_i64(ret, t0, t1);    /* ret = badcfehg */
+        tcg_gen_hrev64_i64(ret, arg);   /* ret = badcfehg */
 
         tcg_gen_movi_i64(t2, 0x0000ffff0000ffffull);
         tcg_gen_shri_i64(t0, ret, 16);  /*  t0 = ..badcfe */
@@ -1936,6 +1931,28 @@ void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_rotli_i64(ret, arg, 32);
 }
 
+/*
+ * hrev64_i64: Byteswap each halfwords within a 64-bit value.
+ *
+ * Byte pattern:  hrev64_i64(abcdefgh) -> badcfehg
+ */
+void tcg_gen_hrev64_i64(TCGv_i64 ret, TCGv_i64 arg)
+{
+    TCGv_i64 mask = tcg_constant_i64(0x00ff00ff00ff00ffull);
+    TCGv_i64 t1 = tcg_temp_ebb_new_i64();
+    TCGv_i64 t2 = tcg_temp_ebb_new_i64();
+
+                                        /* arg = abcdefgh */
+    tcg_gen_shri_i64(t1, arg, 8);       /*  t1 = .abcdefg */
+    tcg_gen_and_i64(t2, t1, mask);      /*  t2 = .a.c.e.g */
+    tcg_gen_and_i64(t1, arg, mask);     /*  t1 = .b.d.f.h */
+    tcg_gen_shli_i64(t1, t1, 8);        /*  t1 = b.d.f.h. */
+    tcg_gen_or_i64(ret, t1, t2);        /* ret = badcfehg */
+
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+}
+
 void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     if (TCG_TARGET_REG_BITS == 32) {
-- 
2.41.0



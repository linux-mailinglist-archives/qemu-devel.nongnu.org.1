Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB337CC328
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 14:27:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjAQ-0003MF-F6; Tue, 17 Oct 2023 08:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsjAK-0003Lj-Aq
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:27:16 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsjAB-0004o5-Lk
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:27:15 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32caaa1c493so4508185f8f.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697545626; x=1698150426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4HsOAhtJhsCXMgyIjrkIukQ3SKJyR2phPKk08rqYntg=;
 b=zDUuwAxzasQNmm5xhPglNqcOjKWJbj6HA7RJzDhZfN+8IL072zLX0vmK0NgM366blD
 At33Ve0bgcQSU7DJqGqnFwWlIfCBDF52JUxNT4d509JADt86k0dj2dbRkjnouMwqxZvE
 8k6D2XXjyr/DmbBNS18IjrU+nqxLNUIfzrbJAlXc7LtrCvkEc7jlnUs9ZeRlfghxTB2F
 qhd0HsgNf/t9ysmH5oG3Q6gm2UkM9q43Dl6k/fbD7Ha25y/O1Qi7WvS0D/tUASw2oag4
 p+JpGGwulVLWoFVPY2Z/m5mRGKG06oDg0zw2SvCjW2FE3v9EY43z5zj3rvpPgWwCvzJu
 /lSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697545626; x=1698150426;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4HsOAhtJhsCXMgyIjrkIukQ3SKJyR2phPKk08rqYntg=;
 b=lYtQvSerz1+No5EOj69WI4nvzHkQNlPZPLgOf/tVVgQ99biGBciXE2I7DzP6pmoQSn
 c+3S2LIcFXrEnCzXtl+7CYMk9FNz9buVStNuQs1dEpPJ2AZRp1VWDNZWxtxc0PYiGf5S
 ht/eER14BdyrmpDDP1IEGpKEOdZKprqulJP/0YweSU6QsLHM6j1KQtxK+BKDWx3VU6CL
 vBUZhU6vX4um4IbiXU6qKdZdyMMukns+FWyCGP3Rg13KHW/lCykxuj9OUZD8FeP1vK9s
 L5tWBrskv3e8Fk94PZKm5t2YMmLiYH0BRMF3WAaO6xOcpsIJsANJXklGNpTEzz+MVMJR
 lRUw==
X-Gm-Message-State: AOJu0YwpNNwP6hgH0iS2irIWZ6NLHgEiYYYloUFv5GzTvlc5cs64tL/k
 2vP41SfXAs+//y1zuimmP0Ov0i/M5P+rFd5pc2GLVg==
X-Google-Smtp-Source: AGHT+IFUTt2l20aTFooalCDf0sYtos1XbLV6EpPuG2s+9++0I5g2vSkQTIT/Ptmbg1Vr3bOwwdxbRA==
X-Received: by 2002:a5d:4052:0:b0:323:3b5f:3564 with SMTP id
 w18-20020a5d4052000000b003233b5f3564mr1858198wrp.10.1697545625895; 
 Tue, 17 Oct 2023 05:27:05 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 q18-20020a056000137200b003143867d2ebsm1575592wrz.63.2023.10.17.05.27.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Oct 2023 05:27:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] target/m68k: Use i128 for 128-bit load/store in
 m68k_copy_line()
Date: Tue, 17 Oct 2023 14:27:02 +0200
Message-ID: <20231017122702.39311-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Based-on: <20231013175109.124308-1-richard.henderson@linaro.org>
  tcg: Add tcg_gen_{ld,st}_i128

RFC because unsure and untested...
---
 target/m68k/translate.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 4d0110de95..1e3d155bd9 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4293,23 +4293,17 @@ DISAS_INSN(chk2)
 
 static void m68k_copy_line(TCGv dst, TCGv src, int index)
 {
+    MemOp mop = MO_128 | MO_TE;
+    TCGv_i128 t = tcg_temp_new_i128();
     TCGv addr;
-    TCGv_i64 t0, t1;
 
     addr = tcg_temp_new();
 
-    t0 = tcg_temp_new_i64();
-    t1 = tcg_temp_new_i64();
-
     tcg_gen_andi_i32(addr, src, ~15);
-    tcg_gen_qemu_ld_i64(t0, addr, index, MO_TEUQ);
-    tcg_gen_addi_i32(addr, addr, 8);
-    tcg_gen_qemu_ld_i64(t1, addr, index, MO_TEUQ);
+    tcg_gen_qemu_ld_i128(t, addr, index, mop);
 
     tcg_gen_andi_i32(addr, dst, ~15);
-    tcg_gen_qemu_st_i64(t0, addr, index, MO_TEUQ);
-    tcg_gen_addi_i32(addr, addr, 8);
-    tcg_gen_qemu_st_i64(t1, addr, index, MO_TEUQ);
+    tcg_gen_st_i128(t, addr, index);
 }
 
 DISAS_INSN(move16_reg)
-- 
2.41.0



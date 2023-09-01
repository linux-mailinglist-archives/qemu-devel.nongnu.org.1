Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 701E17902D6
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 22:32:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcAnS-00088n-1Q; Fri, 01 Sep 2023 16:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAnO-00086z-Cv
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:31:10 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAnK-0005Pb-U5
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:31:10 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c0d5b16aacso19508065ad.1
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 13:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693600265; x=1694205065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VN6l2cROyOIJzFYTqk3mQSzHqtpIGQeP6fwa2uvMk5I=;
 b=mlkChalYArBHuLVyfUFLhw5KKbAHJ5U58eCXE/J2sbxFSKqJhP7HhlS3nwbk0tDk3a
 T4ggddBQRA+xuTi2z6mmBpU/ZnX/DVVccrjRqfYb17X89xUvN0Q6MuJW5V6obvaQRd09
 IkoZeIYkx3ygKr7uRlXpgk+SxIn0KzkOtxaH4ASB0QObp1FML+ER6ZcpP8ldMLC7AzFY
 ebiLwTsEHm74/fXQpryImO7wUKBFHhxugmYBZf3F++kevkLjkrx1Gc0vXqLoL1Mjt2op
 qZoN4WQVpnh7V4ebdulZ9OortXWalrMOkMe8UBWIkpIHgZVfytnH/RZe/18hP8UFTWeY
 O8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693600265; x=1694205065;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VN6l2cROyOIJzFYTqk3mQSzHqtpIGQeP6fwa2uvMk5I=;
 b=HHIOX+fwe39bQpe/VZhsJlgvE2swO9AnZGh1kJghjPdPEW+iGtfi/ABJiCOTzmUKsY
 Ve0u47UrWKqQH7evZ+yq47+y6orTJHHzxM0yszCUaUmtVJeYXiytoV0CnjflPhgvjmuM
 9p86PoOnzNEZSsuoFfQZjSbWJ7+K149R4SNq14u2b4w2au5BP4QoVEzurT/Uy9bhhIGy
 naKm3cRUvjNu7KtLw30YkQnWQHPurdXvyGqMc3txGlgLvfBArjmYYn/VUsawgchZsn1X
 hi+4A4VaolqqwFxAyS9xmameTwDQNQDGfUlw4ovw6infyI4Tmv16/TposNvSDYOKNKtA
 jl5w==
X-Gm-Message-State: AOJu0Yzj81BiE5d3QBlz3nSFo8A0UNAunpXi3jMBO992PiUKHY6TkOoq
 +0UAUkFYyfQI5B3vcF1Y19vR+C208YkK6VOrNKI=
X-Google-Smtp-Source: AGHT+IFtFQWFXxQydjm4SbPah1uzvFkBlm9aMxiHtOH/gHrASiMrnd6yENR3hEuBAdFjz9QzhcllkQ==
X-Received: by 2002:a17:90b:150:b0:269:7eea:d7f6 with SMTP id
 em16-20020a17090b015000b002697eead7f6mr2917655pjb.49.1693600264674; 
 Fri, 01 Sep 2023 13:31:04 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 14-20020a17090a190e00b00262ca945cecsm5360373pjg.54.2023.09.01.13.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 13:31:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2] target/arm: Do not use gen_mte_checkN in trans_STGP
Date: Fri,  1 Sep 2023 13:31:03 -0700
Message-Id: <20230901203103.136408-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

STGP writes to tag memory, it does not check it.
This happened to work because we wrote tag memory first
so that the check always succeeded.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 41 +++++++++++++---------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0b77c92437..c5de176b8b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3020,37 +3020,17 @@ static bool trans_STGP(DisasContext *s, arg_ldstpair *a)
         tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
     }
 
-    if (!s->ata) {
-        /*
-         * TODO: We could rely on the stores below, at least for
-         * system mode, if we arrange to add MO_ALIGN_16.
-         */
-        gen_helper_stg_stub(cpu_env, dirty_addr);
-    } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
-        gen_helper_stg_parallel(cpu_env, dirty_addr, dirty_addr);
-    } else {
-        gen_helper_stg(cpu_env, dirty_addr, dirty_addr);
-    }
-
-    mop = finalize_memop(s, MO_64);
-    clean_addr = gen_mte_checkN(s, dirty_addr, true, false, 2 << MO_64, mop);
-
+    clean_addr = clean_data_tbi(s, dirty_addr);
     tcg_rt = cpu_reg(s, a->rt);
     tcg_rt2 = cpu_reg(s, a->rt2);
 
     /*
-     * STGP is defined as two 8-byte memory operations and one tag operation.
-     * We implement it as one single 16-byte memory operation for convenience.
-     * Rebuild mop as for STP.
-     * TODO: The atomicity with LSE2 is stronger than required.
-     * Need a form of MO_ATOM_WITHIN16_PAIR that never requires
-     * 16-byte atomicity.
+     * STGP is defined as two 8-byte memory operations, aligned to TAG_GRANULE,
+     * and one tag operation.  We implement it as one single aligned 16-byte
+     * memory operation for convenience.  Note that the alignment ensures
+     * MO_ATOM_IFALIGN_PAIR produces 8-byte atomicity for the memory store.
      */
-    mop = MO_128;
-    if (s->align_mem) {
-        mop |= MO_ALIGN_8;
-    }
-    mop = finalize_memop_pair(s, mop);
+    mop = finalize_memop_atom(s, MO_128 | MO_ALIGN, MO_ATOM_IFALIGN_PAIR);
 
     tmp = tcg_temp_new_i128();
     if (s->be_data == MO_LE) {
@@ -3060,6 +3040,15 @@ static bool trans_STGP(DisasContext *s, arg_ldstpair *a)
     }
     tcg_gen_qemu_st_i128(tmp, clean_addr, get_mem_index(s), mop);
 
+    /* Perform the tag store, if tag access enabled. */
+    if (s->ata) {
+        if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+            gen_helper_stg_parallel(cpu_env, dirty_addr, dirty_addr);
+        } else {
+            gen_helper_stg(cpu_env, dirty_addr, dirty_addr);
+        }
+    }
+
     op_addr_ldstpair_post(s, a, dirty_addr, offset);
     return true;
 }
-- 
2.34.1



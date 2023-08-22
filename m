Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4700783AC6
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:21:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLhq-0000I1-R2; Tue, 22 Aug 2023 03:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLhT-0008JO-LY
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:21:18 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLhL-0004vp-Md
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:21:15 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31963263938so3679920f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688862; x=1693293662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAyHO/pa2jDR5RbcTcrgjo8SGOZ1fzlP8kfH4UEF2HY=;
 b=RxUnpz6zon7HNhh58yEi69pIo/wnYgh92zY4slEwXXUWzMSQT4GEW+45nkPcXTEG3r
 8vIUdzFx8Ij04ln/J4XewqdoM+7ZrsKX9B+MdOXv2CPZfa4fGbId+ANawFNY/PG4prP3
 Bxn2TdSpwQbpxiTyANidrD5w6ARDIcjybHgRQhdRPsHgqPDmNL0+lONdpMqey2xx0xfA
 BK/J/YWugFZStOYAkF6CugUXphgIyHihVeIsy2wFk9YAWIJA3RfXVZUIiP6El2cy5xqy
 A+mt4TmyhcJEqkgY3FmkczyC7bW9EdAAoEpbyF8hFy5MHjLWpPOVWTZ9Df0zb01ni3FZ
 nBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688862; x=1693293662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GAyHO/pa2jDR5RbcTcrgjo8SGOZ1fzlP8kfH4UEF2HY=;
 b=f97GnkAXVHBe561OS8D0GHGduWMjTzLl9C3cXB5XKSiqD5pGQoBbRfaV67c3o4BwtC
 LU5pbC04A3kt82vCJb/Kvz+1g0vQNvorgf6iUVYEwQQWgw0YHAhOeb9hI3ZKW0KKNpRm
 C8ySepO5YwpO/98W/B+5xS2YeiekzRgYb0Mr3ho8Bx7cy/DEfuAuXL7dEWOjlDapA1k/
 2xEG+5NEGAy+F8nF/OavO2vh6cz24dOdGqWHsunfLUjSYZFvWF+XHKNgK0bW8lVbnYK7
 tIqjTs4HSZWDFqyBUlaapx9YUUhEnPuJ+Wu75lq6QMMX3G3/I/Kc1W8DbIXd8LWNT9GC
 xnRQ==
X-Gm-Message-State: AOJu0Yy0Ouq0cnXdGK47voGFid6fMQKmBub7rPV52ZVadI2V3jgEdHaC
 2XM3AGR/Rxqs5VqtuvBYztR6A50fcCp/k4lIb38XHw==
X-Google-Smtp-Source: AGHT+IFfKngRWgyVg+F3aPCX4Z2BZJ1Ep/oTD+rNMlX3RgxB+lL7syg7uIYmTg3X8RJUiGPG2EUONw==
X-Received: by 2002:a5d:560a:0:b0:314:3b02:a8a8 with SMTP id
 l10-20020a5d560a000000b003143b02a8a8mr5702430wrv.55.1692688862416; 
 Tue, 22 Aug 2023 00:21:02 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 z1-20020adfd0c1000000b003143c9beeaesm14871841wrh.44.2023.08.22.00.21.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:21:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Jiajie Chen <c@jia.je>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH RESEND v5 17/19] target/loongarch: Add avail_LAM to check
 atomic instructions
Date: Tue, 22 Aug 2023 09:19:57 +0200
Message-ID: <20230822071959.35620-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822071405.35386-1-philmd@linaro.org>
References: <20230822071405.35386-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Song Gao <gaosong@loongson.cn>

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20230822032724.1353391-14-gaosong@loongson.cn>
---
 target/loongarch/translate.h                  |  1 +
 .../loongarch/insn_trans/trans_atomic.c.inc   | 72 +++++++++----------
 2 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index f0d7b82932..faf4ce87f9 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -21,6 +21,7 @@
 #define avail_FP_SP(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_SP))
 #define avail_FP_DP(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_DP))
 #define avail_LSPW(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSPW))
+#define avail_LAM(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM))
 
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
diff --git a/target/loongarch/insn_trans/trans_atomic.c.inc b/target/loongarch/insn_trans/trans_atomic.c.inc
index 194818d74d..40085190f6 100644
--- a/target/loongarch/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/insn_trans/trans_atomic.c.inc
@@ -73,39 +73,39 @@ TRANS(ll_w, ALL, gen_ll, MO_TESL)
 TRANS(sc_w, ALL, gen_sc, MO_TESL)
 TRANS(ll_d, 64, gen_ll, MO_TEUQ)
 TRANS(sc_d, 64, gen_sc, MO_TEUQ)
-TRANS(amswap_w, 64, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
-TRANS(amswap_d, 64, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
-TRANS(amadd_w, 64, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
-TRANS(amadd_d, 64, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
-TRANS(amand_w, 64, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
-TRANS(amand_d, 64, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
-TRANS(amor_w, 64, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
-TRANS(amor_d, 64, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
-TRANS(amxor_w, 64, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
-TRANS(amxor_d, 64, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
-TRANS(ammax_w, 64, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
-TRANS(ammax_d, 64, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
-TRANS(ammin_w, 64, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
-TRANS(ammin_d, 64, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
-TRANS(ammax_wu, 64, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
-TRANS(ammax_du, 64, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
-TRANS(ammin_wu, 64, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
-TRANS(ammin_du, 64, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
-TRANS(amswap_db_w, 64, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
-TRANS(amswap_db_d, 64, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
-TRANS(amadd_db_w, 64, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
-TRANS(amadd_db_d, 64, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
-TRANS(amand_db_w, 64, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
-TRANS(amand_db_d, 64, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
-TRANS(amor_db_w, 64, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
-TRANS(amor_db_d, 64, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
-TRANS(amxor_db_w, 64, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
-TRANS(amxor_db_d, 64, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
-TRANS(ammax_db_w, 64, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
-TRANS(ammax_db_d, 64, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
-TRANS(ammin_db_w, 64, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
-TRANS(ammin_db_d, 64, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
-TRANS(ammax_db_wu, 64, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
-TRANS(ammax_db_du, 64, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
-TRANS(ammin_db_wu, 64, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
-TRANS(ammin_db_du, 64, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
+TRANS(amswap_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
+TRANS(amswap_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
+TRANS(amadd_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
+TRANS(amadd_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
+TRANS(amand_w, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
+TRANS(amand_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
+TRANS(amor_w, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
+TRANS(amor_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
+TRANS(amxor_w, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
+TRANS(amxor_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
+TRANS(ammax_w, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
+TRANS(ammax_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
+TRANS(ammin_w, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
+TRANS(ammin_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
+TRANS(ammax_wu, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
+TRANS(ammax_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
+TRANS(ammin_wu, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
+TRANS(ammin_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
+TRANS(amswap_db_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
+TRANS(amswap_db_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
+TRANS(amadd_db_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
+TRANS(amadd_db_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
+TRANS(amand_db_w, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
+TRANS(amand_db_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
+TRANS(amor_db_w, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
+TRANS(amor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
+TRANS(amxor_db_w, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
+TRANS(amxor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
+TRANS(ammax_db_w, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
+TRANS(ammax_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
+TRANS(ammin_db_w, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
+TRANS(ammin_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
+TRANS(ammax_db_wu, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
+TRANS(ammax_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
+TRANS(ammin_db_wu, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
+TRANS(ammin_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
-- 
2.41.0



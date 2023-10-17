Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AB67CC357
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 14:39:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjLr-00036W-R9; Tue, 17 Oct 2023 08:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsjLn-00031u-E0
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:39:07 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsjLl-0007CQ-VW
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:39:07 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40684f53bfcso51026165e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697546344; x=1698151144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ieYLwocsfjjZTkdy/ghGoFyoMGNTUK0znPSRouPjdQc=;
 b=K7sq63H/ZDjDbiH2jCMlwfqrVp6iiDwjdjLatghTaGVlq4j051VYJUdi3Tge/x8QuN
 tLYVLUXTO31VzXmB9VbOVMcD1s0UMGqDFtBus3erl7VCdGt5/M4AYJ8uNMUsffV04CXB
 VdwTJdjBOJLPwYeeD5CwatCOG3YcncFVhTRJ+CQdhJbN3t9MF4vbsVMqCoSqxFdbO4uJ
 lnz30oOGpzmliaEBNwdl3ZiHl+5Lf/lohGxz32aEqY3KzGJHLQHhs/q2kWG6x88YqySg
 flWgWF7PU9ZnTVNfJhoNgzoWuqqihpBnluNNg+Yz2o4zY13KG9YzKxN5p3aCHlr3lmnz
 nt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697546344; x=1698151144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ieYLwocsfjjZTkdy/ghGoFyoMGNTUK0znPSRouPjdQc=;
 b=pGyxfQroc5X2eu986jvhwPvhXIX3kBdv2G/KPaaI2OPimenEkViipoLEXOy7BQbZSo
 18JxIE+GjYrOATN7eVtkF30ehjhRzIlMgkIURxF2RmWevWdlRFZjcBfwBsdeN5jZ+qSC
 tLuIUiJoqF0aYP2am8inko9CbJYlexopOPFptXM0jeszcdQreP6zcwEkxISB7PWID0ti
 lnBTfxZb6kS/E4Cij/DcvrixhUuLrhvs2++sBk0XmF+rphDgPOubu8VJPHwfsZZVgIpW
 R60NG3ssZH/NQPXt9riCPJeFSlrnv/yb+QT4ckw1tj4qJ3TVu3FeT99sn01z+CZgl52E
 3LcA==
X-Gm-Message-State: AOJu0YyCqtEXX+XEwVo8YiYyeCdR5Uc5H6/R12L914PfrjoTPK/X01QM
 XzFVEuQECcgPpWBBDD5BenDiep4CnkH5+Y2E7aM7eQ==
X-Google-Smtp-Source: AGHT+IFAiT0BXbbeIsTOm5wAOzkSS6zgDOoBUguzW10lW2ZjFPNxl/UMZWI9g6BuSKCFP1O+egvaiQ==
X-Received: by 2002:a05:600c:3b05:b0:401:b6f6:d8fd with SMTP id
 m5-20020a05600c3b0500b00401b6f6d8fdmr1627616wms.6.1697546344409; 
 Tue, 17 Oct 2023 05:39:04 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 j5-20020a05600c1c0500b003fe1c332810sm9900134wms.33.2023.10.17.05.39.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Oct 2023 05:39:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 2/2] target/loongarch: Use i128 for 128-bit load/store in
 XVLD
Date: Tue, 17 Oct 2023 14:38:49 +0200
Message-ID: <20231017123849.40834-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017123849.40834-1-philmd@linaro.org>
References: <20231017123849.40834-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
 target/loongarch/translate.c                |  6 ++++++
 target/loongarch/insn_trans/trans_vec.c.inc | 16 +++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index c6edfc800f..89e35770b7 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -67,6 +67,12 @@ static inline void get_vreg128(TCGv_i128 dest, int regno, int index)
                     offsetof(CPULoongArchState, fpr[regno].vreg.Q(index)));
 }
 
+static inline void set_vreg128(TCGv_i128 src, int regno, int index)
+{
+    tcg_gen_st_i128(src, tcg_env,
+                    offsetof(CPULoongArchState, fpr[regno].vreg.Q(index)));
+}
+
 static inline int plus_1(DisasContext *ctx, int x)
 {
     return x + 1;
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index dd41f5e48e..c8b7bfa67f 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -5458,18 +5458,16 @@ static bool gen_lasx_memory(DisasContext *ctx, arg_vr_i *a,
 
 static void gen_xvld(DisasContext *ctx, int vreg, TCGv addr)
 {
-    int i;
+    MemOp mop = MO_128 | MO_TE;
     TCGv temp = tcg_temp_new();
-    TCGv dest = tcg_temp_new();
+    TCGv_i128 dest = tcg_temp_new_i128();
 
-    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, MO_TEUQ);
-    set_vreg64(dest, vreg, 0);
+    tcg_gen_qemu_ld_i128(dest, addr, ctx->mem_idx, mop);
+    set_vreg128(dest, vreg, 0);
 
-    for (i = 1; i < 4; i++) {
-        tcg_gen_addi_tl(temp, addr, 8 * i);
-        tcg_gen_qemu_ld_i64(dest, temp, ctx->mem_idx, MO_TEUQ);
-        set_vreg64(dest, vreg, i);
-    }
+    tcg_gen_addi_tl(temp, addr, 16);
+    tcg_gen_qemu_ld_i128(dest, temp, ctx->mem_idx, mop);
+    set_vreg128(dest, vreg, 1);
 }
 
 static void gen_xvst(DisasContext * ctx, int vreg, TCGv addr)
-- 
2.41.0



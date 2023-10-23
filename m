Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 268267D3EF6
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:18:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzRf-0006Vv-5G; Mon, 23 Oct 2023 14:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzRH-0005s5-04
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:07 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzRF-0008JJ-BU
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:06 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso2588441b3a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084844; x=1698689644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HoubwkFzMAESazVThDNIBAh5pqmgk/UJhOFdR/AHQTc=;
 b=UK+hUxziVmi6209mz85zviyKaFuE/Mm5UWiLebuAvO6ap+HuPZZemQqnvSNzqsNKQ+
 Wxzf0jmbsgqoIhs/FjutuJYCwRy+xDUIw5gNXmMzK7DHnyN1INQWz+mQbOJ39dwdD3eH
 f7NH5W8m6pbFc9sHqNFxpsf9GKiRVUlGxHdwkoM/JSuerjtzThUv3CAkPtFjRYRUrDyv
 GtYQR67kxV+TOylD7tpL04V9WedQXAUch9I5KDlJQdYpRBXmCW9ciV8KJRoVbWnEkgL3
 FzfnGhADGzRTxKURgELuDTtpSE8zwQ6EUUVcbSGaypZxlXBV/j5wdyrnbALlw+Rls7Ee
 pqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084844; x=1698689644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HoubwkFzMAESazVThDNIBAh5pqmgk/UJhOFdR/AHQTc=;
 b=JYxAr2EVgXtJuRpjtyDwk4VWYhii7DE1AFNWU+drvTvggftcfF8nqz7u+m+c+gwr37
 Yw5g9U4McjSu1wMegFw7FZFTOoukkc2R7bBnPBKrJDBuIUfpXyjo5ZZBeoFK+paCBvpp
 ySJDLlXMrCkFlrX4oNaFaDyP0QCOEXKB0Zxp+WRFI8+tD7oQ6Mqlor4gxrHSFAbEgnrr
 Vhubk1UmE0eYGQZPe76wLblFFR8iqaRoFC8JGlNDwYl5caPVzeF6GKpr4UOdXw9R1Wfx
 Z14wvyNeHzbn4/o/aViSR1bK814GlaNxff/lVKGqzLserBjcxbnmeJtbsaIIfcraM2JP
 E3Wg==
X-Gm-Message-State: AOJu0YyR+DInanvLNsRzxMMVvarwjXYM1JKaoDh2O4dm04cxWh66xFV3
 y59pws9TUoyywBZfZqx0SFQQdphFFQqmWbOJTbg=
X-Google-Smtp-Source: AGHT+IHRLGM++o0VHyK4JjknGuKQDzUMJAUQIuoo8wPMQQtvdVXaW3kszjNvL4XLTpXLE98NNImNDg==
X-Received: by 2002:a62:f246:0:b0:691:27b:15b4 with SMTP id
 y6-20020a62f246000000b00691027b15b4mr16941402pfl.5.1698084844093; 
 Mon, 23 Oct 2023 11:14:04 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:14:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PULL v3 37/38] target/tricore: Use tcg_gen_*extract_tl
Date: Mon, 23 Oct 2023 11:13:28 -0700
Message-Id: <20231023181329.171490-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

The EXTR instructions can use the extract opcodes.

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/translate.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index dd812ec0f0..66553d1be0 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6542,28 +6542,16 @@ static void decode_rrpw_extract_insert(DisasContext *ctx)
     switch (op2) {
     case OPC2_32_RRPW_EXTR:
         if (width == 0) {
-                tcg_gen_movi_tl(cpu_gpr_d[r3], 0);
-                break;
-        }
-
-        if (pos + width <= 32) {
-            /* optimize special cases */
-            if ((pos == 0) && (width == 8)) {
-                tcg_gen_ext8s_tl(cpu_gpr_d[r3], cpu_gpr_d[r1]);
-            } else if ((pos == 0) && (width == 16)) {
-                tcg_gen_ext16s_tl(cpu_gpr_d[r3], cpu_gpr_d[r1]);
-            } else {
-                tcg_gen_shli_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], 32 - pos - width);
-                tcg_gen_sari_tl(cpu_gpr_d[r3], cpu_gpr_d[r3], 32 - width);
-            }
+            tcg_gen_movi_tl(cpu_gpr_d[r3], 0);
+        } else if (pos + width <= 32) {
+            tcg_gen_sextract_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], pos, width);
         }
         break;
     case OPC2_32_RRPW_EXTR_U:
         if (width == 0) {
             tcg_gen_movi_tl(cpu_gpr_d[r3], 0);
         } else {
-            tcg_gen_shri_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], pos);
-            tcg_gen_andi_tl(cpu_gpr_d[r3], cpu_gpr_d[r3], ~0u >> (32-width));
+            tcg_gen_extract_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], pos, width);
         }
         break;
     case OPC2_32_RRPW_IMASK:
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16849721616
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 12:30:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5kz1-00011g-Mm; Sun, 04 Jun 2023 06:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q5kz0-00011Q-8u; Sun, 04 Jun 2023 06:29:10 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q5kyy-0005o9-K8; Sun, 04 Jun 2023 06:29:09 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-38c35975545so3348203b6e.1; 
 Sun, 04 Jun 2023 03:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685874546; x=1688466546;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N424z4fvxORhlJsYYBVuPg930NH8Qs7g6+F84APsNP8=;
 b=cg6iG79Hrg2o/QGmGWKOxFH2g4lM+hEjKhczcIY3l24D7Ngq3JkItePqMa+ch7kVkp
 R2SAAG3bjlqZd1Pduex6cF7ahg+2dg4RR7FZfCa3MdulcPa0mvVLWWaoow38HwkQ2Gi3
 zYfRZubCS25ciu0v+YQb8rskGk9drooyN7NyGeNops0iR9jQ+l27L1sg09E9+hRMEx2m
 HQOx/1VBmEAV4X6FVgOtwn0oMNrML7BuX7QhDVC8LqxAlNLTNb8l+wRY44++N7nk2g/z
 EVPTqtC2NF/qSBxtyeTLbzwNN21VxygeJEuWC20nVVD6MTkMGqN7hSXPM2tFhExC0m8l
 as/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685874546; x=1688466546;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N424z4fvxORhlJsYYBVuPg930NH8Qs7g6+F84APsNP8=;
 b=ZHTESS3Hqvm41pGLfkmc6gIrQBIZo9kA1o0Zm/rvEV7ViL/8T/6+RRjNb0XXo58kEH
 N2Yq8bgTWsKPdEGStDFLCZWmRfavLhdpdmWbFbnUYQigFXl6SyEx0YpVrPOZ6cMBp+q2
 pF5BhgP6O/wdQ49TDgPmpph04RJ8zQQfiHWtMlGq1YKMxThAi85mFmBVH5FasRMklWwz
 Jnr9M68J9Ha/IhJXdXbSit6znPFFBVBZZuoiWCtJBblNMPZoA7VCHrR2mtnNsrhS4UoZ
 kdW60Ykl+M1D2ip8SMGE/SUDP6J1cLomahBTH5i9T2uNIc1/i7tXEdMbFU9kE3SqfLo1
 VPww==
X-Gm-Message-State: AC+VfDzsDmMmvvqE3LARCDD+6id7vBsd9xiS3OKfSw4j1PWQOwM/pz+L
 nGZ5o+nnosWsSGTnlm2dfsE=
X-Google-Smtp-Source: ACHHUZ6pQghZT+VxTcF7Bf8YiTl9fKA5IH4O1kCadvbMlHE71AXAORWYDTkE79W6FoLl1oO/vKyXYg==
X-Received: by 2002:a05:6808:6c3:b0:398:bd63:b5fe with SMTP id
 m3-20020a05680806c300b00398bd63b5femr4699882oih.18.1685874546210; 
 Sun, 04 Jun 2023 03:29:06 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 ik8-20020a170902ab0800b001ae0152d280sm4489241plb.193.2023.06.04.03.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jun 2023 03:29:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH 1/4] target/ppc: Fix lqarx to set cpu_reserve
Date: Sun,  4 Jun 2023 20:28:54 +1000
Message-Id: <20230604102858.148584-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

lqarx does not set cpu_reserve, which causes stqcx. to never succeed.
Fix this and slightly rearrange gen_load_locked so the two functions
match more closely.

Cc: qemu-stable@nongnu.org
Fixes: 94bf2658676 ("target/ppc: Use atomic load for LQ and LQARX")
Fixes: 57b38ffd0c6 ("target/ppc: Use tcg_gen_qemu_{ld,st}_i128 for LQARX, LQ, STQ")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
cpu_reserve got lost in the parallel part with the first patch, then
from serial part when it was merged with the parallel by the second
patch.

Thanks,
Nick

 target/ppc/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3650d2985d..e129cdcb8f 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3583,8 +3583,8 @@ static void gen_load_locked(DisasContext *ctx, MemOp memop)
 
     gen_set_access_type(ctx, ACCESS_RES);
     gen_addr_reg_index(ctx, t0);
-    tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop | MO_ALIGN);
     tcg_gen_mov_tl(cpu_reserve, t0);
+    tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop | MO_ALIGN);
     tcg_gen_mov_tl(cpu_reserve_val, gpr);
     tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
 }
@@ -3872,6 +3872,7 @@ static void gen_lqarx(DisasContext *ctx)
     gen_set_access_type(ctx, ACCESS_RES);
     EA = tcg_temp_new();
     gen_addr_reg_index(ctx, EA);
+    tcg_gen_mov_tl(cpu_reserve, EA);
 
     /* Note that the low part is always in RD+1, even in LE mode.  */
     lo = cpu_gpr[rd + 1];
-- 
2.40.1



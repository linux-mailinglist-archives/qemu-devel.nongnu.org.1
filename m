Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BD770FEF4
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 22:03:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1uge-0004Ba-AB; Wed, 24 May 2023 16:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1ugc-0004BK-Gd
 for qemu-devel@nongnu.org; Wed, 24 May 2023 16:02:18 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1ugb-0001z3-0W
 for qemu-devel@nongnu.org; Wed, 24 May 2023 16:02:18 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-64d3491609fso1027156b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 13:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684958534; x=1687550534;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=o6cJbzSvYvQOTGDtz8/CCuAgm74mnMDf42v4W8C12Tg=;
 b=zy8PP7c7oDa2jK3hIASl9H64D4L6pE8jDIAlaFjQZWR9R9Bm3HZd5P2lyEyz0rhuJS
 H2ct0RuQ6XLWQ6oWbLIDQ38w94wVY5ZuJLlLOKsFpQpDMF5135kj4yz5h2hjBctx6EZ7
 7cfvnwYWUVAzocAqtQtk0bsU9GpEoONVTcxemykLjgnmzwTlnMYXS1W/nt1cPrJ/U7Jx
 sjGgHB4tlTxQgBLQmPLBacA6jNdh+QWBLUi9meqfWW7RJk49Xdn+/CnI1ksp4bvPcNvz
 CtbdFTzH6lNfnc/Rs9DRApf2XcFEoegueLoUxgF5jharQyZq/wIp6lW6JnCXrpUcrI0I
 ERww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684958534; x=1687550534;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o6cJbzSvYvQOTGDtz8/CCuAgm74mnMDf42v4W8C12Tg=;
 b=lACDLn69lAccGk8A6FZegCIouFdIOrd3t1SwHezv12+tiOoY0mnz8O1/xavuPQvBmf
 wMaXJuHFvfi4O6shlgfWsLIw1CcK292koXgj1GXj0F4LrGnzGnOXWQlGGPi5LekLF1C4
 DYD3vt7IClXO2dNGvX/3uEotnCGYUjMjepOM18xXBwfi5L59UB857k3DLxfjleFiwpfV
 YxURTBwNKi7zUCPEKvfiK2eXm8MnCXXRfK7nk4E+PweaTu4Kp0Mgls0Zeum/6azeqlwD
 S2bdrfaHGV+GOkz7bU4JAKq7Vd6wvktK2i+aybaW/KutBlnp1OQiCTwaMPqXLuwkWvDO
 Oqjg==
X-Gm-Message-State: AC+VfDy0Ovu/hsOsMpSif3Aw8mQNqbCJW9H0/LK0eMi9GRhZGgIA9Pyz
 za20Md/a9eISLO+mCGxqaBmbsf2/25zpUtBr00I=
X-Google-Smtp-Source: ACHHUZ5TjFuns05dmwvpWoxZyJbkBjo4nMCz4r9FJIsBguMgJLAh/ebrbq2ATekCFDFofopotQP88g==
X-Received: by 2002:a17:903:2303:b0:1af:a03:8d82 with SMTP id
 d3-20020a170903230300b001af0a038d82mr19489397plh.57.1684958534351; 
 Wed, 24 May 2023 13:02:14 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 21-20020a170902c11500b001a98f064a2asm9151705pli.48.2023.05.24.13.02.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 13:02:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tcg: Fix register move type in tcg_out_ld_helper_ret
Date: Wed, 24 May 2023 13:02:12 -0700
Message-Id: <20230524200212.1354804-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The first move was incorrectly using TCG_TYPE_I32 while the second
move was correctly using TCG_TYPE_REG.  This prevents a 64-bit host
from moving all 128-bits of the return value.

Fixes: ebebea53ef8 ("tcg: Support TCG_TYPE_I128 in tcg_out_{ld,st}_helper_{args,ret}")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index ac30d484f5..2352ca4ade 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -5736,8 +5736,8 @@ static void tcg_out_ld_helper_ret(TCGContext *s, const TCGLabelQemuLdst *ldst,
     mov[0].dst = ldst->datalo_reg;
     mov[0].src =
         tcg_target_call_oarg_reg(TCG_CALL_RET_NORMAL, HOST_BIG_ENDIAN);
-    mov[0].dst_type = TCG_TYPE_I32;
-    mov[0].src_type = TCG_TYPE_I32;
+    mov[0].dst_type = TCG_TYPE_REG;
+    mov[0].src_type = TCG_TYPE_REG;
     mov[0].src_ext = TCG_TARGET_REG_BITS == 32 ? MO_32 : MO_64;
 
     mov[1].dst = ldst->datahi_reg;
-- 
2.34.1



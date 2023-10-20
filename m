Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9117D1783
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:51:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLv-0007t8-EI; Fri, 20 Oct 2023 16:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLP-0007iH-SX
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:44 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLN-00089G-9Y
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:42 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b3c2607d9bso1163944b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834620; x=1698439420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gizyszKoYOssiFVO/W3NqegBEKVfjjL7AQSlumE/K80=;
 b=t6u4/ecE9d+4l1w1L/AD+gd9pFhZAsHDD3w66yDJOIIJw5lVU9ue2SeZG3obp/U6GF
 fLGrNwLYue3AmYzSNudq3NASvxGJJOfVIsNOPbNTCUVv79Am8hxLt/VCzUcYmo6aJLO8
 xdSipfKU6VT82J0sgeqXDKzet0Sq/BY0NxTmGazZFcW8Ufzoo7TeuHTQMVp3JcyGNecm
 pmRfBLoPThHFowT15sCJKDyGf0srQmUwFXDDaoCEjeczhwKeuYe5IYuYBNc4cDp5SwLS
 nBB1K5YXhxUML0/JG0UFgLhFCSZAQoCAfc1BD0QwAqbOCZ7sBARIPoJ5ibh4AALdSICW
 /+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834620; x=1698439420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gizyszKoYOssiFVO/W3NqegBEKVfjjL7AQSlumE/K80=;
 b=aDDkgHfX+4ZwA3QesXN+FEo7LgqIPdffO8uBH5iPts/zHgF4dQDvdSFkQs5nCyujEk
 yc36IvbxN7tPGfAdFSPu3oBbbPAnal9rEh+BTQCjkCvG8ZetT/YEbcWGYhdks5HyqqHF
 j4p4ALmfMxlv8PO4F3GE4qK1TTYoHr6dkDpfrIU+Az4+yrf7/b9LwyMF6ugcPZ2+ax7s
 ngeNNt+lZpc7ZHzWeq3blcLRdTrF1JmEBVHf6S4ksn2xRs6u9YFYif+kIMVAWIn1/FK+
 QXWJvWI1XW9K2s7LkI5GJFMnps6UlaDnaxdw5wPUsewuxFHLcMeTOyvS7Z5lz5/2oqwH
 N7ag==
X-Gm-Message-State: AOJu0YwIShPI6Nt3W8QujaGJ2YC5GfVw2g+nuQh10kMd8X9+JS31U3hY
 kGZVJ20YpD/PVp3lKcQQy7UaFEtDREw5WBgHjag=
X-Google-Smtp-Source: AGHT+IHl3jppGiyWvMDbCxMIbQzJfGTR3CHWSOobPHvxxmO/4c3WyLCaKZyhK08uHrV0TVTPRIVbfg==
X-Received: by 2002:a05:6a00:2d10:b0:6b2:2a2d:7a26 with SMTP id
 fa16-20020a056a002d1000b006b22a2d7a26mr3084508pfb.28.1697834620086; 
 Fri, 20 Oct 2023 13:43:40 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/65] target/hppa: Fix load in do_load_32
Date: Fri, 20 Oct 2023 13:42:33 -0700
Message-Id: <20231020204331.139847-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

The destination is TCGv_i32, so use tcg_gen_qemu_ld_i32
not tcg_gen_qemu_ld_reg.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 21f97f63a9..ff559ed21d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1430,7 +1430,7 @@ static void do_load_32(DisasContext *ctx, TCGv_i32 dest, unsigned rb,
 
     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
              ctx->mmu_idx == MMU_PHYS_IDX);
-    tcg_gen_qemu_ld_reg(dest, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
+    tcg_gen_qemu_ld_i32(dest, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
     if (modify) {
         save_gpr(ctx, rb, ofs);
     }
-- 
2.34.1



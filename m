Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3657A7CEA43
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:52:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESE-00014D-Gz; Wed, 18 Oct 2023 17:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESA-0000rs-Cn
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:46 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtES7-0004Na-3i
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:44 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-581fb6f53fcso553858eaf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665902; x=1698270702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQDrnustD9JMJVkf0X+C7sW4Z0qLBIQjQQllFpFrUUM=;
 b=YlCB5rbXHhXRgm0HIo1I/HY/j7JB7PrfPynCaGRzvlAv3tDWMnc9M6t74qxN3J4iq6
 mlZnSH2Bf3Npv6BYltE/BsVZUmaIEnTpfUHbvGtBHKPbx+OiNff7nd4/aa+cU+Nt7/y3
 OG7cPqlYBkRt6NOXFvdpyxeyGEdaIbbYZkL15EuL+MjZnOR3mZfA7J4eokf9y7IhskoP
 GydHyNmT5N24LkklYWv0VDwe3ivHWvHEv+6cerP9x+JJxqeWSu713Ys70FZuIrM874Et
 TLRYy/RvEM1Oa4Pm74HXrYxN0lufuxE5IRFAeteTDsxCRFpJvy5XV7fbVXefm60dm2Ia
 icBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665902; x=1698270702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQDrnustD9JMJVkf0X+C7sW4Z0qLBIQjQQllFpFrUUM=;
 b=tHKU6y6zFBQOD3amX88s/QJJSax+sGH4H5RBzaX1EefsnUy2ha1bg4sQKlh/wcp5C1
 i2C/uuV39veR7/ofIMKast7+gYWe6Dg7Lz7sEfbPRxtDd+nIxG2yNh+YangFIDMu1gAp
 NuORGzCD76HoBTsrNFCXu4Pa9VjAyjojHBLQaRqrlwglr5tP5sA3yppARBnbYZvk4rZu
 NUGNqc42iRBD2TOn1BN72fY51d+D5LO7p87IHlZQ+4ZESUnIgufzWz+uZD93nK7iompE
 jI/ugIGVfO03K4kJ7E9++xvD7qUMHEyi0/eW+G2cJojmJ7huO0MS8p46kmkhxq+r7Dfp
 FxNQ==
X-Gm-Message-State: AOJu0YwILU3IrHlyA0wK5wcV+Y/hlPlLG7ZkyZ5kh2OZa0iO/7NYvDyx
 zp50RomWY7TwUkUWJBykqbSetJkOnyxU8CUTv+c=
X-Google-Smtp-Source: AGHT+IGxT+uRZlfwIJxR1kAUAj6L47EAJEQTmD7UTKU5IGxqxg4WK0uCrX68YU/xfmi+CPYaTGYSZQ==
X-Received: by 2002:a05:6358:c62a:b0:134:f326:e819 with SMTP id
 fd42-20020a056358c62a00b00134f326e819mr261045rwb.29.1697665901989; 
 Wed, 18 Oct 2023 14:51:41 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 06/61] target/hppa: Fix load in do_load_32
Date: Wed, 18 Oct 2023 14:50:40 -0700
Message-Id: <20231018215135.1561375-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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



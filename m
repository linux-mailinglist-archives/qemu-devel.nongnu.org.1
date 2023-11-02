Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 062147DEA1A
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:35:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMXr-0005nA-Gv; Wed, 01 Nov 2023 21:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXe-0005cF-GG
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:38 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXa-0001Xz-Cc
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:37 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-692c02adeefso466035b3a.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888633; x=1699493433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FgvfDwyIoGSK++AEaNdMmfoRCVSVHMXHgiFS4BjrPMw=;
 b=RxHVe8FpoamB40fRCEiUyFNytX29/prRAhFy+uHJtn35VpdTOaH18X6T0frjK+H0C1
 k/QsKA2yy/dbKhXikCj//vf9wpFlZWzVNsorsq5OR7qh1veNdqn0Duk4dSrpGAWCxKTw
 +kOnW3REZ25z0W25Rn2srCtIk27OhJ0b+F+3AWUvktFisiVDuwX36zvho1zwPRZid9ch
 6MldHd5zxJUjKCDw2Km/P+reMQszqpJcepreoWBFMVJspG2tWUsiCP7Ycp1EJ+9cZYJq
 w54CalV9KzQitPuxOjURwwqIF37FyKI3LPj03P18iP+Cp4KXdXcJX9wHE2k/lXSrUYDt
 5JQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888633; x=1699493433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FgvfDwyIoGSK++AEaNdMmfoRCVSVHMXHgiFS4BjrPMw=;
 b=WZoIvPy4EAYOLID0Xh1bdSWASlGS1CXeQjO3I3i0jHCY9hiDZFEwiqAuKxT+epr15B
 gPxoa2M5UmZGrD6fz7rOOwAoO0TkYW6togSvoKhkYSnOCuK9AlZOz/MmeZh8ljXLqusw
 SFVWwG5TWJiDh2hUqKZ8WZB7CBkFEwYs0JK+49kuH8L5SfTiJQM3F4FrFtu5H5XAKc4Z
 DyzHMQvdDT/SWabjOhkjvTtdtvWFqP6ED6Jjqhp2Wvb8mMLldUykV5SoZu/NfKgylX7m
 g9C5nSzdysVqgjoGd5Euuc+KNHQ08Jk/C4hdEHUZZXhvfs6MtZcopPNTbNjKAUHgnUKT
 hWBg==
X-Gm-Message-State: AOJu0YxGOpetdCOIMCQkQqnDwHPKaGofCo5DIxra0NSqyl4I8eMfWEnv
 gyITRY2aKR0R7yEDlETonuIwryQcHcV0umsGP/Q=
X-Google-Smtp-Source: AGHT+IHgbW0TIKKH6anBCRUfC1cIaDeA5soCclnbe30BXrL3++yGhxfGZ1/J61ClkZf6Uafrfs3WXw==
X-Received: by 2002:a05:6a00:138a:b0:68e:3772:4e40 with SMTP id
 t10-20020a056a00138a00b0068e37724e40mr17728137pfg.3.1698888628817; 
 Wed, 01 Nov 2023 18:30:28 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 13/88] target/hppa: Fix load in do_load_32
Date: Wed,  1 Nov 2023 18:29:01 -0700
Message-Id: <20231102013016.369010-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

The destination is TCGv_i32, so use tcg_gen_qemu_ld_i32
not tcg_gen_qemu_ld_reg.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index c8384fccd9..20e44ed528 100644
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



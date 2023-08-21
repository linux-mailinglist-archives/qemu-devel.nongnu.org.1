Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1AB782158
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 04:21:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXuWv-0002Mz-BK; Sun, 20 Aug 2023 22:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXuWt-0002Mf-8p
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 22:20:31 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXuWq-0002Z4-VR
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 22:20:31 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-563f8e8a53dso1574903a12.3
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 19:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692584427; x=1693189227;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ImPZelBE/lkw2uDypiK5+Vxi3S+R2CKyybX8jsMobhU=;
 b=dGYrjDNzj/xAKhR8bkKVR2Iww+w1VlSmCoEstYWChks+ze2yXHez+2sUCNDciY/sCh
 PMNx/sT77fU4dJ/jZiD8NXhvU463NqrIx7QOrIvmAk00EhPskBexkp03l26eJhz+sNNq
 qGtGd+WEP9e9ug5PjdQFYAwxBft4QtYef61bIDz+b6CbDuRg+HAl36vxtFinfJIrENM3
 FQ0rk/HNZl5xA1DaeBasnRrx+3T09Qep6iR9UnqRTOMRkQ7XIep9W3FkyviYNnopqxla
 p2LI9ESc13vu6JZzs9s1mz4Qv+3vIpyl7c/FidjHqVg1XkbcrE12F1W3KB5wdwNWZfsX
 v/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692584427; x=1693189227;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ImPZelBE/lkw2uDypiK5+Vxi3S+R2CKyybX8jsMobhU=;
 b=FNQ16noKbW7IlOm5OLiLx7V3oupwGaJ+z0zMUIhxSwDD0odsQQqkovpCUzLrocd4aj
 sA9vk2MyUsWIPgKiHJmRt6q0uKpBC2Tm6ucp5g+Tx+e9svNvz5SmbU/LaJ90IB6t2924
 g1M3RI9vLXmy+/8Iw4N9c6RfyO8uhbihxRxa34sz8jfSE/MXVGLGLfuloKu0fWvfEGiz
 zjbdvgStEVhED2oB+qRQGa79czGTUnrFANyiaGWCCNk7SbwtT5n2C1IhHl8+Gh3Ne2Ou
 jB+C6HhXi6Gm5XTkSwc6X1iuC/ntvwQRuDF17YIZyQUfNtLysVWwlVhDRCHvDxjBa123
 7vlw==
X-Gm-Message-State: AOJu0YwWZxIHu+NEf6T56Zij/RqXBBrcZU+09BJKxplyPkBjOAUalRI4
 XHlepIRKB6jN6eoHTpEeQshRDLXLGKctbk+VZzw=
X-Google-Smtp-Source: AGHT+IER/9IdQjfXbuZLnbA5TRSllp/L0Cx+dNQPMFP4VgRGCGoZaWYaUYXCSF+KpVpMFJdQ5ioA5g==
X-Received: by 2002:a17:90a:d347:b0:262:d661:2963 with SMTP id
 i7-20020a17090ad34700b00262d6612963mr2770735pjx.39.1692584427173; 
 Sun, 20 Aug 2023 19:20:27 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:7da6:8db:fd7a:4d62])
 by smtp.gmail.com with ESMTPSA id
 24-20020a17090a035800b00256b67208b1sm7269720pjf.56.2023.08.20.19.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 19:20:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH] target/arm: Fix 64-bit SSRA
Date: Sun, 20 Aug 2023 19:20:25 -0700
Message-Id: <20230821022025.397682-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Typo applied byte-wise shift instead of double-word shift.

Cc: qemu-stable@nongnu.org
Fixes: 631e565450c ("target/arm: Create gen_gvec_[us]sra")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1779
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index b71ac2d0d5..39541ecdf0 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3053,7 +3053,7 @@ void gen_gvec_ssra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
           .vece = MO_32 },
         { .fni8 = gen_ssra64_i64,
           .fniv = gen_ssra_vec,
-          .fno = gen_helper_gvec_ssra_b,
+          .fno = gen_helper_gvec_ssra_d,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .opt_opc = vecop_list,
           .load_dest = true,
-- 
2.34.1



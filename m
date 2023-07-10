Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2496074E127
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:32:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzNw-0003q3-K9; Mon, 10 Jul 2023 18:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzNu-0003pf-O3
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:34 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzNt-0002CT-76
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:34 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fba8e2aa52so56073755e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028172; x=1691620172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=noAqc1iM8teP3z/+IYxbUAPdYxzHFromapc0DSXQg/4=;
 b=hF+jBTV3EnOCwcEfWvbAwTKTVwocoomrdLT3EuM51Zq+v3jgCmt1F5v5LBQKPkrqS8
 IkapOZdHw+9gElHseZCyQXWMjTdMnnMVstgDfILgKTDCTAXHALQOncVCdea9hrPm2GFe
 RrNDVJwwR26UlS1C6I0S1t7ezNDIVg6h1Jc8bmoGKNpUhecf/jni2L49+OWaMRDFfrFP
 /JALgXQVo1/deQfjxv77xfs4wp8u2d07uI5QeWzIQ2c445U9YpOysTaR/9CB3o/+oOhO
 Zc/bV4HuV6fR+9uuZAovfctziPq4uDZYx0q3reTAc3N03S8ceZnMJ5twH6si4hVYYAaF
 DA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028172; x=1691620172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=noAqc1iM8teP3z/+IYxbUAPdYxzHFromapc0DSXQg/4=;
 b=JPvMqxr+o+IR+E7VQGcs+0y4vTJ1/pIv9iGaUjABW2lrwDUb0eXfzTK6W47JC9jW7v
 RUz+Wt3QsBImAgYSk+BZ5+vPCUrtb5643FMLjdBtDXxG98T9SsYbR4TleBMm0rQXIJMu
 PXWZ2M8jkdAHacmTLwZDgv3qojXbCafF/ihl02ghjdor6kiAhUnvx/OwRpuCCDGzc356
 RXDzrwspE9W5/PeQxImgUaS+sqm7O2sQpAAld1dXyZe8+LAhBka26mfbumrgnb2PI7V6
 8aV6Nl9TMCHcb6ZLRuT11fTk4l6JZK7zE1AEbKl+Nk87hfu9X99eIW0sjgGBEtHF8mO4
 ZMaQ==
X-Gm-Message-State: ABy/qLYrMucmfFo+rYyw1SuCkJ5MWP2aZy67bVAUpAJ7q1KMnJ+DPcLd
 j/XSi3oVJA1t+pPapDnvnv28MYkVlHoaoQvpW6XUHQ==
X-Google-Smtp-Source: APBJJlEI0FSFBAK7WnC9PEW9hukdSwgF5k9PDLi7XqurH9qwUcYhxgDFMhTzWef3ZUAEd45FXk1DFQ==
X-Received: by 2002:adf:f8c3:0:b0:314:38e4:25a2 with SMTP id
 f3-20020adff8c3000000b0031438e425a2mr12902983wrq.37.1689028171737; 
 Mon, 10 Jul 2023 15:29:31 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 g15-20020a5d554f000000b0031411e46af3sm512346wrw.97.2023.07.10.15.29.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:29:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marcin Nowakowski <marcin.nowakowski@fungible.com>, qemu-stable@nongnu.org
Subject: [PULL 37/44] target/mips: enable GINVx support for I6400 and I6500
Date: Tue, 11 Jul 2023 00:26:04 +0200
Message-Id: <20230710222611.50978-38-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Marcin Nowakowski <marcin.nowakowski@fungible.com>

GINVI and GINVT operations are supported on MIPS I6400 and I6500 cores,
so indicate that properly in CP0.Config5 register bits [16:15].

Cc: qemu-stable@nongnu.org
Signed-off-by: Marcin Nowakowski <marcin.nowakowski@fungible.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230630072806.3093704-1-marcin.nowakowski@fungible.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu-defs.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index 05d9ec7125..03185d9aa0 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -755,7 +755,7 @@ const mips_def_t mips_defs[] =
         .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (3 << CP0C4_IE) |
                        (1 << CP0C4_AE) | (0xfc << CP0C4_KScrExist),
         .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_VP) |
-                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP),
+                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP) | (3 << CP0C5_GI),
         .CP0_Config5_rw_bitmask = (1 << CP0C5_MSAEn) | (1 << CP0C5_SBRI) |
                                   (1 << CP0C5_FRE) | (1 << CP0C5_UFE),
         .CP0_LLAddr_rw_bitmask = 0,
@@ -795,7 +795,7 @@ const mips_def_t mips_defs[] =
         .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (3 << CP0C4_IE) |
                        (1 << CP0C4_AE) | (0xfc << CP0C4_KScrExist),
         .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_VP) |
-                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP),
+                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP) | (3 << CP0C5_GI),
         .CP0_Config5_rw_bitmask = (1 << CP0C5_MSAEn) | (1 << CP0C5_SBRI) |
                                   (1 << CP0C5_FRE) | (1 << CP0C5_UFE),
         .CP0_LLAddr_rw_bitmask = 0,
-- 
2.38.1



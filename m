Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FFA78EAC9
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:46:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfBF-0003h3-CE; Thu, 31 Aug 2023 06:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB3-0003R5-Qh
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:29 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfAz-00042t-6w
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:28 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31aeedbb264so526072f8f.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478723; x=1694083523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QU826JqtU7kXfHncN4gi9tl/7HUQ0VtfB7fV2Nl8dBc=;
 b=YeKRlXTj0+WXFWQlCGUiAd0vr6ROVJrc+afALHKqLcfMs+smwrybcsHfRA41KcIgJV
 9z9F+VGVYMYkv62Decb+Ld/AX6vowBDWQe0IvricA1Abx5jQsiRALQmR6U3scrJtNGvg
 FI0t6Kd+8t3wwDEKCkFh619+wACjM0Dia+4KBu/y8uUn9i2/YJErWPMnanLqV/B3Q89U
 2kTJpHQoeMM3y7MLSDU20wNJzbJctqXzK0WxBz5HaTGXsd6iaoy8NLNbqOcQQuAxyg/5
 IA3DfShZzLxcMpiV8zi+I9FQ2IDH2AgrMOy1zuXQFYudADyeRM+vQy5mKmz4cuQGPfHr
 XS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478723; x=1694083523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QU826JqtU7kXfHncN4gi9tl/7HUQ0VtfB7fV2Nl8dBc=;
 b=ZsPPK8F+vGLeY6e2o7jCwqLXQ4LoktV6aFYf1CFKkPuXki3Dtxz8qk5dWIPOye7WkF
 X+CqsFWUnzWbgxDYg10CmqbVE7c2nX/cRGukQZzVBtGv/LHPLQ5+jcyJ9H4P2MEX8M5l
 4MupLnqHUGOI8c6DJvQnw3X2mGfriLDWgWVfXaCWjSh/YSU5juwlIRbZBuxNsuOSlrPH
 aUplBnoR/yhVseOJlzenVUo77AhTmrDRj6GZuwK95DdN84xZKo7GuWFPq0Ou+bJsY32T
 F/Nk3K1yau2Ej1CqdzlCeTOlvIYCm674uE5swNbg6pdTkLcaOiZeFrYbmG2FOF9wDSYy
 gefg==
X-Gm-Message-State: AOJu0YxqC8+VgQ4uoVyTjOo+8tkE1gx/QTLohfJdXDH+qug57o1gNh9r
 yLj7+h+XGXmoa47LkhCVJZhm0ccMLBIhEUsQQPs=
X-Google-Smtp-Source: AGHT+IE3yjCcSMPir6ZLvfzEHPlfYLSBC1/0jt8MiFXDu1l1sR4SP6GABt1BZuGWHy29+BIUi3poiQ==
X-Received: by 2002:a05:6000:4d:b0:314:3740:7f69 with SMTP id
 k13-20020a056000004d00b0031437407f69mr3464811wrx.37.1693478723527; 
 Thu, 31 Aug 2023 03:45:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/24] target/arm: Apply access checks to neoverse-v1 special
 registers
Date: Thu, 31 Aug 2023 11:45:02 +0100
Message-Id: <20230831104519.3520658-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

There is only one additional EL1 register modeled, which
also needs to use access_actlr_w.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230811214031.171020-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index bc3db798f09..b0cac05be65 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -560,7 +560,8 @@ static void define_neoverse_n1_cp_reginfo(ARMCPU *cpu)
 static const ARMCPRegInfo neoverse_v1_cp_reginfo[] = {
     { .name = "CPUECTLR2_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 1, .opc2 = 5,
-      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0,
+      .accessfn = access_actlr_w },
     { .name = "CPUPPMCR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 2, .opc2 = 0,
       .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
-- 
2.34.1



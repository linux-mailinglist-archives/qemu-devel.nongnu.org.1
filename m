Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5EC7476E3
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 18:38:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGj1I-0001Nw-6S; Tue, 04 Jul 2023 12:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj1E-0001K0-B2
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:48 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj1B-0001pp-9B
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:48 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-314319c0d3eso3393189f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 09:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688488600; x=1691080600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ljXuz5WdOwWpxwvCuXAlprlm5SQ6d0e/c1sdlk1yWik=;
 b=iXQM3l4hIFS+7AgtV7coajaTKojqc5SP+UnAAVjX2oNehd7JUbojq/oa1H12WjV09a
 JzPapmmFQbwhq2+QJRsaS6GPDTvpkfdpjk7X6L/Y0RSa+wCRX9+WK+ZDn0LZpGvPBM0j
 y1ufWMvL8ky/OT8yMqHtnAsqSK+3r8X/PdJRrgga2vDmOzXfkgYuOgU8e0Xv2+fQl5J7
 zJB0k0DDNHlUZCHcps8TJtrZCapbpUhpzKOTJkQLk+lEAoE0sBCB+awN+nB0qR2jdxyO
 5AI9/ctuoCf5wVJ43Abh9+2tHSU/AjvvYoHruQG+3TVQeJaP7kZ/74YdIvDDUjWJx932
 d/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688488600; x=1691080600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ljXuz5WdOwWpxwvCuXAlprlm5SQ6d0e/c1sdlk1yWik=;
 b=TUoi/d7Hg5lndLRGVRBaQrJ3bGoCRjUe73p0Ivcubwxet/9ZQyR3Pc9tD4Qus6q+qV
 kJim6peHlLH5moGuOpZmJiXZyWADfn6lLBzlDWzh4SO6P+4/K1oVGfKDZR2q8poZL+p0
 XQO4TQbX7/E6J/b4yJGRbKGch8yZ3oN8e6bKrc4GAkvQaBG7PcrAyMCsyAbkOXKFOLr4
 48mIl7Qs5eBzMwHcxRpQaPBrQ8HvS4FtOM83LPrPYXkJr4Ura8dCpi6ICGDfVblk0a8m
 Ezm3Gw7anYafeyhepxbteZRbEe7tfvHoEOS5XcNFe43hJRHYdQrI2nwreq64+1qjHsn6
 ZhzQ==
X-Gm-Message-State: ABy/qLYrF7j5ivbgxvazxqKJZD8UcHfJIRxOwzqFRvYW4/7xT53dG526
 MUPjnqNDv00yj4EEOCrxyXcP0T4ImAs5C/D3Rvk=
X-Google-Smtp-Source: APBJJlF2Milc/X+BkhYVTPEkKqKlfiL63NxEES8z/o0ze5k/XgXSeaLkaO85QYKyFoN0+YxDu3aCaQ==
X-Received: by 2002:adf:efca:0:b0:314:3587:ec72 with SMTP id
 i10-20020adfefca000000b003143587ec72mr6508721wrp.69.1688488600149; 
 Tue, 04 Jul 2023 09:36:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a056000014800b003143b032b7asm4354258wrx.116.2023.07.04.09.36.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 09:36:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/11] hw: arm: allwinner-sramc: Set class_size
Date: Tue,  4 Jul 2023 17:36:33 +0100
Message-Id: <20230704163634.3188465-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704163634.3188465-1-peter.maydell@linaro.org>
References: <20230704163634.3188465-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

AwSRAMCClass is larger than SysBusDeviceClass so the class size must be
advertised accordingly.

Fixes: 05def917e1 ("hw: arm: allwinner-sramc: Add SRAM Controller support for R40")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230628110905.38125-1-akihiko.odaki@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/allwinner-sramc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/allwinner-sramc.c b/hw/misc/allwinner-sramc.c
index a8b731f8f28..d76c24d081f 100644
--- a/hw/misc/allwinner-sramc.c
+++ b/hw/misc/allwinner-sramc.c
@@ -159,6 +159,7 @@ static const TypeInfo allwinner_sramc_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_init = allwinner_sramc_init,
     .instance_size = sizeof(AwSRAMCState),
+    .class_size    = sizeof(AwSRAMCClass),
     .class_init    = allwinner_sramc_class_init,
 };
 
-- 
2.34.1



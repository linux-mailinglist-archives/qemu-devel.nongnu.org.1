Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5C17081DB
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:54:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6U-0004Da-Hv; Thu, 18 May 2023 08:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6Q-0004Bk-3O
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:30 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6I-0007xy-8k
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:28 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f417ea5252so14056625e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414271; x=1687006271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xwItqdXeRUcy3ZRER30kEfBrQGOJx2J+XMMo/JwvEA8=;
 b=MDIUlxsajpkshcjXLCzeEie6FcUN2QJjL8Be6R/BvD3/Txa5HXzMj+Clgo56KlXeLH
 7XHo6J1VR9hsouEU4s3oZWe+4oDlyREEtmTKAkFa3eEcRaex8wosKAqs3ZsNLE2XaSBo
 9mL0iYHYQRU1X9nLVJZzXMKHDdZ49PghNLU4MPOKx/+WI/JS2cqZE/Zf6bhLAB4H500B
 4rldvWkhklrxAqWzuXpjJ+AJUf6VCNN2+UzsMlNfPD7jVNuzCkbNN1HwpwUXcBPOOWH6
 A9mPs7j7z3GmiND8hV8xVLPH57vMThfdyK57v/qf2jKzdqm1fS0R+13/M2rWNP0tpxKG
 Xj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414271; x=1687006271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xwItqdXeRUcy3ZRER30kEfBrQGOJx2J+XMMo/JwvEA8=;
 b=GkQEDM226srL4vGEcDSHj/pSOURyhRmAlXVynqsPHX60B4VcbvzLi83kYSrAsckLM1
 9iqrU3RZHypujSmGutSkaH3PvCK1Ld1yzVF6REyyeXySl/dAxmEWp3gXJLfAv1ooQvQU
 qnjTS2bKpuc4l2/XvY9+mBRmkZZGOaO1gTsWNj/f0DYBCeRhvTaxMkP4f9RllbWyx1vo
 m14J/aSXV0/IcF7FS+ZSvUXZZIhjG/kUmbYJrB4/kaSq0bItspgTEG7RTR/+lCcyJ5lM
 vOgt6Pz6z7dtJpVio9nIMbHYlgD9QEQkacE5kmF4CnU2+7crnKDnA9JIeHBNpwc5ljYU
 rK9A==
X-Gm-Message-State: AC+VfDzI++GBoqYpm9ZMONVUgAkidEeYworsLPlaynK3ZSuZY4i5MpKg
 iXQcDL3RT4ykGCbyZXb0GhF93lfc1KYcDj5qdWU=
X-Google-Smtp-Source: ACHHUZ6GfudeytutYTVdOC3I6e139UdTkxBn1KZP+gJlj19I5ayKRmomU0Uq3wLN0FgV852P4Vl77w==
X-Received: by 2002:a7b:c3c4:0:b0:3f1:75ae:1cfe with SMTP id
 t4-20020a7bc3c4000000b003f175ae1cfemr1436594wmj.7.1684414271598; 
 Thu, 18 May 2023 05:51:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/29] sbsa-ref: use Bochs graphics card instead of VGA
Date: Thu, 18 May 2023 13:50:44 +0100
Message-Id: <20230518125107.146421-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Bochs card is normal PCI Express card so it fits better in system with
PCI Express bus. VGA is simple legacy PCI card.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>
Message-id: 20230505120936.1097060-1-marcin.juszkiewicz@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index a1562f944a6..792371fdce5 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -648,7 +648,7 @@ static void create_pcie(SBSAMachineState *sms)
         }
     }
 
-    pci_create_simple(pci->bus, -1, "VGA");
+    pci_create_simple(pci->bus, -1, "bochs-display");
 
     create_smmu(sms, pci->bus);
 }
-- 
2.34.1



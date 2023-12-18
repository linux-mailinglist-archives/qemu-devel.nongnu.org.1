Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7EE816C92
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:39:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsD-0006uV-CL; Mon, 18 Dec 2023 06:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs9-0006er-5Z
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:21 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs3-0003Jq-9g
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:20 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40c41b43e1eso35324775e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899193; x=1703503993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lh3o7kEui0XF0sV1bPH07EOu1tlpcJ6HGtHE/IUXYQc=;
 b=Da8AXuiG2XQ2Boowp7J+LK4748Kq8FbRbRFCFJHC35L+l8K1LB0Bei4pctT+AFiAxy
 kSRGSh7mr6zthk+i7W8Nx9M6+rAm43yMi7SnaaKcf7hXNdnu0EZoif7DDt1o+QQ7mn4q
 fLAfvz50cumKJmwml1aC9lo5WOGwV7JTDHm5PLXwEN34x9WXX5GCCYHu7nGIuHAPObst
 HMh+Yz2OhM0CnNbmbX0cTLw3rTVgSEp1mv9o7a+k2XHnbkRGzWF3jr+jBmv+2gB285za
 9KKtq+xq90xJcUGszSjKkKuGdDUIsH87Ixg/jTcAhy4WC+e9UMK51WLeMnNLhTJX1CYj
 DBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899193; x=1703503993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lh3o7kEui0XF0sV1bPH07EOu1tlpcJ6HGtHE/IUXYQc=;
 b=RzSVXkZqTp2oNJS8fMB0LJ8PWh8T+1bE8S0GrFWqSulmzEOqasyfpKjwSGD12KiP3F
 RZ940dIvoHUQnmb5eV7dbMGmSC/PUhFOCIpjZ9codmxDg279PbASjIBFZQZwuDFBwA0h
 moJXBftt6Pdv8OqFp9CcMz2YGu89oy4JrR+VwWd3TfkMkpm2TFwHdOZ0/g39/zzoHOL5
 bOPz+azkVkQj5ea1OKa8qMiKYhrA4KvJp3UIJdMJ555VJ97YyE+4vH26b5jcYE2VdjRR
 q/JwnyvwDf0/9NSjyL6YwrBWo+kSypvqnylCohUI04MlNRCznocg2jt05bMJlbtO5lj8
 TEtw==
X-Gm-Message-State: AOJu0Yyj7grNtRDMKB0MVylYGLAQNrvjuroyDavLNQFjuZocwO/tb8dE
 pIRRP+wMg7ADZoCplOLBlcIIbw==
X-Google-Smtp-Source: AGHT+IECtowCfnKf+YOEg1kWCSlPORiv7DojnDfzZc4e1D660tFtuPK4APdQ+eflAmjOg7Kd1bNj+A==
X-Received: by 2002:a05:600c:4507:b0:40c:909:42ab with SMTP id
 t7-20020a05600c450700b0040c090942abmr7228640wmo.82.1702899193292; 
 Mon, 18 Dec 2023 03:33:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 14/35] target/arm: Make NV reads of CurrentEL return EL2
Date: Mon, 18 Dec 2023 11:32:44 +0000
Message-Id: <20231218113305.2511480-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

FEAT_NV requires that when HCR_EL2.NV is set reads of the CurrentEL
register from EL1 always report EL2 rather than the real EL.
Implement this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d060e24356d..6bfc39d8ea7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2240,12 +2240,17 @@ static void handle_sys(DisasContext *s, bool isread,
         }
         return;
     case ARM_CP_CURRENTEL:
-        /* Reads as current EL value from pstate, which is
+    {
+        /*
+         * Reads as current EL value from pstate, which is
          * guaranteed to be constant by the tb flags.
+         * For nested virt we should report EL2.
          */
+        int el = s->nv ? 2 : s->current_el;
         tcg_rt = cpu_reg(s, rt);
-        tcg_gen_movi_i64(tcg_rt, s->current_el << 2);
+        tcg_gen_movi_i64(tcg_rt, el << 2);
         return;
+    }
     case ARM_CP_DC_ZVA:
         /* Writes clear the aligned block of memory which rt points into. */
         if (s->mte_active[0]) {
-- 
2.34.1



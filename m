Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9237B7A083C
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 16:59:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgnmN-000166-6k; Thu, 14 Sep 2023 10:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qgnmL-00014r-4B
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:57:13 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qgnmI-0004O3-RV
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:57:12 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-401ec23be82so11096735e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 07:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694703429; x=1695308229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5tmvXXEw+PIenQIWy8ii+pQoWpYFcR+dhA762ZF8vgU=;
 b=yVyqLT6qz5spH23sy8LP6fT/XWzcglPhIF0vcopmtQsUH9j6qJm7+Jgq5TDIeIm4eo
 F5gsKbyf7nCUKwVzeIkaogSQgZPwUMBCWlB/RnTB1G6d2vYLZrlHBOhlIxmE1l6NS4FD
 8nWW8wtokeqQL/SGEublhpu2Fk6+Q2pvwUaRfaeab8WSBCNQfStW2krLzlbv3lNZnTKg
 jmmIcEVMzXKzxOyJ6P6AGaiZofpGtbukv+qj5YaVzj/iFv6Mnf/TQtNDKFAaDtGM4s4M
 mJjUuthDv2WiE2dEHNPO/caJJfTg25qmL8lbKoyIiOuUBEsTyHzWA26Tw6X2+MmC3lZj
 zKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694703429; x=1695308229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5tmvXXEw+PIenQIWy8ii+pQoWpYFcR+dhA762ZF8vgU=;
 b=T3GyB+ZXTZ6BD5MTkueyxBMIjmCCC3hYOb7KnWuPuUm/pdSpVniDPTbsmljlSN6z5H
 aTe+1+92gxoLTo0VtdVRo2wQQqSwrXsw8HtxUKTnOwL4Ge6GvGH+ptpZDOdyR1pf6aQB
 4d6IGdW6ZFl8F3+V+Cm98JWr+lLOL/6KHmf7EAVuNBmDvdEhubqP6jkfQzhH+JufezE9
 +iKtAYat2KlAO7oXQPlgkQxZyNc7oocfvQRsI7JXIxwIuztweePBdHYMkU3QXrL2/Saj
 JnR91CFzdFwSZmkJxx2NDvJa3LoscLDnIVBH1R9KnHFDZIR2w6kwVEsV0p+BOOpER2X5
 ALKA==
X-Gm-Message-State: AOJu0YwwhutKbeFG0u+7VFC9o8CgBPJR/4SJjr+wXG4BPhOPpgc/bwzN
 BadQMcw/L7+SihnuIB4HFgQ6WpsKiNsY1gt0h34=
X-Google-Smtp-Source: AGHT+IF/qqM16BIxW99H9bQE6sDnbMh8zbLXMtsmD1bolrD22vBSTneSbB/D2Gk19Nhke1Sv7S/CpQ==
X-Received: by 2002:a5d:6211:0:b0:31d:1833:4135 with SMTP id
 y17-20020a5d6211000000b0031d18334135mr4213971wru.28.1694703429214; 
 Thu, 14 Sep 2023 07:57:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 y15-20020a5d470f000000b0031981c500aasm1978483wrq.25.2023.09.14.07.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 07:57:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: [PATCH 2/3] hw/arm/smmuv3: Sort ID register setting into field order
Date: Thu, 14 Sep 2023 15:57:04 +0100
Message-Id: <20230914145705.1648377-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914145705.1648377-1-peter.maydell@linaro.org>
References: <20230914145705.1648377-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In smmuv3_init_regs() when we set the various bits in the ID
registers, we do this almost in order of the fields in the
registers, but not quite. Move the initialization of
SMMU_IDR3.RIL and SMMU_IDR5.OAS into their correct places.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 1e9be8e89af..94d388fc950 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -278,15 +278,15 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->idr[1] = FIELD_DP32(s->idr[1], IDR1, EVENTQS, SMMU_EVENTQS);
     s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS,   SMMU_CMDQS);
 
-    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, HAD, 1);
+    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
 
+    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44 bits */
     /* 4K, 16K and 64K granule support */
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44 bits */
 
     s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
     s->cmdq.prod = 0;
-- 
2.34.1



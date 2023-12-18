Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC912816C50
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:35:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBs5-0006aD-Cp; Mon, 18 Dec 2023 06:33:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs3-0006Yr-5t
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:15 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBrx-0003H6-IK
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:14 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40c3ceded81so27666515e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899188; x=1703503988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lyw7hmYvfBAXpzd5WD7qyMRqQcXNy82umQs3WP8yG8E=;
 b=Qp7W+1Ix6hRVgAink4bdpuBVLo6iIuHxSVu0ab6AItvUAzlAO0aaPWy9Zp0PvD07zj
 SQgBtgE/72ww03OGu73qRi0j5//7mcgRL5nvPzdvKZ3ENHgPQQW3wm3JFrHaTMeN81i7
 8cgSS7/ir9Jln1AbDbaQjOBcVaTr7Ek/rTK4GOp9dfxKDLiTP+IGtA3vC+LYCtSkpP+x
 +8r56bnuYvnuMqyrnJTsuBYSTCe0vP2/S2I0gXVGSuMENZN66ibi9RcOwmQSM85SqbHf
 U0iHvCMYwG8x+sXCtDmbS00l3EaiJ/oOBYzSVCkB0WBz1J2ZL9HZPtrUg6AmS98h5zHT
 F2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899188; x=1703503988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lyw7hmYvfBAXpzd5WD7qyMRqQcXNy82umQs3WP8yG8E=;
 b=tMQKSC+IRf+5rSSR/jasqHjH5ouS7EYoe9yPpvZrEBOGwb4F61IoGDgi7wq8H74Eiy
 NcVhRQFOW/vwkBRHsX8uiTz1BcuZvGMezKPWD8urn21nCdcYs6ErhqG3FltdBuxl2vVY
 5hgydLHLm2TbQsuo6cD7U2clPc0CkI0QG0QOo6w8gm0eu9lsB6QtHAh6IpcGyi9C1Srz
 gS04djNuV2YLc3iz5WAcvryosvxVWX+rliJfSSmSZoDYFeq+WGPHCGEnDPvoLHgN9ZCy
 PQPiptLtkIzUlCkPBHXEsNB1ml0O3FIZHQ+4oI6DUjKv3uZXtVvrjaix2i0WbyT4GguA
 3Vuw==
X-Gm-Message-State: AOJu0Yzd2fiTt6kJoVN3LosvIBo2qMa23mD8MoRKxlon9iQIOdec3xGz
 sv/g9NgYjT0r1PBzBi0RWjkqtysBSmmJokwckIw=
X-Google-Smtp-Source: AGHT+IGyZ2fTBElYgVezfiU9CASG0tWr0DwP2NrgGrS0QZzJp9RZUvnMaSwFzi7dvkZyk5uQoHU+uw==
X-Received: by 2002:a05:600c:1c93:b0:40b:5e59:e9f8 with SMTP id
 k19-20020a05600c1c9300b0040b5e59e9f8mr7900441wms.151.1702899187687; 
 Mon, 18 Dec 2023 03:33:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 02/35] target/arm: Set CTR_EL0.{IDC,DIC} for the 'max' CPU
Date: Mon, 18 Dec 2023 11:32:32 +0000
Message-Id: <20231218113305.2511480-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

The CTR_EL0 register has some bits which allow the implementation to
tell the guest that it does not need to do cache maintenance for
data-to-instruction coherence and instruction-to-data coherence.
QEMU doesn't emulate caches and so our cache maintenance insns are
all NOPs.

We already have some models of specific CPUs where we set these bits
(e.g.  the Neoverse V1), but the 'max' CPU still uses the settings it
inherits from Cortex-A57.  Set the bits for 'max' as well, so the
guest doesn't need to do unnecessary work.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is worthwhile anyway; it also works around what Marc Z
and I think is a KVM bug where booting the L2 guest hangs
if L0 thinks it needs to do cache maintenance ops, when
running all this under QEMU's FEAT_NV/FEAT_NV2 emulation.
---
 target/arm/tcg/cpu64.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index fcda99e1583..40e7a45166f 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1105,6 +1105,16 @@ void aarch64_max_tcg_initfn(Object *obj)
     u = FIELD_DP32(u, CLIDR_EL1, LOUU, 0);
     cpu->clidr = u;
 
+    /*
+     * Set CTR_EL0.DIC and IDC to tell the guest it doesnt' need to
+     * do any cache maintenance for data-to-instruction or
+     * instruction-to-guest coherence. (Our cache ops are nops.)
+     */
+    t = cpu->ctr;
+    t = FIELD_DP64(t, CTR_EL0, IDC, 1);
+    t = FIELD_DP64(t, CTR_EL0, DIC, 1);
+    cpu->ctr = t;
+
     t = cpu->isar.id_aa64isar0;
     t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2);      /* FEAT_PMULL */
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);     /* FEAT_SHA1 */
-- 
2.34.1



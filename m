Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AF2772760
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:17:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT12k-0002kV-0Z; Mon, 07 Aug 2023 10:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT119-0000B4-04
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:34 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT114-0005VM-DJ
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:29 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31768ce2e81so3998573f8f.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 07:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691417724; x=1692022524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pZEGgSdgHuR4AUV+YoPa8xV6M+CUbZlyZQlCkoU7l74=;
 b=sfnzhwLWm74Rc8LnxsYHnMVutQ5D9rPgo3BC7TE+6ntoPyaaFryO9TzWXceBDYJN04
 LY5Jox1CuaQ0wN0u89sQql9/+BDOjlS6TO+n91vRUMd9i1Vb4jkxnF1OtIKn6slR5yt7
 U2cFzStb62o+i82nnl3PMdimbKFHx347Hafk5jo7OUZVhqyRepluYgdWMGxqQKVjKrpc
 IpDRcyZfBOY3QiB1Ms9W+wjBbEJbxmCfBzrQtN7Oyp63ruhoz06SYUmNi85zZcLjsc85
 Gr/2vpYIu7NsuO00r0CruY6I6dxft1hvS34GXgNjDOJUYZR2nBdeGITB43Ek5G4/8S73
 OY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691417724; x=1692022524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pZEGgSdgHuR4AUV+YoPa8xV6M+CUbZlyZQlCkoU7l74=;
 b=ZalgcBpWwzJtPjeW/PaaG1LTeP+HthFGxUxtTtwhJGr/kIp0A/1DU5PbU4J5i3eFax
 lXXodHSf0lURi6gqhoVnojt1qgoRRjJK0+qNFcQcEvrYg0WDDHglhC/51vBoUdPxNXFh
 q7/+ajw2+9kPaCOVyCWjicjuhCbNlg5I3ParoDpP8ESEFLQ9T1DMPXaa+l16K+8HCSWc
 VCYv0NHGSzNCe5ysLDRRI4DoInVA/yLS6gsXGEAV3q0epLKfk4ZiAGuVZm714tXFV2MG
 NoLtMPZOM5RD0DeszwOzFkashUXsXHgF40tPW//+oHdLRxdSW8nxX+aplZXr4FweUDG+
 u/IA==
X-Gm-Message-State: AOJu0Yx9UgFvY1sjk9mYccQ5GqlsCss5hQJUS3W/mK/5Wqb7aHyTuNAG
 W6A1arxF45vXlzIkyNjDOy5GOg==
X-Google-Smtp-Source: AGHT+IE/MhkJP93MVwJ+ozygnj8lhZLuufihKk/oOFvWh/agZkUIxHf1EPWxCt5kcn1yJXC1uqXA8w==
X-Received: by 2002:a5d:4b89:0:b0:314:327:2edb with SMTP id
 b9-20020a5d4b89000000b0031403272edbmr7000898wrt.0.1691417724565; 
 Mon, 07 Aug 2023 07:15:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a05600c261400b003fe2ebf479fsm10835617wma.36.2023.08.07.07.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 07:15:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 15/15] target/arm: Adjust PAR_EL1.SH for Device and
 Normal-NC memory types
Date: Mon,  7 Aug 2023 15:15:14 +0100
Message-Id: <20230807141514.19075-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807141514.19075-1-peter.maydell@linaro.org>
References: <20230807141514.19075-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

The PAR_EL1.SH field documents that for the cases of:
 * Device memory
 * Normal memory with both Inner and Outer Non-Cacheable
the field should be 0b10 rather than whatever was in the
translation table descriptor field. (In the pseudocode this
is handled by PAREncodeShareability().) Perform this
adjustment when assembling a PAR value.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8290ca0aaad..da5db6d3ff6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3342,6 +3342,19 @@ static CPAccessResult ats_access(CPUARMState *env, const ARMCPRegInfo *ri,
 }
 
 #ifdef CONFIG_TCG
+static int par_el1_shareability(GetPhysAddrResult *res)
+{
+    /*
+     * The PAR_EL1.SH field must be 0b10 for Device or Normal-NC
+     * memory -- see pseudocode PAREncodeShareability().
+     */
+    if (((res->cacheattrs.attrs & 0xf0) == 0) ||
+        res->cacheattrs.attrs == 0x44 || res->cacheattrs.attrs == 0x40) {
+        return 2;
+    }
+    return res->cacheattrs.shareability;
+}
+
 static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
                              MMUAccessType access_type, ARMMMUIdx mmu_idx,
                              bool is_secure)
@@ -3470,7 +3483,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
                 par64 |= (1 << 9); /* NS */
             }
             par64 |= (uint64_t)res.cacheattrs.attrs << 56; /* ATTR */
-            par64 |= res.cacheattrs.shareability << 7; /* SH */
+            par64 |= par_el1_shareability(&res) << 7; /* SH */
         } else {
             uint32_t fsr = arm_fi_to_lfsc(&fi);
 
-- 
2.34.1



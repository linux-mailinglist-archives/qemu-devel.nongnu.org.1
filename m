Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F77673B7E0
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:44:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfxL-0002bX-G4; Fri, 23 Jun 2023 08:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx8-0001le-Nw
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:50 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx6-0000hZ-30
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:50 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f9002a1a39so6493385e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523505; x=1690115505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FIM0jkrJI5QtjGm4m8RJZDPmz1IjyL1s0JAX6s9xjdM=;
 b=yE7ve3yDqcbwC5F5R4bLUFyGnzsTg8RzwXRsaupFGoK7zr1Sdcqw0z0B3eMLjJTmRC
 EPM0Gdm7tHLXjJDqHGJjejN8XovtmcYljKWBtwnTz3D3ixwWC3SwDswI4Bd+gpfOx2uv
 OdJgdlmc265H2i2dhwshS3hz9P26P3+n1FsSsWHSzqjtTNG+u57I2nh10iuPRku0q1hI
 gDE6HTbE46RsqQmOuasnewGWt/OCQmSruQrrtOUCPDXgSzkvPtNNfRi4gpcI0Gin1PEG
 oPPLj/7LWc/7yM1/42nP2Nj6J2kqDnNvHVWSXYp61TOZGqgO1SCc9mcoFUTApWtqvgQA
 bHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523505; x=1690115505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FIM0jkrJI5QtjGm4m8RJZDPmz1IjyL1s0JAX6s9xjdM=;
 b=OiDhlfsZlNUkossxZRZP4cSL/WbYYE4lDhJxQCjGfz6Eb6wc5TaBkcP9ZZ1g7UbSui
 E5hac4wVYaJivsKbZXjiVk/rgyMsrhjSIH9CkAyjVVjooelmQv8O/nHNFdgAAfGyqdb/
 rUkaqbJe3tQWvxpl8JVm5aVOCuda1PPMXxvgF2HaxmZ55rqJato9QBNvSxFFtBO7MNlx
 xuQ6RvfKNlXvRsnREMHxBoBQClhxCx98u2BaB1/iXAheTKiC+7R4zNgb/Ml21Op8Gv7/
 w8tOfkUe0Vui52PiHOB/krE2aDA9zHaEyfNB0aab8zAXSy1G8wt1ToOQ7zqndjbH9ZPO
 pOuQ==
X-Gm-Message-State: AC+VfDy0uQqPTBrmmp/SGwoYV86k0ivdnojOG8G2WbICjXHLQgl29QfF
 UUkOK9zrjEcxF9Ax4Q5dW/ctkLDXbwl/RPQ2m8g=
X-Google-Smtp-Source: ACHHUZ5RLyzVadf9MYDcaB6wuiocyv7v9c5UKP1ftm+jBX86PhLipsD8Oa/fl0yvMJK0xbeO/El8bA==
X-Received: by 2002:a7b:c385:0:b0:3fa:77d0:c7b0 with SMTP id
 s5-20020a7bc385000000b003fa77d0c7b0mr2823619wmj.23.1687523505440; 
 Fri, 23 Jun 2023 05:31:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/26] target/arm: Add GPC syndrome
Date: Fri, 23 Jun 2023 13:31:26 +0100
Message-Id: <20230623123135.1788191-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The function takes the fields as filled in by
the Arm ARM pseudocode for TakeGPCException.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230620124418.805717-18-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index d27d1bc31f0..62254d0e518 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -50,6 +50,7 @@ enum arm_exception_class {
     EC_SVEACCESSTRAP          = 0x19,
     EC_ERETTRAP               = 0x1a,
     EC_SMETRAP                = 0x1d,
+    EC_GPC                    = 0x1e,
     EC_INSNABORT              = 0x20,
     EC_INSNABORT_SAME_EL      = 0x21,
     EC_PCALIGNMENT            = 0x22,
@@ -247,6 +248,15 @@ static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
         (cv << 24) | (cond << 20) | rm;
 }
 
+static inline uint32_t syn_gpc(int s2ptw, int ind, int gpcsc,
+                               int cm, int s1ptw, int wnr, int fsc)
+{
+    /* TODO: FEAT_NV2 adds VNCR */
+    return (EC_GPC << ARM_EL_EC_SHIFT) | ARM_EL_IL | (s2ptw << 21)
+            | (ind << 20) | (gpcsc << 14) | (cm << 8) | (s1ptw << 7)
+            | (wnr << 6) | fsc;
+}
+
 static inline uint32_t syn_insn_abort(int same_el, int ea, int s1ptw, int fsc)
 {
     return (EC_INSNABORT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
-- 
2.34.1



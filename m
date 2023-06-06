Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D68E723E56
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:52:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIz-0007pw-Io; Tue, 06 Jun 2023 05:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIt-0007nI-L7
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:39 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIq-0004r7-7g
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:39 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-30b023b0068so4235486f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044914; x=1688636914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Sfywex8mVPl2xoXikd1mJIQYP1AHDSi3msgZeYY33JY=;
 b=YE/qaV+SWJyQrcNYyWckjjLLpmI/DeYhyvGESggUfNPognlLUeXceBqaVjpJmqIR82
 KNg0xHqkCCKE0IJJgoxYKezDp/rC43uSUYOviKvfRUILV5YqEUp1DVIM0UQ+Vks0MuWZ
 PuK2HtukWalpjmn2G4e0de62lkyIxiChgQT0ZApnjUGdzalII2JikVsK0eLfIFsO0bWQ
 T7Gf8MCc3G3a0XoDy3y+H+Czcg8p0e8L3jqPuQXH7J8hmF2N+E06aDSLM6GnRgwgXi0r
 YfZi73TEyrf8t4BMXjkXmFfMk+fnKLu9upT5UfJ4jtwmJfa5LIixgoopJ6OH87E4bVQK
 d18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044914; x=1688636914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sfywex8mVPl2xoXikd1mJIQYP1AHDSi3msgZeYY33JY=;
 b=Z4Nw+fvFjyyflWp4aNy1XRT01aGBR+wlZvHAizCoCJLuGXOAgIqk61oRbEyCqUmkW0
 AAoG4j+BAUkv89IwYoZ2hSJwErvZ3b+VPFH9NF4Mj0CpgDIqSWZnWLJPqpz9NrpsmsZv
 c3E6q9pvnfXs4CMWa8xwiOXje2WaoMsH5LMG+w4Rtn9BG1MUCFeEuCYsmIg6IOHLmUU8
 h918PQhhBDXCeku3lQ7AtTgR1he4LoOdWzx0ljaM6NQvbLSVtINHR/mV7jg3KgoYmHfv
 yR5xLdO+UvXsMgLXVpTycmG+SwKQDTFXdBI0+xZdx73V6bmcIza0sC+Z9mhWlze4+7wt
 RRzw==
X-Gm-Message-State: AC+VfDy1yVZnA1ucgN3PXYDmkx4JGKCbsakbdGZ+1TsByuK18hohX6jp
 kFqiZEV4elP7QFvXuS79WdH/GjHgkqDFv1N3GMg=
X-Google-Smtp-Source: ACHHUZ5ZYtMrMIJxYpxh0T+G/0Z37AkPShMzcdchRT106PyK34gm+rQHNDhnvUmKjl3O8YOJGYdGXw==
X-Received: by 2002:adf:f4ce:0:b0:30a:900b:6bf4 with SMTP id
 h14-20020adff4ce000000b0030a900b6bf4mr8667493wrp.0.1686044914792; 
 Tue, 06 Jun 2023 02:48:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/42] target/arm: Enable FEAT_LSE2 for -cpu max
Date: Tue,  6 Jun 2023 10:48:11 +0100
Message-Id: <20230606094814.3581397-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230530191438.411344-21-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 73389878755..ecbbd63adf6 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -50,6 +50,7 @@ the following architecture extensions:
 - FEAT_LRCPC (Load-acquire RCpc instructions)
 - FEAT_LRCPC2 (Load-acquire RCpc instructions v2)
 - FEAT_LSE (Large System Extensions)
+- FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LVA (Large Virtual Address space)
 - FEAT_MTE (Memory Tagging Extension)
 - FEAT_MTE2 (Memory Tagging Extension)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 886674a4436..2976f94ae45 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -644,6 +644,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR2, IESB, 1);     /* FEAT_IESB */
     t = FIELD_DP64(t, ID_AA64MMFR2, VARANGE, 1);  /* FEAT_LVA */
     t = FIELD_DP64(t, ID_AA64MMFR2, ST, 1);       /* FEAT_TTST */
+    t = FIELD_DP64(t, ID_AA64MMFR2, AT, 1);       /* FEAT_LSE2 */
     t = FIELD_DP64(t, ID_AA64MMFR2, IDS, 1);      /* FEAT_IDST */
     t = FIELD_DP64(t, ID_AA64MMFR2, FWB, 1);      /* FEAT_S2FWB */
     t = FIELD_DP64(t, ID_AA64MMFR2, TTL, 1);      /* FEAT_TTL */
-- 
2.34.1



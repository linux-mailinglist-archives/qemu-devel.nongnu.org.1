Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D41B7716D59
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:18:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44ou-0007iT-RM; Tue, 30 May 2023 15:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44o9-00079K-Fg
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:15:05 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44o4-0004g2-Px
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:15:01 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-256797b5664so1748778a91.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685474096; x=1688066096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9dWxpkriL89hdVCzkPxCT8S4I2dcQ51ihNaTFHcE9jo=;
 b=sDcRGaj/6M7xFwRlS2r9a9WUSpMqse5F4KGwfJqi/AN/R+PS/rckiyo+h85RpOP4Fu
 a+zGbgSDeCmjpGOTB0w0tTuFlQ7sw8JqaquD5QBFdKGaacEpyqlJXZws3fW6AUcgbq/n
 vqRhcnaCfQgTanqinRw6ek8C/BseCrz+GcJMiJGpjZVbs4FTctU3HVGW0jcejX4Hv5/U
 pvPDwyEQK9+wCswTPOoPOkh4DCSgrRrgpIfSWSZu8oIucdm65PZ/PsmlHaayWHWgnpR6
 2PiRmqvBIAz52vS2WyeERPwqUvOSEdvf9GSnRZ+OTmtA3pVeQp2RwdgoxX21wk3U6qgM
 pcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685474096; x=1688066096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9dWxpkriL89hdVCzkPxCT8S4I2dcQ51ihNaTFHcE9jo=;
 b=LPV+AJ9Kf4bGjj6XS5eAK/qhWh6pAI1pM0aQtQG4C/j5VJQwv/CTbpiA3Yp2hT4l9q
 ZbHFD4QSOJHr2kT3BSvMJmh3PIFmH9qVZesc4Rz709hyhkChPj4LaNvxqRVEXn1OXYAb
 Tx5Ef5MWdC9NZXS8hWZvZDTO8U72hXpx7EMMMGP1Mg7n3N6zS64owNkupRtzEvJ4Cp3Q
 ubnNabMbG08sRaxH4wnElH41dbk7KQAol35J4od7sqs4dOppZUKab/ni8pFLNLn43FMi
 TGO+zVslpjnhDnI0058J4iWC2DhHPsNuZL3YZlNsBwkU0OcaEgj/+ycBkGua2YMosd30
 ieuw==
X-Gm-Message-State: AC+VfDz2pCE4po5tJH/RwdNOePR3OhW9n7dv8p4QCpA208W9EUn59mZA
 iCpl8sOBq/q8TNWeOFsPxIK4rLvSNWjq3WIZFV0=
X-Google-Smtp-Source: ACHHUZ4g4GJJXNQxy/Wx0j+EbYFuRiexjn2OixrspyXwGU5e4T++zSP0qfRH0ACc0rrAHbAQPXwYSA==
X-Received: by 2002:a17:90a:540b:b0:255:d1b1:a8f3 with SMTP id
 z11-20020a17090a540b00b00255d1b1a8f3mr3558347pjh.26.1685474096043; 
 Tue, 30 May 2023 12:14:56 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 10-20020a63104a000000b0051806da5cd6sm8926757pgq.60.2023.05.30.12.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:14:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 20/20] target/arm: Enable FEAT_LSE2 for -cpu max
Date: Tue, 30 May 2023 12:14:38 -0700
Message-Id: <20230530191438.411344-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530191438.411344-1-richard.henderson@linaro.org>
References: <20230530191438.411344-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 7338987875..ecbbd63adf 100644
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
index 886674a443..2976f94ae4 100644
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



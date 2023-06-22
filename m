Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC0673A315
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 16:32:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCLKo-000408-VU; Thu, 22 Jun 2023 10:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCLKn-0003zj-9F
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 10:30:53 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCLKl-0003HW-JH
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 10:30:53 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f8777caaa1so5494212e87.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 07:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687444249; x=1690036249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SBgXlxp5+kgTJJ2w9eh5o8PXtNssQstwip1zGaYJPdw=;
 b=bFEwqiNea4khZGMWsOysSMm1AVPMRmj54bmCXZbbpGPNIMNMcH2+cmRzoDqSTeDwuy
 Cgeq7A4Xmg56uKgijQ9S/2x4p8w5qJ+TMmmWHAMlx7UU4MqqCsXSAn2dGfJHNlMCodj7
 Q7/JzxGeSbP/47bkYUKhqSyT4vnjZ7isJ/RpJ7ZuXpAdSYwKwbX/4Tg35XPlzFVX1xbp
 Ou/V95DZIzzj6sLNQJWd2spHj7tLrPRZ+Z7bR59DwJyPdHEgLzujpDuc50UgUizytUve
 xbZ3MVyOKHeRpt/mwVli9y2JC4yN/e9nSUAdEn3FEXknIcBInnJkgfoWjDQvApmTprTp
 vHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687444249; x=1690036249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SBgXlxp5+kgTJJ2w9eh5o8PXtNssQstwip1zGaYJPdw=;
 b=VKSg3byU/osKOb3ypl1+QPdZ399EAOXr0X71LM+XphiuOfCovcAS0qBe9n3ktOFR6n
 4zG9gDeH2lEAdTw4nVqVF1V0k9co/sTwt8ys7MFf/cFigYKASEA+p77TeUDkufZV2RXB
 om3pPZWvm4ijl9fKSvipTJDLLHqH/uqoREp7gvLzhEwwNxOg5VYQabFtLyYPPSnAlA7a
 C2a3WGu5nXhte5dbmG7nWbQm9AzxrkDBp8WSYWPlZzlrhlmGjAbd6uq+g4e1fF4OOFse
 UTMbaHogL7NkaAORO3foiwuliG9UNU1TNdYyXyBs6HhgFGOol2shQxpsRyqiWeK6iEF3
 0bWQ==
X-Gm-Message-State: AC+VfDy25XSFDFO41AtPMD/CI42OFeBrKjL621uAEg22WV/79+9StQZq
 Ns9l3n0SzUTLXmTVzF30xnCBP2ICvHwWnxdgI3QAhtG8
X-Google-Smtp-Source: ACHHUZ5eET3kR9eHMzttneCPzDE7pIKWROlTz/949TKs7rN0AcndDDY9vsIKZmwRvVQsXGfnpfY+pQ==
X-Received: by 2002:a2e:3816:0:b0:2b5:68ad:291f with SMTP id
 f22-20020a2e3816000000b002b568ad291fmr5436120lja.19.1687444249153; 
 Thu, 22 Jun 2023 07:30:49 -0700 (PDT)
Received: from stoup.. ([91.223.100.38]) by smtp.gmail.com with ESMTPSA id
 w16-20020a2e9bd0000000b002b345f71039sm1351957ljj.36.2023.06.22.07.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 07:30:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH] docs/system/arm: Document FEAT_RME
Date: Thu, 22 Jun 2023 16:30:46 +0200
Message-Id: <20230622143046.1578160-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x133.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/cpu-features.rst | 23 +++++++++++++++++++++++
 docs/system/arm/emulation.rst    |  1 +
 2 files changed, 24 insertions(+)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index f4524b6d3e..741bf3a299 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -435,3 +435,26 @@ As with ``sve-default-vector-length``, if the default length is larger
 than the maximum vector length enabled, the actual vector length will
 be reduced.  If this property is set to ``-1`` then the default vector
 length is set to the maximum possible length.
+
+RME CPU Properties
+==================
+
+The status of RME support with QEMU is experimental.  At this time We
+only support RME within the CPU proper, not within the SMMU or GIC.
+The feature is enabled by the CPU property ``x-rme``, with the ``x-``
+prefix present as a reminder of the experimental status, and defaults off.
+
+The method for enabling RME will change in some future QEMU release
+without notice or backward compatibility.
+
+RME Level 0 GPT Size Property
+-----------------------------
+
+To aid firmware developers in testing different possible CPU
+configurations, ``x-l0gptsz=S`` may be used to specify the value
+to encode into ``GPCCR_EL3.L0GPTSZ``, a read-only field that
+specifies the size of the Level 0 Granule Protection Table.
+Legal values for ``S`` are 30, 34, 36, and 39; the default is 30.
+
+As with ``x-rme``, the ``x-l0gptsz`` property may be renamed or
+removed in some future QEMU release.
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index ecbbd63adf..b54718a867 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -66,6 +66,7 @@ the following architecture extensions:
 - FEAT_RAS (Reliability, availability, and serviceability)
 - FEAT_RASv1p1 (RAS Extension v1.1)
 - FEAT_RDM (Advanced SIMD rounding double multiply accumulate instructions)
+- FEAT_RME (Realm Management Extension)
 - FEAT_RNG (Random number generator)
 - FEAT_S2FWB (Stage 2 forced Write-Back)
 - FEAT_SB (Speculation Barrier)
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D22F473B7DD
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:44:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfxP-0002u7-FU; Fri, 23 Jun 2023 08:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx9-0001nz-FG
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:51 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx6-0000iL-Du
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:51 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fa23c3e618so7632945e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523507; x=1690115507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R8SxyUK2MeJ9M9x81z3qduNHsB+tE3Mvd9ZEm4Vxx/c=;
 b=wsEplZ+Ovk7uJHSv5guqeVKkDA+p6We6opN70VqsAmAeZxxN5yXFdHiB3knARQ9+WF
 BU5yZduow3o3yWX/e4vfDHIvkkwMZLclEnUsSW9B/OCbE/AwS1lXxQdCwPubHG5Rnugu
 iKx3blh4Zj7rk0xoAqmtcRxRDbi/hXPxxkFhyVG4yRl4+0dC3CtcSCRyZY1V/QvoMFnr
 Oc/mObghUV3LRJlexb3Ha4tR2pnsCkJMaArhzxNdYcIa0wNw33Bmp9gioeUnH/hyYMbb
 sCEjW9AVpquIoqYccjyugzE0b1x+re4L17ZlopvwX/rH874OrO8WHoBaC5/VoDBYOMtz
 VzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523507; x=1690115507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R8SxyUK2MeJ9M9x81z3qduNHsB+tE3Mvd9ZEm4Vxx/c=;
 b=OSvfZmJa98Ruk4AmSPrblNJnHekIyom6obpxrdP8WwuvM4ytyM41bEX3xxqfOyCG+r
 na0zPhOAZHZbVmcI3Js5P2RoTq8Ic8B2FFGftruXoTYRiGXQ+ttHgbDPJPNWOTDLfmo6
 9qrPWwWIJyWQwbKamDSuY3QWb6zakKKnHPp7YjnEqaOlei3KrtJiijRh/oHTms4UhwTG
 3+Q/rUTas4K9wx8oz+N7Gjrr3YW5yCA5vQMtunm6q+1GSgtTe8E7jhZd+Ve/SzZyAfLs
 cq3qyp9fVRRTZDk7lWHgI5zC7ke+DST+BUfXR1kWYB+KR8aZvBkNRPH23YZ/WltP2fCU
 LOCw==
X-Gm-Message-State: AC+VfDygcxmrseJ/nAgiQUtC7n1hL+bkMwfj4sN31NsLr7qU2EcNx8LQ
 9F2jtMHKwnvQUQgfIRHNLtqEuGFaPwSAEL1c2wQ=
X-Google-Smtp-Source: ACHHUZ7lpSKF0B3qIftZ51Eb3Tna4nQUiPjC+eYioERBKz1RxBV2SwiN6W9Tj6gSn5fdKOkh1gpxlQ==
X-Received: by 2002:a7b:c7d3:0:b0:3f8:fe9b:e1f6 with SMTP id
 z19-20020a7bc7d3000000b003f8fe9be1f6mr15581970wmk.10.1687523507079; 
 Fri, 23 Jun 2023 05:31:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/26] docs/system/arm: Document FEAT_RME
Date: Fri, 23 Jun 2023 13:31:30 +0100
Message-Id: <20230623123135.1788191-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20230622143046.1578160-1-richard.henderson@linaro.org
[PMM: fixed typo; note experimental status in emulation.rst too]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/cpu-features.rst | 23 +++++++++++++++++++++++
 docs/system/arm/emulation.rst    |  1 +
 2 files changed, 24 insertions(+)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index f4524b6d3e7..6bb88a40c77 100644
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
+The status of RME support with QEMU is experimental.  At this time we
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
index ecbbd63adf6..bdafc68819b 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -66,6 +66,7 @@ the following architecture extensions:
 - FEAT_RAS (Reliability, availability, and serviceability)
 - FEAT_RASv1p1 (RAS Extension v1.1)
 - FEAT_RDM (Advanced SIMD rounding double multiply accumulate instructions)
+- FEAT_RME (Realm Management Extension) (NB: support status in QEMU is experimental)
 - FEAT_RNG (Random number generator)
 - FEAT_S2FWB (Stage 2 forced Write-Back)
 - FEAT_SB (Speculation Barrier)
-- 
2.34.1



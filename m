Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C5E7868F7
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 09:55:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ5Ab-00074I-Uv; Thu, 24 Aug 2023 03:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZ5AZ-00073X-0E
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 03:54:19 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZ5AW-0007Eq-Ly
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 03:54:18 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31c4d5bd69cso3522541f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 00:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692863654; x=1693468454;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/+SWCWeMS2SVav6aA7YxrlYTBPZwPBaizY0TGZfUhvM=;
 b=HGgFeR97xoRCaPdgGyoqy8QKHuP5U9Twyi9Ra8zeKIGcQwVPBl0FtYSIPYaBtICHMD
 pUHhhwcgKJ1ewA07ZNG+vL06SjHzz8dYlO2dyr5Q8bICCXttHDwZLq+AgPdBF4lsHk2B
 O+RlTK0BYYat9gv09QKPJhkEzdzMddg5QJ2/Xo71nlep2g9E2/3dwAOI518UsllWZvM7
 PpP2K+74AS+rAIDI2vNpq16Th6+p98pAAEvwY8oTQjgicodEEw99gKu18AUuIAcPhuh4
 bxCL2x8A+CH9bIopmTBX8dRxL9sIt6L2wywLPuK7yKq5QiA+HzcN/bkJ5KRcI6EhMq3G
 L+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692863654; x=1693468454;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/+SWCWeMS2SVav6aA7YxrlYTBPZwPBaizY0TGZfUhvM=;
 b=mCgQbcQnAbiHsF4F15e/OwfvVuoyyJmzW+G40h1wVVqcssBQoja7klpZcwNWTyrMnV
 z+WD8D5OKfqKhhNjXcX5j6jN6qj4VjyY8uSYHRLlwJjzAJG/KYdfkIXclJCJaVKGDmBw
 wL8I73mQb8TWzgIf4O6qY+ZGdcAhtUaEkQWog8LQL/Vg6xnAlPm6kVp6lLo8918MP/RJ
 Zj93mZv/GzTNPnKNaPDNqEKyS24dVueFBg+Q+dcrB/9fkQVCtU9OacWAEhzhvUSNe1RM
 YzxnpgqQKmNnkkRV722GY4M3X/VXnswGRWxEVu32I6VPMR9toLadXV9yVbeObMN+ecDJ
 YPhw==
X-Gm-Message-State: AOJu0Yyi9gMs1+m2fr3qzKq6+IebbCKEi5DoERwD/I35sOl7sYHy3uKr
 s8jlcvmf2cqCnzY8ltQ68o9evw==
X-Google-Smtp-Source: AGHT+IGGUgrJk7BxVQ1ejuErPqxZkKtgktRD+6nviQX5bK7poBOUCP4o80Wsui7XJ/y9WkWwicJ/7A==
X-Received: by 2002:adf:e990:0:b0:319:6d8a:75f8 with SMTP id
 h16-20020adfe990000000b003196d8a75f8mr12462990wrm.44.1692863654352; 
 Thu, 24 Aug 2023 00:54:14 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m14-20020adffe4e000000b00317b0155502sm21853730wrs.8.2023.08.24.00.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 00:54:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 89B661FFBB;
 Thu, 24 Aug 2023 08:54:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH v2] target/arm: properly document FEAT_CRC32
Date: Thu, 24 Aug 2023 08:54:06 +0100
Message-Id: <20230824075406.1515566-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

This is a mandatory feature for Armv8.1 architectures but we don't
state the feature clearly in our emulation list. Also include
FEAT_CRC32 comment in aarch64_max_tcg_initfn for ease of grepping.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
Message-Id: <20230222110104.3996971-1-alex.bennee@linaro.org>

---
v2
  - dropped the breakdown of setting ID registers in other CPU init fns
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index bdafc68819..65d1f39f4b 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -14,6 +14,7 @@ the following architecture extensions:
 - FEAT_BBM at level 2 (Translation table break-before-make levels)
 - FEAT_BF16 (AArch64 BFloat16 instructions)
 - FEAT_BTI (Branch Target Identification)
+- FEAT_CRC32 (CRC32 instruction)
 - FEAT_CSV2 (Cache speculation variant 2)
 - FEAT_CSV2_1p1 (Cache speculation variant 2, version 1.1)
 - FEAT_CSV2_1p2 (Cache speculation variant 2, version 1.2)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 8019f00bc3..1975253dea 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -743,7 +743,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2);      /* FEAT_PMULL */
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);     /* FEAT_SHA1 */
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA2, 2);     /* FEAT_SHA512 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, CRC32, 1);
+    t = FIELD_DP64(t, ID_AA64ISAR0, CRC32, 1);    /* FEAT_CRC32 */
     t = FIELD_DP64(t, ID_AA64ISAR0, ATOMIC, 2);   /* FEAT_LSE */
     t = FIELD_DP64(t, ID_AA64ISAR0, RDM, 1);      /* FEAT_RDM */
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA3, 1);     /* FEAT_SHA3 */
-- 
2.39.2



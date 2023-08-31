Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E12C578EAC0
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:46:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfBJ-0003m1-4R; Thu, 31 Aug 2023 06:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB5-0003YS-L9
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:32 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB0-00043J-BV
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:29 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fef56f7248so6271045e9.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478724; x=1694083524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V+aecnBNWTPodaj6GhkLLfWe+WYRhpIxXHTBKvGRaTA=;
 b=fh1M1XCJLQCVkbRJMHus0gXfPC4AGFC7G44pvZlyHtKjhOLEGkdCIaT2D2i+gRQk1c
 kST7dXOTwQXVkj2YpHPhPhRLDr7ZPzEb54hRn3QcU6g2/4puRjOD4AVzc83PqrQIu+xI
 4rIchycNTGlpiz1iwQ0ijkbS0fCTvZYm9ODQRcCRzaqy0CALTr5CsrKH//GmXAtMXFa2
 fl1l6/7HoqYjkgBSVtmCYPnfM2PnIACDS/fYI8dU8zvw/Q1BaYQRQ3cY3OiXQlevr7gL
 UFyebQPEH1uh7o95SHW3jzdKAj3iZS2vR6nrSHAbzwps24z36KeL2BrO9K8uL3UUvk+N
 8YyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478724; x=1694083524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V+aecnBNWTPodaj6GhkLLfWe+WYRhpIxXHTBKvGRaTA=;
 b=KaNIPnLCYFIPIgm+1dhkPZuCKQPq1aaJPEzq7izWr6zd0efbiw/DAfa843C61BewJm
 iq4opbjGrLPxgZeeh7uZNFHI4V07OltxRVg+7aXC5OjYC2PgIx54GNTnf4Jvxkiq4wLH
 gyxqFf4lLQoboYU6xnVVukd7jlnCSVJQg8YcWB20r9VGK5ATgiEJvHb/5MONxk+rH3V+
 7WgoG0pZ42045sg0ta/hMUQ3yIWfSt/Dkll6T6yrPJj9Ff2BC/bcGWmlmvrcoyi9L+kD
 JMWiAOIhia+MpTIggh4nFUjLbQZlU19kiydE0ZQjfXr2dyhOKmPGONtBVrhej1Vd+1zr
 uREQ==
X-Gm-Message-State: AOJu0Yz6Vv8nlJz235vxPnY8GyMiP99D2nniw5+P/tKYHPor+IUyHI+Q
 jFMGVqvyXfIpjc7iU0u5WOKYs/x/eNiPVuVBzvk=
X-Google-Smtp-Source: AGHT+IG3nYL3qkfDouOa42DG57oIWH1GVP/+iNPT2+7oqm5PsCGheRoMzi5hcEYB8vCnxT99BGT9EA==
X-Received: by 2002:adf:f0cd:0:b0:317:5722:a41b with SMTP id
 x13-20020adff0cd000000b003175722a41bmr3690931wro.7.1693478724757; 
 Thu, 31 Aug 2023 03:45:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/24] target/arm: properly document FEAT_CRC32
Date: Thu, 31 Aug 2023 11:45:05 +0100
Message-Id: <20230831104519.3520658-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

This is a mandatory feature for Armv8.1 architectures but we don't
state the feature clearly in our emulation list. Also include
FEAT_CRC32 comment in aarch64_max_tcg_initfn for ease of grepping.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20230824075406.1515566-1-alex.bennee@linaro.org
Cc: qemu-stable@nongnu.org
Message-Id: <20230222110104.3996971-1-alex.bennee@linaro.org>
[PMM: pluralize 'instructions' in docs]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 2012bbf7c7c..2e6a7c8961e 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -14,6 +14,7 @@ the following architecture extensions:
 - FEAT_BBM at level 2 (Translation table break-before-make levels)
 - FEAT_BF16 (AArch64 BFloat16 instructions)
 - FEAT_BTI (Branch Target Identification)
+- FEAT_CRC32 (CRC32 instructions)
 - FEAT_CSV2 (Cache speculation variant 2)
 - FEAT_CSV2_1p1 (Cache speculation variant 2, version 1.1)
 - FEAT_CSV2_1p2 (Cache speculation variant 2, version 1.2)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 11e406d960e..0f8972950d6 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -788,7 +788,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2);      /* FEAT_PMULL */
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);     /* FEAT_SHA1 */
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA2, 2);     /* FEAT_SHA512 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, CRC32, 1);
+    t = FIELD_DP64(t, ID_AA64ISAR0, CRC32, 1);    /* FEAT_CRC32 */
     t = FIELD_DP64(t, ID_AA64ISAR0, ATOMIC, 2);   /* FEAT_LSE */
     t = FIELD_DP64(t, ID_AA64ISAR0, RDM, 1);      /* FEAT_RDM */
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA3, 1);     /* FEAT_SHA3 */
-- 
2.34.1



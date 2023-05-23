Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A249170DE3C
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:57:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1STV-0007Ae-Mk; Tue, 23 May 2023 09:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSN-0004xv-CE
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:45 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSK-00033T-GY
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:42 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64d2e8a842cso3796477b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850018; x=1687442018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WPQBaswIL5gnAeFH0J21sek4FINXtGXGMKXaBWTmSWg=;
 b=iecY4XBe8xGsyvF5KZfOu2H1chE4haPRyj0TjMwk4dduer4AKHPHa+nGHsO9IB8VSa
 9P09LZJ4ZC4+Ds5vZewgYg19CDNZi3sZvZrB82tkq43G9eMudLg2m7hWPjCcB/6A9+HR
 oAvN6rhHmXyUAwhTmWpFM1Ov7WAzijzhkpZ0t+cCt13j9hzgD5VXYrMpKWD+jqB3tfp+
 WPiqpkK+BQ803+3AHkiregeTLlLj5zacXWb7f75sNXhDyCqQqlWuKd3vJ1lNfKj1TXti
 27kacT55Gz0Wtmzd0hiRAn69q0owhvaaDuBtCLpHFgpg38xql+meX77DtV8azGsHLHga
 f3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850018; x=1687442018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WPQBaswIL5gnAeFH0J21sek4FINXtGXGMKXaBWTmSWg=;
 b=D6kCd+LDrL6nxUH9ZN/6IwDIcfBUUJ2UCwWGY9RdAVn3NbYQgwpV/rO383U9IpCZQn
 xmyeJ66EsCPgjdbHVwRHxR4dXU/BBjtC7NdwUJLtRF4B0obH7IXd3Ezn8ypblBfYV8XY
 Y3u4g/PtYBE3i81RYnjnQBkFjPRZcuIDHpLW1zTkRwYn2VlB76WUKrWRl2Ahatz1fi5S
 UwyPo2cBl7c8UWKihh64XE3gmNzzJMZTlc3X2ed7VUWHs2IsbTgSnd2eNsPPNnnWzPkQ
 YA9tJvqd0dmln0xVMEgT8RStywjrAzIaYjthaqtSyPlYxoE3BePXiGfGH0m6QcE8vo9J
 /PQA==
X-Gm-Message-State: AC+VfDwvVSMsTc7XEX+y0pRi87snA06xjQYuUqGDpb7VhIR9kLztjjgO
 p671UKwQolf0aB88r+fGv7Gu5p2c/11paL5PyWw=
X-Google-Smtp-Source: ACHHUZ6tg0IQgSFe0zDpx6/eovL/7T4HQN18X2c/NKUeewGRnyQr7el3MCKr8+TO/oaPEyLxD4hsXw==
X-Received: by 2002:a05:6a00:1487:b0:64f:3fc8:5d26 with SMTP id
 v7-20020a056a00148700b0064f3fc85d26mr3460352pfu.9.1684850018110; 
 Tue, 23 May 2023 06:53:38 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/52] target/arm: Include helper-gen.h in translator.h
Date: Tue, 23 May 2023 06:52:47 -0700
Message-Id: <20230523135322.678948-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

This had been included via tcg-op-common.h via tcg-op.h,
but that is going away.

It is needed for inlines within translator.h, so we might as well
do it there and not individually in each translator c file.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     | 1 +
 target/arm/tcg/translate-a64.c | 2 --
 target/arm/tcg/translate-sme.c | 1 -
 target/arm/tcg/translate-sve.c | 2 --
 target/arm/tcg/translate.c     | 2 --
 5 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index a9d1f4adc2..868a3abd0d 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -2,6 +2,7 @@
 #define TARGET_ARM_TRANSLATE_H
 
 #include "exec/translator.h"
+#include "exec/helper-gen.h"
 #include "internals.h"
 
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 741a608739..bc0cb98955 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -29,8 +29,6 @@
 #include "qemu/host-utils.h"
 #include "semihosting/semihost.h"
 #include "exec/gen-icount.h"
-#include "exec/helper-proto.h"
-#include "exec/helper-gen.h"
 #include "exec/log.h"
 #include "cpregs.h"
 #include "translate-a64.h"
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index e3adba314e..b0812d9dd6 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -23,7 +23,6 @@
 #include "tcg/tcg-op-gvec.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "translate.h"
-#include "exec/helper-gen.h"
 #include "translate-a64.h"
 #include "fpu/softfloat.h"
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 92ab290106..106baf311f 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -27,8 +27,6 @@
 #include "arm_ldst.h"
 #include "translate.h"
 #include "internals.h"
-#include "exec/helper-proto.h"
-#include "exec/helper-gen.h"
 #include "exec/log.h"
 #include "translate-a64.h"
 #include "fpu/softfloat.h"
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 7468476724..c89825ad6a 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -30,8 +30,6 @@
 #include "qemu/bitops.h"
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
-#include "exec/helper-proto.h"
-#include "exec/helper-gen.h"
 #include "exec/log.h"
 #include "cpregs.h"
 
-- 
2.34.1



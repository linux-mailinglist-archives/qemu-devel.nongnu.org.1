Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC60170DE25
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:54:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SSj-00058G-Su; Tue, 23 May 2023 09:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSK-0004uH-Mr
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:41 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSE-00032E-Di
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:37 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64d426e63baso4407743b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850013; x=1687442013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fjia3Wxg3tvISCHmEv9hWQkEs32v9NCdixUCeRZrr9g=;
 b=D3Stj5FhKIT3w5YpkpoZ5z4Hi+aCiPolr+7VooIiXOy5Km+GT+iAtReUErBrvo2s44
 e4BzcfLxd/sqyLQSrcTwbVLH9oMs7m9rw0lqMrubZ+aeJRrsVEFawwYbcPNj2Ze9buQ/
 BIjFyJeEX6P7Y0U4eK343AshbBQjEUhMOZr5E4hM9rkk6zbwiO5npcMPgE4PiRsLp/a9
 ylmqpdZjEu4A/4iHWWsijH5tkvjP5bRRjcqyU0XeVtaG/97NZliXpnxghPBr+yEPXUM+
 qH5MMcHtGdPquuAHDB/ff1V0vO1s+/ckIcl3yGKsOuI8qwM3h96N9qjO9DvY2PCTab5O
 PNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850013; x=1687442013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fjia3Wxg3tvISCHmEv9hWQkEs32v9NCdixUCeRZrr9g=;
 b=DXVixYQ6YrpDBBIXaFZMIJ0Epuidx8+2Z3Zem52w78xNr+DzPkc5yWyFpTN7tE+s2w
 ZPOnHAcgy67jz5UNFxJjGNZDOuzHdLQN1SL0xL3PYCbNytPFDUoXlA9AHSwCOZ8P7VHJ
 PswfB3j5gXyZQwVegZ3YsOB5GKxh0BQEbqBuup16J+IwOC3bv+DGsjfrEfTTtCPmEiWI
 jo+5ckc/q6OxEtTKe2BBHDRw+9djTR2QyIRo+jOwo9CeFYieVrmtggxxnAIUT/ekm18U
 rHC5bgMsvuicRTEoFV9AkNtgL0PXf/+nRvgbhp6ehqWOSIVeS5rCzblrgynlZEeEw1YY
 hiXQ==
X-Gm-Message-State: AC+VfDz1UUe9Oi0AzgpxLAwdg2MEskmWQS7SKxH8YtIK5m6rC0UCa7Lj
 iFOGQ6gN07yzluYC3gqXbB+l1tIld3SWV16ZXDs=
X-Google-Smtp-Source: ACHHUZ4DicjP4xFNMSsXcoCilRywXxdQHFLqjCDFZC2PYKeTjDNlq+rTyXqHOO38HzR5rYKj1oRwsw==
X-Received: by 2002:a05:6a00:1994:b0:647:3de:c0ff with SMTP id
 d20-20020a056a00199400b0064703dec0ffmr15050210pfl.30.1684850013182; 
 Tue, 23 May 2023 06:53:33 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/52] *: Add missing includes of tcg/tcg.h
Date: Tue, 23 May 2023 06:52:41 -0700
Message-Id: <20230523135322.678948-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

This had been pulled in from exec/cpu_ldst.h, via exec/exec-all.h,
but the include of tcg.h will be removed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/monitor.c             | 1 +
 accel/tcg/tcg-accel-ops-mttcg.c | 2 +-
 accel/tcg/tcg-accel-ops-rr.c    | 2 +-
 target/i386/helper.c            | 3 +++
 target/openrisc/sys_helper.c    | 1 +
 5 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 92fce580f1..f171bc6f5e 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -15,6 +15,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/cpu-timers.h"
 #include "sysemu/tcg.h"
+#include "tcg/tcg.h"
 #include "internal.h"
 
 
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index d50239e0e2..5d72c9b1bd 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -32,7 +32,7 @@
 #include "qemu/guest-random.h"
 #include "exec/exec-all.h"
 #include "hw/boards.h"
-
+#include "tcg/tcg.h"
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-mttcg.h"
 
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index b6d10fa9a2..70b9b89073 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -32,7 +32,7 @@
 #include "qemu/notify.h"
 #include "qemu/guest-random.h"
 #include "exec/exec-all.h"
-
+#include "tcg/tcg.h"
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-rr.h"
 #include "tcg-accel-ops-icount.h"
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 8857444819..682d10d98a 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -28,6 +28,9 @@
 #include "monitor/monitor.h"
 #endif
 #include "qemu/log.h"
+#ifdef CONFIG_TCG
+#include "tcg/tcg.h"
+#endif
 
 void cpu_sync_avx_hflag(CPUX86State *env)
 {
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index ccdee3b8be..110f157601 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -26,6 +26,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
 #endif
+#include "tcg/tcg.h"
 
 #define TO_SPR(group, number) (((group) << 11) + (number))
 
-- 
2.34.1



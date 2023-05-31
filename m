Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C36B07174CC
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:08:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D41-0007JH-OP; Wed, 31 May 2023 00:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3n-0006rb-TW
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:45 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3l-0006AR-DR
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:42 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-3f6c81cc112so57395781cf.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505819; x=1688097819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/ikHj+R8q+414Kg3TRPRaaz9VV3CP4E0627qsrQV5k=;
 b=K4wLYhr+dOpt5KNxmdOhcJKKwoZancPWH6L+4mIGcaIWyT4MM9MUscQoaOGqmr3eeQ
 p8iUUcECDIzICst6Ev7OJPv3Y+AM8pNBZ1zFaX7sX6ZPhu4th/QjUfDE7tDPZzPYLyFN
 lhJSqUHvHEDCWi+N1bwRkVHTmYN9ffBneYZxLL9R6OHAFSCXcsc2EMl0p447iuqF2O10
 keYLhI5AroQasSm0h0PnfnOQo8Y+SR1mnPYPNxwoLU6GLGkSjv5CKcQn8qfcU7WhhloQ
 qYgsNZ+s1g2Ex2Kgl5zyeBpqvR3dK1F5qCjFKijYETtebeTRkrWWQQhO7Xt4CRxCBiTs
 dA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505819; x=1688097819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/ikHj+R8q+414Kg3TRPRaaz9VV3CP4E0627qsrQV5k=;
 b=d0ZtxMXad4uWe8t8mLPS9Mr1RmPNaQIYWLHF2rG9HEblE45A9/r0CMbBVCx7YpaoYk
 ZEf7lJ1OwA2BwtUZQ3zeuidiBkDHaWr53xxqW9OaWTd49gND33FUN/hDBK+2JKR+0h23
 n8WZ1tMIwO+10StWFjfsso8WqfW6yT/dUVJwsRdfFYDxilhG72pADYoGHSUXFREjAsgm
 cMGzmQSyJ077dYrarH9yvimNESbyTp00T2a2kviRn0zRguX1ZK22apS6eMmwNZBXB4uk
 kWcI1tEfUPErM/65AbGxdKAGZQt5PdlPHouhdWPCEEjN9DnXZMj0Y7gZUUoSXia8TQlV
 RPgg==
X-Gm-Message-State: AC+VfDyKThYg1mORIJnWmH+9+jhHHcncOWXZ5NOBQlqR7Uf+szs+jKvX
 ySuOvc+OJsT6VliT9o857DBGIaTzy2EPhTUQGE4=
X-Google-Smtp-Source: ACHHUZ4lNf7Hd6e4sxj0ucX5xSbko/N2B5ZaWvtozCe44zMkQotwrLfxA1dHNRXxQsEmEWhjitxJ6A==
X-Received: by 2002:a05:622a:647:b0:3f6:a210:1fec with SMTP id
 a7-20020a05622a064700b003f6a2101fecmr4495352qtb.29.1685505819031; 
 Tue, 30 May 2023 21:03:39 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 10/48] *: Add missing includes of tcg/tcg.h
Date: Tue, 30 May 2023 21:02:52 -0700
Message-Id: <20230531040330.8950-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x830.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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



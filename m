Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7F3723145
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:26:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GcZ-0001py-9T; Mon, 05 Jun 2023 16:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcV-0001oU-Dr
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:03 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcT-0003oF-Nj
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:03 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-65540715b4bso1364647b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996159; x=1688588159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/ikHj+R8q+414Kg3TRPRaaz9VV3CP4E0627qsrQV5k=;
 b=Gh2kk1x84/s4C334U/p2pidxHfGy9/FfIt1A0vOWQIWOXar0RGgaMe8uQ9dr/j+FzF
 okDmgEtbYmtvJdu9vt7d0U+IkWgDW4fht8hkCjeGGVK12k6jYt4r7XhWKyc7pLlCAqXP
 VpxOIpFQspe9RVEGDLf6wC2ylZ6reBsoB+E5c/hcN7ePIsFFqPE3pSStJuAdXTy/8HrS
 qgvNNQQ8jrdVFKXxU2zdlSyLVpzEeiGRz5VbJ7G5XZzt6Nf9EqVRfbe7rFbqPAiBHg2o
 50GbnUyGinB3bJcGXN7BWqzwgm03vMVtZH/tY42L50EfXQj9KMZSN8+654NP9iBgZkOL
 gH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996159; x=1688588159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/ikHj+R8q+414Kg3TRPRaaz9VV3CP4E0627qsrQV5k=;
 b=S5A1+PPTOrap1nwaFPV7r2wA0MxEkkOBkZOCW8eQ/ufQim6Ee8YRWymba4WhAt1ZTx
 PZdbs4RPYFOIpQgf++KHBJisSO6V5FxHxBVGgSIqGsijhnuygl6hucBHfXBI2OB9s+7r
 j4QLboj8zQeNaUzhHp4wsW+WxGkmVZRnvKFEMlIcg7ZJtuNb9THrAxz9K3Shr3KmfgUs
 yJsJ4fhoazZw0hYvOm6uvWVknbt+EGFCxKbvZOzoyVkGoavYaMsg5dmHvvct6+lvLdCz
 FTeMzjPRc61/CoIm3wpedXc1ysc0Tubwij9AzIBpmOXHLSYVMLfFoBoyj3hlf6QEGOLs
 L7tA==
X-Gm-Message-State: AC+VfDy1/D4A6EKqXyk5ZoYcdYgZaNiJMbrohj7D3TpMqUqq5R2i5dNb
 TAzslM9Zw3tJxKIteqLXKDYMy0H2bm9qODe0fR8=
X-Google-Smtp-Source: ACHHUZ4AfUd4zh5OXHJCFJELuK5bYP6Du1U/YBbILrwv/rWlg/gurHx3El5IRxIY81Y6JzL7IFpWAA==
X-Received: by 2002:a05:6a00:194f:b0:658:e95b:256a with SMTP id
 s15-20020a056a00194f00b00658e95b256amr1020877pfk.1.1685996159410; 
 Mon, 05 Jun 2023 13:15:59 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:15:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/52] *: Add missing includes of tcg/tcg.h
Date: Mon,  5 Jun 2023 13:15:06 -0700
Message-Id: <20230605201548.1596865-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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



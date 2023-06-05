Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E99D723144
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:26:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GgK-0007Hi-5u; Mon, 05 Jun 2023 16:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfq-0006sg-7E
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:32 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfn-0005jV-2e
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:29 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b01d912924so49326035ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996366; x=1688588366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WRpN/gEKoBKxUq8HSm115zlXgrzm+s7nqPytLNJQu4M=;
 b=QrpkG03w1BoGfcMpPLPNdM2lFuMkGxhvgjLuKC1wC2++xxCEkMo3x7t/XXwY7wDiX1
 fWEp3wvR2z+wMKQlREtJDnGR12aqC+WkVZD8JfgZxV2WptRU2Os+nb1jiYc8ogEJYajW
 AJRMc7G9SuU5lxpr9T9c23FcdjMBF2EMHApy82mCszu0pGS5KwGbVcqLiSPUQDZA85nf
 VmjUeIWVxVpfgZGCTmN2h+iI5E+KalxsGguraeGp3M/JDcYQdGGcoGv6ezRPmCIDyEcv
 5049IgHOxZfEYhSUojqFyFyIyaS7CDGrdzEhZFHSXaSu4uJuXbq99asBZgBGbsJgb7AQ
 HSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996366; x=1688588366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WRpN/gEKoBKxUq8HSm115zlXgrzm+s7nqPytLNJQu4M=;
 b=DsJ4vHMWKycGeR4C0TGKC8+udNZygJ5MzMyAHlU5ycfOLGxfWC6wrb7mZ05wBWbM1v
 OwfUpT1uDkGfa9bxjVX+6jTDu2UJ3XFvdoYxdatt2nxOQu1XscdLLgQibn6PUoCmIUcO
 CQEM/xeMJJBLMbfYh/wl44nJV8naZ3LsS1sF9ss2D6kkYjwi/GVZzGtNjoHJvXVobzXK
 U1AQQT1TNKfmFS0AAhgbbN/Lx5+543fSv/20r3Lr50BsBs7Fus7iu9jdew0PtQc69aBv
 BbWsWuw/srSRWXnhmfaL49rOfj64Ne0+CHNSCXTAuyx4zmWInYiNk2uzA1yYSL7pgCDh
 /y5g==
X-Gm-Message-State: AC+VfDxl7BuP+s3suxk6wyroMjDBtjIJKId/jwKkQwKvhnH30jP6qpd8
 bUJKv2rrqe6vzCDkKFpVngStZ3YGRTP8CJ5OVBA=
X-Google-Smtp-Source: ACHHUZ5LvAHeVqyCBROhg8Dr5O/synAH3amlLrNdF4ObGe/+b1vdrxXMc5o03V+idNV63ZBO+T9mQg==
X-Received: by 2002:a17:902:b195:b0:1b1:d0b2:b9b3 with SMTP id
 s21-20020a170902b19500b001b1d0b2b9b3mr74618plr.23.1685996365736; 
 Mon, 05 Jun 2023 13:19:25 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 w20-20020a170902c79400b001a980a23802sm7018184pla.111.2023.06.05.13.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:19:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 41/52] target/*: Add missing includes of
 exec/translation-block.h
Date: Mon,  5 Jun 2023 13:15:37 -0700
Message-Id: <20230605201548.1596865-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

This had been pulled in via exec/exec-all.h, via exec/translator.h,
but the include of exec-all.h will be removed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/translate.c   | 1 +
 target/loongarch/translate.c | 3 +--
 target/mips/tcg/translate.c  | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 770de58647..708339198e 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -22,6 +22,7 @@
 #include "tcg/tcg-op-gvec.h"
 #include "exec/helper-gen.h"
 #include "exec/helper-proto.h"
+#include "exec/translation-block.h"
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "internal.h"
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 1cf27a4611..3146a2d4ac 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -9,11 +9,10 @@
 #include "cpu.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
-
+#include "exec/translation-block.h"
 #include "exec/translator.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-
 #include "exec/log.h"
 #include "qemu/qemu-print.h"
 #include "fpu/softfloat.h"
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index f3da05ba3b..74af91e4f5 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -26,6 +26,7 @@
 #include "translate.h"
 #include "internal.h"
 #include "exec/helper-proto.h"
+#include "exec/translation-block.h"
 #include "semihosting/semihost.h"
 #include "trace.h"
 #include "disas/disas.h"
-- 
2.34.1



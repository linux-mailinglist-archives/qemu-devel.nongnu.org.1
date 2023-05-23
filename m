Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAA570DEEC
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:14:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SVf-0003ER-7s; Tue, 23 May 2023 09:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVb-0003AX-AO
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:03 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVY-0004Be-9F
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:01 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-64d5b4c400fso3397737b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850218; x=1687442218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gIw13ktYRKuHjGYgqanTyY2L+IU7oi03A0ph96rfnSk=;
 b=DnPhdf1D+iWjK1y0vhfVlKethFneI8pvrIrE3xCjHnNmtJJTzH8v1bLdbsEe4LdbIG
 uX4YnHm/TtTRHL6t9kEMCmVWuQO74Qjjqz3nPzE6viuKPq0tEsVEa6wr9CLj/y7zYFLD
 lPXtyDi2FOhsSr58iSLgbEDBSv1kOIHZSrvZKrsSCAWyt7anRPCfqrBYBxQe42C0zUa9
 ZmjwdBLMVwXGaKeqo0E1RelvznZ5lSYaohlLocvoPJyhlb4xjWN0MG1Er0FwhylSWXPm
 0KxSO7QV/vjRXWcNwjSpBdVotW6DgVoRjvaKLl4y6TTTKhdBB11rvZIAAGYNN7J/mjAz
 vmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850218; x=1687442218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gIw13ktYRKuHjGYgqanTyY2L+IU7oi03A0ph96rfnSk=;
 b=TtQTnd+tmVb1LpALCFzlSGICAUJ3lfIuQgDkHPa+lDgMMGHucI/uwAMjibH1EYbHO7
 8mmiP8vd7aHnnO2Q6TgJeVoCe1xfP5ADuDG6/PFmmiybaw7EjtQBhF+TADkVPxt3ODXQ
 Xf5uRuX8vpiHrnWBtQeUuF44R2aQ7kAMFW7hOyLyrRdvc7WSllY+9y1D1ZydGakcHb4d
 IphoirRtfNJJbo+7H4HKIjBI7n9VTFy82ObJrZ8NaEb1+i4ya3b6LISBQzheV8mW3boB
 e2E1RV/hctTsgjXHNlyMij7oA/RG6SdhlJX/dvH/hcXhOilxdVgxQ8GCtH80LgfDHJ/M
 fDfQ==
X-Gm-Message-State: AC+VfDwlEweAyNOqmrxRG6Do7Y2hJtLmwpsCL0uD7OCkqF6Uv5yNfl4j
 A9KSDUGB2AA4MbgeKdsT1+xzAVYNTqeypQcpYn4=
X-Google-Smtp-Source: ACHHUZ72oTMtrWEs7fHZKMvjMEw9tFgAphAo/Nf/J9+BAYGQZ9+7V3RBG6/kyiHGsFqw1LqsaUy9ig==
X-Received: by 2002:a05:6a00:1788:b0:636:e52f:631e with SMTP id
 s8-20020a056a00178800b00636e52f631emr19960416pfg.1.1684850218746; 
 Tue, 23 May 2023 06:56:58 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a62a50b000000b0063799398eaesm5805790pfm.51.2023.05.23.06.56.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:56:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 42/52] *: Add missing includes of exec/translation-block.h
Date: Tue, 23 May 2023 06:53:12 -0700
Message-Id: <20230523135322.678948-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/translate.c   | 1 +
 target/loongarch/translate.c | 3 +--
 target/mips/tcg/translate.c  | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index eda384a9db..16cdfcc2bd 100644
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



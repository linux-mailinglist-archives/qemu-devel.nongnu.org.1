Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 268CC70DE5E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:02:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SVt-0003lI-ID; Tue, 23 May 2023 09:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVl-0003UE-Ip
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:13 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVa-0004CF-0h
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:12 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d41763796so2907226b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850220; x=1687442220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yAI6VIgzMZpgJduQw+zbfBfSRhC2iaxfwnzVojWouK0=;
 b=X3NDGYHP/J5DtEHxOb5/zazcfj6L/Cmdjw0d7wiaB0y6t69KHI9wJJaTVPi2Ux+BLI
 zS1kY6EzUGQVjOIHXEMugHifwTsoObcIKDgFr1ZSD3OaNaj3g19oomRpBfwRXMZCivhv
 4ckxZVouExW/3B1Vpgz2OKZ9gIBbPckObq+efq4RPFF5OB2epCuTgv+fMKEm+7U4Xzgm
 pGiFesDNz8wYF0F36t0KSUsRBTwSjtVH3lXjrXRRqKriAUYBABE59Bxh4/tGmwBUA6ob
 ZYcEZwOqT/gsp+qFIJ98OReHlawHmSsnxfKgaCExu0EKAl9i7GE2OrHXyoEz6WQ2NpFk
 77bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850220; x=1687442220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yAI6VIgzMZpgJduQw+zbfBfSRhC2iaxfwnzVojWouK0=;
 b=OYPHMbTNEB8JVAPsU+TM4K5MaMaIgQq3rVGrkYjwvu7xh93H90aBYfKn+zSKOc29G4
 72gVj8UvkN8InE3srOexCN2HDRx+BvbKhJOVzmk2/EQ7WexlU+6WBIhE8ignzY1DRlg5
 /07etFNq9+SdFxH6h9GkQFFLV/3YCbw7x9+qNnFLNplFgmL3+0iFDZVaPviuqq08xJ20
 18W8+aQPzggpNvg0a8YHiBDppKjvEHdbRfXXi6jbJIwvqE6r56RQCQNPYrQeUNVTZpE8
 rvLNu5EPgLEhGvzuDx166l5kEDViR47F9507Vfpc3k+yI3atRv6Lw9T3ZUbiXzUYdIGD
 2Abg==
X-Gm-Message-State: AC+VfDwThJLeYVlShhrIhUCr5wMTBs9wgbR0pOBdtLJ2ylvt2qTyB+Tj
 JKCLJT75iS/0jyoTjWqTA2e/5MuKJtQiWlRJrvA=
X-Google-Smtp-Source: ACHHUZ6W87dJebLSJ+EjHbyPHe3wZL2eQfGIELTAfHZ7/NPoFFd73NnVvKZ9HihMQIsK9GN2Zjz/Tw==
X-Received: by 2002:a05:6a00:1783:b0:644:d775:60bb with SMTP id
 s3-20020a056a00178300b00644d77560bbmr20520014pfg.20.1684850220053; 
 Tue, 23 May 2023 06:57:00 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a62a50b000000b0063799398eaesm5805790pfm.51.2023.05.23.06.56.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:56:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 44/52] accel/tcg: Tidy includes for translator.[ch]
Date: Tue, 23 May 2023 06:53:14 -0700
Message-Id: <20230523135322.678948-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reduce the header to only bswap.h and cpu_ldst.h.
Move exec/translate-all.h to translator.c.
Reduce tcg.h and tcg-op.h to tcg-op-common.h.
Remove otherwise unused headers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 6 +-----
 accel/tcg/translator.c    | 8 +++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 228002a623..224ae14aa7 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -18,12 +18,8 @@
  * member in your target-specific DisasContext.
  */
 
-
 #include "qemu/bswap.h"
-#include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
-#include "exec/translate-all.h"
-#include "tcg/tcg.h"
+#include "exec/cpu_ldst.h"	/* for abi_ptr */
 
 /**
  * gen_intermediate_code
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 60a613c99d..fda4e7f637 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -8,15 +8,13 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "tcg/tcg.h"
-#include "tcg/tcg-op.h"
 #include "exec/exec-all.h"
-#include "exec/log.h"
 #include "exec/translator.h"
+#include "exec/translate-all.h"
 #include "exec/plugin-gen.h"
-#include "exec/replay-core.h"
-
+#include "tcg/tcg-op-common.h"
 
 static void gen_io_start(void)
 {
-- 
2.34.1



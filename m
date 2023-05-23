Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F3E70DEFA
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:16:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SVf-0003FP-EP; Tue, 23 May 2023 09:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVb-0003Ap-IM
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:03 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVY-0004C2-Q9
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:03 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-64d3fbb8c1cso4747716b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850219; x=1687442219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5OmjOrE/P0VU5UgUG9OCCxhc4dLq9WZZ40K8T/sgGq8=;
 b=ncImANGMt9TB30AnijYfbmCyyodwfC3hQwqkzYfOHjyF2327TEBgBlwB9Gtutgf8i5
 afZ3saKly3Xq+USoyASyEN2k3zNbPJb1B4StRNqdw/FKGZRqfZHF4fHX5uFFvhorclBt
 AfxJkH+aL//g5BkxF9thr7Onfi+5KnI2eV9R85QuGnZOUpFalB5UgOT2G41yXXAhF5WP
 3NrXDnaOVZjp6Z5I2LGJ1Mnz3RRt8ljwIRyb2Cj2g8Ga4Fw2KjZHjJKXt1e3RjncHb7C
 3lsz0oQ4hfC1phJklVTLpeLSs2RwbWZWtQnD7XxOmlXelSIAnImmwqqn1OCDlIu5ciIG
 r3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850219; x=1687442219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5OmjOrE/P0VU5UgUG9OCCxhc4dLq9WZZ40K8T/sgGq8=;
 b=V5ocvLHwTXZkexsBAfbCVi3XSQUIdaKoiH3PXa0iG4cOQ61hriFlM03AUYERe/NpYB
 pKOP/nkPCf6twhtbZCt31fNScpLaaR+vZAZsX7YVmWEA7XJTFuVZtXK/lFQp0/HvmJZ1
 qiKRJnG7j3LzdO3ZojtPXLRQ5Iz7bUHkZlAIH6Ttx0CGuKbwBrtdsXP7GE3c3ZxL7sNy
 XzOeooAZv1EL5W63LyYl6dq8+G5me3OoJimaHjKe3EVNM3Vi41B38fxYBJ6C87aQGXs4
 8GApR9a4cjOVLbThHGtvExz5pDe0MHojViwTjVwzlsqMvFXeU5IdxHFAmtQhsm6xtTKS
 4otA==
X-Gm-Message-State: AC+VfDwZM5LpUAagaNaG1Ix2DYwHyDMWJ5a4DHHUl0q4Hb2OLExc3V/9
 NaXdXvZ+fZsO9xBCzNhn0E3w1QHop2O55ncCpEs=
X-Google-Smtp-Source: ACHHUZ7pmu0Zp1G8oZwwabO6GAweM3SV5KN3TGn0qA+nhmh4L1Z97HF0/61whLETzIS8RykSbz32Eg==
X-Received: by 2002:a05:6a00:14c4:b0:643:9cc0:a3be with SMTP id
 w4-20020a056a0014c400b006439cc0a3bemr17506050pfu.5.1684850219394; 
 Tue, 23 May 2023 06:56:59 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a62a50b000000b0063799398eaesm5805790pfm.51.2023.05.23.06.56.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:56:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 43/52] *: Add missing includes of exec/exec-all.h
Date: Tue, 23 May 2023 06:53:13 -0700
Message-Id: <20230523135322.678948-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

This had been pulled in via exec/translator.h,
but the include of exec-all.h will be removed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 5b53b6215d..4d88197715 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -4,6 +4,7 @@
 #include "cpu.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
+#include "exec/exec-all.h"
 #include "exec/translator.h"
 #include "exec/helper-gen.h"
 #include "internals.h"
-- 
2.34.1



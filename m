Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFE170DEEB
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:14:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SSy-0005wG-CM; Tue, 23 May 2023 09:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSH-0004bX-So
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:39 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSD-00031u-PF
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:36 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64d2ca9ef0cso3750548b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850012; x=1687442012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FMynriKgHY7/a7Zeekt4jsXQMXu8INdJVu2wztuImV0=;
 b=nzLdzEiT2fInIGnjrcnAuX+RYtWr+1bokG/EpdUQyYK+NsGi+HPcbLgP79AutX5/pQ
 Uf7feEw/FiNvhcEMpWZ7emAAheSTWKgqDfrF0Rnh+c++5n2rg1mV91LmUwL0h3afUIkt
 BimW2RiSBChYoArovaGXsTDWaAAmFJjEK4CH2doB24ZAriZ55nebaBjt9ydlwGNRHhib
 oAKhLF5zEGkjQsFIIBaZragcdJk1VL0mdqfWNEu2PTV4wS6kE740iB6NMqMlwTBWj/kw
 rdedSqPBT78L6BLQdyRNxwHtkXCCIlGBpzUgDm/Zlfp2WhYDL+7u/eq7ej/FmrgXbHSo
 J8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850012; x=1687442012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FMynriKgHY7/a7Zeekt4jsXQMXu8INdJVu2wztuImV0=;
 b=cl+q9CiTrm5haFOSP7iyOB/BTenn40O+QLCDdmcJStZtomloVn4G8TLyG/YoyGvD6n
 6h3yqfYP+FdCtdBQKqmnCC9L3KytGz9KIpCxxSNzSs5vxUHJHH7hIGOq1Em+OIfPfmMT
 vcu4gNT+PkcQMm/9zNVwfvpXDqjHx5UbPlVaVWb4TPfn9cJ2OVr+C5OBqNaFQBbd5NXe
 MblEgQHph73MkdMZx+YX9rGY+lLNzSBjV7cKA4plysKSzY7YVbh7iQt6bQZqjw3yAPu5
 36KTOkhApGL6VUzd5pyp1D0ru/Mw5IufYnhLItSLfJqnk1eeiHEtVL+3yU60tsysn/bI
 4wjw==
X-Gm-Message-State: AC+VfDy8sRuD9+tQ1O2O6jiPyh2LJB0VEWcwsgdWir2mUuajbNecQ3tY
 siLju5iPrhdY3agHXt1q1tDbyJ3pu4xkYF+ti6E=
X-Google-Smtp-Source: ACHHUZ6Quni6Xr2uS5VDzCrJZXGBAR6qBqXOGOMXP3DzIUFY0PMxFHhsh/PY4BPNBaKsGHDg2wJ6MA==
X-Received: by 2002:a05:6a00:1798:b0:64d:22d:adb3 with SMTP id
 s24-20020a056a00179800b0064d022dadb3mr16641362pfg.1.1684850012466; 
 Tue, 23 May 2023 06:53:32 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/52] *: Add missing includes of tcg/debug-assert.h
Date: Tue, 23 May 2023 06:52:40 -0700
Message-Id: <20230523135322.678948-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

This had been pulled in from tcg/tcg.h, via exec/cpu_ldst.h,
via exec/exec-all.h, but the include of tcg.h will be removed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu.c      | 1 +
 target/rx/cpu.c       | 1 +
 target/rx/op_helper.c | 1 +
 target/tricore/cpu.c  | 1 +
 4 files changed, 4 insertions(+)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index a24c23c247..8f741f258c 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "cpu.h"
 #include "disas/dis-asm.h"
+#include "tcg/debug-assert.h"
 
 static void avr_cpu_set_pc(CPUState *cs, vaddr value)
 {
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 67452e310c..157e57da0f 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "hw/loader.h"
 #include "fpu/softfloat.h"
+#include "tcg/debug-assert.h"
 
 static void rx_cpu_set_pc(CPUState *cs, vaddr value)
 {
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index acce650185..dc0092ca99 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -23,6 +23,7 @@
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
 #include "fpu/softfloat.h"
+#include "tcg/debug-assert.h"
 
 static inline G_NORETURN
 void raise_exception(CPURXState *env, int index,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index d0a9272961..7fa113fed2 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "qemu/error-report.h"
+#include "tcg/debug-assert.h"
 
 static inline void set_feature(CPUTriCoreState *env, int feature)
 {
-- 
2.34.1



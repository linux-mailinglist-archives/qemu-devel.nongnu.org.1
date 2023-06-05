Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75195723139
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:25:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GcX-0001pF-E0; Mon, 05 Jun 2023 16:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcU-0001o5-LN
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:02 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcS-0003nm-0A
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:02 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-650c8cb68aeso3084081b3a.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996158; x=1688588158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNL16VFJ/JVKBYmioxTJxOZayJwkRUPqGfQWbKcHjhI=;
 b=MlJpHsfYfgxjVmgCYc8l1kVmR3TWflq7344LHL/KBgLsFrpNUijwPwSwehWfjr5BvR
 drbkr/MlchiPjiKZND+JTwB1t4Un6WkjjDJIE0K0oujFZdgdv/rhPZ7K9GLtD5qiPH7H
 1J80Ge1iQJYOpqrAq11M+bYtTjv845z4ADrGoYHhJ1PZPj9/znGv8jT16bg4LS+SwhHA
 V0SnXYf34k3HMaELZdaY1il526cMDxuj+Vw3CapTLFTll1SemmYJrFAYnszP+iJ4WlXV
 bJMPBeEJMJcJYUlthIthlH7VnIquZI8NOQOLvCzVSplflPEKmQOJdqava266YisKGdTX
 pl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996158; x=1688588158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BNL16VFJ/JVKBYmioxTJxOZayJwkRUPqGfQWbKcHjhI=;
 b=GGhXDAc+QxDL4ha+eiGsa7zo+T0v4l4WmieQLk5X4pq5f17qCOpokeynAY5LWzQKph
 D+MGpM/WxBJEJ8qD+78vuBDzrs7wIa1pvcTGGX42Q0yLbS0lcswlth8zYz39FCTKRbGe
 ryGQSihLDur/QYL29Vlo8RobnQIzTOB2vmFqjQ8hg5Vi39i/mAmFMwUzEIrF8Sr8Kbbo
 4okcvTunSbaKyk7O4haMIs878fMJ5QWfxb/QUeVlLW/XoMu2fhkMZk3xVHwhtnInuftA
 b08VRlHkxhuIHHMwP1K3QS47hWWe1pqLf2hj9tRq33ok6gJ34M2/n/2YAKF+BW1CExIc
 dscA==
X-Gm-Message-State: AC+VfDxI8MrCkf+sWTdNmroIYOQ+FghTj/XLPgrFAhihk+jTqy/Wttlj
 a+QX7YrxyHH/HtqtblB4M4J3mxqZst+Kjfaq5u4=
X-Google-Smtp-Source: ACHHUZ5LJclL0QiPpDmBbz43J7iN1nRZAa1pecYTJLiZwiWsflrMOyFdPalrjPbRA552io1ArqdYWw==
X-Received: by 2002:a05:6a00:198c:b0:64d:6a78:1575 with SMTP id
 d12-20020a056a00198c00b0064d6a781575mr591535pfl.30.1685996158481; 
 Mon, 05 Jun 2023 13:15:58 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:15:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/52] target/*: Add missing includes of tcg/debug-assert.h
Date: Mon,  5 Jun 2023 13:15:05 -0700
Message-Id: <20230605201548.1596865-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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



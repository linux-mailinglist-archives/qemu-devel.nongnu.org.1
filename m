Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11742740976
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 08:34:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEOjX-0002fZ-Vg; Wed, 28 Jun 2023 02:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEOjV-0002fF-Rx
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:32:53 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEOjU-0002ut-57
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:32:53 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fa99742bd1so29200535e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 23:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687933970; x=1690525970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O0cRK8tGjtjZxpS34d3FV4u4gabHFwB+aSZ5fuDgNn0=;
 b=hSH7ahh6XuwUwLYDK/dH6lHy0Ub7fB10ajM7djIF0+u6RPIqLk4gfxkXG8SGe2sjCX
 WtAJ1nCr4DA8NkS5xGoMw8VGVbmxWb33WY/zDulqtrgQ4z6Ir5dqlltHxtDcrQm0fphX
 nmhAK/22F4kh/zQE+RfFoWg0i+C997jFGXiV4K/2w+Ef4altFDHLhQNMXrlCoUvHtpc0
 0Dq9Y4X+IE00xG5NZVIvaM/yJOhp5+a9OcHbIQumcW/UVeF4ItoNNm9dwQdF1JPHF7C2
 9Dk7oYiRLUEQd+vVJWO097KAYLUtVm0GrH/zaCsPqq06a44W56nPfKqxeITpHGYJNWVa
 m+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687933970; x=1690525970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O0cRK8tGjtjZxpS34d3FV4u4gabHFwB+aSZ5fuDgNn0=;
 b=LgwnT/UZ8b72ZkY2xgx95UZdvdJSJx9R1me4m5A8hlmmQgplcTcnh6D0gGhH+DbbzS
 Ha3Pj0d2GCurtoZ4pK1Hj4y7bvSpkKPAqmYxC+2sG/t1vsTO4IBQ1NzbjXTGbuud2FEJ
 dCgPjHBTgGtp/UPRSi7TZ/eQBYuxWOy6JG6vM/dcCExUixxaDO7ZDPXzmXN5qamFm93s
 mmrE34JBVl92WFDFP17gPtTl+LB3S3Wx8/P7/CCFrXW6ydgei3FarMq4pxRkOXKI+QZr
 ul/V3zHUmVerq4bis7UAgZpQj0AjPhXn9GhgjKXprjeBW2UVheEW2DqnNWLMpdWsPpmN
 74ng==
X-Gm-Message-State: AC+VfDymWfrBV1mSkwPXX2c5xqSLWxnbWlj6r+I+SDUwZkkNrFTusSah
 8fw3CujNrb3kxeCRkugbQWL6lUC8aCcaUqXiSMs=
X-Google-Smtp-Source: ACHHUZ6HQ0ua7PppxxElhjW4ZpBwsAceIajPMd9ME2D+IfkQZNtithVcByeGdn99hkPqEo6aU94Bug==
X-Received: by 2002:a05:600c:2945:b0:3f9:b31d:5689 with SMTP id
 n5-20020a05600c294500b003f9b31d5689mr18756638wmd.36.1687933970256; 
 Tue, 27 Jun 2023 23:32:50 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 p2-20020adfe602000000b00307c8d6b4a0sm12326202wrm.26.2023.06.27.23.32.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Jun 2023 23:32:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/4] target/riscv: Restrict sysemu specific header to user
 emulation
Date: Wed, 28 Jun 2023 08:32:32 +0200
Message-Id: <20230628063234.32544-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628063234.32544-1-philmd@linaro.org>
References: <20230628063234.32544-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.c        | 8 +++++---
 target/riscv/cpu_helper.c | 2 ++
 target/riscv/csr.c        | 2 ++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fb8458bf74..d9a3684b3e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -23,9 +23,13 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
+#ifndef CONFIG_USER_ONLY
 #include "pmu.h"
-#include "internals.h"
 #include "time_helper.h"
+#include "sysemu/kvm.h"
+#include "kvm_riscv.h"
+#endif
+#include "internals.h"
 #include "exec/exec-all.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
@@ -33,8 +37,6 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "fpu/softfloat-helpers.h"
-#include "sysemu/kvm.h"
-#include "kvm_riscv.h"
 #include "tcg/tcg.h"
 
 /* RISC-V CPU definitions */
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 55c36025d7..3c28396eaf 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -28,7 +28,9 @@
 #include "tcg/tcg-op.h"
 #include "trace.h"
 #include "semihosting/common-semi.h"
+#ifndef CONFIG_USER_ONLY
 #include "sysemu/cpu-timers.h"
+#endif
 #include "cpu_bits.h"
 #include "debug.h"
 #include "tcg/oversized-guest.h"
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ea7585329e..e5737dcf58 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -21,8 +21,10 @@
 #include "qemu/log.h"
 #include "qemu/timer.h"
 #include "cpu.h"
+#ifndef CONFIG_USER_ONLY
 #include "pmu.h"
 #include "time_helper.h"
+#endif
 #include "qemu/main-loop.h"
 #include "exec/exec-all.h"
 #include "exec/tb-flush.h"
-- 
2.38.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCB678B3C4
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 16:57:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qadfS-0003gj-IS; Mon, 28 Aug 2023 10:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qadfP-0003f0-LM
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 10:56:35 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qadfK-0000ot-Oy
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 10:56:35 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31768ce2e81so2757069f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 07:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693234589; x=1693839389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hMOKghXrfuL2nEVSI0FVVFrCQiH4vRrzALBYVbmWdy0=;
 b=hLiW3X0tKv0ifK2Iv2M8fQWcZsgferHbAPqoiLS0BbwOb+sxsmHimiuv96YvKWfF7L
 wurQPiaKyVZcAU+HvrQuGae60pyk6MxR0kOQmy9dbjsi8+VEpUDcr3YGICwd54C/1TPj
 jwnX1tgaCBTSzztnL8etEpNHLK9P8VhRpl7GEzQTpJgOZU2CtboSh7b/o4pQpA6ij0Pu
 7npEvxi9yVdvgeCQ1sIcoUd3yXPMEbmjc3BRnud1KJ5xA85g8JMUx/+ptI2QqZt0fUqh
 d6WXTbiwgZqbTUkDjIgJP8Rab8vuJ3/A93TrObpCunrpX4PPUYnSJUFoHF8tBJW18/SF
 R33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693234589; x=1693839389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hMOKghXrfuL2nEVSI0FVVFrCQiH4vRrzALBYVbmWdy0=;
 b=NpEK/1fnxXnnRCz0rGiZmXqNor9pr+q0ItSm7KcibC3ijUSs2oEkU2RQfxAnTQsjlf
 lLU0GBMOw6ldGKE/zh376bs3QTibvrYPDVc+zmm9LdhsJbMHFuynMCrICRt1AGkU3YPZ
 JBmf2ph0GJWyW+V5lLAZM/uESqCeq18EudX3Z4Hvx2cntDqGHE0OnEFOVAcgjMv7TaGD
 1+xeesBVZ/pqXY5uQt9N+/D83N2Um4Ka8RepdswshUN2GLeBxK9Z43sLE+089kFsT6D1
 gthnK4EpuxVCSDGO+u7vvJGHUADo956BVQ34onYeZcYIt9m2Hra/qJxCxQAvLjB8YNDr
 wzFA==
X-Gm-Message-State: AOJu0YzlmDV4mDGLb308QrkkeloeP2vEDnKQMsVbPrQ4L4+Lt+UTQPQH
 /B9ChdaNI3sERelOZ2hW6ho0Hjmp7R2ZOJXAZTQ=
X-Google-Smtp-Source: AGHT+IHmNQaLn6o7jeSGZu1EqQIRovWYhxt64cFIOBFmqkiL0TJ/RPcrB7bR4vIUSYi75ImyBt4pUA==
X-Received: by 2002:a5d:6103:0:b0:317:53e7:d7c2 with SMTP id
 v3-20020a5d6103000000b0031753e7d7c2mr18905335wrt.11.1693234589253; 
 Mon, 28 Aug 2023 07:56:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 y6-20020adfd086000000b003179b3fd837sm10803230wrh.33.2023.08.28.07.56.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Aug 2023 07:56:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/8] target/helper: Remove unnecessary 'qemu/main-loop.h'
 header
Date: Mon, 28 Aug 2023 16:55:44 +0200
Message-ID: <20230828145545.81165-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828145545.81165-1-philmd@linaro.org>
References: <20230828145545.81165-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

"qemu/main-loop.h" declares functions related to QEMU's
main loop mutex, which these files don't access. Remove
the unused "qemu/main-loop.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/pmu.h                   | 2 --
 target/arm/ptw.c                     | 1 -
 target/loongarch/iocsr_helper.c      | 1 -
 target/loongarch/op_helper.c         | 1 -
 target/mips/tcg/sysemu/lcsr_helper.c | 1 -
 target/nios2/op_helper.c             | 1 -
 target/ppc/int_helper.c              | 1 -
 target/ppc/machine.c                 | 1 -
 target/ppc/mem_helper.c              | 1 -
 target/ppc/mmu_common.c              | 1 -
 target/ppc/mmu_helper.c              | 1 -
 target/ppc/power8-pmu.c              | 1 -
 target/ppc/translate.c               | 1 -
 target/riscv/csr.c                   | 1 -
 target/riscv/m128_helper.c           | 1 -
 target/riscv/op_helper.c             | 1 -
 target/s390x/tcg/crypto_helper.c     | 1 -
 target/s390x/tcg/misc_helper.c       | 1 -
 target/xtensa/dbg_helper.c           | 1 -
 target/xtensa/fpu_helper.c           | 1 -
 target/xtensa/mmu_helper.c           | 2 --
 target/xtensa/op_helper.c            | 2 --
 target/xtensa/win_helper.c           | 1 -
 23 files changed, 26 deletions(-)

diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index d2be06a133..2bfb71ba87 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -17,8 +17,6 @@
  */
 
 #include "cpu.h"
-#include "qemu/main-loop.h"
-#include "exec/exec-all.h"
 
 bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
                                         uint32_t target_ctr);
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index bfbab26b9b..a4b0172df3 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/range.h"
-#include "qemu/main-loop.h"
 #include "exec/exec-all.h"
 #include "cpu.h"
 #include "internals.h"
diff --git a/target/loongarch/iocsr_helper.c b/target/loongarch/iocsr_helper.c
index dda9845d6c..6cd01d5f09 100644
--- a/target/loongarch/iocsr_helper.c
+++ b/target/loongarch/iocsr_helper.c
@@ -6,7 +6,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
diff --git a/target/loongarch/op_helper.c b/target/loongarch/op_helper.c
index cf84f20aba..fe79c62fa4 100644
--- a/target/loongarch/op_helper.c
+++ b/target/loongarch/op_helper.c
@@ -7,7 +7,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
diff --git a/target/mips/tcg/sysemu/lcsr_helper.c b/target/mips/tcg/sysemu/lcsr_helper.c
index 8f97d04313..fb57bcbb78 100644
--- a/target/mips/tcg/sysemu/lcsr_helper.c
+++ b/target/mips/tcg/sysemu/lcsr_helper.c
@@ -7,7 +7,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "internal.h"
 #include "qemu/host-utils.h"
diff --git a/target/nios2/op_helper.c b/target/nios2/op_helper.c
index 0aaf33ffc2..5017457c5e 100644
--- a/target/nios2/op_helper.c
+++ b/target/nios2/op_helper.c
@@ -22,7 +22,6 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
-#include "qemu/main-loop.h"
 
 void helper_raise_exception(CPUNios2State *env, uint32_t index)
 {
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 834da80fe3..96cdb3c7e3 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "internal.h"
 #include "qemu/host-utils.h"
-#include "qemu/main-loop.h"
 #include "qemu/log.h"
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 134b16c625..1270a1f7fc 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -7,7 +7,6 @@
 #include "mmu-hash64.h"
 #include "migration/cpu.h"
 #include "qapi/error.h"
-#include "qemu/main-loop.h"
 #include "kvm_ppc.h"
 #include "power8-pmu.h"
 
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 46eae65819..c7535481d6 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "qemu/host-utils.h"
-#include "qemu/main-loop.h"
 #include "exec/helper-proto.h"
 #include "helper_regs.h"
 #include "exec/cpu_ldst.h"
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 8c000e250d..6ca5d12207 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -28,7 +28,6 @@
 #include "exec/log.h"
 #include "helper_regs.h"
 #include "qemu/error-report.h"
-#include "qemu/main-loop.h"
 #include "qemu/qemu-print.h"
 #include "internal.h"
 #include "mmu-book3s-v3.h"
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index d3ea7588f9..f87d35379a 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -28,7 +28,6 @@
 #include "exec/log.h"
 #include "helper_regs.h"
 #include "qemu/error-report.h"
-#include "qemu/main-loop.h"
 #include "qemu/qemu-print.h"
 #include "internal.h"
 #include "mmu-book3s-v3.h"
diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
index 2537cded83..cbc5889d91 100644
--- a/target/ppc/power8-pmu.c
+++ b/target/ppc/power8-pmu.c
@@ -17,7 +17,6 @@
 #include "exec/helper-proto.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
-#include "qemu/main-loop.h"
 #include "hw/ppc/ppc.h"
 #include "power8-pmu.h"
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 49b6a757b7..7111b34030 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -26,7 +26,6 @@
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
 #include "qemu/host-utils.h"
-#include "qemu/main-loop.h"
 
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ea7585329e..de31818daa 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -23,7 +23,6 @@
 #include "cpu.h"
 #include "pmu.h"
 #include "time_helper.h"
-#include "qemu/main-loop.h"
 #include "exec/exec-all.h"
 #include "exec/tb-flush.h"
 #include "sysemu/cpu-timers.h"
diff --git a/target/riscv/m128_helper.c b/target/riscv/m128_helper.c
index e6a4f6120a..ec14aaa901 100644
--- a/target/riscv/m128_helper.c
+++ b/target/riscv/m128_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "qemu/main-loop.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 7e2f1908ee..5355225d56 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internals.h"
-#include "qemu/main-loop.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 762b277884..93aabd236f 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -13,7 +13,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/main-loop.h"
 #include "qemu/guest-random.h"
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 576157b1f3..e85658ce22 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
-#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "s390x-internal.h"
 #include "qemu/host-utils.h"
diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
index ce2a820c60..3e0c9e8e8b 100644
--- a/target/xtensa/dbg_helper.c
+++ b/target/xtensa/dbg_helper.c
@@ -27,7 +27,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
index d2a10cc797..381e83ded8 100644
--- a/target/xtensa/fpu_helper.c
+++ b/target/xtensa/fpu_helper.c
@@ -27,7 +27,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index fa66e8e867..12552a3347 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -27,14 +27,12 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "qemu/main-loop.h"
 #include "qemu/qemu-print.h"
 #include "qemu/units.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
 
 #define XTENSA_MPU_SEGMENT_MASK 0x0000001f
 #define XTENSA_MPU_ACC_RIGHTS_MASK 0x00000f00
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 1af7becc54..03e2c1889a 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -26,12 +26,10 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
 #include "qemu/timer.h"
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/xtensa/win_helper.c b/target/xtensa/win_helper.c
index 5a1555360a..ec9ff44db0 100644
--- a/target/xtensa/win_helper.c
+++ b/target/xtensa/win_helper.c
@@ -27,7 +27,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
-- 
2.41.0



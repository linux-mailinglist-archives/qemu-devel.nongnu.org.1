Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E5B754074
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 19:27:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKMYZ-0006oq-SA; Fri, 14 Jul 2023 13:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKMYW-0006oh-5v
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:26:12 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKMYQ-0008Cc-Ek
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:26:11 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbef8ad9bbso19197245e9.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 10:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689355564; x=1691947564;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AkuF2B3VMQ7vk791DstUBMlIMAZDDaeR6QoKuqG6UU4=;
 b=EVX2U7LadZrCbRN4pByIzO9/g5NQKTWQUpGFbkzmPc5GT5tuZApp0mbt9iYx/jQCPt
 TRFvpgAMdRrptFvmAUDReVMtBEgJl+wwg5Qlzfn+PVE+6IYg3RR9fJHGzx8RrRphEyo2
 xBLzGNUDgCVm1Ik5+xonxtxhy75HjR9714lgJLhF0qubXAo5A8XCOuFPsgQCIDVDdxWo
 MwbC57gMoyY7vHsMcxUZgb5oVmaIDTGOSdWhbybSjL5gHnrt/6Xd02cUkry3uFYE32GV
 izLPkvfaSI+C4dxvk3qEWY0yAtoYaWgxIBh4gpuc/TpWo1ceSRYeYEjtL83lCBaTtGBj
 7HCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689355564; x=1691947564;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AkuF2B3VMQ7vk791DstUBMlIMAZDDaeR6QoKuqG6UU4=;
 b=jg1/zT19EH2i/3cZoCEnMNRH5EcQa34jphUIM3+WAFjRz2+Gl3FIvZP3KHakSs7n9G
 9DUKFJnAheV4gk2Eeb0zEvF+QwF2BbZrdkqrTBqwQ3IzK2+lbw2R+FCJsiV6g7OPUDn6
 k80/Ue62HM8qR93t7e/BnzkoeBUoLVzA4+JMIuzi5I50u8b32oP3l6yQOUk//pzBOoyt
 vQZ0moQW6QjwNff4JPkFjsc85KHgH4HHfMlRaBEtPLL2mHqEMTs/3cc4Ut9GRNRhuvjR
 dlOS3eVsKWagAWu3yi9qpNvhD29pRkxwanpsXj8+03GfwrWsMTCU6KNNjErMCnqSLTzt
 YGTg==
X-Gm-Message-State: ABy/qLbQps/pCkpFnywS/6LhVruE+Ym5WnSwPRypG/l/LbEcM+vIDuAh
 VWas2mOaOzr+WMHbCmacEOG7T7g6GMP/vHED3O8=
X-Google-Smtp-Source: APBJJlEuW18qmJ8Zc/tJeaT4jK09BoPoLag2asuLhootQ8aVEG7oPSISw4YObf1NRyPp7oau2oHMlQ==
X-Received: by 2002:a1c:740b:0:b0:3fb:b3aa:1c88 with SMTP id
 p11-20020a1c740b000000b003fbb3aa1c88mr4875333wmc.26.1689355564474; 
 Fri, 14 Jul 2023 10:26:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 o6-20020a1c7506000000b003fc00212c1esm1849518wmc.28.2023.07.14.10.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 10:26:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH] target/sparc: Handle FPRS correctly on big-endian hosts
Date: Fri, 14 Jul 2023 18:26:02 +0100
Message-Id: <20230714172602.397267-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

In CPUSparcState we define the fprs field as uint64_t.  However we
then refer to it in translate.c via a TCGv_i32 which we set up with
tcg_global_mem_new_ptr().  This means that on a big-endian host when
the guest does something to writo te the FPRS register this value
ends up in the wrong half of the uint64_t, and the QEMU C code that
refers to env->fprs sees the wrong value.  The effect of this is that
guest code that enables the FPU crashes with spurious FPU Disabled
exceptions.  In particular, this is why
 tests/avocado/machine_sparc64_sun4u.py:Sun4uMachine.test_sparc64_sun4u
times out on an s390 host.

There are multiple ways we could fix this; since there are actually
only three bits in the FPRS register and the code in translate.c
would be a bit painful to convert to dealing with a TCGv_i64, change
the type of the CPU state struct field to match what translate.c is
expecting.

(None of the other fields referenced by the r32[] array in
sparc_tcg_init() have the wrong type.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Another in my occasional series of "fix an avocado failure on
s390" Friday afternoon patches :-)

 target/sparc/cpu.h     | 2 +-
 target/sparc/cpu.c     | 4 ++--
 target/sparc/gdbstub.c | 5 ++++-
 target/sparc/machine.c | 3 ++-
 target/sparc/monitor.c | 2 +-
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 95d2d0da71d..98044572f26 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -521,7 +521,7 @@ struct CPUArchState {
     uint64_t igregs[8]; /* interrupt general registers */
     uint64_t mgregs[8]; /* mmu general registers */
     uint64_t glregs[8 * MAXTL_MAX];
-    uint64_t fprs;
+    uint32_t fprs;
     uint64_t tick_cmpr, stick_cmpr;
     CPUTimer *tick, *stick;
 #define TICK_NPT_MASK        0x8000000000000000ULL
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index e329a7aece5..130ab8f5781 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -673,8 +673,8 @@ static void sparc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                  "cleanwin: %d cwp: %d\n",
                  env->cansave, env->canrestore, env->otherwin, env->wstate,
                  env->cleanwin, env->nwindows - 1 - env->cwp);
-    qemu_fprintf(f, "fsr: " TARGET_FMT_lx " y: " TARGET_FMT_lx " fprs: "
-                 TARGET_FMT_lx "\n", env->fsr, env->y, env->fprs);
+    qemu_fprintf(f, "fsr: " TARGET_FMT_lx " y: " TARGET_FMT_lx " fprs: %016x\n",
+                 env->fsr, env->y, env->fprs);
 
 #else
     qemu_fprintf(f, "psr: %08x (icc: ", cpu_get_psr(env));
diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index a1c8fdc4d55..bddb9609b7b 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -96,7 +96,10 @@ int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     case 83:
         return gdb_get_regl(mem_buf, env->fsr);
     case 84:
-        return gdb_get_regl(mem_buf, env->fprs);
+    {
+        target_ulong fprs = env->fprs;
+        return gdb_get_regl(mem_buf, fprs);
+    }
     case 85:
         return gdb_get_regl(mem_buf, env->y);
     }
diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 44b9e7d75d6..5a8502804a4 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -168,7 +168,8 @@ const VMStateDescription vmstate_sparc_cpu = {
         VMSTATE_UINT64_ARRAY(env.bgregs, SPARCCPU, 8),
         VMSTATE_UINT64_ARRAY(env.igregs, SPARCCPU, 8),
         VMSTATE_UINT64_ARRAY(env.mgregs, SPARCCPU, 8),
-        VMSTATE_UINT64(env.fprs, SPARCCPU),
+        VMSTATE_UINT32(env.fprs, SPARCCPU),
+        VMSTATE_UNUSED(4), /* was unused high half of uint64_t fprs */
         VMSTATE_UINT64(env.tick_cmpr, SPARCCPU),
         VMSTATE_UINT64(env.stick_cmpr, SPARCCPU),
         VMSTATE_CPU_TIMER(env.tick, SPARCCPU),
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index 318413686aa..73f15aa272d 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -154,7 +154,7 @@ const MonitorDef monitor_defs[] = {
     { "otherwin", offsetof(CPUSPARCState, otherwin) },
     { "wstate", offsetof(CPUSPARCState, wstate) },
     { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
-    { "fprs", offsetof(CPUSPARCState, fprs) },
+    { "fprs", offsetof(CPUSPARCState, fprs), NULL, MD_I32 },
 #endif
     { NULL },
 };
-- 
2.34.1



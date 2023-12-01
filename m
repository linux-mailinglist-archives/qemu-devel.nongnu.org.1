Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83819800ABB
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 13:18:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r92TB-00069m-5P; Fri, 01 Dec 2023 07:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r92SJ-0005aq-FL; Fri, 01 Dec 2023 07:17:16 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r92SH-0006Oc-0z; Fri, 01 Dec 2023 07:17:14 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6cdde2aeb64so1947257b3a.2; 
 Fri, 01 Dec 2023 04:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701433029; x=1702037829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d4fmWfFJUU2wqj42pGTu3PZsHuJqb1f7yCNTxZGW2ZY=;
 b=l8uZFrifZ13qKFlCSYFaOGvLerlFUnK394lqefMMYKAqw1AC7zaAeYZyvuc3AIKdbn
 yJluQvvu56evuw2iKWngjLGqrDzfbtEmT176A/XR+t4qtryVS+CpoEMzOPwJDR4LR1bq
 QSPO9P3ZO60PrXAA3WLRE08J54oBwCkue791wy8eYUeg47qctcvoC7bBjsdLp9LQOX8I
 ZWgjjIYWQsmP1lBvNQwkG3+rrPm+kJeBEQ4grIdCOmyLWksSBAas/WNHtm+P9lzondQ6
 UFBU5zDmHocA+IBiLhTH6eFdlRqUGMhqSTK5NI+FE/SU7nOMndvplL2XkJxDadm9+1QT
 l1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701433029; x=1702037829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d4fmWfFJUU2wqj42pGTu3PZsHuJqb1f7yCNTxZGW2ZY=;
 b=IctJbagmWhGsiv6ZS6qlR+i+veFYktnzAzbiUcWncXUrvvrs/jzeBxnw4/cZHW+cI4
 1hGvruOeNoQ3YyXXVqjf3i9Jc487Rz18PAlPXSCvFLr5NX17fkemwaAMacjXkhehvbp6
 VfDFpmUcoJ6s2Da6DowEwqvXDEJgWWt7aYqCz8rjnuN3GjsC2SDOKS8+vqiCfIibedbe
 0/OzjBDtJ6yXzpv8tXjJxRMoDyd2rwqGwG8EnDL2p3AYgKwaGdonR1uQKcrQqaTPcs7q
 Ds7CWsEZdZ+9K9XM5bOEjTOd4Tv92J4DteFmdFLAvH3pJf1WjJUkVmnsO0hLWtRKLog4
 OJxQ==
X-Gm-Message-State: AOJu0Yys0e/DcQZ610Qd8vOho7qqwjLLRICODDacN62f6qWrouxMVCqS
 NiTvUzCpjeooIWPdSBkO4ttkBWcDQso=
X-Google-Smtp-Source: AGHT+IFZr5qtokxwhWbi7ijlEuXaCzSKNOQfJ80WZ94pnq8wuPycCyRol4geeC1ebSMWliVMc3Q/VA==
X-Received: by 2002:a05:6a00:8ce:b0:6c3:1b7d:ecee with SMTP id
 s14-20020a056a0008ce00b006c31b7deceemr32551023pfu.15.1701433029617; 
 Fri, 01 Dec 2023 04:17:09 -0800 (PST)
Received: from wheely.local0.net ([124.170.16.164])
 by smtp.gmail.com with ESMTPSA id
 r19-20020aa78b93000000b006cdd39faaaesm2830782pfd.20.2023.12.01.04.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 04:17:09 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 7/8] target/ppc: Implement core timebase state machine and
 TFMR
Date: Fri,  1 Dec 2023 22:16:35 +1000
Message-ID: <20231201121636.142694-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201121636.142694-1-npiggin@gmail.com>
References: <20231201121636.142694-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This implements the core timebase state machine, which is the core side
of the time-of-day system in POWER processors. This facility is operated
by control fields in the TFMR register, which also contains status
fields.

The core timebase interacts with the chiptod hardware, primarily to
receive TOD updates, to synchronise timebase with other cores. This
model does not actually update TB values with TOD or updates received
from the chiptod, as timebases are always synchronised. It does step
through the states required to perform the update.

There are several asynchronous state transitions. These are modelled
using using mfTFMR to drive state changes, because it is expected that
firmware poll the register to wait for those states. This is good enough
to test basic firmware behaviour without adding real timers. The values
chosen are arbitrary.

Acked-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h             |  36 ++++++
 target/ppc/timebase_helper.c | 210 ++++++++++++++++++++++++++++++++++-
 2 files changed, 243 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 87a6b720f4..ebc663b914 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1188,6 +1188,14 @@ DEXCR_ASPECT(PHIE, 6)
 struct pnv_tod_tbst {
     int tb_ready_for_tod; /* core TB ready to receive TOD from chiptod */
     int tod_sent_to_tb;   /* chiptod sent TOD to the core TB */
+
+    /*
+     * "Timers" for async TBST events are simulated by mfTFAC because TFAC
+     * is polled for such events. These are just used to ensure firmware
+     * performs the polling at least a few times.
+     */
+    int tb_state_timer;
+    int tb_sync_pulse_timer;
 };
 
 /*****************************************************************************/
@@ -2661,6 +2669,34 @@ enum {
     HMER_XSCOM_STATUS_MASK      = PPC_BITMASK(21, 23),
 };
 
+/* TFMR */
+enum {
+    TFMR_CONTROL_MASK           = PPC_BITMASK(0, 24),
+    TFMR_MASK_HMI               = PPC_BIT(10),
+    TFMR_TB_ECLIPZ              = PPC_BIT(14),
+    TFMR_LOAD_TOD_MOD           = PPC_BIT(16),
+    TFMR_MOVE_CHIP_TOD_TO_TB    = PPC_BIT(18),
+    TFMR_CLEAR_TB_ERRORS        = PPC_BIT(24),
+    TFMR_STATUS_MASK            = PPC_BITMASK(25, 63),
+    TFMR_TBST_ENCODED           = PPC_BITMASK(28, 31), /* TBST = TB State */
+    TFMR_TBST_LAST              = PPC_BITMASK(32, 35), /* Previous TBST */
+    TFMR_TB_ENABLED             = PPC_BIT(40),
+    TFMR_TB_VALID               = PPC_BIT(41),
+    TFMR_TB_SYNC_OCCURED        = PPC_BIT(42),
+    TFMR_FIRMWARE_CONTROL_ERROR = PPC_BIT(46),
+};
+
+/* TFMR TBST (Time Base State Machine). */
+enum {
+    TBST_RESET                  = 0x0,
+    TBST_SEND_TOD_MOD           = 0x1,
+    TBST_NOT_SET                = 0x2,
+    TBST_SYNC_WAIT              = 0x6,
+    TBST_GET_TOD                = 0x7,
+    TBST_TB_RUNNING             = 0x8,
+    TBST_TB_ERROR               = 0x9,
+};
+
 /*****************************************************************************/
 
 #define is_isa300(ctx) (!!(ctx->insns_flags2 & PPC2_ISA300))
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 08a6b47ee0..bc1d54a427 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "hw/ppc/ppc.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "qemu/log.h"
@@ -145,15 +146,218 @@ void helper_store_booke_tsr(CPUPPCState *env, target_ulong val)
 }
 
 #if defined(TARGET_PPC64)
-/* POWER processor Timebase Facility */
+/*
+ * POWER processor Timebase Facility
+ */
+
+/*
+ * The TBST is the timebase state machine, which is a per-core machine that
+ * is used to synchronize the core TB with the ChipTOD. States 3,4,5 are
+ * not used in POWER8/9/10.
+ *
+ * The state machine gets driven by writes to TFMR SPR from the core, and
+ * by signals from the ChipTOD. The state machine table for common
+ * transitions is as follows (according to hardware specs, not necessarily
+ * this implementation):
+ *
+ * | Cur            | Event                            | New |
+ * +----------------+----------------------------------+-----+
+ * | 0 RESET        | TFMR |= LOAD_TOD_MOD             | 1   |
+ * | 1 SEND_TOD_MOD | "immediate transition"           | 2   |
+ * | 2 NOT_SET      | mttbu/mttbu40/mttbl              | 2   |
+ * | 2 NOT_SET      | TFMR |= MOVE_CHIP_TOD_TO_TB      | 6   |
+ * | 6 SYNC_WAIT    | "sync pulse from ChipTOD"        | 7   |
+ * | 7 GET_TOD      | ChipTOD xscom MOVE_TOD_TO_TB_REG | 8   |
+ * | 8 TB_RUNNING   | mttbu/mttbu40                    | 8   |
+ * | 8 TB_RUNNING   | TFMR |= LOAD_TOD_MOD             | 1   |
+ * | 8 TB_RUNNING   | mttbl                            | 9   |
+ * | 9 TB_ERROR     | TFMR |= CLEAR_TB_ERRORS          | 0   |
+ *
+ * - LOAD_TOD_MOD will also move states 2,6 to state 1, omitted from table
+ *   because it's not a typical init flow.
+ *
+ * - The ERROR state can be entered from most/all other states on invalid
+ *   states (e.g., if some TFMR control bit is set from a state where it's
+ *   not listed to cause a transition away from), omitted to avoid clutter.
+ *
+ * Note: mttbl causes a timebase error because this inevitably causes
+ * ticks to be lost and TB to become unsynchronized, whereas TB can be
+ * adjusted using mttbu* without losing ticks. mttbl behaviour is not
+ * modelled.
+ *
+ * Note: the TB state machine does not actually cause any real TB adjustment!
+ * TB starts out synchronized across all vCPUs (hardware threads) in
+ * QMEU, so for now the purpose of the TBST and ChipTOD model is simply
+ * to step through firmware initialisation sequences.
+ */
+static unsigned int tfmr_get_tb_state(uint64_t tfmr)
+{
+    return (tfmr & TFMR_TBST_ENCODED) >> (63 - 31);
+}
+
+static uint64_t tfmr_new_tb_state(uint64_t tfmr, unsigned int tbst)
+{
+    tfmr &= ~TFMR_TBST_LAST;
+    tfmr |= (tfmr & TFMR_TBST_ENCODED) >> 4; /* move state to last state */
+    tfmr &= ~TFMR_TBST_ENCODED;
+    tfmr |= (uint64_t)tbst << (63 - 31); /* move new state to state */
+
+    if (tbst == TBST_TB_RUNNING) {
+        tfmr |= TFMR_TB_VALID;
+    } else {
+        tfmr &= ~TFMR_TB_VALID;
+    }
+
+    return tfmr;
+}
+
+static void tb_state_machine_step(CPUPPCState *env)
+{
+    uint64_t tfmr = env->spr[SPR_TFMR];
+    unsigned int tbst = tfmr_get_tb_state(tfmr);
+
+    if (!(tfmr & TFMR_TB_ECLIPZ) || tbst == TBST_TB_ERROR) {
+        return;
+    }
+
+    if (env->pnv_tod_tbst.tb_sync_pulse_timer) {
+        env->pnv_tod_tbst.tb_sync_pulse_timer--;
+    } else {
+        tfmr |= TFMR_TB_SYNC_OCCURED;
+        env->spr[SPR_TFMR] = tfmr;
+    }
+
+    if (env->pnv_tod_tbst.tb_state_timer) {
+        env->pnv_tod_tbst.tb_state_timer--;
+        return;
+    }
+
+    if (tfmr & TFMR_LOAD_TOD_MOD) {
+        tfmr &= ~TFMR_LOAD_TOD_MOD;
+        if (tbst == TBST_GET_TOD) {
+            tfmr = tfmr_new_tb_state(tfmr, TBST_TB_ERROR);
+            tfmr |= TFMR_FIRMWARE_CONTROL_ERROR;
+        } else {
+            tfmr = tfmr_new_tb_state(tfmr, TBST_SEND_TOD_MOD);
+            /* State seems to transition immediately */
+            tfmr = tfmr_new_tb_state(tfmr, TBST_NOT_SET);
+        }
+    } else if (tfmr & TFMR_MOVE_CHIP_TOD_TO_TB) {
+        if (tbst == TBST_SYNC_WAIT) {
+            tfmr = tfmr_new_tb_state(tfmr, TBST_GET_TOD);
+            env->pnv_tod_tbst.tb_state_timer = 3;
+        } else if (tbst == TBST_GET_TOD) {
+            if (env->pnv_tod_tbst.tod_sent_to_tb) {
+                tfmr = tfmr_new_tb_state(tfmr, TBST_TB_RUNNING);
+                tfmr &= ~TFMR_MOVE_CHIP_TOD_TO_TB;
+                env->pnv_tod_tbst.tb_ready_for_tod = 0;
+                env->pnv_tod_tbst.tod_sent_to_tb = 0;
+            }
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR, "TFMR error: MOVE_CHIP_TOD_TO_TB "
+                          "state machine in invalid state 0x%x\n", tbst);
+            tfmr = tfmr_new_tb_state(tfmr, TBST_TB_ERROR);
+            tfmr |= TFMR_FIRMWARE_CONTROL_ERROR;
+            env->pnv_tod_tbst.tb_ready_for_tod = 0;
+        }
+    }
+
+    env->spr[SPR_TFMR] = tfmr;
+}
+
 target_ulong helper_load_tfmr(CPUPPCState *env)
 {
-    return env->spr[SPR_TFMR];
+    tb_state_machine_step(env);
+
+    return env->spr[SPR_TFMR] | TFMR_TB_ECLIPZ;
 }
 
 void helper_store_tfmr(CPUPPCState *env, target_ulong val)
 {
-    env->spr[SPR_TFMR] = val;
+    uint64_t tfmr = env->spr[SPR_TFMR];
+    uint64_t clear_on_write;
+    unsigned int tbst = tfmr_get_tb_state(tfmr);
+
+    if (!(val & TFMR_TB_ECLIPZ)) {
+        qemu_log_mask(LOG_UNIMP, "TFMR non-ECLIPZ mode not implemented\n");
+        tfmr &= ~TFMR_TBST_ENCODED;
+        tfmr &= ~TFMR_TBST_LAST;
+        goto out;
+    }
+
+    /* Update control bits */
+    tfmr = (tfmr & ~TFMR_CONTROL_MASK) | (val & TFMR_CONTROL_MASK);
+
+    /* Several bits are clear-on-write, only one is implemented so far */
+    clear_on_write = val & TFMR_FIRMWARE_CONTROL_ERROR;
+    tfmr &= ~clear_on_write;
+
+    /*
+     * mtspr always clears this. The sync pulse timer makes it come back
+     * after the second mfspr.
+     */
+    tfmr &= ~TFMR_TB_SYNC_OCCURED;
+    env->pnv_tod_tbst.tb_sync_pulse_timer = 1;
+
+    if (ppc_cpu_tir(env_archcpu(env)) != 0 &&
+        (val & (TFMR_LOAD_TOD_MOD | TFMR_MOVE_CHIP_TOD_TO_TB))) {
+        qemu_log_mask(LOG_UNIMP, "TFMR timebase state machine can only be "
+                                 "driven by thread 0\n");
+        goto out;
+    }
+
+    if (((tfmr | val) & (TFMR_LOAD_TOD_MOD | TFMR_MOVE_CHIP_TOD_TO_TB)) ==
+                        (TFMR_LOAD_TOD_MOD | TFMR_MOVE_CHIP_TOD_TO_TB)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "TFMR error: LOAD_TOD_MOD and "
+                                       "MOVE_CHIP_TOD_TO_TB both set\n");
+        tfmr = tfmr_new_tb_state(tfmr, TBST_TB_ERROR);
+        tfmr |= TFMR_FIRMWARE_CONTROL_ERROR;
+        env->pnv_tod_tbst.tb_ready_for_tod = 0;
+        goto out;
+    }
+
+    if (tfmr & TFMR_CLEAR_TB_ERRORS) {
+        /*
+         * Workbook says TFMR_CLEAR_TB_ERRORS should be written twice.
+         * This is not simulated/required here.
+         */
+        tfmr = tfmr_new_tb_state(tfmr, TBST_RESET);
+        tfmr &= ~TFMR_CLEAR_TB_ERRORS;
+        tfmr &= ~TFMR_LOAD_TOD_MOD;
+        tfmr &= ~TFMR_MOVE_CHIP_TOD_TO_TB;
+        tfmr &= ~TFMR_FIRMWARE_CONTROL_ERROR; /* XXX: should this be cleared? */
+        env->pnv_tod_tbst.tb_ready_for_tod = 0;
+        env->pnv_tod_tbst.tod_sent_to_tb = 0;
+        goto out;
+    }
+
+    if (tbst == TBST_TB_ERROR) {
+        qemu_log_mask(LOG_GUEST_ERROR, "TFMR error: mtspr TFMR in TB_ERROR"
+                                       " state\n");
+        tfmr |= TFMR_FIRMWARE_CONTROL_ERROR;
+        return;
+    }
+
+    if (tfmr & TFMR_LOAD_TOD_MOD) {
+        /* Wait for an arbitrary 3 mfspr until the next state transition. */
+        env->pnv_tod_tbst.tb_state_timer = 3;
+    } else if (tfmr & TFMR_MOVE_CHIP_TOD_TO_TB) {
+        if (tbst == TBST_NOT_SET) {
+            tfmr = tfmr_new_tb_state(tfmr, TBST_SYNC_WAIT);
+            env->pnv_tod_tbst.tb_ready_for_tod = 1;
+            env->pnv_tod_tbst.tb_state_timer = 3; /* arbitrary */
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR, "TFMR error: MOVE_CHIP_TOD_TO_TB "
+                                           "not in TB not set state 0x%x\n",
+                                           tbst);
+            tfmr = tfmr_new_tb_state(tfmr, TBST_TB_ERROR);
+            tfmr |= TFMR_FIRMWARE_CONTROL_ERROR;
+            env->pnv_tod_tbst.tb_ready_for_tod = 0;
+        }
+    }
+
+out:
+    env->spr[SPR_TFMR] = tfmr;
 }
 #endif
 
-- 
2.42.0



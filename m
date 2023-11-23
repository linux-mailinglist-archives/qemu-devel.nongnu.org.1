Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8B57F5C5D
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 11:33:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r66zA-0006AU-2i; Thu, 23 Nov 2023 05:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r66z7-00068L-Jh; Thu, 23 Nov 2023 05:31:01 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r66z3-0006jL-HQ; Thu, 23 Nov 2023 05:31:01 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cf74ad87e0so5837265ad.3; 
 Thu, 23 Nov 2023 02:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700735452; x=1701340252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHs87zyPo5rp34m15ThA5k+UEpfu+5+tbqdj+0DUG1c=;
 b=jWk5gnkmCnaEqFdZrvYUf7lplVMb7QJPBwEn4Y/xUfjtnHtUBd5XahDz5GGvt5IMia
 DaXGDYaGl6D74TsPUvqneeaSceaX1FcLhFDM2ADHoYeSzf93nIQQtZ4IoVsMfgJFECeo
 qZFbSZqL7dLMDUpuJMYIrohVeMifr2aBKomLdC+3werJJVkY6NngMrj6H7aTov6YkJhC
 nwnFRCyiTifw3N5xhsQYT6R/ZyRHYNS6d/R7A+E1hsbNixO6bnhpP07STLg2POBTRUpK
 NY/iOR90KP/4EFqdBCxwXY5sMDBPM4lxyGpGPaVR6RYpssfiB7I/kRZjfXT3xqOIys3V
 SRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700735452; x=1701340252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHs87zyPo5rp34m15ThA5k+UEpfu+5+tbqdj+0DUG1c=;
 b=dZ1fnQqNtrBfQyBomEn/WcyMvTy2nsCRVS/PIQNq2NWP9jNJFrpuFudQe5FDZtfp7X
 oZWUVZpq5K8NDoG/3sugq9y/+tqTev4jAA7kdNN8TMWMf1Yh0NLk1fKjuU0SNEK7kui3
 lh0KRv5NUeWA7hWDl2waomnVjzzwuc7YjqKkteW9HywLXTmtbN2KSq4eCqhQP0YJxRPs
 YC8pTyEt6ASK4VklLYvWhWalUbeimR6eKyvqws/EX87SKwzvcPpg8z0HfY7GUjn6tN7b
 qafXjqRqBHph/UH0+1Q2ZWv2Tk8pGaIrzED/tBI4tpzLXumH1ZezkIPpF7oQIGnjbqRO
 lQeA==
X-Gm-Message-State: AOJu0YxWPThJ7tQdMtwvs/vcPCA6EUGFDLC+XbMOGCP+CLeZ97TIF+od
 chvskJ0gQyD9UDZN2WAGi3whKX5ezvI=
X-Google-Smtp-Source: AGHT+IHFUXMV19aYwvsq99HBmciKyyVDjQIFGoE4PhFW+YzldC7+kz00AoSSXfTjmWzoD6iBlr+xcQ==
X-Received: by 2002:a17:902:ced1:b0:1cc:6597:f421 with SMTP id
 d17-20020a170902ced100b001cc6597f421mr6208407plg.48.1700735451861; 
 Thu, 23 Nov 2023 02:30:51 -0800 (PST)
Received: from wheely.local0.net (60-240-124-93.tpgi.com.au. [60.240.124.93])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a170902d38400b001cc1dff5b86sm1009070pld.244.2023.11.23.02.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 02:30:51 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 6/7] target/ppc: Implement core timebase state machine and TFMR
Date: Thu, 23 Nov 2023 20:30:17 +1000
Message-ID: <20231123103018.172383-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123103018.172383-1-npiggin@gmail.com>
References: <20231123103018.172383-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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
 target/ppc/cpu.h             |  35 ++++++
 target/ppc/timebase_helper.c | 210 ++++++++++++++++++++++++++++++++++-
 2 files changed, 242 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 8df5626939..ed4f06f059 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1264,6 +1264,13 @@ struct CPUArchState {
     /* PowerNV chiptod / timebase facility state. */
     int tb_ready_for_tod; /* core TB ready to receive TOD from chiptod */
     int tod_sent_to_tb;   /* chiptod sent TOD to the core TB */
+
+    /*
+     * Timers for async events are simulated by mfTFAC because TFAC is to be
+     * polled for event.
+     */
+    int tb_state_timer;
+    int tb_sync_pulse_timer;
 #endif
 #endif
 
@@ -2655,6 +2662,34 @@ enum {
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
index 08a6b47ee0..9c77736e77 100644
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
+    if (env->tb_sync_pulse_timer) {
+        env->tb_sync_pulse_timer--;
+    } else {
+        tfmr |= TFMR_TB_SYNC_OCCURED;
+        env->spr[SPR_TFMR] = tfmr;
+    }
+
+    if (env->tb_state_timer) {
+        env->tb_state_timer--;
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
+            env->tb_state_timer = 3;
+        } else if (tbst == TBST_GET_TOD) {
+            if (env->tod_sent_to_tb) {
+                tfmr = tfmr_new_tb_state(tfmr, TBST_TB_RUNNING);
+                tfmr &= ~TFMR_MOVE_CHIP_TOD_TO_TB;
+                env->tb_ready_for_tod = 0;
+                env->tod_sent_to_tb = 0;
+            }
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR, "TFMR error: MOVE_CHIP_TOD_TO_TB "
+                          "state machine in invalid state 0x%x\n", tbst);
+            tfmr = tfmr_new_tb_state(tfmr, TBST_TB_ERROR);
+            tfmr |= TFMR_FIRMWARE_CONTROL_ERROR;
+            env->tb_ready_for_tod = 0;
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
+    env->tb_sync_pulse_timer = 1;
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
+        env->tb_ready_for_tod = 0;
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
+        env->tb_ready_for_tod = 0;
+        env->tod_sent_to_tb = 0;
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
+        env->tb_state_timer = 3;
+    } else if (tfmr & TFMR_MOVE_CHIP_TOD_TO_TB) {
+        if (tbst == TBST_NOT_SET) {
+            tfmr = tfmr_new_tb_state(tfmr, TBST_SYNC_WAIT);
+            env->tb_ready_for_tod = 1;
+            env->tb_state_timer = 3; /* arbitrary */
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR, "TFMR error: MOVE_CHIP_TOD_TO_TB "
+                                           "not in TB not set state 0x%x\n",
+                                           tbst);
+            tfmr = tfmr_new_tb_state(tfmr, TBST_TB_ERROR);
+            tfmr |= TFMR_FIRMWARE_CONTROL_ERROR;
+            env->tb_ready_for_tod = 0;
+        }
+    }
+
+out:
+    env->spr[SPR_TFMR] = tfmr;
 }
 #endif
 
-- 
2.42.0



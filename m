Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F10D7F5C50
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 11:31:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r66z7-000662-3s; Thu, 23 Nov 2023 05:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r66z4-00064M-VL; Thu, 23 Nov 2023 05:30:58 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r66yy-0006iy-7K; Thu, 23 Nov 2023 05:30:58 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1cc9b626a96so5411865ad.2; 
 Thu, 23 Nov 2023 02:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700735447; x=1701340247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2nZxspqxXGSaOJSNc7FrNBWBoHuHjERZ9VQDvWondA=;
 b=JtoDKP0uHB7rL4e8k4p9WEIGqdKGdpx/p1/RowB9RcKXJv2lhS1IcecrqBHAXjezwe
 5t7Q9skjEXoCIss9No8ihELf+5Ftsw9j5UW+O+kYCo0QnZcHVfagVkWVPZ/m1Lz+1X5d
 YeDdPzxJt8IqwaqExayUIzrdstTOW5JG1fw53cZJ8Ql4vwPVftIV1uUg0H//AfWCS8EV
 H3TqoyAgckCFMfpCfd0e1M5pbaS7piul+UyhAI7ISOcv9oC4K7qOULXQKOLDwXOVCddq
 2VCEUvyNaST6dT+ddqUVRuppeRqIDYsI9CR+Qvzgl9Yr7SwgLC69IOLyDPSYEV8iYDBZ
 UFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700735447; x=1701340247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p2nZxspqxXGSaOJSNc7FrNBWBoHuHjERZ9VQDvWondA=;
 b=U5oEA7oP+Az0owUOgf41Q5OZG+2yKL7L581NVSn6A4BQu1bEz8ANaLosa06YHPwckM
 /ewztZGYUGULoUzosRJkcW+Hy3IP/0G1HLOtM6bE3Sd/JPr44wP3U79X+cxsk4CbuMo0
 9k+8KecyLIQGd8ZwHYJMLkdgYVnXnBljfv4Q00WnF/aGJOwBxUn8qCM0ZkXAJcCO2EPr
 gIL7+lon+65c8dRhLv7U5zpdm4JzsgVPjVpzLmzTvYvBGsjrjuYkLewloOhl0zB+IqRC
 2Xvxh/YUwxj6W7UKBLuStBSHDPWqr6/ecYJ2XrqnXhl97ySiOd37hIyeCnZoM4vlQ1Wx
 igwQ==
X-Gm-Message-State: AOJu0YxWJAqAAhzeTtEDrR+8AWjdbJ6u+l3B6ANvhmeobaVjeM4C9wDK
 6PWLRWZAShl/r1eg2oSXwp2rIoqZnTE=
X-Google-Smtp-Source: AGHT+IHVU/b5CnUm6m7u4gu4fSvf0dJfamC9xxL7vYVqAS1/emWw/YpE9KM6ylFibfVSk6yTmwvNXA==
X-Received: by 2002:a17:902:d511:b0:1cc:5aef:f2c1 with SMTP id
 b17-20020a170902d51100b001cc5aeff2c1mr4673429plg.33.1700735446889; 
 Thu, 23 Nov 2023 02:30:46 -0800 (PST)
Received: from wheely.local0.net (60-240-124-93.tpgi.com.au. [60.240.124.93])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a170902d38400b001cc1dff5b86sm1009070pld.244.2023.11.23.02.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 02:30:46 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 5/7] pnv/chiptod: Implement the ChipTOD to Core transfer
Date: Thu, 23 Nov 2023 20:30:16 +1000
Message-ID: <20231123103018.172383-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123103018.172383-1-npiggin@gmail.com>
References: <20231123103018.172383-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

One of the functions of the ChipTOD is to transfer TOD to the Core
(aka PC - Pervasive Core) timebase facility.

The ChipTOD can be programmed with a target address to send the TOD
value to. The hardware implementation seems to perform this by
sending the TOD value to a SCOM addres.

This implementation grabs the core directly and manipulates the
timebase facility state in the core. This is a hack, but it works
enough for now. A better implementation would implement the transfer
to the PnvCore xscom register and drive the timebase state machine
from there.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_chiptod.h |  3 ++
 include/hw/ppc/pnv_core.h    |  4 ++
 target/ppc/cpu.h             |  7 +++
 hw/ppc/pnv.c                 | 33 +++++++++++++
 hw/ppc/pnv_chiptod.c         | 92 ++++++++++++++++++++++++++++++++++++
 5 files changed, 139 insertions(+)

diff --git a/include/hw/ppc/pnv_chiptod.h b/include/hw/ppc/pnv_chiptod.h
index e2765c3bfc..ffcc376e80 100644
--- a/include/hw/ppc/pnv_chiptod.h
+++ b/include/hw/ppc/pnv_chiptod.h
@@ -29,6 +29,8 @@ enum tod_state {
     tod_stopped = 1,
 };
 
+typedef struct PnvCore PnvCore;
+
 struct PnvChipTOD {
     DeviceState xd;
 
@@ -40,6 +42,7 @@ struct PnvChipTOD {
     enum tod_state tod_state;
     uint64_t tod_error;
     uint64_t pss_mss_ctrl_reg;
+    PnvCore *slave_pc_target;
 };
 
 struct PnvChipTODClass {
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 4db21229a6..5f52ae7dbf 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -85,4 +85,8 @@ struct PnvQuad {
     MemoryRegion xscom_regs;
     MemoryRegion xscom_qme_regs;
 };
+
+PnvCore *pnv_get_core_by_xscom_base(PnvChip *chip, uint32_t xscom_base);
+PnvCore *pnv_get_core_by_id(PnvChip *chip, uint32_t core_id);
+
 #endif /* PPC_PNV_CORE_H */
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 848e583c2d..8df5626939 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1258,6 +1258,13 @@ struct CPUArchState {
     uint32_t tlb_need_flush; /* Delayed flush needed */
 #define TLB_NEED_LOCAL_FLUSH   0x1
 #define TLB_NEED_GLOBAL_FLUSH  0x2
+
+#if defined(TARGET_PPC64)
+    /* Would be nice to put these into PnvCore */
+    /* PowerNV chiptod / timebase facility state. */
+    int tb_ready_for_tod; /* core TB ready to receive TOD from chiptod */
+    int tod_sent_to_tb;   /* chiptod sent TOD to the core TB */
+#endif
 #endif
 
     /* Other registers */
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 546266ae3d..fa0dc26732 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2032,6 +2032,39 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
     }
 }
 
+PnvCore *pnv_get_core_by_xscom_base(PnvChip *chip, uint32_t xscom_base)
+{
+    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
+    int i;
+
+    for (i = 0; i < chip->nr_cores; i++) {
+        PnvCore *pc = chip->cores[i];
+        CPUCore *cc = CPU_CORE(pc);
+        int core_hwid = cc->core_id;
+
+        if (pcc->xscom_core_base(chip, core_hwid) == xscom_base) {
+            return pc;
+        }
+    }
+    return NULL;
+}
+
+PnvCore *pnv_get_core_by_id(PnvChip *chip, uint32_t core_id)
+{
+    int i;
+
+    for (i = 0; i < chip->nr_cores; i++) {
+        PnvCore *pc = chip->cores[i];
+        CPUCore *cc = CPU_CORE(pc);
+
+        if (cc->core_id == core_id) {
+            return pc;
+        }
+    }
+    return NULL;
+}
+
+
 static void pnv_chip_realize(DeviceState *dev, Error **errp)
 {
     PnvChip *chip = PNV_CHIP(dev);
diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
index a7bfe4298d..a2c1c83800 100644
--- a/hw/ppc/pnv_chiptod.c
+++ b/hw/ppc/pnv_chiptod.c
@@ -201,6 +201,62 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
         chiptod->pss_mss_ctrl_reg = val & PPC_BITMASK(0, 31);
         break;
 
+    case TOD_TX_TTYPE_CTRL_REG:
+        /*
+         * This register sets the target of the TOD value transfer initiated
+         * by TOD_MOVE_TOD_TO_TB. The TOD is able to send the address to
+         * any target register, though in practice only the PC TOD register
+         * should be used. ChipTOD has a "SCOM addressing" mode which fully
+         * specifies the SCOM address, and a core-ID mode which uses the
+         * core ID to target the PC TOD for a given core.
+         *
+         * skiboot uses SCOM for P10 and ID for P9, possibly due to hardware
+         * weirdness. For this reason, that is all we implement here.
+         */
+        if (val & PPC_BIT(35)) { /* SCOM addressing */
+            uint32_t addr2 = val >> 32;
+            uint32_t reg = addr2 & 0xfff;
+
+            if (reg != PC_TOD) {
+                qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: SCOM addressing: "
+                              "unimplemented slave register 0x%" PRIx32 "\n",
+                              reg);
+                return;
+            }
+
+            /*
+             * This may not deal with P10 big-core addressing at the moment.
+             * The big-core code in skiboot syncs small cores, but it targets
+             * the even PIR (first small-core) when syncing second small-core.
+             */
+            chiptod->slave_pc_target =
+                    pnv_get_core_by_xscom_base(chiptod->chip, addr2 & ~0xfff);
+            if (!chiptod->slave_pc_target) {
+                qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
+                              " TOD_TX_TTYPE_CTRL_REG val 0x%" PRIx64
+                              " invalid slave XSCOM address\n", val);
+            }
+
+        } else { /* PIR addressing */
+            uint32_t core_id;
+
+            if (!is_power9) {
+                qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: PIR addressing"
+                              " is only implemented for POWER9\n");
+                return;
+            }
+
+            core_id = GETFIELD(TOD_TX_TTYPE_PIB_SLAVE_ADDR, val) & 0x1f;
+            chiptod->slave_pc_target = pnv_get_core_by_id(chiptod->chip,
+                                                           core_id);
+            if (!chiptod->slave_pc_target) {
+                qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
+                              " TOD_TX_TTYPE_CTRL_REG val 0x%" PRIx64
+                              " invalid slave core ID 0x%" PRIx32 "\n",
+                              val, core_id);
+            }
+        }
+        break;
     case TOD_ERROR_REG:
         chiptod->tod_error &= ~val;
         break;
@@ -215,6 +271,42 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
     case TOD_LOAD_TOD_REG:
         chiptod->tod_state = tod_running;
         break;
+    case TOD_MOVE_TOD_TO_TB_REG:
+        /*
+         * XXX: it should be a cleaner model to have this drive a SCOM
+         * transaction to the target address, and implement the state machine
+         * in the PnvCore. For now, this hack makes things work.
+         */
+        if (!(val & PPC_BIT(0))) {
+            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
+                          " TOD_MOVE_TOD_TO_TB_REG with bad val 0x%016lx\n",
+                          val);
+        } else if (chiptod->slave_pc_target == NULL) {
+            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
+                          " TOD_MOVE_TOD_TO_TB_REG with no slave target\n");
+        } else {
+            PowerPCCPU *cpu = chiptod->slave_pc_target->threads[0];
+            CPUPPCState *env = &cpu->env;
+
+            /*
+             * Moving TOD to TB will set the TB of all threads in a
+             * core, so skiboot only does this once per thread0, so
+             * that is where we keep the timebase state machine.
+             *
+             * It is likely possible for TBST to be driven from other
+             * threads in the core, but for now we only implement it for
+             * thread 0.
+             */
+
+            if (env->tb_ready_for_tod) {
+                env->tod_sent_to_tb = 1;
+            } else {
+                qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
+                              " TOD_MOVE_TOD_TO_TB_REG with TB not ready to"
+                              " receive TOD\n");
+            }
+        }
+        break;
     case TOD_TX_TTYPE_4_REG:
         if (is_power9) {
             chiptod_power9_send_remotes(chiptod);
-- 
2.42.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD277E3301
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:33:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0BtW-0002jm-CM; Mon, 06 Nov 2023 21:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BtM-0002Mf-FW
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:36 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BtK-00033u-Lq
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:36 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1cc394f4cdfso35545745ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324352; x=1699929152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6nS6hf7Wi/XnOI0vXjxHyhHjdp7+KtBoPSC9aLMTBPo=;
 b=fwnDBducieWsJN2PJ7cZkrLjzcJmaMTVODzMbzlA5dI3xU3dPBF1iYLw4F6fiFMMp5
 IYYTAOh7pFAxLER6Nt6IoEWLcOsOZ4wqHLwX1+PinbsWTKbJmbC1r4PN93qHfd9I2ME/
 DmjfX9b0iBpGOYN3z1dr2TYvaRkFb0hh/TjnmLKxJnXz6G58UhDHpGKK7UJJ85J6J2kQ
 eeH+4zOeLGB6EA3m9MJwuo4dtBqY59yQLE+U6CM9Yye03lox8fuflmQvwSzv6JvOYgJV
 syMcXea4zUAYA0p7YXlWeSrXHJyA/ihTz2tjLF611jIzWKm1bSFcpWW64CTv892IhKuA
 kTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324352; x=1699929152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6nS6hf7Wi/XnOI0vXjxHyhHjdp7+KtBoPSC9aLMTBPo=;
 b=YGdTSfNXxU6iXL46l9Z3UMt9NkhkmEScQgGfT+ohaWe86l0HTsSjNWa9oQ9BlPFkdC
 WbylO+ylSxrRnZJcVy7dqmnL9F99pcZY4SDB/ONp/ZTvI8TJqfY2udvYbmA2b1+BrSR4
 uSw3Qr1PaCG8pCpEOW5W1WegRMrdbTG3snB6xg1okCoquIku0I8U1BeUMyMrSfhay4HG
 dfCH0uHOdHYbrSzdepO8LPCkuJfl5/gIAOGjedC3F2RAxR0nNEL5lTXXoQN7P9pFiOqV
 4sjL8CpNFUm2xuMCLvu7dFX+Czh5tsf6C7jEBZYRR+zBCv53PAmCj+ZWiI2kXQo4pBUQ
 UfQA==
X-Gm-Message-State: AOJu0YxrZU+aoc09IYxyKrHMEGJXcStceRzugLJP1Us1CXkjUHXCfNLF
 PfoK+4qlKT1p3asv0ifBRQjNwCGXKV5yxQ==
X-Google-Smtp-Source: AGHT+IGTy25I/4vcRmeMyG1jXAPnuf/nin29TI0hg724ThnN5VJGJfY2BugLFLxyUJHsBlxW6GhZfQ==
X-Received: by 2002:a17:902:ecd2:b0:1cc:6dfa:ca55 with SMTP id
 a18-20020a170902ecd200b001cc6dfaca55mr21364745plh.25.1699324351945; 
 Mon, 06 Nov 2023 18:32:31 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:32:31 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rob Bradford <rbradford@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Atish Patra <atishp@rivosinc.com>
Subject: [PULL 45/49] target/riscv: Propagate error from PMU setup
Date: Tue,  7 Nov 2023 12:29:41 +1000
Message-ID: <20231107022946.1055027-46-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Rob Bradford <rbradford@rivosinc.com>

More closely follow the QEMU style by returning an Error and propagating
it there is an error relating to the PMU setup.

Further simplify the function by removing the num_counters parameter as
this is available from the passed in cpu pointer.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20231031154000.18134-2-rbradford@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmu.h         |  3 ++-
 target/riscv/pmu.c         | 19 +++++++++----------
 target/riscv/tcg/tcg-cpu.c |  8 +++++++-
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index 2bfb71ba87..88e0713296 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -17,13 +17,14 @@
  */
 
 #include "cpu.h"
+#include "qapi/error.h"
 
 bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
                                         uint32_t target_ctr);
 bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env,
                                   uint32_t target_ctr);
 void riscv_pmu_timer_cb(void *priv);
-int riscv_pmu_init(RISCVCPU *cpu, int num_counters);
+void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
 int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
                                uint32_t ctr_idx);
 int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 36f6307d28..13801ccb78 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -434,22 +434,21 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
 }
 
 
-int riscv_pmu_init(RISCVCPU *cpu, int num_counters)
+void riscv_pmu_init(RISCVCPU *cpu, Error **errp)
 {
-    if (num_counters > (RV_MAX_MHPMCOUNTERS - 3)) {
-        return -1;
+    uint8_t pmu_num = cpu->cfg.pmu_num;
+
+    if (pmu_num > (RV_MAX_MHPMCOUNTERS - 3)) {
+        error_setg(errp, "Number of counters exceeds maximum available");
+        return;
     }
 
     cpu->pmu_event_ctr_map = g_hash_table_new(g_direct_hash, g_direct_equal);
     if (!cpu->pmu_event_ctr_map) {
-        /* PMU support can not be enabled */
-        qemu_log_mask(LOG_UNIMP, "PMU events can't be supported\n");
-        cpu->cfg.pmu_num = 0;
-        return -1;
+        error_setg(errp, "Unable to allocate PMU event hash table");
+        return;
     }
 
     /* Create a bitmask of available programmable counters */
-    cpu->pmu_avail_ctrs = MAKE_32BIT_MASK(3, num_counters);
-
-    return 0;
+    cpu->pmu_avail_ctrs = MAKE_32BIT_MASK(3, pmu_num);
 }
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 1a3351b142..144bdac1b2 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -689,7 +689,13 @@ static bool tcg_cpu_realize(CPUState *cs, Error **errp)
     }
 
     if (cpu->cfg.pmu_num) {
-        if (!riscv_pmu_init(cpu, cpu->cfg.pmu_num) && cpu->cfg.ext_sscofpmf) {
+        riscv_pmu_init(cpu, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return false;
+        }
+
+        if (cpu->cfg.ext_sscofpmf) {
             cpu->pmu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                           riscv_pmu_timer_cb, cpu);
         }
-- 
2.41.0



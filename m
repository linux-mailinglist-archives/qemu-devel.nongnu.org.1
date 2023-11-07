Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7070B7E331E
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:36:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0BtX-0002sk-7r; Mon, 06 Nov 2023 21:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BtT-0002di-CK
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:44 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BtR-000355-Gi
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:43 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc9b626a96so26948225ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324360; x=1699929160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86eOCq3GJb8P19t66TMmdNIR+r6mp8CuoVNtyVMI0o0=;
 b=RYq7o3r0u+160+04s2LtmjnB8Uj0rCtAYqlE9ImEWcfZPlGvLs3hgsD9Eaecw2Q0kF
 tXVRgLacPTK3rxvnG1stQBTeS5UaRrTxQvkR81J9qq2MrP74N2kOhZagbUtF30tTPP1V
 k7jBjjY02lzfdQtK2mAGk/zQMPVapTxtwZt0afFJqXTbZfZkg265E3Sn4W3qP2A6+8P5
 TzZJOgs68J/24/Yc6bS2249IgD+vyF2Bb2jnyzSW8+w4x2FSFTaK93R8Gs+byj7XOPWy
 fJS5r1gZnjKT7pKEy3GPJRlV5ZYUZc3XTbvb8M92AjzZxGDCp8p9BWn79CsEu1oKG2J+
 1kzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324360; x=1699929160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=86eOCq3GJb8P19t66TMmdNIR+r6mp8CuoVNtyVMI0o0=;
 b=jxyMF4klFv1PuMqw+g34NF9Rzen5GxPjMMwXrEqnVULvH3p2LMBlI9EDuhKO9ohseI
 lXfeFfEMio47MQjPb0agTzdj0YUiehjCENDCqNH9wTjJPHo5TT+9jqF2zUd/7BKk1/On
 7kPFEBsd4sZ2Htz6WDb0xMoqoinw/5fM/9mimzNqFMoiesUlG4wps6iHiFrWvJcrlpVb
 Va7DYZxaTT7+k+iwURAI2xiPyUQN4iEjUZqBwx5doChF+HSu3l9MVxHULBBLaGRX76rO
 9Y1FK0M9Zo553PXANCrku69ZF/dQVm4fePm1PjtAWt/Hqjqn8K/3wmUT4IUYNoHO/yCb
 igJQ==
X-Gm-Message-State: AOJu0Ywj/VpNlSXTk31tamNv18SC9dH+5dJk98fLaXAXq8Uiqy8b36Rt
 Lw+hUv1ya6uFV7WuSpLPGKz2gbiQdsUIGA==
X-Google-Smtp-Source: AGHT+IHXaHjxy2yQYi9o1eFdG7/dlMalEgIi4ylyPk1wWQ+wjOl33+HDGAUA5SHAMy7BWuUT3lhEnQ==
X-Received: by 2002:a17:902:f093:b0:1cc:3932:4a95 with SMTP id
 p19-20020a170902f09300b001cc39324a95mr17861000pla.62.1699324359722; 
 Mon, 06 Nov 2023 18:32:39 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:32:38 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rob Bradford <rbradford@rivosinc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Atish Patra <atishp@rivosinc.com>
Subject: [PULL 47/49] target/riscv: Use existing PMU counter mask in FDT
 generation
Date: Tue,  7 Nov 2023 12:29:43 +1000
Message-ID: <20231107022946.1055027-48-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

During the FDT generation use the existing mask containing the enabled
counters rather then generating a new one. Using the existing mask will
support the use of discontinuous counters.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20231031154000.18134-4-rbradford@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmu.h | 2 +-
 hw/riscv/virt.c    | 2 +-
 target/riscv/pmu.c | 6 +-----
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index 88e0713296..505fc850d3 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -28,6 +28,6 @@ void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
 int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
                                uint32_t ctr_idx);
 int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
-void riscv_pmu_generate_fdt_node(void *fdt, int num_counters, char *pmu_name);
+void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 1732c42915..c7fc97e273 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -722,7 +722,7 @@ static void create_fdt_pmu(RISCVVirtState *s)
     pmu_name = g_strdup_printf("/pmu");
     qemu_fdt_add_subnode(ms->fdt, pmu_name);
     qemu_fdt_setprop_string(ms->fdt, pmu_name, "compatible", "riscv,pmu");
-    riscv_pmu_generate_fdt_node(ms->fdt, hart.cfg.pmu_num, pmu_name);
+    riscv_pmu_generate_fdt_node(ms->fdt, hart.pmu_avail_ctrs, pmu_name);
 
     g_free(pmu_name);
 }
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 13801ccb78..7ddf4977b1 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -34,13 +34,9 @@
  * to provide the correct value as well. Heterogeneous PMU per hart is not
  * supported yet. Thus, number of counters are same across all harts.
  */
-void riscv_pmu_generate_fdt_node(void *fdt, int num_ctrs, char *pmu_name)
+void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name)
 {
     uint32_t fdt_event_ctr_map[15] = {};
-    uint32_t cmask;
-
-    /* All the programmable counters can map to any event */
-    cmask = MAKE_32BIT_MASK(3, num_ctrs);
 
    /*
     * The event encoding is specified in the SBI specification
-- 
2.41.0



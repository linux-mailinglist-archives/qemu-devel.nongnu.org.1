Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 112FF7C576E
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:51:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaYC-0000AS-Ei; Wed, 11 Oct 2023 10:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qqaYA-000076-Mj
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:51:02 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qqaY8-0000Vc-P6
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:51:02 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32167a4adaaso6295244f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697035859; x=1697640659;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bytYQtr86+xvVw4UcM9bSG9EBrq4aWlnek5rPmUwEro=;
 b=vENiIN/DJqjZN6A4LfXsiiAfzFajOApMgm9hU1P3u7/pD9ZhrVNYj7DSrmAYDUdLC0
 IOfaRDzSlzcPVcS0Ex1onpMbE1tCNSZ1MDpzoAvUT2FGkRWL56qAu4Okwo9iawUnW3F0
 W7Hn92o6jvt2TnDX5Ee4pAk8ZhReoSytPqMk1KVzSkYE3W+A8CSrsNqhZtTuwzz+O4rf
 BZnbmYSDVJ2S6BzVEmMz1xWkd87G3XQaD0kXjX2AxtI2Qsj6P0u+yw3Uk/esYtxfDx3H
 zf8ZQpmYYnPncj6nN0/f9LEN9f7hlD4noomK5riabLwCNJEJ2wQdyd/FCM2YVjLAej2M
 RG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697035859; x=1697640659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bytYQtr86+xvVw4UcM9bSG9EBrq4aWlnek5rPmUwEro=;
 b=rD9nVBuBG8PnbklQmwCtpNAbIq4548xj8etJZh1n9EYuu8VpboUYuvoVyGWlWCR9qh
 y6HPQM2iCXUn0l6q3XsnosLYlNx/Pk9gk3dJDuSzRS3sM73U+SJ2gc/Gq7tSjUzi4iHe
 8+SbhaByg8zaAcK7rGdNZjeIQUmzZPeovyX3Fgm8Ax6DyR7ADMaJugROD8ELEj2aIa9W
 y+Y49qFz9dBgr6MzbSztAKc+Jl45/ywika9bG2egSLvjoCDYhIT3ZSuapFsG42LUzDlQ
 nrpMqmBhv/ix/wXJj7/BBDFruiMJv5/1dE0cukSEec74Kwvzhol4f75cXPKdyahj4WIQ
 Q7ew==
X-Gm-Message-State: AOJu0YwhPhVAwWYSGHQ3Z1oQgL+EcwEReP1yUX0THQa4m2FpGmwdWBRe
 zPoKnECHthiB4u5igzKPNHDOLqG1khX2WTfcInvCMA==
X-Google-Smtp-Source: AGHT+IGe2trxy8S1Nk05p/8OP4sAUOYJIdJJKnBdLFEuEMIdWd3O1Y9jHdH7BvfNu2H/5mCl7eEXvQ==
X-Received: by 2002:adf:ef4a:0:b0:314:2fdd:28ef with SMTP id
 c10-20020adfef4a000000b003142fdd28efmr17551837wrp.18.1697035859016; 
 Wed, 11 Oct 2023 07:50:59 -0700 (PDT)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 n16-20020a05600c3b9000b0040684abb623sm19709208wms.24.2023.10.11.07.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:50:58 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH v2 3/6] target/riscv: Use existing PMU counter mask in FDT
 generation
Date: Wed, 11 Oct 2023 15:45:51 +0100
Message-ID: <20231011145032.81509-4-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011145032.81509-1-rbradford@rivosinc.com>
References: <20231011145032.81509-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=rbradford@rivosinc.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

During the FDT generation use the existing mask containing the enabled
counters rather then generating a new one. Using the existing mask will
support the use of discontinuous counters.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
---
 hw/riscv/virt.c    | 2 +-
 target/riscv/pmu.c | 6 +-----
 target/riscv/pmu.h | 2 +-
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 5edc1d98d2..acdbaf9da5 100644
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
-- 
2.41.0



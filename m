Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 997A77CE183
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:46:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8j3-0001a6-Vc; Wed, 18 Oct 2023 11:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qt8j1-0001Yl-LT
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:44:47 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qt8iz-0004wV-Js
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:44:47 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-507962561adso8367570e87.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697643883; x=1698248683;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AC8jq+P5CM/fRZxkStBxJxLjJuS0g72lNMKPJ6Ep+4k=;
 b=pGj7jbnpuqDIdu8FzGk8u1mT2AeU3JFU1OT8oVdwB75uKwEjZMNro77xwqts5DiNQI
 NR59I8ORUkPsujU18zo3RZ+tapE82P6W2l1oCQr57DhJgEs+EqPg2rKxVYPbZoHm0sSe
 GI2jgnCffZ6nFRoVkRgZ95uehVwYve/ZVkVdS7TBmKENfcFsu970aQpU1LuQAWk9+arM
 k8mLJ+0Vy+y7JMPnRwLsmQKOAyHBPx8HEUW2vkrwG3VlPHk5DlGzIWsIk69eiZcMx3Hu
 aEj6YksFGrDW6S3906e5QWpGlarQI06Ek5PJPj7RtSb8R4/A7fc3HraTak0K7gidpKV4
 8VkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697643883; x=1698248683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AC8jq+P5CM/fRZxkStBxJxLjJuS0g72lNMKPJ6Ep+4k=;
 b=DeOrCrX9ybwAiYU6DQXeGjm6zbLmFgap98e5NzGE8gA6+VrNd9ZAG28ZWpE21pdQMS
 9AQmsyJE+gdqaHHziUnuuYtBYx7vvIUnz70RHS7dlGue7pHgeplIDVF0K8KihjTwUPps
 steDL7h5569T14C3LJNVJbR0LxZbFjZL6TGLMJXQuIPdsXzv9qklpgFwVQURd9UKBkA8
 W291Znz+yogQSR9KuyRaJa3eiCG7YtGWCfns8MJ2377KSUhkH+RpshuH4J3/3t4v+up/
 0j9o6+x7s5Z3ShhAR9/sYGZOFHttrxv36XSIcxYoNTG+PNj07eDMlqzdAsHgO8+d9uU+
 KsEA==
X-Gm-Message-State: AOJu0Yypz3uo99QB4sZT4KN1rGDdH+Tcr9ZJl6lABbx7kq6ku4yf8GKP
 XmBwqNC2VUuMXGgaqH2GBTp3QEEexkO8VVbHDH/x7g==
X-Google-Smtp-Source: AGHT+IEPYsW1307G7J3z/hTPuqT3ph/TkCnsGor2XyGa661SN6qVswYx+mAyE5IvZqalQbf8QzplBw==
X-Received: by 2002:ac2:528a:0:b0:507:9625:5fd3 with SMTP id
 q10-20020ac2528a000000b0050796255fd3mr4150861lfm.32.1697643883628; 
 Wed, 18 Oct 2023 08:44:43 -0700 (PDT)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 b14-20020a05600c4e0e00b0040607da271asm1963580wmq.31.2023.10.18.08.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:44:43 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH v4 3/6] target/riscv: Use existing PMU counter mask in FDT
 generation
Date: Wed, 18 Oct 2023 16:39:11 +0100
Message-ID: <20231018154434.17367-4-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018154434.17367-1-rbradford@rivosinc.com>
References: <20231018154434.17367-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=rbradford@rivosinc.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c    | 2 +-
 target/riscv/pmu.c | 6 +-----
 target/riscv/pmu.h | 2 +-
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 9de578c756..241681f98d 100644
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



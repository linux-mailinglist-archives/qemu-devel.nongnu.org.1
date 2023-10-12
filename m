Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 681A87C63C3
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:13:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn3U-0001lL-Pj; Thu, 12 Oct 2023 00:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn3P-0001VS-2b
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:07 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn3M-0002M1-Vk
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:06 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c9d3a21f7aso4610035ad.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083917; x=1697688717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h5ifPuLs3wBGPNAbGDGXqLDpOUl6NFpvK8jXrRN0fKE=;
 b=UbttLlD9b34ueiiQgJX6caOGZQUujMMchmz0eD8O+smGQ9B00ysAZ3b1jXvNU26xI4
 WopdR2asWEjMunDRa6II2Db9wZzOTiKAPyrk0eVtDSOaMMS8Qbd0C1hN8SUv3ofa5jUx
 Tu99rDfXL3Sjx23sk6PcZ/bc4jjeb9r6O1wKbhprQ2N0Nl4az1wERiQurcmRFlIfZ8hS
 lsaS4HB2RRNdAeocBkIPbfe7Tlx12iB5uUTp8uDNv10fqpPd7qT34xy+bT3/gizLyv+V
 p0fCZlZWhcS3e++lQ8mzFca2ym6kwujJTa9QcuapNBp8AdWwCniCZol+qWwrgD2DORq+
 EYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083917; x=1697688717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h5ifPuLs3wBGPNAbGDGXqLDpOUl6NFpvK8jXrRN0fKE=;
 b=UZRwqFzSZ3a4tF9PInNkW61yCtYvptgDldbCEVvH8pU44CPc/i8KpoUO1qFLqc2u0J
 niyOuB1UmwE14ZowNp03UDgp8BO7DLYMxCfSYVAqeElBva1LqQfFtaMHYLR8jWOl2Fil
 82BGWH9E4j26lG7oFA7bBSPvj8EVC29uh+oHYQs4aVKARcCScgeG72Gzja/c7BgIN+2o
 x7xGLL95tbS/TlW9F5U24cFVOqZR2bELzYFajYUOjlhSxCzDWSvL54Hwf8XsVvaVmIsG
 Q9W4cT1SWMdGnkb4j37RMz4Hw61kIk2lDGveqRoVrwnnWLv8UbytRzv0EINna50RvR32
 e7wA==
X-Gm-Message-State: AOJu0YxIMjz7Nga8uBFKwyDGRfpJETjc0WWn9AHmmDC2If2otnzwKv9d
 wKaK2qqhkU18kBCvOqzlCULMcwqQ05Bh2Q==
X-Google-Smtp-Source: AGHT+IGsLKOlXQ5loYUc7CUynfbaK132tJUsVOVJb+N2SueXwHNCncg2xcF5cBRT3gfMogXlJ3q8Ig==
X-Received: by 2002:a17:902:c3cd:b0:1c6:1cd8:5b59 with SMTP id
 j13-20020a170902c3cd00b001c61cd85b59mr22162520plj.1.1697083917551; 
 Wed, 11 Oct 2023 21:11:57 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:11:56 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 15/54] target/riscv/cpu.c: introduce cpu_cfg_ext_auto_update()
Date: Thu, 12 Oct 2023 14:10:12 +1000
Message-ID: <20231012041051.2572507-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

During realize() time we're activating a lot of extensions based on some
criteria, e.g.:

    if (cpu->cfg.ext_zk) {
        cpu->cfg.ext_zkn = true;
        cpu->cfg.ext_zkr = true;
        cpu->cfg.ext_zkt = true;
    }

This practice resulted in at least one case where we ended up enabling
something we shouldn't: RVC enabling zca/zcd/zcf when using a CPU that
has priv_spec older than 1.12.0.

We're also not considering user choice. There's no way of doing it now
but this is about to change in the next few patches.

cpu_cfg_ext_auto_update() will check for priv version mismatches before
enabling extensions. If we have a mismatch between the current priv
version and the extension we want to enable, do not enable it. In the
near future, this same function will also consider user choice when
deciding if we're going to enable/disable an extension or not.

For now let's use it to handle zca/zcd/zcf enablement if RVC is enabled.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20230912132423.268494-16-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7544fff392..bd73b61d3c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -177,6 +177,43 @@ static void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset,
     *ext_enabled = en;
 }
 
+static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(isa_edata_arr); i++) {
+        if (isa_edata_arr[i].ext_enable_offset != ext_offset) {
+            continue;
+        }
+
+        return isa_edata_arr[i].min_version;
+    }
+
+    g_assert_not_reached();
+}
+
+static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
+                                    bool value)
+{
+    CPURISCVState *env = &cpu->env;
+    bool prev_val = isa_ext_is_enabled(cpu, ext_offset);
+    int min_version;
+
+    if (prev_val == value) {
+        return;
+    }
+
+    if (value && env->priv_ver != PRIV_VERSION_LATEST) {
+        /* Do not enable it if priv_ver is older than min_version */
+        min_version = cpu_cfg_ext_get_min_version(ext_offset);
+        if (env->priv_ver < min_version) {
+            return;
+        }
+    }
+
+    isa_ext_update_enabled(cpu, ext_offset, value);
+}
+
 const char * const riscv_int_regnames[] = {
     "x0/zero", "x1/ra",  "x2/sp",  "x3/gp",  "x4/tp",  "x5/t0",   "x6/t1",
     "x7/t2",   "x8/s0",  "x9/s1",  "x10/a0", "x11/a1", "x12/a2",  "x13/a3",
@@ -1268,12 +1305,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
 
     /* zca, zcd and zcf has a PRIV 1.12.0 restriction */
     if (riscv_has_ext(env, RVC) && env->priv_ver >= PRIV_VERSION_1_12_0) {
-        cpu->cfg.ext_zca = true;
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
         if (riscv_has_ext(env, RVF) && env->misa_mxl_max == MXL_RV32) {
-            cpu->cfg.ext_zcf = true;
+            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
         }
         if (riscv_has_ext(env, RVD)) {
-            cpu->cfg.ext_zcd = true;
+            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcd), true);
         }
     }
 
-- 
2.41.0



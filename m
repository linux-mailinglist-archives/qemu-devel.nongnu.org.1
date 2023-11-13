Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D06607EA58D
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 22:40:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2eed-000696-KI; Mon, 13 Nov 2023 16:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r2eec-00068x-Fp
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 16:39:34 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r2eea-0001VG-Rr
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 16:39:34 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc4f777ab9so36812355ad.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 13:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699911570; x=1700516370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUh/6KkW4XcW8kKVIfjTyve/D2pqne6pt1Gsp4Re3wQ=;
 b=R9hX4BooM9sAf+CjIGIDaxXEL+Qv49y5g0w9vz7mMso1C2A7chk0pVpCBVr30vdr6h
 jJQw436YaH5EFUPt4ENsgjmTd3/lFX6BbjSUvbetl9ywxucgMz0ehQrTQJickBqhloTd
 ycXZgXb3iijUGyLixSTU6Te+P0raCzperU3On+gFh2sHdLsm8H613JR85nW5syuwDblp
 uMgMS99/k64XX11K+1TLZfYyjO8Ou2zukwBsGV9qtN1n0E95JC9TeId8jw1I73QoHsLV
 vOS2XIYRlDNDp90D6QMQzlaSMQ3WTlaxPQ7VoivXJDCvBG3CX9rtaGLEqNY4Tru0ZBtF
 poqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699911570; x=1700516370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BUh/6KkW4XcW8kKVIfjTyve/D2pqne6pt1Gsp4Re3wQ=;
 b=FJzE808sJRo/D7h4mFSZgn7QWVYL3rQYtgyf20Z7eUBZzzIHtmsBhcS38As35lBr2W
 jXbXCKs4vLk9az+KYV7TTxVhSiZgfbEhttYoVXfimmf6lQDbigV4D26R43XqKtfp0b1h
 bcFRxW5//nNqX04YaUvC5E6/Ov358cZAC68XnYbrzZvE0ecOuxwUWnCuZfDzPaPZy1V/
 lX7rvoyv159nEWSn/KHgcIs2cc7I4N67FCuZZI9oGsiHMRSRrV+Ru9ZEfj4G3GovVKgD
 Ib5HZRgcQpvvQfOfm5GeP5++wUD67eA40XTwYMh29NFxPCHlCavHNetIYaJXT2ferTm+
 fufg==
X-Gm-Message-State: AOJu0YwJ5PcnJtlaPfxfjXZWaqJFPfSBbhHiQzTU0eYGjalRESLbh+7T
 QuKHBG7wlpbJ5jQNZhjmHeVt6cw9bu1a8mjh7Cg=
X-Google-Smtp-Source: AGHT+IHUSu7MpgylO/d+b9HuQStXxv4++OOMX1Jpi6gmMuwW+RIUQlSx12lu6CWx67c2oJfy5/PpFQ==
X-Received: by 2002:a17:902:ab4f:b0:1ca:7909:6ee6 with SMTP id
 ij15-20020a170902ab4f00b001ca79096ee6mr440336plb.61.1699911570545; 
 Mon, 13 Nov 2023 13:39:30 -0800 (PST)
Received: from grind.. ([152.250.131.148]) by smtp.gmail.com with ESMTPSA id
 a6-20020a170902900600b001c736746d33sm4455423plp.217.2023.11.13.13.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 13:39:30 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 5/6] target/riscv: add rv32i CPU
Date: Mon, 13 Nov 2023 18:39:03 -0300
Message-ID: <20231113213904.185320-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113213904.185320-1-dbarboza@ventanamicro.com>
References: <20231113213904.185320-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Add a bare bones 32 bit CPU, like we already did with rv64i, to ease the
pain of users trying to build a CPU from scratch and having to disable
the defaults we have with the regular rv32 CPU.

See:

https://lore.kernel.org/qemu-riscv/258be47f-97be-4308-bed5-dc34ef7ff954@Spark/

For a use case where the existence of rv32i would make things simpler.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 4d1aa54311..f345c17e69 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -34,6 +34,7 @@
 #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
 #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
 #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x-rv128")
+#define TYPE_RISCV_CPU_RV32I            RISCV_CPU_TYPE_NAME("rv32i")
 #define TYPE_RISCV_CPU_RV64I            RISCV_CPU_TYPE_NAME("rv64i")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a52bf1e33c..55cf114b61 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -666,6 +666,28 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
     cpu->cfg.ext_zicsr = true;
     cpu->cfg.pmp = true;
 }
+
+static void rv32i_bare_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    riscv_cpu_set_misa(env, MXL_RV32, RVI);
+
+    /* Remove the defaults from the parent class */
+    RISCV_CPU(obj)->cfg.ext_zicntr = false;
+    RISCV_CPU(obj)->cfg.ext_zihpm = false;
+
+    /* Set to QEMU's first supported priv version */
+    env->priv_ver = PRIV_VERSION_1_10_0;
+
+    /*
+     * Support all available satp_mode settings. The default
+     * value will be set to MBARE if the user doesn't set
+     * satp_mode manually (see set_satp_mode_default()).
+     */
+#ifndef CONFIG_USER_ONLY
+    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
+#endif
+}
 #endif
 
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
@@ -1860,6 +1882,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31,  rv32_sifive_e_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34,  rv32_imafcu_nommu_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34,  rv32_sifive_u_cpu_init),
+    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32I, rv32i_bare_cpu_init),
 #elif defined(TARGET_RISCV64)
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,   rv64_base_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51,  rv64_sifive_e_cpu_init),
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DA474D5DA
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:40:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq5r-0003aW-Hk; Mon, 10 Jul 2023 08:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5G-0002hR-Ml
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:45 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5D-0004gW-AI
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:41 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-666683eb028so2210880b3a.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992416; x=1691584416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wm85/rp8ngelfAH1JXxJvOyIeMQkVrBvuXH7/PGURM=;
 b=Mn+amNWc1PWm8BfXz4/H2pspkmwsmqmKfFBoRy1fwCK015Emu2pTSMSo2Tb7RkpD1r
 uWPIqX+yYq52IBesT7XquFfKs4WA+QLp927jH6SBtWEqCH6wWjcYBKX0QcnkD3ZlRJi5
 C4iJPdAlz+uy/VYJHCY2iFJ1N/hsEFOURgVkUP30vZEnKa3S1LUAXu/XdsqkFuEjwAsD
 39EZlhzarPSqEJWij0i98lt9TKVNrZAB5LWem2z2ocl+AnvOq1FtqBPm7FgaEHO6KiQQ
 h48BHsYCMfNMEviNEVHCbAAQsAFY7rq7KSNwCDjg29XXLD+3je+BWpODgJD0KuRDB37+
 HFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992416; x=1691584416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3wm85/rp8ngelfAH1JXxJvOyIeMQkVrBvuXH7/PGURM=;
 b=DicKpiqpV08hNDZ6zErVq/VDmHS0jdgTBFDpfJER1eVOJIu+b4r18Zc3SU6CbY5b6i
 ryjP3oLjje23YuZYuk1+fsebswdS9PddgjXIY0cTgHQvRAg01oycnZG4f4z27fMbK0pt
 Tzi7iw8AB93IdzqVhSuclH120IUW4aEbd3l+5kPW0T/K7rMqNEI1rrj1Ea6ZSaHXEpje
 ee1KkGVFbWiH9UdKrmeID1myK6BUK+65LjchZd7DIQnguYMeO2wATbkAAoIb9Y/C4W/C
 6uoaxfcAEfYcX+Q2oJSY3eZyuRp62gZHzUzrAnsUQFjGYD3tsvyUm4eXmPWiYM+22xPF
 l9tg==
X-Gm-Message-State: ABy/qLbLuctzKhSVhUhoeyvygTaAuWIY6oHaKf9ZnqsHzpJCbdJkIwcW
 ILqzGd8ipCXhANEceI4OSvUwoWjOC5jUDg==
X-Google-Smtp-Source: APBJJlGjf0wbrgPdhNlgpNyb6nFn57daQYKJLYGc6XTi+I8ftxf2PzKz7Ebv10+Q66mUq5FtZ34DBQ==
X-Received: by 2002:a05:6a20:1e4e:b0:12e:5d45:b219 with SMTP id
 cy14-20020a056a201e4e00b0012e5d45b219mr10511394pzb.26.1688992416025; 
 Mon, 10 Jul 2023 05:33:36 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:33:35 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Ivan Klokov <ivan.klokov@syntacore.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 22/54] target/riscv: Add RVV registers to log
Date: Mon, 10 Jul 2023 22:31:33 +1000
Message-Id: <20230710123205.2441106-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
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

From: Ivan Klokov <ivan.klokov@syntacore.com>

Print RvV extension register to log if VPU option is enabled.

Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230629083730.386604-1-ivan.klokov@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 57 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b9b3879281..0c9faf4633 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -55,6 +55,17 @@ struct isa_ext_data {
 #define ISA_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
     {#_name, _min_ver, offsetof(struct RISCVCPUConfig, _prop)}
 
+/*
+ * From vector_helper.c
+ * Note that vector data is stored in host-endian 64-bit chunks,
+ * so addressing bytes needs a host-endian fixup.
+ */
+#if HOST_BIG_ENDIAN
+#define BYTE(x)   ((x) ^ 7)
+#else
+#define BYTE(x)   (x)
+#endif
+
 /*
  * Here are the ordering rules of extension naming defined by RISC-V
  * specification :
@@ -183,6 +194,14 @@ const char * const riscv_fpr_regnames[] = {
     "f30/ft10", "f31/ft11"
 };
 
+const char * const riscv_rvv_regnames[] = {
+  "v0",  "v1",  "v2",  "v3",  "v4",  "v5",  "v6",
+  "v7",  "v8",  "v9",  "v10", "v11", "v12", "v13",
+  "v14", "v15", "v16", "v17", "v18", "v19", "v20",
+  "v21", "v22", "v23", "v24", "v25", "v26", "v27",
+  "v28", "v29", "v30", "v31"
+};
+
 static const char * const riscv_excp_names[] = {
     "misaligned_fetch",
     "fault_fetch",
@@ -611,7 +630,8 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
-    int i;
+    int i, j;
+    uint8_t *p;
 
 #if !defined(CONFIG_USER_ONLY)
     if (riscv_has_ext(env, RVH)) {
@@ -695,6 +715,41 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
             }
         }
     }
+    if (riscv_has_ext(env, RVV) && (flags & CPU_DUMP_VPU)) {
+        static const int dump_rvv_csrs[] = {
+                    CSR_VSTART,
+                    CSR_VXSAT,
+                    CSR_VXRM,
+                    CSR_VCSR,
+                    CSR_VL,
+                    CSR_VTYPE,
+                    CSR_VLENB,
+                };
+        for (int i = 0; i < ARRAY_SIZE(dump_rvv_csrs); ++i) {
+            int csrno = dump_rvv_csrs[i];
+            target_ulong val = 0;
+            RISCVException res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
+
+            /*
+             * Rely on the smode, hmode, etc, predicates within csr.c
+             * to do the filtering of the registers that are present.
+             */
+            if (res == RISCV_EXCP_NONE) {
+                qemu_fprintf(f, " %-8s " TARGET_FMT_lx "\n",
+                             csr_ops[csrno].name, val);
+            }
+        }
+        uint16_t vlenb = cpu->cfg.vlen >> 3;
+
+        for (i = 0; i < 32; i++) {
+            qemu_fprintf(f, " %-8s ", riscv_rvv_regnames[i]);
+            p = (uint8_t *)env->vreg;
+            for (j = vlenb - 1 ; j >= 0; j--) {
+                qemu_fprintf(f, "%02x", *(p + i * vlenb + BYTE(j)));
+            }
+            qemu_fprintf(f, "\n");
+        }
+    }
 }
 
 static void riscv_cpu_set_pc(CPUState *cs, vaddr value)
-- 
2.40.1



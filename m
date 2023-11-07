Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2122D7E32F8
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:32:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bs3-0003hg-Rh; Mon, 06 Nov 2023 21:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Brz-0003Rr-Nr
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:12 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Brx-0002qS-Nj
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:11 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc58219376so47273255ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324265; x=1699929065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+l+1t79awKYdpzWbF/GryNTML7IoJXjmHxwTu+cmmks=;
 b=ClVxkvjR6Y6VnmKLx9uhGRQSeeeFSCtWZSAoUaZqSitRnM18FDRK3aVx5hrz10xld7
 0iFQa1WRD9tBsfIK/KuGNd2+mLKwbKJ+6tGejQ7INL972XzzZnGLgbJY+YPyp63YnbKr
 3ZoGMe4AT4pc29x2sOaABtVFHFBmQico2anYek4ss6Xfdy6eWFNu0WDmmbDE0f5B5No8
 ZoG0iFL4Fwy3koe9roo8dnaXSP6V8CzzCG6rgJRDumT7Y76t5squ7GYjfPTJbFz7AeA4
 JDZevV4QvPFyWJlSes+3EDC6ARWGUpSyVKxD0t96DxunCLaoCbZ45heEtvCV//9FM/nK
 pGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324265; x=1699929065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+l+1t79awKYdpzWbF/GryNTML7IoJXjmHxwTu+cmmks=;
 b=o+5Xqx+oVVsPiNdtFJoFaOND+Q0VhQCXcu4hTsc1sy0k/oqYlFdyETJCs02jr1IpV5
 7CuxH3Vx8nbUk/F1/w/dIoVJpqU3j+RwflfRCaHT+K/A8vYoLyHJiRu8tjuSt3I6ZHOH
 A1NOMQDssUDXEs9FTkXADYvUATOIybrlwu/qDNHqi+hj8BR2LQATGXFdg18nv9gHrqmb
 +P+RZfW2gBcmNgmylRxH/o2xse2iW5i0lJqAewQ91MmNXNgdNHBzjtWd4s6o5HGBvOZo
 KZSTuO9zKCC1/sGTzFD6i+Lljfno/LnB/VFVYCdps7TnNLYKW53/NJ8U16pYTxwzNLHh
 Tlrw==
X-Gm-Message-State: AOJu0Yx+8/s0BFO0Jqq8k9c9brYCYtEDujUfiitvblESJUjYA4E76392
 w+prg6KQ+dr2RR6nGzj51VS8+mvuyAFVtw==
X-Google-Smtp-Source: AGHT+IG4FpZKlL9vFERxaDMe2iF4HAodz36toQaxtMFUZ7MtoYZi3qMpNv+mfIAbrVebPcfAx5ejZw==
X-Received: by 2002:a17:902:ecce:b0:1cc:59a1:79c6 with SMTP id
 a14-20020a170902ecce00b001cc59a179c6mr27505391plh.18.1699324265356; 
 Mon, 06 Nov 2023 18:31:05 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:31:04 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/49] target/riscv: pmp: Clear pmp/smepmp bits on reset
Date: Tue,  7 Nov 2023 12:29:16 +1000
Message-ID: <20231107022946.1055027-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Mayuresh Chitale <mchitale@ventanamicro.com>

As per the Priv and Smepmp specifications, certain bits such as the 'L'
bit of pmp entries and mseccfg.MML can only be cleared upon reset and it
is necessary to do so to allow 'M' mode firmware to correctly reinitialize
the pmp/smpemp state across reboots. As required by the spec, also clear
the 'A' field of pmp entries.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231019065644.1431798-1-mchitale@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.h |  2 ++
 target/riscv/cpu.c | 11 +++++++++++
 target/riscv/pmp.c | 10 ++++++++++
 3 files changed, 23 insertions(+)

diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index cf5c99f8e6..9af8614cd4 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -28,6 +28,7 @@ typedef enum {
     PMP_READ  = 1 << 0,
     PMP_WRITE = 1 << 1,
     PMP_EXEC  = 1 << 2,
+    PMP_AMATCH = (3 << 3),
     PMP_LOCK  = 1 << 7
 } pmp_priv_t;
 
@@ -81,6 +82,7 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index);
 void pmp_update_rule_nums(CPURISCVState *env);
 uint32_t pmp_get_num_rules(CPURISCVState *env);
 int pmp_priv_to_page_prot(pmp_priv_t pmp_priv);
+void pmp_unlock_entries(CPURISCVState *env);
 
 #define MSECCFG_MML_ISSET(env) get_field(env->mseccfg, MSECCFG_MML)
 #define MSECCFG_MMWP_ISSET(env) get_field(env->mseccfg, MSECCFG_MMWP)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0c58c8571f..a2881bfa38 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -884,6 +884,17 @@ static void riscv_cpu_reset_hold(Object *obj)
     }
     /* mmte is supposed to have pm.current hardwired to 1 */
     env->mmte |= (EXT_STATUS_INITIAL | MMTE_M_PM_CURRENT);
+
+    /*
+     * Clear mseccfg and unlock all the PMP entries upon reset.
+     * This is allowed as per the priv and smepmp specifications
+     * and is needed to clear stale entries across reboots.
+     */
+    if (riscv_cpu_cfg(env)->ext_smepmp) {
+        env->mseccfg = 0;
+    }
+
+    pmp_unlock_entries(env);
 #endif
     env->xl = riscv_cpu_mxl(env);
     riscv_cpu_update_mask(env);
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 21d2489e27..4dfaa28fce 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -135,6 +135,16 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
     return false;
 }
 
+void pmp_unlock_entries(CPURISCVState *env)
+{
+    uint32_t pmp_num = pmp_get_num_rules(env);
+    int i;
+
+    for (i = 0; i < pmp_num; i++) {
+        env->pmp_state.pmp[i].cfg_reg &= ~(PMP_LOCK | PMP_AMATCH);
+    }
+}
+
 static void pmp_decode_napot(target_ulong a, target_ulong *sa,
                              target_ulong *ea)
 {
-- 
2.41.0



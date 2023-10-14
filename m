Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B2A7C9287
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 05:37:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrVS6-0007av-BH; Fri, 13 Oct 2023 23:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrVRy-0007aK-8T
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 23:36:26 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrVRw-00044q-OH
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 23:36:26 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6b20a48522fso1154723b3a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 20:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697254583; x=1697859383;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IKk6IyCieLsIGaxm0GofI4QujL1p3Wha0xoTTyMZRjs=;
 b=S3JU9aqi8B+CWnlj9Xp4LSAIConG41LXB8rBhZvwWNFccQvFtRfjn+IXZZhCDsOftc
 +4w2C8NC6F5dbZZLs/KxITFlXb9xdERaXN0YPhsCsassWEP68DEQV4HnDDGfmaHJ0WFu
 Ht9OXCMEZ4bxATx3tU7NvgUynslNrG5EVFlMGKo+4NvPfhDDS0/UgyaaWy9E5nExMTFl
 cNYo6W0ylwjYFCL45RL4VrCsJa4CamqLsc7UsuhtFrGNfZeBQm+e8IK0jzAmoXRZrsCi
 ZwnnyZDFOE33EFpZeoJuLA9jsOb7A9elzseIQJnZDWqVUsNQu0awCbII6cbJSq5m6aLJ
 rlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697254583; x=1697859383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IKk6IyCieLsIGaxm0GofI4QujL1p3Wha0xoTTyMZRjs=;
 b=ShZypBd0cFpKPIO4Ncv4CYe8mVtSNfXeYgI+jo7wvf27/XwDioiWecIyhvDMxI2v5W
 jEeGx1PUGvFx4KOSTsOcbWj6xc1LfoE3QlKs+hxN3uqE+zVG5rz8Ve/CrLFMaaJNDubf
 IgmVH6pCb4ShfqpDs1dQNsJCrhwCyj3wR4TXVL+7eqHILOOzgOKNRpcrOcn5MF8X5Gbj
 67gV0jVI626Ve+ouJ8Gt4pTSJpxf0IRjXMZrGQh/rCE40RNKWOOvF0fw4bRhb3lrtMvj
 gEYulm6yoe9/1cL2jE18wnTmqYPKWwsRxN3ZDSkgNmd2OCIeASom6mDpGsK4ZFaoaOIC
 DaCA==
X-Gm-Message-State: AOJu0YwpUVoSnJf8IwpsvCawEL9s759aBtF794IUAnowk+F6s344ozYf
 7xfJP70mKr80Hh4ZezTGww/KkQ==
X-Google-Smtp-Source: AGHT+IGE61g7j9rf1ckqZDbfdbd8sEpDTdz9DpEPY/D7IQBYuj2OzqPAzvMJ5uJ1CDdeLTxMjdLIuA==
X-Received: by 2002:a05:6a20:3d17:b0:157:54fd:5c26 with SMTP id
 y23-20020a056a203d1700b0015754fd5c26mr32198915pzi.38.1697254583135; 
 Fri, 13 Oct 2023 20:36:23 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 l21-20020a170902d35500b001c737950e4dsm4601654plk.2.2023.10.13.20.36.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 20:36:22 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v2 2/3] target/riscv: Initialize gdb_core_xml_file only once
Date: Sat, 14 Oct 2023 12:35:40 +0900
Message-ID: <20231014033545.15220-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231014033545.15220-1-akihiko.odaki@daynix.com>
References: <20231014033545.15220-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

gdb_core_xml_file was assigned each time a CPU is instantiated before
this change.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/riscv/cpu.c         | 5 +++++
 target/riscv/tcg/tcg-cpu.c | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ac4a6c7eec..a811215150 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1575,6 +1575,11 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     cc->get_pc = riscv_cpu_get_pc;
     cc->gdb_read_register = riscv_cpu_gdb_read_register;
     cc->gdb_write_register = riscv_cpu_gdb_write_register;
+#ifdef TARGET_RISCV64
+    cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
+#elif defined(TARGET_RISCV32)
+    cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
+#endif
     cc->gdb_num_core_regs = 33;
     cc->gdb_stop_before_watchpoint = true;
     cc->disas_set_info = riscv_cpu_disas_set_info;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index e0cbc56320..626fb2acea 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -150,8 +150,6 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
 
 static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
 {
-    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
-    CPUClass *cc = CPU_CLASS(mcc);
     CPURISCVState *env = &cpu->env;
 
     /* Validate that MISA_MXL is set properly. */
@@ -159,11 +157,9 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
 #ifdef TARGET_RISCV64
     case MXL_RV64:
     case MXL_RV128:
-        cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
         break;
 #elif defined(TARGET_RISCV32)
     case MXL_RV32:
-        cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
         break;
 #endif
     default:
-- 
2.42.0



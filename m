Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4489C7E32FB
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:33:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bst-00080c-7D; Mon, 06 Nov 2023 21:32:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bsq-0007iG-Lj
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:04 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bso-0002yH-UF
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:04 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c9b7c234a7so47272095ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324321; x=1699929121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+SH9Ip7WmuinJXSIi5UcPFN/9X//d/Ykun1KLraKdM=;
 b=lOGQN+B47VsOs+BVScgkKRqFREZtUce1qUMUxcMvfxvg8eUTFxFfRHuYyRSnXI5a/T
 TanC5/Guzntwyzp4osfsd2RShZ0KoEjxWJhsAdqel/Y/jkBvGpjSwF7748SD6fRFIqoY
 6Ala2g7Ngf6k7QLXZ4dIAhDCsCH6jTlmE7E0f536DuZ1dhHC+6NFD2IjNSo+i2cYOVYc
 ycdmecl3Owm5PYffzeB/jH5qZGSnHaIjrYLa8hizF5NquI7YWQ9sOFnVGZWl1EdG/Hvx
 otsnOOlu6EGkj5zSQdHyIL9F8z3nuzlePlXdYz/INK8f9fQk7/kEq5KsMF7Q1NBV2o/c
 PAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324321; x=1699929121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t+SH9Ip7WmuinJXSIi5UcPFN/9X//d/Ykun1KLraKdM=;
 b=AzVO+Keqiq+Kg7Q3WLxSjyFVA8KjrkOw8wx5lXtIV+qUmujbi5dYxsrx8KDCA7bwN+
 QdDq39hfk9qOj06wIbF2o+0soIhvV3BzmTkGtRJj2s8MTe9VNlptCNWndY+w+fC5lgxj
 4oa4iFdfRPOYbMb4F6GX7ZFU8NSrpRzOg4wf7AN5VU8T+3fjUM00NUB9CTkbzo6Mf0AF
 /y1nAEl25gZI8RiWS1fL4fulOkapuIrVwqWv7RlfxzNA6ZKztOrcZ/3mmBQGTQWqWTpj
 Bb85cN21mwRbGP31In+f73711m+qPZOeUhbVfkQg5QMlgSPgvUEybGyLuxJybktKtUf5
 3Prw==
X-Gm-Message-State: AOJu0YxzZQ6eAW69zVvuSQ6XSZo+sw05bpTWR/1+5I5bSJZ3T+iceZRI
 s9HSNxdGokwIz/jfQMhs1kdkG/X9SoTW+w==
X-Google-Smtp-Source: AGHT+IHQ/6wMwOHkRE2FtfFRuQbu+vnXkmpA2cPGgKfqUonubVmMzpaIKuh7jAWvUGisXT84grBHhg==
X-Received: by 2002:a17:902:e743:b0:1c9:cc88:502c with SMTP id
 p3-20020a170902e74300b001c9cc88502cmr20686059plf.69.1699324321276; 
 Mon, 06 Nov 2023 18:32:01 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:32:00 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 36/49] target/riscv: Add cfg properties for Zvks[c|g] extensions
Date: Tue,  7 Nov 2023 12:29:32 +1000
Message-ID: <20231107022946.1055027-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Max Chou <max.chou@sifive.com>

Vector crypto spec defines the ShangMi algorithm suite related
extensions (Zvks, Zvksc, Zvksg) combined by several vector crypto
extensions.

Signed-off-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231026151828.754279-9-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h     |  3 +++
 target/riscv/tcg/tcg-cpu.c | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 08733002a7..634ff673b3 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -101,6 +101,9 @@ struct RISCVCPUConfig {
     bool ext_zvkn;
     bool ext_zvknc;
     bool ext_zvkng;
+    bool ext_zvks;
+    bool ext_zvksc;
+    bool ext_zvksg;
     bool ext_zmmul;
     bool ext_zvfbfmin;
     bool ext_zvfbfwma;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 9540d1df4e..1a3351b142 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -519,6 +519,23 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkt), true);
     }
 
+    if (cpu->cfg.ext_zvksc) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvks), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
+    }
+
+    if (cpu->cfg.ext_zvksg) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvks), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkg), true);
+    }
+
+    if (cpu->cfg.ext_zvks) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvksed), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvksh), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkb), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkt), true);
+    }
+
     if (cpu->cfg.ext_zvkt) {
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbb), true);
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED5A82E298
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 23:28:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPVOu-0000XV-Ra; Mon, 15 Jan 2024 17:25:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPVOt-0000XF-JC
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:25:47 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPVOs-000633-6R
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:25:47 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6db79e11596so1061921b3a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 14:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705357544; x=1705962344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9YxTyhvBJBHZnpiGwupT/MZk+RpUH5/F7uqSrQEr/Q=;
 b=lUu5tDHAc+zNN9dmqToM8/bg6PyOBlWULMM7lDh4nIbh+x1LLDc1ydx7Fx/zFwPrj1
 hzg+7nLBsahGkC4eQvk+A9ESZX3EN4bWBaBQSeiJBzTabHPrYmMBhAZlP+pJ6vh0m18y
 ETDOTIC3gxy/OARIDN5quAtjQRpceHAXQHbbge1cEhdu1PHa7F5Beo2wqvhvMJj28lB3
 YSEHEQmnwJKL0TVu6kTeuLQUlUEPykAsgbssPNW/OWlsEGo06rIXPRhKbrG9TCKK7//s
 RR9gXd3J2bmlxbssDjWItJmdf9+HqLRWafr6SCPPl9cKAFXSeE0BOeAoaCMuUadmiicE
 BbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705357544; x=1705962344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U9YxTyhvBJBHZnpiGwupT/MZk+RpUH5/F7uqSrQEr/Q=;
 b=RgAF2SYxW7fINxNEPgZpUG4fUGhkN34rKastn2LoZCkunv4wCTSAMqEfS0uePgqJtE
 unAU/z+Ncyykh4QyW16Jkyl3oNbM/b4bvvvNN8uZsC1oa0oHjxCjbiBcTynnpgtxu5Nm
 YV2K1FTpipWYNlhHQ2ImB6A+PHAzReTSQTs/SD934T/at7lpWsYUP+tdvV8WGFd2gRKy
 8rgyCJBtBmni1pOwy0p4OKB2yhwjspVO4TuhZSWNrTml/xEXIor7H11f2D6fbuJDJWVU
 y4isIvEI9fI9slA+jxEhpC0h7mcByIFZU22TC7S75Dl3KjCiMkL/uY9Qd2K8KYSbF7Ws
 2V9g==
X-Gm-Message-State: AOJu0YyUbc9+XsPYVjVgUXdqP1WFVkDH5yYGn4LGch/9SMafBZzD1M+s
 +oziSDkm+CZBRm72V9jU+KHaxYGHAprGk/snkN1x2vkc1yLShQ==
X-Google-Smtp-Source: AGHT+IEr3GW5oUNZIstQmBwZKZmNCuvBnfjIEwveaICKgZyJfSwg7RZoqMBoPTV9thgA71yX422puA==
X-Received: by 2002:aa7:9e49:0:b0:6da:1d19:db46 with SMTP id
 z9-20020aa79e49000000b006da1d19db46mr6333515pfq.34.1705357544409; 
 Mon, 15 Jan 2024 14:25:44 -0800 (PST)
Received: from grind.. ([152.234.123.64]) by smtp.gmail.com with ESMTPSA id
 ks19-20020a056a004b9300b006d977f70cd5sm8125940pfb.23.2024.01.15.14.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 14:25:44 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 03/12] target/riscv/gdbstub.c: use 'vlenb' instead of
 shifting 'vlen'
Date: Mon, 15 Jan 2024 19:25:19 -0300
Message-ID: <20240115222528.257342-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115222528.257342-1-dbarboza@ventanamicro.com>
References: <20240115222528.257342-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x433.google.com
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

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/gdbstub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 58b3ace0fe..5ab0abda19 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -130,7 +130,7 @@ static int riscv_gdb_set_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
 
 static int riscv_gdb_get_vector(CPURISCVState *env, GByteArray *buf, int n)
 {
-    uint16_t vlenb = riscv_cpu_cfg(env)->vlen >> 3;
+    uint16_t vlenb = riscv_cpu_cfg(env)->vlenb;
     if (n < 32) {
         int i;
         int cnt = 0;
@@ -146,7 +146,7 @@ static int riscv_gdb_get_vector(CPURISCVState *env, GByteArray *buf, int n)
 
 static int riscv_gdb_set_vector(CPURISCVState *env, uint8_t *mem_buf, int n)
 {
-    uint16_t vlenb = riscv_cpu_cfg(env)->vlen >> 3;
+    uint16_t vlenb = riscv_cpu_cfg(env)->vlenb;
     if (n < 32) {
         int i;
         for (i = 0; i < vlenb; i += 8) {
@@ -266,7 +266,7 @@ static int ricsv_gen_dynamic_vector_xml(CPUState *cs, int base_reg)
     RISCVCPU *cpu = RISCV_CPU(cs);
     GString *s = g_string_new(NULL);
     g_autoptr(GString) ts = g_string_new("");
-    int reg_width = cpu->cfg.vlen;
+    int reg_width = cpu->cfg.vlenb << 3;
     int num_regs = 0;
     int i;
 
-- 
2.43.0



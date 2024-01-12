Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0DD82C6D3
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 22:40:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOPEY-0003t6-L1; Fri, 12 Jan 2024 16:38:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rOPEV-0003r7-JF
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 16:38:31 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rOPET-0001bP-S0
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 16:38:31 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6daa822be30so3316699b3a.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 13:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705095508; x=1705700308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9YxTyhvBJBHZnpiGwupT/MZk+RpUH5/F7uqSrQEr/Q=;
 b=D9FYKsAS/ZFy4hXL3dfewcpogNXNm6ACSFmEjKDGbUoaHL39fP8yhR0GH3kCPVb4Za
 P99K1SqnVbCAFvBgW0IeOrfj0L658zjh9slo6dMuOp+mgjqsj8RW8nAfpI9MR3VhwR+A
 U3stFb5zHwERCZP2SYeoC0s8IHGhShoQOC0sLBnLQ1E0nkmCABruOvmsB4DqRrlzTvP+
 dKOteK4fKxvV+m0HsPhYh4x5DbJSZL1CGsHPgFPg/fQ0G7pDUg9BORTzBpYfm7fAbgU6
 D6OU8PysvuM+aWfFEQRZG9NB3n1F0cHWOPyUlFIGB8zK9jzo2nJq5kQeTHJlxDC4aXtY
 Uv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705095508; x=1705700308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U9YxTyhvBJBHZnpiGwupT/MZk+RpUH5/F7uqSrQEr/Q=;
 b=kLHQdakh6V3CD7DwRJiPwgg/t2FTQQeojgUFfTsKpFEYwXO8gJ+FKTYGMoGEcPsQhb
 UYhNB6AZB3vRrxAJ8lRQ+ARpgCA8Li+rjT+BhfN0c4qgmUttb663N4nWAtgnVguIWgKt
 6TILzVklpqgVPxqWeQ1nr4IhHHJF6R5EosRxBzq41hVmG1Nv9zdOZgxtLmnAAqG2xTVK
 eAsvlZomr0N9ibGG82xAsD+/yn78zXHe/2aVnEP40DosSyyfbQX8AmpfAoVvzw+OIVS4
 0j9FTpeJcZDiQIO3o8UdjQNuwQ+5dH7lrY4CvXSa8855TjDOBTn7Pd0Zy8mmwf13WsJP
 PfwA==
X-Gm-Message-State: AOJu0Ywjmv2Jye2REjYhyQoEmBkrHpniOChCSZyWfblHEWElKzg+4eRJ
 C/5CRGIYkA+tP1jCNNfK7rwLjyhksJlxjcIaKnzclPlRmcUHdQ==
X-Google-Smtp-Source: AGHT+IExE0N3ou/wp0WsVjsM3fEJwxupNlFH9odq8LCGv6mZHgAHn8sMvBH8PILm7i8Ey5UdPuXRQg==
X-Received: by 2002:a17:902:d14a:b0:1d4:3b5b:7aab with SMTP id
 t10-20020a170902d14a00b001d43b5b7aabmr1128064plt.132.1705095508111; 
 Fri, 12 Jan 2024 13:38:28 -0800 (PST)
Received: from grind.. ([152.234.123.64]) by smtp.gmail.com with ESMTPSA id
 lf8-20020a170902fb4800b001d5b2967d00sm364727plb.290.2024.01.12.13.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 13:38:27 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 03/13] target/riscv/gdbstub.c: use 'vlenb' instead of shifting
 'vlen'
Date: Fri, 12 Jan 2024 18:38:02 -0300
Message-ID: <20240112213812.173521-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112213812.173521-1-dbarboza@ventanamicro.com>
References: <20240112213812.173521-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x436.google.com
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3246D81BD9C
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:53:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGNDH-0002Vm-Iy; Thu, 21 Dec 2023 12:52:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGND7-0002Ux-Ud
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:51:53 -0500
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGND6-0007wP-DR
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:51:53 -0500
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-35fd04ede25so4222745ab.0
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1703181110; x=1703785910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=57es9uIj9qaNcaBTGtjJpnb2VodcVdLLqcTy46mtENI=;
 b=aKGq3oM5b44ZeBqLiXnFKq+Tecy4qE2HRcoa6ci3mMFHuFDu7mF2kPv6m/M4Oob8wR
 wPv3bJWqLuxq17ZLFjJJK46QPccB9ivsgfb0NLAt4knnRslR0Qntsb0UyjawuGjWZXZJ
 Z3zhzKcBFPigXkIEtqH9JqZhouLxNhw52nb6siMC8Vz0r7hQn9q2buCPelRhrTjyuJBv
 ffijczOy1FROb96C1cOu7F9/M1D9piuQ8GvGNG/a5lFEijfU8nqYIrJ2dQKFZZSQtg5b
 nbwD0kpaC+h4PUuImmqVZJA1ZwDEWA48JUBUsDFB7GorQFTGnmRK6O/t6RETZAjFw7KW
 OkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703181110; x=1703785910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=57es9uIj9qaNcaBTGtjJpnb2VodcVdLLqcTy46mtENI=;
 b=mzV/1f/HI34bd/G924x6M9C+uXYshq84un+2kiTMIYsRo1KkGLS1DNiAxd/i2guqrF
 HWMF04Dspn/8/cnsHCuTzNuEp3hPKifbzbC30aaLEYWCeoDYvjKH9tu/M6k+hCNWhHaO
 87hefdtXqVFN8lHQFKHS6+RAIXZvv0UjmgVWwo5DpnJE4kHZOxcFSMWs4zuR9CgnwR5h
 ugQ5eaGDGjREDqyMifg3Kedez0KxqzzRkPXnzO/N3q+D1ckpUhulEIDRNLWdNU8sFjtW
 r1F+HW6ckax3Vn8HjgtKL2daXmDzke7v6j5GlVzc3gNY4GjVjjgx3XYvbftUWoZi8vHg
 8IgA==
X-Gm-Message-State: AOJu0YyPZ5Mk/qghbLJZHtq0RitMXmeYPn1Dw5s5t7slXztahH3cZEmw
 Pi0R9ZG8gI3sdgxOAdFv/EfUVnxSDQ8CsThcnjdvJw==
X-Google-Smtp-Source: AGHT+IHCZT0+0QZH7S678OEziEvRLFDOfToyGch2ZMiEjR8k4WFAs1qXZrP1ncMK4b2PAk3vDqWw/A==
X-Received: by 2002:a05:6e02:180c:b0:35f:d00b:236b with SMTP id
 a12-20020a056e02180c00b0035fd00b236bmr2622093ilv.49.1703181110170; 
 Thu, 21 Dec 2023 09:51:50 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.205])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a63f50a000000b005b18c53d73csm1806261pgh.16.2023.12.21.09.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:51:49 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 02/16] target/riscv: move 'pmu-mask' and 'pmu-num' to
 riscv_cpu_properties[]
Date: Thu, 21 Dec 2023 14:51:23 -0300
Message-ID: <20231221175137.497379-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221175137.497379-1-dbarboza@ventanamicro.com>
References: <20231221175137.497379-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-il1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Every property in riscv_cpu_options[] will be migrated to
riscv_cpu_properties[]. This will make their default values init
earlier, allowing cpu_init() functions to overwrite them. We'll also
implement common getters and setters that both accelerators will use,
allowing them to share validations that TCG is doing.

For pmu-mask and pmu-num it's just a matter of migrating the properties
from one array to the other.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 70bf10aa7c..ba62792e30 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1464,9 +1464,6 @@ const PropertyInfo prop_pmu_num = {
 };
 
 Property riscv_cpu_options[] = {
-    DEFINE_PROP_UINT32("pmu-mask", RISCVCPU, cfg.pmu_mask, MAKE_64BIT_MASK(3, 16)),
-    {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
-
     DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
     DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
 
@@ -1485,6 +1482,10 @@ Property riscv_cpu_options[] = {
 static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
 
+    DEFINE_PROP_UINT32("pmu-mask", RISCVCPU, cfg.pmu_mask,
+                       MAKE_64BIT_MASK(3, 16)),
+    {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
+
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
 #endif
-- 
2.43.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCEF8369E1
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 17:13:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRwu2-0006le-Ee; Mon, 22 Jan 2024 11:12:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rRwu0-0006km-Jo
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:12:00 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rRwtx-0005PN-VP
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:12:00 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2901ceb0d33so3007209a91.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 08:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705939916; x=1706544716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rpdpiw7feyllSaKykryPp2iLp2Z3weCX4u5s8qlFyP0=;
 b=RFd0oH7sPm7WTokM75/puP4Eh4LSC3QhzpLtiQx+eL1wuh1qSVdhukQtSmeuSPnEZU
 aVqHRS9zSgYMK2K4mCAQ2GxaV/WyqWlRBJtesE++Lid/GKsvIOQquDJbLCbWKLM1APE7
 +EEMBYO3LUXlmJoD6Kap9GRnKDoXeF28fVI1y0+gAq8YEVTvKX5xMCJV0WidP0rYSR2m
 Q1tkifnvZNvnOuVKK9SnuNx8B6NsVVgV3GB7gQDmzoieFI0aGfvrQPHTimFKFyctWvm9
 lVU6Uz7LWoSAHRHcX23zoCOXQvR2y9Y1057KyOydeV7DCucW3L7JkFxHKBD7LJdu54Uu
 SJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705939916; x=1706544716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rpdpiw7feyllSaKykryPp2iLp2Z3weCX4u5s8qlFyP0=;
 b=Y5nBo+dIa/yfV3pWM7Kh3CNEmw0B4qAxLHST0rXpP0gk5fr9Tv3W5eAHJLbbtW82CK
 0WsZysFnyTWguSS4xBe3tcVrudlJSxj4uFUKvbdOFtEMUapI+rkUgwqSLlID5+8BG5ZH
 2CXW0CNNearfD5GMAcMG2Rwv1eLcPR+sMdWp9qBOg3QBHKmPAEc4l1EUBL+5yNxBGcKp
 LAaoyxGts0z7sRKazlxLX55R63pOtfD2Pv8Y1r3+PweMox6lv3XZzbDL/SDeS5gN2hdK
 vH0Br3jEMct/6AkJEaG4Ok6l6OsnHBh2BrjRCi/xtPu6x5vxmNPSmT6eyXHi5VLNv+xl
 tK/w==
X-Gm-Message-State: AOJu0YxFTWjEajDFs5VB9bF/ppK1XlsH92XPeZ0qHrk9OW+gu3UhPbLr
 E/+MHYipe4/mHuhO4SDI6u6NcHCXJk1hGFqGo4awxhhkNSCaXb4N+EgdtXcL9Yzl4lPOM21MQE+
 x
X-Google-Smtp-Source: AGHT+IF8b3aBPFYLpS/uqpjZeKB4oVtLMteFftP+wTtD6U14lEJB/uN/SiRZVcgvloqAEwRCgsMSsA==
X-Received: by 2002:a17:90b:3642:b0:28d:fd67:fa9c with SMTP id
 nh2-20020a17090b364200b0028dfd67fa9cmr5636082pjb.37.1705939916139; 
 Mon, 22 Jan 2024 08:11:56 -0800 (PST)
Received: from grind.. ([152.234.127.94]) by smtp.gmail.com with ESMTPSA id
 db3-20020a17090ad64300b0028e245501e7sm9866446pjb.4.2024.01.22.08.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 08:11:55 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 13/13] target/riscv/cpu.c: remove cpu->cfg.vlen
Date: Mon, 22 Jan 2024 13:11:07 -0300
Message-ID: <20240122161107.26737-14-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122161107.26737-1-dbarboza@ventanamicro.com>
References: <20240122161107.26737-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102a.google.com
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

There is no need to keep both 'vlen' and 'vlenb'. All existing code
that requires 'vlen' is retrieving it via 'vlenb << 3'.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 8 +++-----
 target/riscv/cpu_cfg.h     | 1 -
 target/riscv/tcg/tcg-cpu.c | 4 +++-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 89f2349eb4..88e8cc8681 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1319,7 +1319,6 @@ static void riscv_cpu_init(Object *obj)
 
     /* Default values for non-bool cpu properties */
     cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
-    cpu->cfg.vlen = 128;
     cpu->cfg.vlenb = 128 >> 3;
     cpu->cfg.elen = 64;
     cpu->cfg.cbom_blocksize = 64;
@@ -1811,22 +1810,21 @@ static void prop_vlen_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (value != cpu->cfg.vlen && riscv_cpu_is_vendor(obj)) {
+    if (value != cpu->cfg.vlenb && riscv_cpu_is_vendor(obj)) {
         cpu_set_prop_err(cpu, name, errp);
         error_append_hint(errp, "Current '%s' val: %u\n",
-                          name, cpu->cfg.vlen);
+                          name, cpu->cfg.vlenb << 3);
         return;
     }
 
     cpu_option_add_user_setting(name, value);
-    cpu->cfg.vlen = value;
     cpu->cfg.vlenb = value >> 3;
 }
 
 static void prop_vlen_get(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
-    uint16_t value = RISCV_CPU(obj)->cfg.vlen;
+    uint16_t value = RISCV_CPU(obj)->cfg.vlenb << 3;
 
     visit_type_uint16(v, name, &value, errp);
 }
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 50479dd72f..e241922f89 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -139,7 +139,6 @@ struct RISCVCPUConfig {
     bool ext_XVentanaCondOps;
 
     uint32_t pmu_mask;
-    uint16_t vlen;
     uint16_t vlenb;
     uint16_t elen;
     uint16_t cbom_blocksize;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 401ba0beba..da437975b4 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -298,7 +298,9 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
 static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
                                  Error **errp)
 {
-    if (cfg->vlen > RV_VLEN_MAX || cfg->vlen < 128) {
+    uint32_t vlen = cfg->vlenb << 3;
+
+    if (vlen > RV_VLEN_MAX || vlen < 128) {
         error_setg(errp,
                    "Vector extension implementation only supports VLEN "
                    "in the range [128, %d]", RV_VLEN_MAX);
-- 
2.43.0



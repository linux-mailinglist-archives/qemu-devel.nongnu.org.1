Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C4C82E28B
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 23:26:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPVPP-0000su-OI; Mon, 15 Jan 2024 17:26:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPVPN-0000rl-EI
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:26:17 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPVPL-000690-NV
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:26:17 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3bd5c4cffefso3491410b6e.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705357574; x=1705962374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uTZ9DvaXYMznw+pv5Glto07Sg3ttKbbiQQL6C8QSH3A=;
 b=oHjUMxhkfW8Xt/Cx4E/5jQSrSZaeULryKOe+eTp7fiamoJ/Sls1ZY5/yCuzQUCGwQm
 bmapn32IDsmQLdi7zH2TFdPT60yzwQzIJO80ALTqPdh2DlLcE7JaP8E9JAT/7Y2Fh5mT
 oPLz62JvVOWMUnpkW+1aMUeSWml4ijTDorVZh5qyleqYg5u/AE1CUHtEd6LlU2QVZ3IO
 s13e6WpF1mV4L8iSRh8zdNCGF7ySlw/NVY8JByGVlzEVkT+BkcsyfSiuajDpFvF5aGAT
 5whj+WCPiDI/4RyjSgC18fu6vP3JvqpoHpIttPPdAGJvufJ+9eLnpwEHFg9yAQle68kc
 0pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705357574; x=1705962374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uTZ9DvaXYMznw+pv5Glto07Sg3ttKbbiQQL6C8QSH3A=;
 b=oskm47j8/ukweE7cyHNHLpcOrYm6V+h5E+OLTJq48+Dw/Go01XBdvhrj1qB9uI2Mx8
 FWUNaOYFt6dvIpITNZTHUntY8bKUc+RZUP8E6Ub8mNwCGvUGaw02z79zpknRUcBIO7X9
 z93eABJlf48L4eda9wThbWxbGMaSyBHZc5xeT0kBKPTzmuYSiljXEAB5KeeZwbu7d81Q
 kIP0lP4ey1vyscDATngKV45KpZ6g0GfHJFniv3rnJdANqZ03uJEs2oYLPwvo8BlzGLXS
 BhI756EXFreRZRc+WLKfqnPct5t4BD5eiSJ0jqOCil97EnlXbc9JJy5OUUh8z42Lylsv
 dC4w==
X-Gm-Message-State: AOJu0Yxp5rPhg3cEvvqM3SVMD2ov20MB2pVuXlD9DAkUdRXqlOk4NRPW
 7TsfLTQWsvkfDbN7SC0QC4HfFBqiV9p6kIg7859iTFPjtr2n3w==
X-Google-Smtp-Source: AGHT+IGUtjboszdQF0aat3DMfutwYY15LU+v0xEgM/mWVV6nXvY04XWOKuN/qhKu6Ub7/13Enf5xiQ==
X-Received: by 2002:a05:6808:188c:b0:3bd:6df0:ee81 with SMTP id
 bi12-20020a056808188c00b003bd6df0ee81mr4973762oib.63.1705357573910; 
 Mon, 15 Jan 2024 14:26:13 -0800 (PST)
Received: from grind.. ([152.234.123.64]) by smtp.gmail.com with ESMTPSA id
 ks19-20020a056a004b9300b006d977f70cd5sm8125940pfb.23.2024.01.15.14.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 14:26:13 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 12/12] target/riscv/cpu.c: remove cpu->cfg.vlen
Date: Mon, 15 Jan 2024 19:25:28 -0300
Message-ID: <20240115222528.257342-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115222528.257342-1-dbarboza@ventanamicro.com>
References: <20240115222528.257342-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x232.google.com
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
---
 target/riscv/cpu.c         | 8 +++-----
 target/riscv/cpu_cfg.h     | 1 -
 target/riscv/tcg/tcg-cpu.c | 4 +++-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f4261d2ffc..7b3f69d3fb 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1313,7 +1313,6 @@ static void riscv_cpu_init(Object *obj)
 
     /* Default values for non-bool cpu properties */
     cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
-    cpu->cfg.vlen = 128;
     cpu->cfg.vlenb = 128 >> 3;
     cpu->cfg.elen = 64;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
@@ -1802,22 +1801,21 @@ static void prop_vlen_set(Object *obj, Visitor *v, const char *name,
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
index daff0b8f60..667421b0b7 100644
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCED82C6CE
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 22:39:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOPF6-0004cH-Ck; Fri, 12 Jan 2024 16:39:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rOPF4-0004a0-0f
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 16:39:06 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rOPF0-00022Q-VM
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 16:39:05 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d480c6342dso54146835ad.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 13:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705095541; x=1705700341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uTZ9DvaXYMznw+pv5Glto07Sg3ttKbbiQQL6C8QSH3A=;
 b=nnSZsJyMZWX3apiAVDKcPtmk5mmk8VATynyaX4yGs5+bsOaL8OiEIgtE4ZmQXj0BRu
 lnkHqqWWPoMFBK+/XKfoiaYlPnyq2olfEiHhff5FVOWsdVbSkyITnOMsl+cEAy5qoQco
 7HM+U/zSlLI3t88EPAjNOwbfH0XAuaV6An9WDAuAX01HIbdzbkwkmp/fIli4CcAgStQ2
 /oRg96XQlK3PHbbn4cFcF62ohOTIRgMq2xwn9X4srxnanQR/sR2kv15Ilwz+YS9lt83j
 MZnrWZsQKadJVKvQQDf3QXFi+iEsJI6eDGtzgisx88Ykdk2Q1kzGo7ohewwiAyLS8o48
 ewrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705095541; x=1705700341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uTZ9DvaXYMznw+pv5Glto07Sg3ttKbbiQQL6C8QSH3A=;
 b=wJG/5kMmY0uqFXqx7Qye3J+8ciMypBdhoVxQoqHQKwRzx1lZH+Xvk9CllJD+HTJypk
 K9VXCNxeXgvY4GpHX1gxPAUaOQkqmElkfsEZaST6ZooxIBDyCZTdpeuRPzJwp2Sr7Rrj
 XFgrK7RojBh/YOmTdoHeSEugbCIeNvNnbaz1lV3Ks0eYUjfG9wIc/nS4oewPbJF+GMKK
 XDFNBUxZKnu5ihIg0V/QqCqoOZqiky6TlG1COORQMIMMFx+mEZrMKIStTQuHOJHEQ2oR
 carmQEB4/G6X2XrJcUsLxdwPPVMWtN4JRFnwkgWKg5jr5m9JzeYhv+VvoYdE+9tA0xca
 av7g==
X-Gm-Message-State: AOJu0YzdA8j73vQ5HuEyDg/ei2GIJutCFKlblxGOEQreJz3dSulHoBCE
 9kz7j9JmFnCVhwAAFLhyhyMBs0qk9f6rOqcGHmtSd2cgVJKCpw==
X-Google-Smtp-Source: AGHT+IEH8Qr+VPrbaLy2M5waqOuPdRzn8NyfmbsqALgi8gBMLPPGODUjfUinIC6kp608oNg1Dl7WjA==
X-Received: by 2002:a17:902:d485:b0:1d4:dddc:d38d with SMTP id
 c5-20020a170902d48500b001d4dddcd38dmr2055268plg.57.1705095540836; 
 Fri, 12 Jan 2024 13:39:00 -0800 (PST)
Received: from grind.. ([152.234.123.64]) by smtp.gmail.com with ESMTPSA id
 lf8-20020a170902fb4800b001d5b2967d00sm364727plb.290.2024.01.12.13.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 13:39:00 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 13/13] target/riscv/cpu.c: remove cpu->cfg.vlen
Date: Fri, 12 Jan 2024 18:38:12 -0300
Message-ID: <20240112213812.173521-14-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112213812.173521-1-dbarboza@ventanamicro.com>
References: <20240112213812.173521-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
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



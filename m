Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1589081C9D9
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 13:24:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGeYe-0001dL-A3; Fri, 22 Dec 2023 07:23:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGeYZ-0001c7-IF
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 07:23:11 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGeYX-0006Bg-RL
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 07:23:11 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5943a178d57so367235eaf.1
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 04:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1703247788; x=1703852588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVk73oD5tkPjlMefdi1dGnXgulNf3GxsdmvCZQ8ytTI=;
 b=QXmu6QhoaVx+SlU573Tu3zHcdppO/HjpFIMt57JkPKYd2N4hfJUBis8428/cIYnSOX
 6pJWsfJR23hnHubTnnaKizFRMCPkeOHXAqyS+lQ0v2UO3Q/0X1t6oPSktwJ2nFeKyJqZ
 m/l2nl8NwdpTR/r3AQ2vJYS+6H+kl+gIlW9aGL2hp7uiQ8C0XAIp1crj33mn9QmeS3cj
 SollE5o8lYb2h+KXdPgoq9cc+HOj5lETGIioMafgRUxWtKqVA1a/yrkuwkNAhoFdbrZB
 LnSlTZsJzSNs7LeMHi1CRnC1DtqlQzg5R5XWow78Vz1G0elegMXqGM3mTDb8IJg5zd10
 fqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703247788; x=1703852588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xVk73oD5tkPjlMefdi1dGnXgulNf3GxsdmvCZQ8ytTI=;
 b=tEFkhM50EntJxML1bIoDEHKNYbLJY7U5lMD5U/9WXx4iRyKksXQTJ/+Tcoa5ThCjOg
 EAQ6agRIugT3c24gpCJl3aT2r0eX4TCOT0a+5UuJ3oCLzUq0BCvb5JUbpFyowN6joHOa
 6JkA09y/02FKJTz1SwA5D32kJ6VsDZV4jqodgRSoIkMwKiFWC/xFVMruVumjqVUFLQNN
 G72eFZfJHbuePCF5mRvRCnpzGMsVZ7ZkPQX819d+ULrp1wToqBE3MI/n5iboYGgkvRYE
 vfCXtyCcHKV1j1kZ83/0X9kd29LcFzhQWTbw11fNwBZo31nooU5j8cOHhcP5Y+5iGuJt
 cUsg==
X-Gm-Message-State: AOJu0Yy5SAIcivuAHmvxdUzkZ4faMooxMK+wMLH/kaw40z77YNvIk4cG
 cbDyO6Lonsmj/emJEjUJUP42ko+hIkTa7f9MYh15TGnRQJlVnw==
X-Google-Smtp-Source: AGHT+IF+WQ6I/SF5ic+IzPNb0Ynh9e4qgJBkfz6hTkyIq17hbY5ic54swjk0z4uGgoynwpdWBWLaCA==
X-Received: by 2002:a05:6358:63a8:b0:174:b807:1208 with SMTP id
 k40-20020a05635863a800b00174b8071208mr1096983rwh.62.1703247787943; 
 Fri, 22 Dec 2023 04:23:07 -0800 (PST)
Received: from grind.dc1.ventanamicro.com (201-69-66-51.dial-up.telesp.net.br.
 [201.69.66.51]) by smtp.gmail.com with ESMTPSA id
 g14-20020aa7874e000000b006ce7ad8c14esm3274901pfo.164.2023.12.22.04.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 04:23:07 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 09/16] target/riscv: move 'elen' to riscv_cpu_properties[]
Date: Fri, 22 Dec 2023 09:22:28 -0300
Message-ID: <20231222122235.545235-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222122235.545235-1-dbarboza@ventanamicro.com>
References: <20231222122235.545235-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc33.google.com
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

Do the same thing we did with 'vlen' in the previous patch with 'elen'.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         | 52 ++++++++++++++++++++++++++++++++++++--
 target/riscv/tcg/tcg-cpu.c |  5 ----
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c2ff50bcab..8be619b6f1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1723,9 +1723,54 @@ static const PropertyInfo prop_vlen = {
     .set_default_value = qdev_propinfo_set_default_value_uint,
 };
 
-Property riscv_cpu_options[] = {
-    DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
+static void prop_elen_set(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint16_t value;
+
+    if (!visit_type_uint16(v, name, &value, errp)) {
+        return;
+    }
+
+    if (!is_power_of_2(value)) {
+        error_setg(errp, "Vector extension ELEN must be power of 2");
+        return;
+    }
+
+    /* Always allow setting a default value */
+    if (cpu->cfg.elen == 0) {
+        cpu->cfg.elen = value;
+        return;
+    }
+
+    if (value != cpu->cfg.elen && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        error_append_hint(errp, "Current '%s' val: %u\n",
+                          name, cpu->cfg.elen);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.elen = value;
+}
+
+static void prop_elen_get(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    uint16_t value = RISCV_CPU(obj)->cfg.elen;
 
+    visit_type_uint16(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_elen = {
+    .name = "elen",
+    .get = prop_elen_get,
+    .set = prop_elen_set,
+    .set_default_value = qdev_propinfo_set_default_value_uint,
+};
+
+Property riscv_cpu_options[] = {
     DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
     DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
 
@@ -1748,6 +1793,9 @@ static Property riscv_cpu_properties[] = {
     {.name = "vlen", .info = &prop_vlen,
      .set_default = true, .defval.u = 128},
 
+    {.name = "elen", .info = &prop_elen,
+     .set_default = true, .defval.u = 64},
+
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
 #endif
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 8ec858e096..84064ef7e0 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -185,11 +185,6 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
         return;
     }
 
-    if (!is_power_of_2(cfg->elen)) {
-        error_setg(errp, "Vector extension ELEN must be power of 2");
-        return;
-    }
-
     if (cfg->elen > 64 || cfg->elen < 8) {
         error_setg(errp,
                    "Vector extension implementation only supports ELEN "
-- 
2.43.0



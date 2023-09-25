Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 642A67ADE42
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 19:59:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkpqU-0001WK-7O; Mon, 25 Sep 2023 13:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkpqR-0001JQ-NA
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:58:07 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkpqQ-0002G9-3A
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:58:07 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c364fb8a4cso63287965ad.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 10:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695664684; x=1696269484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pPRdKO6FGSbBSFrOgeddG0LVwoijigHLj3i7YRRgCqE=;
 b=bZVEw0B8qGTISaDvP4ChJtEd4XdCPsuKOyl/ItS4qFPlaetnCFQ1dZpesr0uzBf7j1
 jZVpUMWysCVI0lFPEMVSDM9pv+yvvZpjrYOT4xMSSuQG9/dmoA3MF7DBxe0ysCmANqEj
 D2adjpWid9G2FJw0ExThs6mHeADG7p4dirwa3vgtrsGhiZe42ilBroBzFOJDXRssYdrL
 O3ixOGqfxRpJTlkzkMV+7y2/eT3vkP/tdfTESZ3dJyK+I1IUuNoPbsyUEXY5cMDH/bco
 Gb59RqSN1sDua6AcBJlqO3zJkYSK4m3fPW6E6XWQ7f1ODhbatQHp42Nhfp/Z5Ub8yhVY
 f3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695664684; x=1696269484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pPRdKO6FGSbBSFrOgeddG0LVwoijigHLj3i7YRRgCqE=;
 b=RMNTfWw08UvIaUrdrfEthRdWz/bLpXYl+bhxXccuVI78Is1r6Ko91i8H2xuoeys0Ny
 9T52FIbr95lPtx5ox1tm5XnaKqUkjiWgKE7UZNyulKKAMq51xfP15QHAlLjwT3GvKEAR
 FOpoiHJHpHvUk/C3CzqCfpmdjUwFuZ4mYof6otU4nE5INoUGiPGL2lRvdxVT0qA8rAla
 yNW1N0tYXswHGFZFxXKrCleJFmtkZbRGbxqHUb8dosLM1cd7tNDGP14oAeTQ/A9PPsNS
 bBHpLXzMN+RGbUk/A/1kCIiijiHdWiuLf8gs3PPBu9MnOWXEg3t0Z9zIMAgvUfNuklCZ
 XItA==
X-Gm-Message-State: AOJu0YyB4eBRQzIAdPRDMzp7CQIeBwdmkMZhnnkR6NkAsbZNjQgHWFOX
 5xqdcfVHKbn0wuyGpS+RxAPABVDPR8DvRHgfdkg=
X-Google-Smtp-Source: AGHT+IGfNaRjGmUdIh3FiQU3HIdOStWD2B2D4tTS1lm3Q/cYDWu6XS+O/P/+dUa6eg6E/eDVQJiojw==
X-Received: by 2002:a17:90a:9745:b0:277:2d2d:9a37 with SMTP id
 i5-20020a17090a974500b002772d2d9a37mr5537539pjw.4.1695664684573; 
 Mon, 25 Sep 2023 10:58:04 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 i3-20020a17090a65c300b00262ca945cecsm3312722pjs.54.2023.09.25.10.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 10:58:04 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v4 16/19] target/riscv/cpu.c: make misa_ext_cfgs[] 'const'
Date: Mon, 25 Sep 2023 14:57:06 -0300
Message-ID: <20230925175709.35696-17-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925175709.35696-1-dbarboza@ventanamicro.com>
References: <20230925175709.35696-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The array isn't marked as 'const' because we're initializing their
elements in riscv_cpu_add_misa_properties(), 'name' and 'description'
fields.

In a closer look we can see that we're not using these 2 fields after
creating the MISA properties. And we can create the properties by using
riscv_get_misa_ext_name() and riscv_get_misa_ext_description()
directly.

Remove the 'name' and 'description' fields from RISCVCPUMisaExtConfig
and make misa_ext_cfgs[] a const array.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8616c9e2f5..4875feded7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1212,8 +1212,6 @@ static void riscv_cpu_init(Object *obj)
 }
 
 typedef struct RISCVCPUMisaExtConfig {
-    const char *name;
-    const char *description;
     target_ulong misa_bit;
     bool enabled;
 } RISCVCPUMisaExtConfig;
@@ -1317,7 +1315,7 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
 #define MISA_CFG(_bit, _enabled) \
     {.misa_bit = _bit, .enabled = _enabled}
 
-static RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
+static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
     MISA_CFG(RVA, true),
     MISA_CFG(RVC, true),
     MISA_CFG(RVD, true),
@@ -1344,25 +1342,22 @@ void riscv_cpu_add_misa_properties(Object *cpu_obj)
     int i;
 
     for (i = 0; i < ARRAY_SIZE(misa_ext_cfgs); i++) {
-        RISCVCPUMisaExtConfig *misa_cfg = &misa_ext_cfgs[i];
+        const RISCVCPUMisaExtConfig *misa_cfg = &misa_ext_cfgs[i];
         int bit = misa_cfg->misa_bit;
-
-        misa_cfg->name = riscv_get_misa_ext_name(bit);
-        misa_cfg->description = riscv_get_misa_ext_description(bit);
+        const char *name = riscv_get_misa_ext_name(bit);
+        const char *desc = riscv_get_misa_ext_description(bit);
 
         /* Check if KVM already created the property */
-        if (object_property_find(cpu_obj, misa_cfg->name)) {
+        if (object_property_find(cpu_obj, name)) {
             continue;
         }
 
-        object_property_add(cpu_obj, misa_cfg->name, "bool",
+        object_property_add(cpu_obj, name, "bool",
                             cpu_get_misa_ext_cfg,
                             cpu_set_misa_ext_cfg,
                             NULL, (void *)misa_cfg);
-        object_property_set_description(cpu_obj, misa_cfg->name,
-                                        misa_cfg->description);
-        object_property_set_bool(cpu_obj, misa_cfg->name,
-                                 misa_cfg->enabled, NULL);
+        object_property_set_description(cpu_obj, name, desc);
+        object_property_set_bool(cpu_obj, name, misa_cfg->enabled, NULL);
     }
 }
 
-- 
2.41.0



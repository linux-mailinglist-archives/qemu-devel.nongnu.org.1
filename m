Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5161B790293
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 21:50:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcA8f-0001aI-43; Fri, 01 Sep 2023 15:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA7G-0008H6-Sv
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:47:39 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA7C-0003VY-Aj
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:47:38 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-57325fcd970so1403508eaf.1
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 12:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693597652; x=1694202452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AyVWaMmj9Qc4zQK9znRP2XVU6qSjLOqppOf0U1ZHYzA=;
 b=aHsKOslDmcDhAqnU5FFU4ndGJIzLSZa0Lkpg9jGEr7fUQwiexE28K/zD2SMRGdgKDj
 ks6DsATHC1rP3wno7ZO4eyoyisAv0zOsno22jLSntYN0vibpYOiheDycMLvJ/9Dm+e5p
 srWTs4K6PuaXCCtsxyxeDFBHLH0AkRCIwNaYyqAB6uVEYz3gJ90/uTEAAbjWoCpfH+7+
 On56KnJma3erTVDTGpFE795OXTJWl/3TCl/X2R4yyHRmVk+6wpCyRBkGPSootG17y4bv
 KsNwB1zy0XAF5byQxqyKSn2Y9/c7HdHVoYhRfPnsQAgKe4QPXGOFKA3G6V4SK+OJZlkw
 SzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693597652; x=1694202452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AyVWaMmj9Qc4zQK9znRP2XVU6qSjLOqppOf0U1ZHYzA=;
 b=KNN/eTF09D14ndEsf4HN2inq+ZEY95KrgJIt6FOgGRiYhyeSYkYLBZ5HykOJvUJ9J0
 L/Pgu2yels9wFAYz1V9fGW3rpQqRzLuUtrx3mTaJfZuUReTTouGIIttp1oQNE2Ddjvwl
 q9v5twTLpsqQKW+KUVFEagSOiQFz7/ik+nWG6u4N3QZmSdxeq9NpVTqly398gBupvjbO
 E+K3LhT8zQx2zMB8V6dSXn7kUU2AZgqKIpsesk3xKuKT9k6jMNLP6jF1nqeNwLkkVqr/
 4D7FxfiEGHOU7BnUtppA6m6GKN5/lDEOvIHAL1QkQmfGcwyi5A1Dvh48rZq6uJ/Sh2z9
 5Pug==
X-Gm-Message-State: AOJu0YwRa9WoL6JiRxX5q02EubOsY3NuQ7tSPlK19+Bao9mqHkJKzDBY
 UaJG/PL1PACaQ5OiC8b4uXk3vIUWB27nE0aoJPY=
X-Google-Smtp-Source: AGHT+IGCG1teF2QQF3cqTHEjdGEfK7jLswLSeY/ao8jbXwDLwrb45C0l8SZqoNpBQeHj8HqC0UjR7Q==
X-Received: by 2002:a4a:385b:0:b0:570:c0c3:8319 with SMTP id
 o27-20020a4a385b000000b00570c0c38319mr3797690oof.3.1693597652015; 
 Fri, 01 Sep 2023 12:47:32 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.194])
 by smtp.gmail.com with ESMTPSA id
 h187-20020a4a5ec4000000b00565d41ba4d0sm2303002oob.35.2023.09.01.12.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 12:47:31 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 18/20] target/riscv: use isa_ext_update_enabled() in
 init_max_cpu_extensions()
Date: Fri,  1 Sep 2023 16:46:24 -0300
Message-ID: <20230901194627.1214811-19-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
References: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Before adding support to detect if an extension was user set we need to
handle how we're enabling extensions in riscv_init_max_cpu_extensions().
object_property_set_bool() calls the set() callback for the property,
and we're going to use this callback to set the 'multi_ext_user_opts'
hash.

This means that, as is today, all extensions we're setting for the 'max'
CPU will be seen as user set in the future. Let's change set_bool() to
isa_ext_update_enabled() that will just enable/disable the flag on a
certain offset.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1ca034e6da..617b861258 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2172,24 +2172,24 @@ static void riscv_init_max_cpu_extensions(Object *obj)
     set_misa(env, env->misa_mxl, env->misa_ext | RVG | RVJ | RVV);
 
     for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
-        object_property_set_bool(obj, prop->name, true, NULL);
+        isa_ext_update_enabled(cpu, prop->offset, true);
     }
 
     /* set vector version */
     env->vext_ver = VEXT_VERSION_1_00_0;
 
     /* Zfinx is not compatible with F. Disable it */
-    object_property_set_bool(obj, "zfinx", false, NULL);
-    object_property_set_bool(obj, "zdinx", false, NULL);
-    object_property_set_bool(obj, "zhinx", false, NULL);
-    object_property_set_bool(obj, "zhinxmin", false, NULL);
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zfinx), false);
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zdinx), false);
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zhinx), false);
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zhinxmin), false);
 
-    object_property_set_bool(obj, "zce", false, NULL);
-    object_property_set_bool(obj, "zcmp", false, NULL);
-    object_property_set_bool(obj, "zcmt", false, NULL);
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zce), false);
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcmp), false);
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcmt), false);
 
     if (env->misa_mxl != MXL_RV32) {
-        object_property_set_bool(obj, "zcf", false, NULL);
+        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
     }
 }
 
-- 
2.41.0



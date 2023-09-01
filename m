Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C79F79029D
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 21:50:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcA6c-0007rB-GZ; Fri, 01 Sep 2023 15:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA6a-0007qm-Hm
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:46:56 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA6Y-00031a-AS
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:46:56 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-572a7141434so1325093eaf.2
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 12:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693597613; x=1694202413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MoAd5LD1BxMnupNH6/trItdA1XMHMQzc01b70ikSrOQ=;
 b=e1XfyHZRN407giJeC4Eu5PuYLpioDSMqeSwHsM1X7OdNsWDNiUwJLI/pAXIm2KdPGj
 j71l5m+u94y8ymeqjxyMofoE4R9/82nlIonckidXEx5kJaVXWjWcJeZ4FCuMszlNlam3
 o3w6qKFYYaNSbJUJxXLPWCKRD7dFv+RcGsv7BkAOKJoyXPmaxByIlmycluJn0yzXJDk2
 kBCMv/X7ZP9DJkTTRLEvudTo6NO2/z+yv15k8AHqxlqkyGP8w5dIh32ljLIpZ6kYa+A8
 ktctNvGuR5CTRw/8HBIvpc8iKx8tj08UzvHSbIBdihKpiR7ijhpZyQDL+TvqbP3njsnL
 YZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693597613; x=1694202413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MoAd5LD1BxMnupNH6/trItdA1XMHMQzc01b70ikSrOQ=;
 b=SL344T32Nl6MLhbRsi2mZT4US68NZ4fiqWwKN3nJRMeRZzNelBxO65rvX+BLxqmFMv
 fEntXcI8YSzyEtm27vQOqlHv0G43UayRWRA+kUFMccQGmHAYyYkkXws8wxJF/7cGRJ8z
 JUos1SY3OTxUuLoQpci/X9EDfo7TMCQISS1HD7FOF+5PzZA+0O/kS4w7iz3HsdycwrFJ
 QSgSJAuA76vs5Cr2wfvP7UxXxQMngFhF8L3z2gSpjxK2VTU0Ul1UVGuKR6dp7PIH7MeO
 43yhLKUGmrFnh7ZJkfoHuK+oxfpCRwYZtiufeVZToSQygujIjZ+fgKYiRzP/DA7oRGSv
 n44g==
X-Gm-Message-State: AOJu0YyFOjW+1Xb4ZIwmSs/xMWep60HVqvZX56o0mk92IzRhQA3LYvE+
 z7sSKdnG3ujzOU4IoQGrf8tSitq4fxtmvaZbla8=
X-Google-Smtp-Source: AGHT+IHOkNC9jRYjojBhKOytSV5l3b2FpU9OUydHcOPZWDsMX5IEstttMc2NABjLKtIhXyCMbui7dA==
X-Received: by 2002:a4a:3416:0:b0:573:bf68:8dbc with SMTP id
 b22-20020a4a3416000000b00573bf688dbcmr3669027ooa.7.1693597612688; 
 Fri, 01 Sep 2023 12:46:52 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.194])
 by smtp.gmail.com with ESMTPSA id
 h187-20020a4a5ec4000000b00565d41ba4d0sm2303002oob.35.2023.09.01.12.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 12:46:52 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 06/20] target/riscv/cpu.c: split vendor exts from
 riscv_cpu_extensions[]
Date: Fri,  1 Sep 2023 16:46:12 -0300
Message-ID: <20230901194627.1214811-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
References: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2d.google.com
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

Our goal is to make riscv_cpu_extensions[] hold only ratified,
non-vendor extensions.

Create a new riscv_cpu_vendor_exts[] array for them, changing
riscv_cpu_add_user_properties() and riscv_cpu_add_kvm_properties()
accordingly.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2349f813e4..86d536f242 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1867,7 +1867,10 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("zcmt", RISCVCPU, cfg.ext_zcmt, false),
     DEFINE_PROP_BOOL("zicond", RISCVCPU, cfg.ext_zicond, false),
 
-    /* Vendor-specific custom extensions */
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static Property riscv_cpu_vendor_exts[] = {
     DEFINE_PROP_BOOL("xtheadba", RISCVCPU, cfg.ext_xtheadba, false),
     DEFINE_PROP_BOOL("xtheadbb", RISCVCPU, cfg.ext_xtheadbb, false),
     DEFINE_PROP_BOOL("xtheadbs", RISCVCPU, cfg.ext_xtheadbs, false),
@@ -1978,6 +1981,10 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
         riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
     }
 
+    for (prop = riscv_cpu_vendor_exts; prop && prop->name; prop++) {
+        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
+    }
+
     for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
         riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
     }
@@ -2022,6 +2029,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
         qdev_property_add_static(dev, prop);
     }
 
+    for (prop = riscv_cpu_vendor_exts; prop && prop->name; prop++) {
+        qdev_property_add_static(dev, prop);
+    }
+
     for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
         qdev_property_add_static(dev, prop);
     }
-- 
2.41.0



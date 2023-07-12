Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2DA75120D
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 22:59:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJguf-0000IM-IX; Wed, 12 Jul 2023 16:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJguc-0000Fi-Va
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 16:58:15 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJgub-0005Uk-80
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 16:58:14 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6b5d57d7db9so6214920a34.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 13:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689195492; x=1691787492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s5kfyjMJSLHvJ1gc5dHqkhz0kAEnFcjYnR+16wCW8gg=;
 b=P6GSkWvH4rJM0v7tNVsvMaoVVDLgNlpwvGdiZ0kH+2Hh9OCX1ADJo5dMXpdmfL3/0i
 ubrQxIcdKrpXtarAZL2X5ZyrWeOVQHbS9xZIRRpm2RkKL7neewQJTk+/1wn1VBqNOkoF
 Vym+VjPPqw9tByUUEpPLdr35nUBu3cgoBatjjVREIAHEqLsmsVX5uhBYN8pcDjXHXi6l
 //j0tAmIvmQnfOlSYz5uFnBF8Ujm6jQAF3RORZ3u++aAuPzohJ+/Z7+0H4WD9S2IRgWx
 piyRQ7CbLtRtwIlHLIGoJ1G3o6J16gzBJU5K8hOqAL0FqDd+HFYSR6sVRmFno2sNWWQY
 i36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689195492; x=1691787492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s5kfyjMJSLHvJ1gc5dHqkhz0kAEnFcjYnR+16wCW8gg=;
 b=lPYG662cWR57TYUwZAzc3j2fg8iuZc1YsZqHS/W0Z0Nzv/VHVMngwE1kGD+QgStkjQ
 Ws0Yn/lq6yLrf7zcdgPFs4QX3BWYzbX5TBgrAB/MdeZMEJtdq3gjPUNdPMKXU5GYMLNu
 WUHbt3OvVMA2SdiATvwQJvF3JlJbfCz5vJHqXfDN8oCHmkMo9a9uS6WHQoUmXbcCL7lM
 weuRmkenTWYjfwkCIBMYn+cHOyyXi5M8vMmCtcwdxGUC1fOomSLwRfyZWO2TCkKE0/7c
 20QCWO1FeLqL+O8GiFTUu4w7TKNQvIYrVkD/xEIYCuVxGfXsCcxmblhZ9bZu93WPDtkR
 0Acg==
X-Gm-Message-State: ABy/qLYsCG0XBl32Tj4ChUksR4Y2gv3wxLlZoRYuh3njSm3gn9oSIKC7
 7+mcaXJDT8f9y1R0ztbwn5ium85MidaTpz3DaoM=
X-Google-Smtp-Source: APBJJlF3PNO7CDyTBm0rOK8mVEKpn+Ba1EwOktXB7WeGwl+iIdIAIfZElWT0joNbZd6G8Km3G48jYg==
X-Received: by 2002:a05:6870:8194:b0:1b0:2de8:f14a with SMTP id
 k20-20020a056870819400b001b02de8f14amr19337945oae.28.1689195491871; 
 Wed, 12 Jul 2023 13:58:11 -0700 (PDT)
Received: from grind.. (201-69-66-19.dial-up.telesp.net.br. [201.69.66.19])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a056870344200b001a9911765efsm2359904oah.40.2023.07.12.13.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 13:58:11 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v2 3/7] target/riscv/cpu.c: split vendor exts from
 riscv_cpu_extensions[]
Date: Wed, 12 Jul 2023 17:57:44 -0300
Message-ID: <20230712205748.446931-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712205748.446931-1-dbarboza@ventanamicro.com>
References: <20230712205748.446931-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x336.google.com
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

Our goal is to make riscv_cpu_extensions[] hold only ratified,
non-vendor extensions.

Create a new riscv_cpu_vendor_exts[] array for them, changing
riscv_cpu_add_user_properties() accordingly.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 735e0ed793..9bbdc46126 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1808,20 +1808,6 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("zcmp", RISCVCPU, cfg.ext_zcmp, false),
     DEFINE_PROP_BOOL("zcmt", RISCVCPU, cfg.ext_zcmt, false),
 
-    /* Vendor-specific custom extensions */
-    DEFINE_PROP_BOOL("xtheadba", RISCVCPU, cfg.ext_xtheadba, false),
-    DEFINE_PROP_BOOL("xtheadbb", RISCVCPU, cfg.ext_xtheadbb, false),
-    DEFINE_PROP_BOOL("xtheadbs", RISCVCPU, cfg.ext_xtheadbs, false),
-    DEFINE_PROP_BOOL("xtheadcmo", RISCVCPU, cfg.ext_xtheadcmo, false),
-    DEFINE_PROP_BOOL("xtheadcondmov", RISCVCPU, cfg.ext_xtheadcondmov, false),
-    DEFINE_PROP_BOOL("xtheadfmemidx", RISCVCPU, cfg.ext_xtheadfmemidx, false),
-    DEFINE_PROP_BOOL("xtheadfmv", RISCVCPU, cfg.ext_xtheadfmv, false),
-    DEFINE_PROP_BOOL("xtheadmac", RISCVCPU, cfg.ext_xtheadmac, false),
-    DEFINE_PROP_BOOL("xtheadmemidx", RISCVCPU, cfg.ext_xtheadmemidx, false),
-    DEFINE_PROP_BOOL("xtheadmempair", RISCVCPU, cfg.ext_xtheadmempair, false),
-    DEFINE_PROP_BOOL("xtheadsync", RISCVCPU, cfg.ext_xtheadsync, false),
-    DEFINE_PROP_BOOL("xventanacondops", RISCVCPU, cfg.ext_XVentanaCondOps, false),
-
     /* These are experimental so mark with 'x-' */
     DEFINE_PROP_BOOL("x-zicond", RISCVCPU, cfg.ext_zicond, false),
 
@@ -1840,6 +1826,23 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static Property riscv_cpu_vendor_exts[] = {
+    DEFINE_PROP_BOOL("xtheadba", RISCVCPU, cfg.ext_xtheadba, false),
+    DEFINE_PROP_BOOL("xtheadbb", RISCVCPU, cfg.ext_xtheadbb, false),
+    DEFINE_PROP_BOOL("xtheadbs", RISCVCPU, cfg.ext_xtheadbs, false),
+    DEFINE_PROP_BOOL("xtheadcmo", RISCVCPU, cfg.ext_xtheadcmo, false),
+    DEFINE_PROP_BOOL("xtheadcondmov", RISCVCPU, cfg.ext_xtheadcondmov, false),
+    DEFINE_PROP_BOOL("xtheadfmemidx", RISCVCPU, cfg.ext_xtheadfmemidx, false),
+    DEFINE_PROP_BOOL("xtheadfmv", RISCVCPU, cfg.ext_xtheadfmv, false),
+    DEFINE_PROP_BOOL("xtheadmac", RISCVCPU, cfg.ext_xtheadmac, false),
+    DEFINE_PROP_BOOL("xtheadmemidx", RISCVCPU, cfg.ext_xtheadmemidx, false),
+    DEFINE_PROP_BOOL("xtheadmempair", RISCVCPU, cfg.ext_xtheadmempair, false),
+    DEFINE_PROP_BOOL("xtheadsync", RISCVCPU, cfg.ext_xtheadsync, false),
+    DEFINE_PROP_BOOL("xventanacondops", RISCVCPU, cfg.ext_XVentanaCondOps, false),
+
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static Property riscv_cpu_options[] = {
     DEFINE_PROP_UINT8("pmu-num", RISCVCPU, cfg.pmu_num, 16),
 
@@ -1921,6 +1924,9 @@ static void riscv_cpu_add_user_properties(Object *obj)
         qdev_property_add_static(dev, prop);
     }
 
+    for (prop = riscv_cpu_vendor_exts; prop && prop->name; prop++) {
+        qdev_property_add_static(dev, prop);
+    }
 }
 
 static Property riscv_cpu_properties[] = {
-- 
2.41.0



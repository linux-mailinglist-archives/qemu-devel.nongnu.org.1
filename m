Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55636758674
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 23:05:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLrrG-0002Vn-UR; Tue, 18 Jul 2023 17:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLrrB-0002UT-TP
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 17:03:41 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLrr9-0007BR-56
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 17:03:41 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6b9b427b4fcso4296379a34.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 14:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689714217; x=1692306217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0sa5w3UfVfRGxM1ujmnSB2aZ6nIU9cshAXgpho1bOdg=;
 b=T0becYtSE4eYFQWt6JG6Z+GTU9hH/bWY13zi2PkWYjKceVY/8fP/e5WuDZP9KdKlDg
 xOWxpsvAV5br+Kq26JmHdvOyWjCJ0/7A5DCrdRGaTI6xlXZHHCdKyK4ekBbhOts7cVJG
 exuZGxbdJzebl3nxtJ6RWJhDCuSVreQv2+smAhUDX7ymwdtAcGAjGVyYxhc1wSjBAi7C
 fKLg9lSrJxTOIQwn809Q77j4xA22ZbIeVDyMNaHjuVCV0uzvHiU4AL2Tu/9/lklWFbb6
 i+8ZbfoFesh+77YYQOJKsnQ8cG+P27GQS6vnX2Aiagj2o72LhUeTkRxsxSx3Kgt/dvk/
 jAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689714217; x=1692306217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0sa5w3UfVfRGxM1ujmnSB2aZ6nIU9cshAXgpho1bOdg=;
 b=CdZdDUusFHHhYvbQWy7pRUz1BqsEBeoMjRN8grRhE/ciM5R/spCb/MTPcpdoZlQdtE
 FE8zwLT7Z2zmsO8M8XFZzZuAvkg0iwBGze7xxI4tcUJJnOA3NrqYWD/LNq2/35MME7wf
 +om4Hvf/5oXQu49ORDYLeyJPBOwtgl7579CVO/49+iuCbN8J4idU+mIzJ37gSwicIP9f
 1a6qjyQn3WcDEP7VagcXTG5YcZxXmxwolHa0Q4FOxzRXr5LYAy5NPLReQt3Kz9WufL+B
 coPqgx229TrXRpvolxk1xhXiO/fieXn23ZtnbKF9KBwOT8ccx5sgh2gbRjXtAr1lrH0g
 xuqw==
X-Gm-Message-State: ABy/qLZw+44iAVL5icsMho0AdYVRAzw/+ebSPTF9Iw18tR7vG8oGtz9T
 pnUr7C9A2LfyxBidGMyp8+NFYHS2pEHgkC9a0ZXKVg==
X-Google-Smtp-Source: APBJJlHyG8KXk3/CjGvxfrFvxOahoGUyC23zpyMtxNzGcXxfwAKmsKaxboYrweB+arOdf7NR912pBA==
X-Received: by 2002:a05:6830:22f6:b0:6b9:50a8:1e76 with SMTP id
 t22-20020a05683022f600b006b950a81e76mr4160734otc.17.1689714217778; 
 Tue, 18 Jul 2023 14:03:37 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a056830140200b006b96384ba1csm1160657otp.77.2023.07.18.14.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 14:03:37 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v4 01/11] target/riscv/cpu.c: split CPU options from
 riscv_cpu_extensions[]
Date: Tue, 18 Jul 2023 18:03:19 -0300
Message-ID: <20230718210329.200404-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718210329.200404-1-dbarboza@ventanamicro.com>
References: <20230718210329.200404-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x333.google.com
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

We'll add a new CPU type that will enable a considerable amount of
extensions. To make it easier for us we'll do a few cleanups in our
existing riscv_cpu_extensions[] array.

Start by splitting all CPU non-boolean options from it. Create a new
riscv_cpu_options[] array for them. Add all these properties in
riscv_cpu_add_user_properties() as it is already being done today.

No functional changes made.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9339c0241d..587a5a9548 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1751,7 +1751,6 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
 
 static Property riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
-    DEFINE_PROP_UINT8("pmu-num", RISCVCPU, cfg.pmu_num, 16),
     DEFINE_PROP_BOOL("sscofpmf", RISCVCPU, cfg.ext_sscofpmf, false),
     DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
     DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
@@ -1767,11 +1766,6 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
     DEFINE_PROP_BOOL("sstc", RISCVCPU, cfg.ext_sstc, true),
 
-    DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
-    DEFINE_PROP_STRING("vext_spec", RISCVCPU, cfg.vext_spec),
-    DEFINE_PROP_UINT16("vlen", RISCVCPU, cfg.vlen, 128),
-    DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
-
     DEFINE_PROP_BOOL("smstateen", RISCVCPU, cfg.ext_smstateen, false),
     DEFINE_PROP_BOOL("svadu", RISCVCPU, cfg.ext_svadu, true),
     DEFINE_PROP_BOOL("svinval", RISCVCPU, cfg.ext_svinval, false),
@@ -1802,9 +1796,7 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("zhinxmin", RISCVCPU, cfg.ext_zhinxmin, false),
 
     DEFINE_PROP_BOOL("zicbom", RISCVCPU, cfg.ext_icbom, true),
-    DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
     DEFINE_PROP_BOOL("zicboz", RISCVCPU, cfg.ext_icboz, true),
-    DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
 
     DEFINE_PROP_BOOL("zmmul", RISCVCPU, cfg.ext_zmmul, false),
 
@@ -1848,6 +1840,18 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static Property riscv_cpu_options[] = {
+    DEFINE_PROP_UINT8("pmu-num", RISCVCPU, cfg.pmu_num, 16),
+
+    DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
+    DEFINE_PROP_STRING("vext_spec", RISCVCPU, cfg.vext_spec),
+
+    DEFINE_PROP_UINT16("vlen", RISCVCPU, cfg.vlen, 128),
+    DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
+
+    DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
+    DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
+};
 
 #ifndef CONFIG_USER_ONLY
 static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
@@ -1916,6 +1920,14 @@ static void riscv_cpu_add_user_properties(Object *obj)
 #endif
         qdev_property_add_static(dev, prop);
     }
+
+    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
+        /* Check if KVM created the property already */
+        if (object_property_find(obj, riscv_cpu_options[i].name)) {
+            continue;
+        }
+        qdev_property_add_static(dev, &riscv_cpu_options[i]);
+    }
 }
 
 static Property riscv_cpu_properties[] = {
-- 
2.41.0



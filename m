Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9BB790292
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 21:50:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcA6N-0007ml-R1; Fri, 01 Sep 2023 15:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA6L-0007lz-RO
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:46:41 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA6I-0002v1-Mu
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:46:41 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5735282d713so1390394eaf.2
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 12:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693597597; x=1694202397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0N0oTIyVCTE0+WINtqk5L95k/7qBHpAfwshUNyTE0mY=;
 b=EtVE++5RhSmQkuZc1oZ8DYuxoUHEGcnTTwLPe8qIx5mjNYtNTaRzBfwlMFoNU0kC0g
 Jy5vUdoPGCRjDftQqcQEGW/du7eeZXBgguLW5LGa6k84nuUt2bl8NSisIifOd30aAqHC
 1gSxFQThBnzGA3Eb28d7f2lO1TL7DT9TnnvDMEYKWJ8wXd8+m4d4EMomYxXu+/DKNJTp
 +EDfVU2/24A9dH0av8bO/6a0io8kssr1upV21QoEhzOTEjwuoAE9w9GwCra8vyQpP2uK
 BUC1LT7HLYYPQV0UZbxdWSt4noke535hd3dM/mAO+dUHSwFilMjkJ6zqMdenf4xWmMQN
 EQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693597597; x=1694202397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0N0oTIyVCTE0+WINtqk5L95k/7qBHpAfwshUNyTE0mY=;
 b=cesP1KHoHxfadlVfPuGdBYcaxbAWvxnwPfTIYUE2R1nxEQrBna6/K9zOJSQc/GvyfO
 Kj0mGyYYEOR4ofM1Rr+hPCFphhQzQlOf11+ClBsV5LhHx7+rn0ythsAxq+DAAfUDe8ZR
 myuj/JLBT2CuwN/VoGOPW+RhraKNqewwxk5U4M/7Xm7Fbd4jj6j+C6AEdCRr/m05ZxYW
 BMjKhtA+LreSF6cgHwPkcv04tznSEExoVDx72KHLkEpvGeAeYp79+JnEjT9B1gnoEVKY
 /A0Xxjzwn8/zSTE+s2/DZsyzLCWJ2i6Zi6SssbmtQbaxl7auNJlXYhGCP+qCB8p5a5Oh
 b1UQ==
X-Gm-Message-State: AOJu0YwkIiaDHoZO9bWj8TRcQUuglERgiX9fx2iWq49LHnw3m9Wdx9NS
 bsTkY/+MAODRqi9ObR59FKaJoN+umSNoPOU8DQc=
X-Google-Smtp-Source: AGHT+IEJO1KAxLV8Y85h8Iosdc+PyEDc52U2feQYFUYjXN9ODDhPT0Ln/BrzlwMKYnHcRT6lvjH2Zw==
X-Received: by 2002:a05:6820:284:b0:573:3fe0:cdd6 with SMTP id
 q4-20020a056820028400b005733fe0cdd6mr3978125ood.6.1693597596893; 
 Fri, 01 Sep 2023 12:46:36 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.194])
 by smtp.gmail.com with ESMTPSA id
 h187-20020a4a5ec4000000b00565d41ba4d0sm2303002oob.35.2023.09.01.12.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 12:46:36 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 01/20] target/riscv/cpu.c: split CPU options from
 riscv_cpu_extensions[]
Date: Fri,  1 Sep 2023 16:46:07 -0300
Message-ID: <20230901194627.1214811-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
References: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2a.google.com
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

We'll add a new CPU type that will enable a considerable amount of
extensions. To make it easier for us we'll do a few cleanups in our
existing riscv_cpu_extensions[] array.

Start by splitting all CPU non-boolean options from it. Create a new
riscv_cpu_options[] array for them. Add all these properties in
riscv_cpu_add_user_properties() as it is already being done today.

'mmu' and 'pmp' aren't really extensions in the usual way we think about
RISC-V extensions. These are closer to CPU features/options, so move
both to riscv_cpu_options[] too. In the near future we'll need to match
all extensions with all entries in isa_edata_arr[], and so it happens
that both 'mmu' and 'pmp' do not have a riscv,isa string (thus, no priv
spec version restriction). This further emphasizes the point that these
are more a CPU option than an extension.

No functional changes made.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f227c7664e..fdbd8eb0b8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1810,7 +1810,6 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
 
 static Property riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
-    DEFINE_PROP_UINT8("pmu-num", RISCVCPU, cfg.pmu_num, 16),
     DEFINE_PROP_BOOL("sscofpmf", RISCVCPU, cfg.ext_sscofpmf, false),
     DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
     DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
@@ -1823,15 +1822,8 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("Zve32f", RISCVCPU, cfg.ext_zve32f, false),
     DEFINE_PROP_BOOL("Zve64f", RISCVCPU, cfg.ext_zve64f, false),
     DEFINE_PROP_BOOL("Zve64d", RISCVCPU, cfg.ext_zve64d, false),
-    DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
-    DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
     DEFINE_PROP_BOOL("sstc", RISCVCPU, cfg.ext_sstc, true),
 
-    DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
-    DEFINE_PROP_STRING("vext_spec", RISCVCPU, cfg.vext_spec),
-    DEFINE_PROP_UINT16("vlen", RISCVCPU, cfg.vlen, 128),
-    DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
-
     DEFINE_PROP_BOOL("smstateen", RISCVCPU, cfg.ext_smstateen, false),
     DEFINE_PROP_BOOL("svadu", RISCVCPU, cfg.ext_svadu, true),
     DEFINE_PROP_BOOL("svinval", RISCVCPU, cfg.ext_svinval, false),
@@ -1862,9 +1854,7 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("zhinxmin", RISCVCPU, cfg.ext_zhinxmin, false),
 
     DEFINE_PROP_BOOL("zicbom", RISCVCPU, cfg.ext_icbom, true),
-    DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
     DEFINE_PROP_BOOL("zicboz", RISCVCPU, cfg.ext_icboz, true),
-    DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
 
     DEFINE_PROP_BOOL("zmmul", RISCVCPU, cfg.ext_zmmul, false),
 
@@ -1918,6 +1908,21 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static Property riscv_cpu_options[] = {
+    DEFINE_PROP_UINT8("pmu-num", RISCVCPU, cfg.pmu_num, 16),
+
+    DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
+    DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
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
@@ -1986,6 +1991,14 @@ static void riscv_cpu_add_user_properties(Object *obj)
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



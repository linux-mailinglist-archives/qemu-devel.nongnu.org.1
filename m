Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A627510DF
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 21:03:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJf6F-0000nd-Tq; Wed, 12 Jul 2023 15:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJf6B-0000mn-2p
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:02:03 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJf69-0006Vi-Dv
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:02:02 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6b73c2b6dcfso4800570a34.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 12:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689188519; x=1691780519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RiSgAfEWU0a1sAwwC0juXw9kQhptA+n3m54/TaSZbs=;
 b=RhcV4wuzaEyoy793fQw+Y0E/OEbutOWpYewL5xMn2szCzNmfKeZuwYDH6C6L0/bpT6
 kZNg1z6Uk0rPUnz0q1GMJ/Wd/arrEmflmJ7A54pDhZBtYeb0THKKW2kAhNEwKaaNvPfV
 9tQ7OD0NoJVFa6hgFOzQuDb7RiFjmqsmY8BGBIG7jXOmg/m9WjvurwSZ/xYGzUG4bekG
 6dZlwDWlRh87mkOy/hCMRrCVIg4d9eCiebsh2elFX2W0rgIRvROXNII4/YdbTAVtXPRc
 IW5bJJDc+FrxPg8Mozc7yQyMiNbRLGO3WlUCLdL8aGDvVlcxxE/60wINLUPilvPRxTNJ
 6vBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689188519; x=1691780519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4RiSgAfEWU0a1sAwwC0juXw9kQhptA+n3m54/TaSZbs=;
 b=UJ9lAKGRxVZH7fiugjoeMfsN/4mhAJwEMfLdw/qsZG0d9uk+GlLp/7LLat8ycUyOlx
 oznHBaMbpAx/klgZhIclKzbbYJKe/mI8xZNPbNFe4wL65vYlGN7slt3evuaoTmdKK4Z5
 iEKOL+j+kPvBkxiDPrv4YEi1wae74K+R8fjGZMCk8mp7GcooatLKpYjmpA/Ac/Ec7gKv
 /Pop4UPcZRRb2QHeWmbEw9XTVLyj+7AsQEtDQbMTyRj6pW7L+CKSRL3WJm+tKbowuyKt
 MdAOaSsbT89J6PB3Y4MF/gRheHjL18ZSxDhr59ykm1ePg+QEn/Kb0pN3wk+dlFFPqX5i
 eavg==
X-Gm-Message-State: ABy/qLYvJIqJtcQssn56HdbRcsiYXcl2O5GGbt4ag5NJpjPZdjmvTIhw
 ixbdOMsny2Gj2KH6ExQhl/hIeMy4lb7WLa4Naaw=
X-Google-Smtp-Source: APBJJlGx99JPgGuqaAc5vZU1DXloNZ540rVcQRYdlkQZpziLj4TyGyziMFDJbPl3KsJJcsJjs8Kcrw==
X-Received: by 2002:a05:6808:1190:b0:3a3:ff72:1451 with SMTP id
 j16-20020a056808119000b003a3ff721451mr10296940oil.7.1689188519408; 
 Wed, 12 Jul 2023 12:01:59 -0700 (PDT)
Received: from grind.. (201-69-66-19.dial-up.telesp.net.br. [201.69.66.19])
 by smtp.gmail.com with ESMTPSA id
 a9-20020a05680802c900b003a020d24d7dsm2174435oid.56.2023.07.12.12.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 12:01:59 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 1/7] target/riscv/cpu.c: split CPU options from
 riscv_cpu_extensions[]
Date: Wed, 12 Jul 2023 16:01:43 -0300
Message-ID: <20230712190149.424675-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712190149.424675-1-dbarboza@ventanamicro.com>
References: <20230712190149.424675-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x330.google.com
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
---
 target/riscv/cpu.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9339c0241d..cdf9eeeb6b 100644
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
 
@@ -1848,6 +1840,20 @@ static Property riscv_cpu_extensions[] = {
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
+
+    DEFINE_PROP_END_OF_LIST(),
+};
 
 #ifndef CONFIG_USER_ONLY
 static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
@@ -1916,6 +1922,11 @@ static void riscv_cpu_add_user_properties(Object *obj)
 #endif
         qdev_property_add_static(dev, prop);
     }
+
+    for (prop = riscv_cpu_options; prop && prop->name; prop++) {
+        qdev_property_add_static(dev, prop);
+    }
+
 }
 
 static Property riscv_cpu_properties[] = {
-- 
2.41.0



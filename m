Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 546217C63EA
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:19:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn2X-0000ul-Si; Thu, 12 Oct 2023 00:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn2V-0000uZ-PY
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:11 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn2T-00022c-Sd
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:11 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c9b7c234a7so4921415ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083868; x=1697688668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDX95WCT1uI/VlPlP2qVR8LIHQGxyb3eJMOksGz7Doc=;
 b=ktX2EMR9NiDL0cTYi6o+IOpT6psDhU/Tt3d1rG19c0X8DXYt1UQ2mwyp8DsaMYCxBQ
 0MSJjFxt+gsnqQQeS1bJHqlPVTvM4vS7t68J9EjmkU4NV6YmnztL5K94cwQw6h3lDYwW
 YAN5J/HpEtzEyHM855Ef7X2cXYYaUn3vfDLY+kq+zsteEwej6498VDPD/9srTSgC2Jul
 8DSSXyl9wcc9xhvnMOJOXUIotRm2iBpX5UcJURZhZrcBFsy1oYPh3ywYctnP0XDKq78Y
 o2MIrcyxkJ1k4Ll9xAMjF3ja6pSbzNJP0out0nUjWS7i0EIcpi1OcQrf8uwvkwdMEFPy
 XG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083868; x=1697688668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NDX95WCT1uI/VlPlP2qVR8LIHQGxyb3eJMOksGz7Doc=;
 b=oODBRmzT71w/czwbKVKBQvP+Cs+TtlOYpB7QEKICswf7y5SU0wnErscfbnhSjOqboH
 M5Lw+dmOqjEsiRphFu4xp/QFsX+Vf1MsKom66qasD5W7/BJR0A67aei5X+L7m5KUMpKd
 mTxHQx/JB7puHo2VFC3T+MJVCqHVzb+JEuuuogWPZ5e2+UwGRGKT/hMMXW8cq4pqg8s5
 hmh07I3c+1BHgMvBXFdsOdTN7Vy+H4UuNEpDTvR8wEMIggOgs2JWejW/YOvxyLPba6Ov
 SFwBYmsYYH7PTJUf0bwJc+UQ5ZiKk8GOf8wf+Ad9ZQaLcDoO2IZQD0/ErTTsabPPbgNO
 nFwg==
X-Gm-Message-State: AOJu0YwByZ/anylAdRbqpmBQ5fGdN4F9Jvx/CNHYO+o8z8JojCFS4kc/
 dwxhhBm9Q0/hBR0pekda5+c7T7HgrE0tmw==
X-Google-Smtp-Source: AGHT+IFeSiZxyY1Zvm9XeD03n2s5//u5ig9f0N0boHo4JILHfbs3VigHuN8PCbvVzTeFn76NemisYA==
X-Received: by 2002:a17:902:e54a:b0:1c6:2dbb:e5fa with SMTP id
 n10-20020a170902e54a00b001c62dbbe5famr29504790plf.44.1697083868125; 
 Wed, 11 Oct 2023 21:11:08 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:11:07 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 01/54] target/riscv/cpu.c: split CPU options from
 riscv_cpu_extensions[]
Date: Thu, 12 Oct 2023 14:09:58 +1000
Message-ID: <20231012041051.2572507-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

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
Message-ID: <20230912132423.268494-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f5572704de..03143c3686 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1806,7 +1806,6 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
 
 static Property riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
-    DEFINE_PROP_UINT8("pmu-num", RISCVCPU, cfg.pmu_num, 16),
     DEFINE_PROP_BOOL("sscofpmf", RISCVCPU, cfg.ext_sscofpmf, false),
     DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
     DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
@@ -1819,15 +1818,8 @@ static Property riscv_cpu_extensions[] = {
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
@@ -1858,9 +1850,7 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("zhinxmin", RISCVCPU, cfg.ext_zhinxmin, false),
 
     DEFINE_PROP_BOOL("zicbom", RISCVCPU, cfg.ext_icbom, true),
-    DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
     DEFINE_PROP_BOOL("zicboz", RISCVCPU, cfg.ext_icboz, true),
-    DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
 
     DEFINE_PROP_BOOL("zmmul", RISCVCPU, cfg.ext_zmmul, false),
 
@@ -1914,6 +1904,21 @@ static Property riscv_cpu_extensions[] = {
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
@@ -1982,6 +1987,14 @@ static void riscv_cpu_add_user_properties(Object *obj)
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



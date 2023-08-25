Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6355788822
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 15:12:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZWZS-0001tN-HZ; Fri, 25 Aug 2023 09:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZWZP-0001rl-Pn
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:09:47 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZWZN-00073B-EM
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:09:47 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1c8d2606fc9so1069088fac.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 06:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692968984; x=1693573784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+HngWOHC+z3LAYvy2w4nJSLAWIE+M1Sz2Rz6/22kNw=;
 b=HivoGvwObMTZsV7WQpkIClOOc6kSxVCniwq5PrcDH6bcXw1HwkcFMO6XwAf+77F7WH
 fFjG/0tbSTseXdUTcfsAvLk7E2BC2v/BNL/bNpomt+cFN4/oM59YVGY90qOqXVLMZ3z4
 fG/A0+8yaCiZKNX24Y4HwWvw6yIj15/1i5MrTendscn5+4VtGkYz9SAOaweBIzg5LNen
 /GD+2jaGZAeFo/dbSPdf5D+CGlicpjQwxd9B/27g0OO0gy3NHPPzqP4/c0RC3CZ5fksL
 cwwEks2v8h5E0Vf52+ZpUohf128k9TQZzTdhegcSONSpE5XQnPy8jaYSHIR1Bbqo4HK5
 kwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692968984; x=1693573784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t+HngWOHC+z3LAYvy2w4nJSLAWIE+M1Sz2Rz6/22kNw=;
 b=gErsU7qiEFEWxWRVWk4qz0rTCzjwuOWmks7a347qc6W8uvzu/l6ep2DDANCh85q3A1
 Es+s+rRUsG23pdpEt78fZRW2P26353iWTG+A7VjN5nBPehRFT52DEdnU8dmhn3X3QhIT
 Ow9T1xDB+5q7ySz+puHvcDnN/BG+r8okVQybj2VGmz/v8ExAQAwbuwGpvhz7TaydhAmN
 ifgCUekqwYI0OYmi4Gchskf8t5vcAHkE42cGPJpFfl91SGa/1BUR0UQokWlRrS0CRQen
 G7D/8a2aA5IXXIu1sScehqOm1FiJI8YdrNkx+pFoXS/moZFu0wuqR96O3MYi4bmRKX/X
 BKGw==
X-Gm-Message-State: AOJu0YwgdMGWfoZpVivTAM4Bqv4VqsLezqw5QCGFCcbghTyRiCqlSMIa
 bkbENMu3USjfaDLoaT8RjDtJfFLxTbTMy9lU+KI=
X-Google-Smtp-Source: AGHT+IELHcnHnObffJXDe4gnZnv8Ysz5RXnFCJocQr6iy0vTA5xJlgx58Rn4RN8FUkpPbyviA7BJwA==
X-Received: by 2002:a05:6870:5387:b0:1bb:c0ee:5554 with SMTP id
 h7-20020a056870538700b001bbc0ee5554mr1721606oan.2.1692968984050; 
 Fri, 25 Aug 2023 06:09:44 -0700 (PDT)
Received: from grind.. ([179.93.21.19]) by smtp.gmail.com with ESMTPSA id
 ds23-20020a0568705b1700b001c50fb56845sm966189oab.16.2023.08.25.06.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 06:09:43 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 14/20] target/riscv/kvm: do not use
 riscv_cpu_add_misa_properties()
Date: Fri, 25 Aug 2023 10:08:47 -0300
Message-ID: <20230825130853.511782-15-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825130853.511782-1-dbarboza@ventanamicro.com>
References: <20230825130853.511782-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x29.google.com
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

riscv_cpu_add_misa_properties() is being used to fill the missing KVM
MISA properties but it is a TCG helper that was adapted to do so. We'll
move it to tcg-cpu.c in the next patches, meaning that KVM needs to fill
the remaining MISA properties on its own.

Do not use riscv_cpu_add_misa_properties(). Let's create a new array
with all available MISA bits we support that can be read by KVM. Then,
inside kvm_riscv_add_cpu_user_properties(), we'll create all KVM MISA
properties as usual and then use this array to add any missing MISA
properties with the riscv_cpu_add_kvm_unavail_prop() helper.

Note that we're creating misa_bits[], and not using the existing
'riscv_single_letter_exts[]', because the latter is tuned for riscv,isa
related functions and it doesn't have all MISA bits we support. Commit
0e2c377023 ("target/riscv: misa to ISA string conversion fix") has the
full context.

While we're at it, move both satp and the multi-letter extension
properties to kvm_riscv_add_cpu_user_properties() as well.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         |  2 ++
 target/riscv/cpu.h         |  3 ++-
 target/riscv/kvm/kvm-cpu.c | 17 +++++++++++------
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bf6c8519b1..f9aea6a80a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -38,6 +38,8 @@
 
 /* RISC-V CPU definitions */
 static const char riscv_single_letter_exts[] = "IEMAFDQCPVH";
+const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
+                              RVC, RVS, RVU, RVH, RVJ, RVG};
 
 struct isa_ext_data {
     const char *name;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 950c2301f2..9ec3b98bd2 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -43,7 +43,7 @@
 #define RV(x) ((target_ulong)1 << (x - 'A'))
 
 /*
- * Consider updating misa_ext_info_arr[] and misa_ext_cfgs[]
+ * Update misa_bits[], misa_ext_info_arr[] and misa_ext_cfgs[]
  * when adding new MISA bits here.
  */
 #define RVI RV('I')
@@ -60,6 +60,7 @@
 #define RVJ RV('J')
 #define RVG RV('G')
 
+extern const uint32_t misa_bits[13];
 const char *riscv_get_misa_ext_name(uint32_t bit);
 const char *riscv_get_misa_ext_description(uint32_t bit);
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 85e8b0a927..501384924b 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -387,6 +387,8 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
 {
     int i;
 
+    riscv_add_satp_mode_properties(cpu_obj);
+
     for (i = 0; i < ARRAY_SIZE(kvm_misa_ext_cfgs); i++) {
         KVMCPUConfig *misa_cfg = &kvm_misa_ext_cfgs[i];
         int bit = misa_cfg->offset;
@@ -402,6 +404,11 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
                                         misa_cfg->description);
     }
 
+    for (i = 0; i < ARRAY_SIZE(misa_bits); i++) {
+        const char *ext_name = riscv_get_misa_ext_name(misa_bits[i]);
+        riscv_cpu_add_kvm_unavail_prop(cpu_obj, ext_name);
+    }
+
     for (i = 0; i < ARRAY_SIZE(kvm_multi_ext_cfgs); i++) {
         KVMCPUConfig *multi_cfg = &kvm_multi_ext_cfgs[i];
 
@@ -418,6 +425,10 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
     object_property_add(cpu_obj, "cboz_blocksize", "uint16",
                         NULL, kvm_cpu_set_cbomz_blksize,
                         NULL, &kvm_cboz_blocksize);
+
+    riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_extensions);
+    riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_vendor_exts);
+    riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_experimental_exts);
 }
 
 static int kvm_riscv_get_regs_core(CPUState *cs)
@@ -1301,12 +1312,6 @@ static void kvm_cpu_instance_init(CPUState *cs)
 
     if (rcc->user_extension_properties) {
         kvm_riscv_add_cpu_user_properties(obj);
-        riscv_add_satp_mode_properties(obj);
-        riscv_cpu_add_misa_properties(obj);
-
-        riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_extensions);
-        riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_vendor_exts);
-        riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_experimental_exts);
     }
 
     for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
-- 
2.41.0



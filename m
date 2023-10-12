Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E7E7C63EC
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:19:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn4a-0005LV-2K; Thu, 12 Oct 2023 00:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4R-000555-43
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:11 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4P-0002dl-4e
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:10 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5827f6d60aaso387551a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083987; x=1697688787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S8OzPE9tTQEFJsynemPuRdaCieXFhO95LpXmTL5U7ro=;
 b=AbD9MJdLOpb1/l3RbSiq2lO6m/Lsu7eFRecVKmfpB0rF7tsiT2i0ca6qqru4FPWZJr
 DNvnBHaFaUB4scByoFCYh4ESoE+qJp9Zdr7+D+aq9m5CTCxB2dxRO//uj6XC4NMVFd7C
 51vAYQLljTu0Tuvq6mIYGM+bjZ0Az1+qQyh/RMbfQkdjbxfUJ2colD124p+82DE/Pkca
 bbccgQbPjkseVZvjQ2Z5A6E8reizP1v3BkGF+FtaMaHQrnECReBxC5h5jUw5igsg36Wh
 zDbdN7zXbRZRNVW9QxxvB7iq+1xScR9CcjMxHg6pYUKbq+HFa1l5Yo8COThwCpt7HgWH
 37Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083987; x=1697688787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S8OzPE9tTQEFJsynemPuRdaCieXFhO95LpXmTL5U7ro=;
 b=TaZSj1EJu32kBkfLHfL8xhBTGpjGcb21k5FwyYskOiE+ynqa5XAxfRwbTW0VmHjIrV
 sThBiUq4acePYLblQCHnHErwUd+qSEcyy/zsR7xsxlLAO/03jHEkown0wjt3tETm/VgV
 50fE12uso0GThmQpEWM9h/+dJcKZvWd4HMTwlysKl6M8YbZLNqFjv1OIXO0OUgn4x5Ht
 QkGp8R9PqjVnpsaLwiPMDPaXMNWJ2Iavg9RSEL7P49DtHDooyfNmMCvcBMrTOKPAJ4nd
 +L4aSvzrqlRm/xmDgSpP6WKavPAvkeHRf/agVAnK+iemgolSNtVaTL0J07GDgQ1QWbQi
 yDvQ==
X-Gm-Message-State: AOJu0YxUfJe2/5BgQ4r0ZwfquoWwJw+DhjlcNS07iX/QDKWEyvE6ZO5c
 Hy6X81pc/Cj8Uf1XB8WcLzUluaF8cCy0EQ==
X-Google-Smtp-Source: AGHT+IHN3ier0lE6yQuig2ioAC9pNLXvCAfrtyj2yjndDxzOoZbynyTuydrsxgfRrqef4VZhJ3CPiA==
X-Received: by 2002:a05:6a20:258e:b0:159:c24f:5fa4 with SMTP id
 k14-20020a056a20258e00b00159c24f5fa4mr23653952pzd.1.1697083987326; 
 Wed, 11 Oct 2023 21:13:07 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:13:06 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 35/54] target/riscv/kvm: do not use
 riscv_cpu_add_misa_properties()
Date: Thu, 12 Oct 2023 14:10:32 +1000
Message-ID: <20231012041051.2572507-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
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

riscv_cpu_add_misa_properties() is being used to fill the missing KVM
MISA properties but it is a TCG helper that was adapted to do so. We'll
move it to tcg-cpu.c in the next patches, meaning that KVM needs to fill
the remaining MISA properties on its own.

Do not use riscv_cpu_add_misa_properties(). Let's create a new array
with all available MISA bits we support that can be read by KVM. The
array is zero terminate to allow us to iterate through it without
knowing its size.

Then, inside kvm_riscv_add_cpu_user_properties(), we'll create all KVM
MISA properties as usual and then use this array to add any missing MISA
properties with the riscv_cpu_add_kvm_unavail_prop() helper.

Note that we're creating misa_bits[], and not using the existing
'riscv_single_letter_exts[]', because the latter is tuned for riscv,isa
related functions and it doesn't have all MISA bits we support. Commit
0e2c377023 ("target/riscv: misa to ISA string conversion fix") has the
full context.

While we're at it, move both satp and the multi-letter extension
properties to kvm_riscv_add_cpu_user_properties() as well.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230925175709.35696-14-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  3 ++-
 target/riscv/cpu.c         |  2 ++
 target/riscv/kvm/kvm-cpu.c | 22 ++++++++++++++--------
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d4b4ac3481..6f041d3333 100644
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
 
+extern const uint32_t misa_bits[];
 const char *riscv_get_misa_ext_name(uint32_t bit);
 const char *riscv_get_misa_ext_description(uint32_t bit);
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d8753240bf..cc439e5839 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -38,6 +38,8 @@
 
 /* RISC-V CPU definitions */
 static const char riscv_single_letter_exts[] = "IEMAFDQCPVH";
+const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
+                              RVC, RVS, RVU, RVH, RVJ, RVG, 0};
 
 struct isa_ext_data {
     const char *name;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 606fdab223..c6615cb807 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -396,6 +396,8 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
 {
     int i;
 
+    riscv_add_satp_mode_properties(cpu_obj);
+
     for (i = 0; i < ARRAY_SIZE(kvm_misa_ext_cfgs); i++) {
         KVMCPUConfig *misa_cfg = &kvm_misa_ext_cfgs[i];
         int bit = misa_cfg->offset;
@@ -411,6 +413,11 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
                                         misa_cfg->description);
     }
 
+    for (i = 0; misa_bits[i] != 0; i++) {
+        const char *ext_name = riscv_get_misa_ext_name(misa_bits[i]);
+        riscv_cpu_add_kvm_unavail_prop(cpu_obj, ext_name);
+    }
+
     for (i = 0; i < ARRAY_SIZE(kvm_multi_ext_cfgs); i++) {
         KVMCPUConfig *multi_cfg = &kvm_multi_ext_cfgs[i];
 
@@ -427,6 +434,10 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
     object_property_add(cpu_obj, "cboz_blocksize", "uint16",
                         NULL, kvm_cpu_set_cbomz_blksize,
                         NULL, &kvm_cboz_blocksize);
+
+    riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_extensions);
+    riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_vendor_exts);
+    riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_experimental_exts);
 }
 
 static int kvm_riscv_get_regs_core(CPUState *cs)
@@ -801,7 +812,7 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
     }
 }
 
-static void riscv_init_user_properties(Object *cpu_obj)
+static void riscv_init_kvm_registers(Object *cpu_obj)
 {
     RISCVCPU *cpu = RISCV_CPU(cpu_obj);
     KVMScratchCPU kvmcpu;
@@ -810,7 +821,6 @@ static void riscv_init_user_properties(Object *cpu_obj)
         return;
     }
 
-    kvm_riscv_add_cpu_user_properties(cpu_obj);
     kvm_riscv_init_machine_ids(cpu, &kvmcpu);
     kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
     kvm_riscv_init_multiext_cfg(cpu, &kvmcpu);
@@ -1324,13 +1334,9 @@ static void kvm_cpu_instance_init(CPUState *cs)
     Object *obj = OBJECT(RISCV_CPU(cs));
     DeviceState *dev = DEVICE(obj);
 
-    riscv_init_user_properties(obj);
-    riscv_add_satp_mode_properties(obj);
-    riscv_cpu_add_misa_properties(obj);
+    riscv_init_kvm_registers(obj);
 
-    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_extensions);
-    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_vendor_exts);
-    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_experimental_exts);
+    kvm_riscv_add_cpu_user_properties(obj);
 
     for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
         /* Check if we have a specific KVM handler for the option */
-- 
2.41.0



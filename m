Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C945681C9DF
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 13:24:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGeYm-0001uW-Uv; Fri, 22 Dec 2023 07:23:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGeYl-0001tz-FK
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 07:23:23 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGeYj-0006Dv-Gg
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 07:23:23 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5cd8667c59eso1370305a12.2
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 04:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1703247800; x=1703852600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YOG7GjzzHRfLatHdrFLWdWSYTLIf6bifme29NkFErLs=;
 b=F2IYV+nZqnZ1zzUqx6NDefWaFhLUMTFlfZ8+vV6J8YZqyZCiwWmB9u1fdItYnWpgVR
 8+XC9AJia2fzKOPSePKnKj9VnA2NfqnxLqQGSjUpzvW/hVTRuacQBaRWsq3e9bS8dzUK
 vA3K0/P6jTyBkKHDIx2L7y2n8JcsHft+mqIuUQV78WbmUtV8A9Lkma8AL9+EHu41D1Tw
 f7yioKOkC2RlM8h7z8L0VkZxLWcQV+i7I3ePVFkr0yIM8ACY/nWuE+v1ac9JfImlPhHC
 wRLk/jQGE0NJudCT+rSGGD9bb/4buDHXnHq4xPo6n7/ISmRBaDYImIkBl/OEkNynv87L
 sM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703247800; x=1703852600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YOG7GjzzHRfLatHdrFLWdWSYTLIf6bifme29NkFErLs=;
 b=G+qSuy5g7I1OW42CgTo7FOlIlb30dXb3sZ/AOwK8pTztESWV3+v7fTo+A12xV8/Tmk
 vqE9ZdgOZKy82ZnIlYirUg1cepOnorsbzroGAJiOCZ2Sgzmz/z1c8sRkumX2ppE/utiK
 B45d5TimEciGPbGB/06TMNALXM03uzSfYTrUn7GDBS4DdOVgTkjZ2/YaHqK2hEWSlSk/
 Ca+wnm5SgkSE02C2mJIWdmx8Z+UQiVhHCPFmSvFY47hn9jiM3z/tLmTIqztkzetbgfCI
 5sSxKbaDLqqL4Nm6lmpF+NOJVoFzYT5GZa8uTMx9uGiosPBV9vumkA2RdwpuLboPblAv
 mtRg==
X-Gm-Message-State: AOJu0YyURFtZp11JENVHJZqX00vsVx74SY+wunwYLB4HU46v6us7PLMX
 xBJ5KJwuVsMNfatO0uBXxx+dmkYYES6rVT9q5WUaHToOf33mAg==
X-Google-Smtp-Source: AGHT+IEFTjxgHsbSnfiabKY7tsWfEVffMExprXFVqAh6H2jw37VriuXH2cq7H6ygJ0VLiYFHtBIrnQ==
X-Received: by 2002:a05:6a20:8e0c:b0:18d:10d7:3313 with SMTP id
 y12-20020a056a208e0c00b0018d10d73313mr1571708pzj.20.1703247799839; 
 Fri, 22 Dec 2023 04:23:19 -0800 (PST)
Received: from grind.dc1.ventanamicro.com (201-69-66-51.dial-up.telesp.net.br.
 [201.69.66.51]) by smtp.gmail.com with ESMTPSA id
 g14-20020aa7874e000000b006ce7ad8c14esm3274901pfo.164.2023.12.22.04.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 04:23:19 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 13/16] target/riscv: remove riscv_cpu_options[]
Date: Fri, 22 Dec 2023 09:22:32 -0300
Message-ID: <20231222122235.545235-14-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222122235.545235-1-dbarboza@ventanamicro.com>
References: <20231222122235.545235-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x535.google.com
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

The array is empty and can be removed.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         | 5 -----
 target/riscv/cpu.h         | 1 -
 target/riscv/kvm/kvm-cpu.c | 9 ---------
 target/riscv/tcg/tcg-cpu.c | 4 ----
 4 files changed, 19 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f30058518a..7b1cc5d0c9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1860,11 +1860,6 @@ static const PropertyInfo prop_cboz_blksize = {
     .set_default_value = qdev_propinfo_set_default_value_uint,
 };
 
-Property riscv_cpu_options[] = {
-
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 988471c7ba..f06987687a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -774,7 +774,6 @@ extern const RISCVCPUMultiExtConfig riscv_cpu_extensions[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[];
-extern Property riscv_cpu_options[];
 
 typedef struct isa_ext_data {
     const char *name;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 137a8ab2bb..5800abc9c6 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1443,19 +1443,10 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
 static void kvm_cpu_instance_init(CPUState *cs)
 {
     Object *obj = OBJECT(RISCV_CPU(cs));
-    DeviceState *dev = DEVICE(obj);
 
     riscv_init_kvm_registers(obj);
 
     kvm_riscv_add_cpu_user_properties(obj);
-
-    for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
-        /* Check if we have a specific KVM handler for the option */
-        if (object_property_find(obj, prop->name)) {
-            continue;
-        }
-        qdev_property_add_static(dev, prop);
-    }
 }
 
 void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 84064ef7e0..d3eeedc758 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -889,10 +889,6 @@ static void riscv_cpu_add_user_properties(Object *obj)
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_experimental_exts);
 
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_deprecated_exts);
-
-    for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
-        qdev_property_add_static(DEVICE(obj), prop);
-    }
 }
 
 /*
-- 
2.43.0



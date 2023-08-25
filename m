Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5A7788826
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 15:12:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZWZm-00027Z-Rg; Fri, 25 Aug 2023 09:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZWZh-000263-6Q
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:10:05 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZWZe-00076D-QR
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:10:04 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1c504386370so577513fac.1
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 06:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692969001; x=1693573801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VuJMCp2LBSY6NnsD/ghs0+i3Nv5scvtnxYjJhkSRc9A=;
 b=L/EeK6kB7ifzk6kxkeDm2UswQNgoxpAemeSE5sIGgIHeUTTx1v+xthn19c7qjy/8ng
 8Ug7yOsJK1m4q3nP6JSvE91UNTFTL3sBFq2ANeOoNYPXStLFTOFm92y8UtmuqqRMvdcK
 2snllbFe0Py66f4xyBL4VDkBpCBAbxfBtvdBl4ttkYvSr/gs8VLxNk+eFGFrvVSejtgk
 CxY1apHxzyU6oOK4p+GW4TKZnsmuCrZfbRYdti+blyoAiD4ByF5TCeHa9zUtQ3BpMbOu
 xste/sK2/X3HO35Lk/FnyAr5YN9HhN02AVBI7m4lZIgTmtVdoPz9jwAqcdj99MEy6Dj8
 /rZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692969001; x=1693573801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VuJMCp2LBSY6NnsD/ghs0+i3Nv5scvtnxYjJhkSRc9A=;
 b=gVHfBSJ8mMN/C2wVOXNB6n3FRbVFhxlDDNxzWpJY4e1Y+weLsvZN2zGbzIfoOXRJlV
 KsU9n7Dt8vXwFIQtCXvWF7zXgVb4kgmYj35TKv8duTA2UkhC99sigGOpUpbc4FWaZjiW
 7sfFQV1Jp4HilVt67w7cI82h02b2LdTNfc2jCdIHFBHXB/sxKIWlW/UgDelqZ7YE+vmW
 2ZhmfPEe2291REHICMQTl1xuKwv5ObyNafokDOMV4/Pw6MaggrV5881zPxQH9jEjHdMa
 AG2klEr/Vvjckc/DlDetpt2B3Hc5JltzCEUXwLLomuuH+YdHLPO/brWCj8+FLTb3apyF
 WJgg==
X-Gm-Message-State: AOJu0YwkyTJd2yUi+xZm1ufjyOvtNoTTpcw8C4QtdJn/SDKLrUD1kSMM
 oYUxFb4wY9xFCfALK56rlySfdwRNxTWaOPif+VQ=
X-Google-Smtp-Source: AGHT+IGBVISzsAmCtW8XNQxdL8ousSNEHvxf0R1yeoh0cH3FrS7jGlVVDgCNoMVFKRcHZbjtsltQLg==
X-Received: by 2002:a05:6870:32d3:b0:1bb:a264:a7ba with SMTP id
 r19-20020a05687032d300b001bba264a7bamr2866476oac.56.1692969001005; 
 Fri, 25 Aug 2023 06:10:01 -0700 (PDT)
Received: from grind.. ([179.93.21.19]) by smtp.gmail.com with ESMTPSA id
 ds23-20020a0568705b1700b001c50fb56845sm966189oab.16.2023.08.25.06.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 06:10:00 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 20/20] target/riscv: add 'kvm_supported' class property
Date: Fri, 25 Aug 2023 10:08:53 -0300
Message-ID: <20230825130853.511782-21-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825130853.511782-1-dbarboza@ventanamicro.com>
References: <20230825130853.511782-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2e.google.com
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

This follows the same idea of 'tcg_support' property added in the
previous patch. Note that we're now implementing the 'cpu_realizefn' for
the KVMAccel class since this verification is done in realize() time.

Supporting vendor CPUs with KVM is not possible. We rely on the
extension support of the KVM module running in the host, making it
impossible to guarantee that a vendor CPU will have all the required
extensions available. The only way to guarantee that a vendor CPU is KVM
compatible is running KVM in a host that has the same vendor CPU, and
for this case we already have the 'host' CPU type.

We're better of declaring that all vendors CPUs are not KVM capable.
After this patch, running KVM accel with a vendor CPU will produce an
error like the following:

$ ./qemu-system-riscv64 -M virt,accel=kvm -cpu veyron-v1
qemu-system-riscv64: 'veyron-v1' CPU is not compatible with KVM acceleration

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu-qom.h     |  1 +
 target/riscv/cpu.c         |  1 +
 target/riscv/kvm/kvm-cpu.c | 24 ++++++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index e86b76f9fe..32d9bb07b4 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -72,5 +72,6 @@ struct RISCVCPUClass {
 
     bool user_extension_properties;
     bool tcg_supported;
+    bool kvm_supported;
 };
 #endif /* RISCV_CPU_QOM_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f749ea2a2e..73302bb72a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1646,6 +1646,7 @@ static void riscv_dynamic_cpu_class_init(ObjectClass *c, void *data)
 
     rcc->user_extension_properties = true;
     rcc->tcg_supported = true;
+    rcc->kvm_supported = true;
 }
 
 static void riscv_vendor_cpu_class_init(ObjectClass *c, void *data)
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 501384924b..85f3b8c80e 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1289,6 +1289,7 @@ static void riscv_kvm_cpu_class_init(ObjectClass *c, void *data)
     RISCVCPUClass *rcc = RISCV_CPU_CLASS(c);
 
     rcc->user_extension_properties = true;
+    rcc->kvm_supported = true;
 }
 
 static const TypeInfo riscv_kvm_cpu_type_infos[] = {
@@ -1302,6 +1303,28 @@ static const TypeInfo riscv_kvm_cpu_type_infos[] = {
 
 DEFINE_TYPES(riscv_kvm_cpu_type_infos)
 
+/*
+ * We'll get here via the following path:
+ *
+ * riscv_cpu_realize()
+ *   -> cpu_exec_realizefn()
+ *      -> kvm_cpu_realizefn() (via accel_cpu_realizefn())
+ */
+static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    RISCVCPUClass *rcc = RISCV_CPU_GET_CLASS(cpu);
+
+    if (!rcc->kvm_supported) {
+        g_autofree char *name = riscv_cpu_get_name(rcc);
+        error_setg(errp, "'%s' CPU is not compatible with KVM acceleration",
+                   name);
+        return false;
+    }
+
+    return true;
+}
+
 static void kvm_cpu_instance_init(CPUState *cs)
 {
     Object *obj = OBJECT(RISCV_CPU(cs));
@@ -1328,6 +1351,7 @@ static void kvm_cpu_accel_class_init(ObjectClass *oc, void *data)
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
     acc->cpu_instance_init = kvm_cpu_instance_init;
+    acc->cpu_realizefn = kvm_cpu_realizefn;
 }
 
 static const TypeInfo kvm_cpu_accel_type_info = {
-- 
2.41.0



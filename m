Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B909A81BDA9
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:54:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGNDo-0003B7-59; Thu, 21 Dec 2023 12:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGNDj-0002xx-Dw
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:52:31 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGNDd-00081I-EA
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:52:28 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6d97b7c8efdso440769b3a.0
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1703181144; x=1703785944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bgOCv5hvqNsl0wb4x/wspvOVZ58Wc7qh+1mml5TD4r0=;
 b=bq3FDnXVcuPqJT9RLRXWdYacUDcDoZCqxkl0ISgSwkn7b+wsCvEVTk7e230WKja8i6
 CtwgnoXstAmVYuimVgyst04flvKqSgnwj7gAE8SYwIrO3T8f/wyBqkG3AMtg2kRIt544
 dQkQpm7NM3DHff/kg0ZTKpHVAXJXznSnJQXdGhyRs1ZliGsDq+ygoW9hgYHxh4WwwDiq
 oFq/Rob1HRcqLIoGucQ5XREfr+Yb89X1RyLTRg7ce1SmgL/OTI+fD8fYogpE+nwEzkns
 ujpnsS7UTK2qjceUrIrnRZ9CdfxTu+SCphYofzrU2YbWImVe0PSCew8jIiZKp3im0clN
 H9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703181144; x=1703785944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bgOCv5hvqNsl0wb4x/wspvOVZ58Wc7qh+1mml5TD4r0=;
 b=LutaccGlhz03DUPcFCtcmeCDpfKa2TalLWnE6X6zY85Yvg77uc2CLnc6Es6x/1HXO2
 3h279NHn4EyWO3VWFMJ85/bvphU4JkWHz+CUL1hjXDnjGzIiSIjNx9H8ifjjJ2izV1/g
 AsTTi86RKFQgMBGVyYBU26ZN9iS5F5Lta/B5GknNYt18U/9IA/r5ilX3EYyQM/M7KACJ
 YroUofZKTTbEg1Veqtcsl0iKvWSrl4m0/VGmTkDXmBXyW2H3iHj1js80qAja7h+aG1AU
 kHkGbJvkc7CCA07b8c54EkdDTbFgTFa+e++ArOsAo6SdKYaUjYvkTwZVcZg/B+1kv1xI
 K3Pg==
X-Gm-Message-State: AOJu0YxvV0OlqTU/vXNOl3u/rUjuuAVsqVu/XjNM59PUD7NGvmL0ik+m
 Yv/y2MLC5pJYFIBErmI9tDMI3qr+AP7Yk1wb6GzOe/kRrN0t6A==
X-Google-Smtp-Source: AGHT+IEHMbAQyJDoNVQxZ/3bAW4FPcK8eGZAS/qtGUVwP+P4hQm8VC6vK+TO+il4OkRDjaEtosDSiw==
X-Received: by 2002:a05:6a20:3945:b0:194:c8f5:6040 with SMTP id
 r5-20020a056a20394500b00194c8f56040mr63509pzg.1.1703181143734; 
 Thu, 21 Dec 2023 09:52:23 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.205])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a63f50a000000b005b18c53d73csm1806261pgh.16.2023.12.21.09.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:52:23 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 13/16] target/riscv: remove riscv_cpu_options[]
Date: Thu, 21 Dec 2023 14:51:34 -0300
Message-ID: <20231221175137.497379-14-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221175137.497379-1-dbarboza@ventanamicro.com>
References: <20231221175137.497379-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
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

The array is empty and can be removed.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         | 5 -----
 target/riscv/cpu.h         | 1 -
 target/riscv/kvm/kvm-cpu.c | 9 ---------
 target/riscv/tcg/tcg-cpu.c | 4 ----
 4 files changed, 19 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d558f1f1e3..11afc45103 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1860,11 +1860,6 @@ const PropertyInfo prop_cboz_blksize = {
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



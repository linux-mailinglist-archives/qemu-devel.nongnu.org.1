Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC44D8295F3
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:11:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUS7-0000cH-Kh; Wed, 10 Jan 2024 04:00:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUS4-0000Q1-S5
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:44 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUS2-00055p-P7
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:44 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6d9cdd0a5e6so2018759b3a.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877241; x=1705482041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qrYI739WxkwcLq7V1+5AMpOlAwm7py90P+M9mgGxOJI=;
 b=JytcL/Bna02RbmUp1iXALOmpFDLdASudMvp4bF8qsKHiqRvuzre6djnFLRNRNJdx4C
 eNN+TlQeNYuARJzjjqWAKniTL4wfkIcCOdvEmThlJ0VNRtNL13poWSayOsiAhyBeNNvS
 AjLZCCiy50sa+3NWdNKtahY2u6yoGAvS6hJWD66fD+pDx4w12zrAxlt7STTDCB33FjjM
 X13OudCSNdp95ZOBTy99OIGpyGjGVjinDnjLVnpMmihQaSS79HiQUEMPKaPq6fmEGVrF
 c3HNqPSoR59J9lBGHmyzt0y+myS+vwnUVJ0QI0AIM9Hpiq6zJB/DE0IeTp8OQ31Qf2Ih
 0XbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877241; x=1705482041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qrYI739WxkwcLq7V1+5AMpOlAwm7py90P+M9mgGxOJI=;
 b=hsPSOwmxBOovVf57LaZSAWKAxZGcHoijW/7jdTsQG0Ey6vcCqlCD/57aj6G4uO91pN
 t0vd4RSrSnff54nt/mOTSdVDN0/q8ND00tI21GTn7gCECTOgRzmRxgaeuSbRZHV582c9
 /6srhM1RjwqVPqg8iBjuzeOLm7Y2CsxkvWnXlNUdjJib+03GLIs+84YgS/9P/vxrWoky
 wx3HuNgKQsWGi4/Ynnr6g3KvHkJi0PyVl4lRVCadGAUnTM31OjZWpVtso8+Z2m/DDPRu
 rXF02ixf17yetVmuE6xpRzUEwExcRy4llVdpaQhwqPcrAhLCnx5wSYNnBjpMagfxNrZe
 4gkg==
X-Gm-Message-State: AOJu0Yw+LJBauux/g//Pq0uyNgYMVZyVE1AFPoc9DZn0khM7jUVy7N7I
 tB0vpISAOBUHqMWrlEOaQO7xTjlCA/hSKgqY
X-Google-Smtp-Source: AGHT+IHIRiaUx2xNSzd+iIC6ek5JrRD+kmH2GbKpeeofKN0omMBnGUt4ObJr+J5Yq2iHGyzHcODC7Q==
X-Received: by 2002:a05:6a00:b34:b0:6d9:ecbc:14cd with SMTP id
 f52-20020a056a000b3400b006d9ecbc14cdmr592530pfu.0.1704877240754; 
 Wed, 10 Jan 2024 01:00:40 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:00:40 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 46/65] target/riscv: add 'rva22u64' CPU
Date: Wed, 10 Jan 2024 18:57:14 +1000
Message-ID: <20240110085733.1607526-47-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

This CPU was suggested by Alistair [1] and others during the profile
design discussions. It consists of the bare 'rv64i' CPU with rva22u64
enabled by default, like an alias of '-cpu rv64i,rva22u64=true'.

Users now have an even easier way of consuming this user-mode profile by
doing '-cpu rva22u64'. Extensions can be enabled/disabled at will on top
of it.

We can boot Linux with this "user-mode" CPU by doing:

-cpu rva22u64,sv39=true,s=true,zifencei=true

[1] https://lore.kernel.org/qemu-riscv/CAKmqyKP7xzZ9Sx=-Lbx2Ob0qCfB7Z+JO944FQ2TQ+49mqo0q_Q@mail.gmail.com/

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231218125334.37184-19-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-qom.h     |  1 +
 target/riscv/cpu.c         | 17 +++++++++++++++++
 target/riscv/tcg/tcg-cpu.c |  9 +++++++++
 3 files changed, 27 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 4d1aa54311..12fe78fc52 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -35,6 +35,7 @@
 #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
 #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x-rv128")
 #define TYPE_RISCV_CPU_RV64I            RISCV_CPU_TYPE_NAME("rv64i")
+#define TYPE_RISCV_CPU_RVA22U64         RISCV_CPU_TYPE_NAME("rva22u64")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 199b581380..cd3c22e92b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1575,6 +1575,15 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+#if defined(TARGET_RISCV64)
+static void rva22u64_profile_cpu_init(Object *obj)
+{
+    rv64i_bare_cpu_init(obj);
+
+    RVA22U64.enabled = true;
+}
+#endif
+
 static const gchar *riscv_gdb_arch_name(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
@@ -1836,6 +1845,13 @@ char *riscv_isa_string(RISCVCPU *cpu)
         .instance_init = initfn            \
     }
 
+#define DEFINE_PROFILE_CPU(type_name, initfn) \
+    {                                         \
+        .name = type_name,                    \
+        .parent = TYPE_RISCV_BARE_CPU,        \
+        .instance_init = initfn               \
+    }
+
 static const TypeInfo riscv_cpu_type_infos[] = {
     {
         .name = TYPE_RISCV_CPU,
@@ -1880,6 +1896,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,   rv64_veyron_v1_cpu_init),
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,  rv128_base_cpu_init),
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I, rv64i_bare_cpu_init),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64, rva22u64_profile_cpu_init),
 #endif
 };
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 6c9e2e9a28..f2a9558737 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1100,6 +1100,15 @@ static void riscv_cpu_add_profiles(Object *cpu_obj)
         object_property_add(cpu_obj, profile->name, "bool",
                             cpu_get_profile, cpu_set_profile,
                             NULL, (void *)profile);
+
+        /*
+         * CPUs might enable a profile right from the start.
+         * Enable its mandatory extensions right away in this
+         * case.
+         */
+        if (profile->enabled) {
+            object_property_set_bool(cpu_obj, profile->name, true, NULL);
+        }
     }
 }
 
-- 
2.43.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A332B7E03FE
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 14:50:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyuVx-00025J-Q0; Fri, 03 Nov 2023 09:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyuVp-0001zn-Hx
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 09:47:04 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyuVm-0000vP-8R
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 09:47:01 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5af5b532d8fso24371547b3.2
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 06:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699019216; x=1699624016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/25/w6VPciXl8XJUOxv9FKlLe00Mni1/bZBeQWxZNQk=;
 b=QMZHeKmsHKdxGXV81dATm6qDK+XRMjPLYaRe64rNbJxgXnmIjatEyVu7VhxejfpY68
 ibhuqOt6arqUjM0q5070RSjVvou9kT+7Ca1Abk+Ns3RorGHLeUUBcj3inpCRCfEY9MhD
 7l8wVK1O9/wqdvdivv9TsSYmJFXs2hmVUVDj3tfCoRUkBD4bqX5nQFDQXwNCTxchBhGd
 i0lVZbVDgwF07pNAB4RQa9uTbChDAhP4TM5HFepY7cTq+Zw1u6mb/BYqEeO9k+d9TGLW
 5AHgZABaiYI/9o4ET9au7v4vECETIzFvWHI2U11KrG3vmVpGueDQ63PMMpbb0JlLXCGr
 0tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699019216; x=1699624016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/25/w6VPciXl8XJUOxv9FKlLe00Mni1/bZBeQWxZNQk=;
 b=acqwi1ftGbqVG2TOOln2CvnrYVOBUNRltFfP8+oV1vioMWMBNs0eT4zdCp62J99zTA
 XPx6DjpKWL2t8eQfL1m+Jes5NiuM5odinaktf1D1UDCAvNhOMb0Y1TTzKuXTf5/8ffEY
 WGkjM41rKdqyhqq0B2de8slVHNorMMH5FzpaINYHQNRmP8Ftfo9XIkDrHDojhTB29ejn
 Bj1SOcvkRJw8prNbXaDB53fLQin1wqYGEbiohBXF90RRhZV929qO4vW4/r7h2EJHjsoh
 yJobtPBt8wXqjNtCP8l0WCT5uaH2TAwFMnCVfrhXfGYTf9tpH+rOxzC19YhziDRiCHo4
 CWBQ==
X-Gm-Message-State: AOJu0Yz161FlK8dJBb4BuyF8HFH5FgNTDK5FczWu6Wu5lE7omDGREC02
 M75QthuRyoBzNKTmXjgkI/aMZ8Ke2jCGaMhPNXo=
X-Google-Smtp-Source: AGHT+IGLw5/vQ/wj+UF6SYO+ePTg2/trCr2s5YGRUtKBZ3V6B7Zom4ZChtUKXZqLVOTqGE7Kpujx2A==
X-Received: by 2002:a0d:cb95:0:b0:5a1:d63f:5371 with SMTP id
 n143-20020a0dcb95000000b005a1d63f5371mr3010782ywd.20.1699019216467; 
 Fri, 03 Nov 2023 06:46:56 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 j68-20020a0df947000000b00582b239674esm935814ywf.129.2023.11.03.06.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 06:46:56 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v10 08/18] target/riscv: add rva22u64 profile definition
Date: Fri,  3 Nov 2023 10:46:19 -0300
Message-ID: <20231103134629.561732-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231103134629.561732-1-dbarboza@ventanamicro.com>
References: <20231103134629.561732-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1135.google.com
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

The rva22U64 profile, described in:

https://github.com/riscv/riscv-profiles/blob/main/profiles.adoc#rva22-profiles

Contains a set of CPU extensions aimed for 64-bit userspace
applications. Enabling this set to be enabled via a single user flag
makes it convenient to enable a predictable set of features for the CPU,
giving users more predicability when running/testing their workloads.

QEMU implements all possible extensions of this profile. All the so
called 'synthetic extensions' described in the profile that are cache
related are ignored/assumed enabled (Za64rs, Zic64b, Ziccif, Ziccrse,
Ziccamoa, Zicclsm) since we do not implement a cache model.

An abstraction called RISCVCPUProfile is created to store the profile.
'ext_offsets' contains mandatory extensions that QEMU supports. Same
thing with the 'misa_ext' mask. Optional extensions must be enabled
manually in the command line if desired.

The design here is to use the common target/riscv/cpu.c file to store
the profile declaration and export it to the accelerator files. Each
accelerator is then responsible to expose it (or not) to users and how
to enable the extensions.

Next patches will implement the profile for TCG and KVM.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 32 ++++++++++++++++++++++++++++++++
 target/riscv/cpu.h | 12 ++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4e3ee16a25..5b78b7496d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1487,6 +1487,38 @@ Property riscv_cpu_options[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+/*
+ * RVA22U64 defines some 'named features' or 'synthetic extensions'
+ * that are cache related: Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa
+ * and Zicclsm. We do not implement caching in QEMU so we'll consider
+ * all these named features as always enabled.
+ *
+ * There's no riscv,isa update for them (nor for zic64b, despite it
+ * having a cfg offset) at this moment.
+ */
+static RISCVCPUProfile RVA22U64 = {
+    .name = "rva22u64",
+    .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVU,
+    .ext_offsets = {
+        CPU_CFG_OFFSET(ext_zicsr), CPU_CFG_OFFSET(ext_zihintpause),
+        CPU_CFG_OFFSET(ext_zba), CPU_CFG_OFFSET(ext_zbb),
+        CPU_CFG_OFFSET(ext_zbs), CPU_CFG_OFFSET(ext_zfhmin),
+        CPU_CFG_OFFSET(ext_zkt), CPU_CFG_OFFSET(ext_zicntr),
+        CPU_CFG_OFFSET(ext_zihpm), CPU_CFG_OFFSET(ext_zicbom),
+        CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),
+
+        /* mandatory named features for this profile */
+        CPU_CFG_OFFSET(zic64b),
+
+        RISCV_PROFILE_EXT_LIST_END
+    }
+};
+
+RISCVCPUProfile *riscv_profiles[] = {
+    &RVA22U64,
+    NULL,
+};
+
 static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index bf12f34082..e4d5d69207 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -66,6 +66,18 @@ const char *riscv_get_misa_ext_description(uint32_t bit);
 
 #define CPU_CFG_OFFSET(_prop) offsetof(struct RISCVCPUConfig, _prop)
 
+typedef struct riscv_cpu_profile {
+    const char *name;
+    uint32_t misa_ext;
+    bool enabled;
+    bool user_set;
+    const int32_t ext_offsets[];
+} RISCVCPUProfile;
+
+#define RISCV_PROFILE_EXT_LIST_END -1
+
+extern RISCVCPUProfile *riscv_profiles[];
+
 /* Privileged specification version */
 enum {
     PRIV_VERSION_1_10_0 = 0,
-- 
2.41.0



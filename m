Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E747F66B9
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:54:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EoD-0008Nc-F3; Thu, 23 Nov 2023 13:52:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6Eo0-00086t-2D
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:52:07 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6Enw-0008K3-Kz
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:52:03 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc2575dfc7so8869605ad.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700765513; x=1701370313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbNxLYOyAxv1Zp/nW5Ak7yeVc804Q40HQaCIKzw/tb8=;
 b=nu7TJgkL4inl7j5JNLbjdafBt5NuvSbdik4fkGEcPAdVoZ7KloGCyoJCbkB+n0t8f5
 AJRMCL0UL6/16ZKwJYdiDkkGJnpitB+VzDgCfbOg2ytmwgLbN4/QCZlKMuoMdFiQ66PC
 ZkpH2R9vsj5DuQdW7ThesLZYigwD+IouWsn9jq7F4U6HMxcC9vqkvyc8vGyw9/Jot91p
 nsku9Opj/NmPIg1+Z35kgKchm1I+VWwvptrnKzBQRw57/mVDAm1n5Kc0Xiut+t0MvvDu
 94h46Qhsbk9iTrLV2xTn3bjr4e+cv1TZLqWeJeSJmDDlcPjBPzxLFvIV/4CwDvDqnmbS
 f7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700765513; x=1701370313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pbNxLYOyAxv1Zp/nW5Ak7yeVc804Q40HQaCIKzw/tb8=;
 b=BtoL4X7lSbk3rIkojdWVvb6VzUhwgqBEC1jjKWVqMcubDy9Gm87tYb8RKIx9a8SUCr
 4+mxlOrSu5JYEFlfyVNddaeti52r8uRXG/35uF7SNJ3UHGg5mExygPaZCLTX4LKTfgyL
 /GY9KwjGZu4Okgjp/TRgYwS7hUsGyrIUxrGN9lBlEFCzHNL9KRr+oVZq/EueVrpWMh2n
 +fiWZe3BMr4dXtxnh6xjYd2x0VRcQx6smaHUogKAVyFx35sUGJGblAdLIsXlvE3mdaEe
 pv/vP3NgUCwjdxPiAE21/joLR+ZOH5tZzsthpRdYtxP+tt/5y+T5CeeC3219CzO7I/kK
 BjNA==
X-Gm-Message-State: AOJu0YyjQkHA4fWw8kuszJj1HkBjIdxDqouISAtRy4UkIwZ9zUX+zkRr
 7DVAVlR29sFtr4Hsf0dAHgUFE1FkE6ldX0niLiU=
X-Google-Smtp-Source: AGHT+IHQWScj0z/CmcouKdVLsd19iq67aYSWNvj0WPPSEguAP64/gcFhYYhKdKF6tUG+i8IdMPGB/w==
X-Received: by 2002:a17:903:246:b0:1c5:d063:b70e with SMTP id
 j6-20020a170903024600b001c5d063b70emr283164plh.53.1700765513416; 
 Thu, 23 Nov 2023 10:51:53 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a17090282c400b001bb1f0605b2sm1662638plz.214.2023.11.23.10.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 10:51:53 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v11 08/18] target/riscv: add rva22u64 profile
 definition
Date: Thu, 23 Nov 2023 15:51:12 -0300
Message-ID: <20231123185122.1100436-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123185122.1100436-1-dbarboza@ventanamicro.com>
References: <20231123185122.1100436-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
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
index 8841052290..f2be40ae21 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1524,6 +1524,38 @@ Property riscv_cpu_options[] = {
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
index 5fb4ca2324..5ff629650d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -76,6 +76,18 @@ const char *riscv_get_misa_ext_description(uint32_t bit);
 
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



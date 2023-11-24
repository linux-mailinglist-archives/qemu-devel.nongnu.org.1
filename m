Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 882497F853A
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 21:27:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6cj1-0001xK-Sn; Fri, 24 Nov 2023 15:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6cj0-0001wg-12
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 15:24:30 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6ciy-0005I0-48
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 15:24:29 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6cbc8199a2aso1863218b3a.1
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 12:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700857466; x=1701462266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbNxLYOyAxv1Zp/nW5Ak7yeVc804Q40HQaCIKzw/tb8=;
 b=lxBYZo6e2sJkzpHmTbUACh9ayOcjAY1lSBmLwuTuGuw41Cp46PZojgzpgnKX+BlUXq
 nchmMbPRVA/Cz+PylcR9AtaiJncT+x30psNjQpJXdayCd1LeYTmBioYoGRAIGbtE77+M
 e1grEQs8KOt4otwHIcHJK6PeQ6y1ybKWVnj60i4vw4gG/O90p1NMsSLEzskQtF7dnlFn
 tmaecZf2CaA83oXevJ34hvy+3IlzNe8D8hnOPvVhd0qjMn0isWPyx12tPVigvIewKXsY
 f58xdAGexaAMVdXexfd5YhJAgRovxqr22x+1yfjuYkOpr19+2PfmykKnhy2N9n2Dkv0c
 4Q0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700857466; x=1701462266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pbNxLYOyAxv1Zp/nW5Ak7yeVc804Q40HQaCIKzw/tb8=;
 b=btkQySuP6GaVttsfTCmJ3oNWT5NsJkS+ojTnwWrO8WhG0/BqQ6GH6f8d9UuzvSPILr
 91CAdkqbvNnd4g3G7Z6hEbZOKzwXpylOgVBGVJ2edt8udYsQ1RWuHmYKxkCOPfEvYu10
 G3BhpsLbtVsQZEnrRFFF84fpJq+svy5BXG5ZPa+G9PDUL297ISpxsn+hFR13u4bRJbC3
 dmGFaAGW+F2NZHyXtz/tRWmMJdrANC+aDPi3zS5ii29xHkpXaJduHSJh8Gg64eHqk9gD
 aOY7zw9pjLIBmHpLHqCTXqV8iav6izLp4V53Pqspb+NJZWr/eEBLP5wOZBcIsb7sll5j
 8l/w==
X-Gm-Message-State: AOJu0Yw4JS68toVRLLqrqJYZUtInZdfdk/K2ksc7SVW1JXvMNbJDb7al
 2LXeWVWbHEqGqXjDwJ5cn7Kg1PZSduCtaSCWEW8=
X-Google-Smtp-Source: AGHT+IE7P6LEyIukOqCf+DBg4nT6J2vAcR7RRJm5MFLuRyGD8SdDO+uDSPuqRsJ6tGooWey0LZ0TAg==
X-Received: by 2002:a05:6a20:5484:b0:18b:e692:4314 with SMTP id
 i4-20020a056a20548400b0018be6924314mr4204544pzk.56.1700857466355; 
 Fri, 24 Nov 2023 12:24:26 -0800 (PST)
Received: from grind.. ([152.250.131.119]) by smtp.gmail.com with ESMTPSA id
 t24-20020a1709028c9800b001c59f23a3fesm3548267plo.251.2023.11.24.12.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 12:24:25 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v12 08/18] target/riscv: add rva22u64 profile
 definition
Date: Fri, 24 Nov 2023 17:23:43 -0300
Message-ID: <20231124202353.1187814-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231124202353.1187814-1-dbarboza@ventanamicro.com>
References: <20231124202353.1187814-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
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



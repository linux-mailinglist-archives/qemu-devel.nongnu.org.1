Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 475AC7D6DAD
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 15:51:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qveHG-0001PS-Gb; Wed, 25 Oct 2023 09:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qveH3-0001JC-4s
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:50:17 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qveH1-0002sy-AX
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:50:16 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ca052ec63bso49455035ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 06:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698241813; x=1698846613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QjI62DkoCXzlKV/RXE0N1msrqew6tlh6uNDxMViuZBE=;
 b=bNGsyRhu1kIoQl5r8pnVCYmHiIQ/4EcawdlnTdSsle7cZjHPVGhrNixOfyQ4ZRd4mJ
 +1hkgRB4jQJ5Be6M7mx7YrQ3Xr0nD2UZuq1vdF9KKZv1ZYQe6m+hIOTn2rAHyhVKoabU
 x34RmMGD4YkKNygkSdqKW/zjLPl+dekh25fWBRAPwBmkURy3P9GJfO9vrLwnMiYA/TAM
 E57cicoKSNSI9Bu77dD638VXYid/tqOKh0lZ3uOZHOT12KzqAY74wp/AC4E7vToDaw41
 wWTNYyYFeP7bzbHTzVSAEPiDKpEFieXQufZxJmbqdG7hdlxmPvTcOKMzVAI0bpEA/i6n
 r5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698241813; x=1698846613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QjI62DkoCXzlKV/RXE0N1msrqew6tlh6uNDxMViuZBE=;
 b=E52JbBRbCeVw1oEXCI5j/JQQQ5xkPzk1nR689UE6Ntx9HTQU7tZATqLiXqicpUulgB
 bRQy5OpWskN0i9ezeAI6lF4u9djovytpvf89G1iHwaAdzqXZ32FL7bX1QAu6izjQvDwp
 9lPUB6+192oyFvB539cD+f5hAIUqISOcw10aJYqR6RozpDVcgL2viyZkYdCc8LTbODDv
 CtrxQ3BDPqVgVrucZsYEOMy0PIHV0BvyldtCmzL43vTzGhnTT6P1AS+VKIM6abYivsxf
 uai68Ljg6Qolq3dDULiLKFB5WlGGImFhZJJVeyXzyJk44QkzUxER7Z8f2dltlSqoTleX
 6/vw==
X-Gm-Message-State: AOJu0YydTZj4o4+2e/rmbkYivTeFSsVd6Yp4rV3by2KwtBnwtKhP+3AF
 DFZQ6s7TCLh2EUg20lm/6aZC3/yD7KQ4K70ReGM=
X-Google-Smtp-Source: AGHT+IGxCqP11nlyoEyhUDlolpShmPJMP7dqa66MHap9t/EsTcCuCvzvW8LRn3sVuI4CUXNxZPC4Yg==
X-Received: by 2002:a17:903:2342:b0:1ca:e7f9:a49b with SMTP id
 c2-20020a170903234200b001cae7f9a49bmr11147045plh.23.1698241812938; 
 Wed, 25 Oct 2023 06:50:12 -0700 (PDT)
Received: from grind.. ([191.255.2.33]) by smtp.gmail.com with ESMTPSA id
 jw4-20020a170903278400b001ca485b8515sm9252548plb.91.2023.10.25.06.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 06:50:12 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 1/9] target/riscv: add rva22u64 profile definition
Date: Wed, 25 Oct 2023 10:49:53 -0300
Message-ID: <20231025135001.531224-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025135001.531224-1-dbarboza@ventanamicro.com>
References: <20231025135001.531224-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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

The rva22U64 profile, described in:

https://github.com/riscv/riscv-profiles/blob/main/profiles.adoc#rva22-profiles

Contains a set of CPU extensions aimed for 64-bit userspace
applications. Enabling this set to be enabled via a single user flag
makes it convenient to enable a predictable set of features for the CPU,
giving users more predicability when running/testing their workloads.

QEMU implements all possible extensions of this profile. The exception
is Zicbop (Cache-Block Prefetch Operations) that is not available since
QEMU RISC-V does not implement a cache model. For this same reason all
the so called 'synthetic extensions' described in the profile that are
cache related are ignored (Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa,
Zicclsm).

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
---
 target/riscv/cpu.c | 20 ++++++++++++++++++++
 target/riscv/cpu.h | 12 ++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f40da4c661..c9e263cbac 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1429,6 +1429,26 @@ Property riscv_cpu_options[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+/* Optional extensions left out: RVV, zfh, zkn, zks */
+static RISCVCPUProfile RVA22U64 = {
+    .name = "rva22u64",
+    .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC,
+    .ext_offsets = {
+        CPU_CFG_OFFSET(ext_zicsr), CPU_CFG_OFFSET(ext_zihintpause),
+        CPU_CFG_OFFSET(ext_zba), CPU_CFG_OFFSET(ext_zbb),
+        CPU_CFG_OFFSET(ext_zbs), CPU_CFG_OFFSET(ext_zfhmin),
+        CPU_CFG_OFFSET(ext_zkt), CPU_CFG_OFFSET(ext_zicntr),
+        CPU_CFG_OFFSET(ext_zihpm), CPU_CFG_OFFSET(ext_zicbom),
+        CPU_CFG_OFFSET(ext_zicboz),
+
+        RISCV_PROFILE_EXT_LIST_END
+    }
+};
+
+RISCVCPUProfile *riscv_profiles[] = {
+    &RVA22U64, NULL,
+};
+
 static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8efc4d83ec..34277eaa0b 100644
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



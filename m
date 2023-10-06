Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B04DA7BB8F2
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 15:23:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qokmQ-00061O-K7; Fri, 06 Oct 2023 09:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qokm9-0005tU-I4
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 09:21:56 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qokm7-00038q-Kf
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 09:21:53 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-578e33b6fb7so1476102a12.3
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 06:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1696598510; x=1697203310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvFPTIiAXaXHOXezY7X5+ACmqmm2s3KN/IMfdAwxSwI=;
 b=M1M+ER2h79xQu/lLD/h47uDVpAnifngOeK6ouDYw4sDW5oB7kxhnzo+u9y9hnVy/XD
 MCYxrCJaMFO+Du4lsncNS3MtQvJxwYem+xxsdT2j/hkZgMVEylT/zbmEmjZxkVnqA3k5
 KBaQ7bkEc6a9edPgv+qyjxPs6F1Iwk2SLFnSNyCMTRbafwvN/FNfUQfOfhQ7dW9/h1ar
 /dLxuhLWp+pe1rEwMg8pTmdE+yRIi6tTvRNXFTGlp3SjrkeAcYBgtr/C+N5/g7v0TrTb
 FFt8a7QIkYjGwqrEroHudmiKDlxHV4F30yAcM9LM6IR69KbaO2uPOa0gwX9RQgS3ksX3
 43bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696598510; x=1697203310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rvFPTIiAXaXHOXezY7X5+ACmqmm2s3KN/IMfdAwxSwI=;
 b=lnlh+yCeFKpbhRnSGfIMOh++J2moMaUoJyjKF1WQyH2mkIrlrK0qpBKM3HlKYXkmij
 O2odqUaTP5SXhR33qC7ezvxw0tQig0Cm6d3Wy65amCR/7GKyKGASSaBvdYSL503MwHEK
 HCi99jS4JPYcp03hOz0Vjo02nmra8Fy1vAMnpP52fvbYSMc2BCTvGb16v8BxVEFtUmSH
 y+Uh5GXCe+qeXrqvZe8fPdzw8BDhTADE90Fr0vqK20ba1I8vL+QUVxy/uONzTW4WQ14H
 CpU5qCYmdTRlU/KE6+1Lj+gZ3Z5wCJyIHjTbhV/+s/9nqgqs37OjkdP5B7sveztxCoLn
 6/0w==
X-Gm-Message-State: AOJu0YzNsTEcM7mfstZPNKaJlh/oKnTv2D9kV+jXkz/08hm6Sh1/G/Ui
 oli8zmgIY6+un2TVci9jIloxZGFTa61al5OAo+Y=
X-Google-Smtp-Source: AGHT+IGuSdAB8YsPPrxavCT2IzRuDtsih4P0NRvM4LngbRB7DO18RYhXDuJtAsYhO38qF31XubTIJw==
X-Received: by 2002:a05:6a21:a5aa:b0:15d:fc71:1b9e with SMTP id
 gd42-20020a056a21a5aa00b0015dfc711b9emr10932126pzc.49.1696598509884; 
 Fri, 06 Oct 2023 06:21:49 -0700 (PDT)
Received: from grind.. ([177.94.42.196]) by smtp.gmail.com with ESMTPSA id
 c12-20020a170902c1cc00b001c60a548331sm3796669plc.304.2023.10.06.06.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 06:21:49 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 03/10] target/riscv: add rva22u64 profile definition
Date: Fri,  6 Oct 2023 10:21:27 -0300
Message-ID: <20231006132134.1135297-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006132134.1135297-1-dbarboza@ventanamicro.com>
References: <20231006132134.1135297-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
---
 target/riscv/cpu.c | 20 ++++++++++++++++++++
 target/riscv/cpu.h | 12 ++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b3befccf89..a439ff57a4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1376,6 +1376,26 @@ Property riscv_cpu_options[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+/* Optional extensions left out: RVV, zfh, zkn, zks */
+static RISCVCPUProfile RVA22U64 = {
+    .name = "rva22u64",
+    .misa_ext = RVM | RVA | RVF | RVD | RVC,
+    .ext_offsets = {
+        CPU_CFG_OFFSET(ext_icsr), CPU_CFG_OFFSET(ext_zihintpause),
+        CPU_CFG_OFFSET(ext_zba), CPU_CFG_OFFSET(ext_zbb),
+        CPU_CFG_OFFSET(ext_zbs), CPU_CFG_OFFSET(ext_zfhmin),
+        CPU_CFG_OFFSET(ext_zkt), CPU_CFG_OFFSET(ext_icntr),
+        CPU_CFG_OFFSET(ext_ihpm), CPU_CFG_OFFSET(ext_icbom),
+        CPU_CFG_OFFSET(ext_icboz),
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
index 3f11e69223..216bbbe7cd 100644
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



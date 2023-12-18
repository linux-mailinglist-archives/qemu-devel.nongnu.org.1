Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A24816ED3
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 13:55:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFD8R-0002hR-GE; Mon, 18 Dec 2023 07:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD8Q-0002fx-51
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:54:14 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD8O-0004sg-4R
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:54:13 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d3470496e2so26465425ad.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 04:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702904050; x=1703508850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2bGo1sVGElE8H+a2siy0iaGzyoRqnmbF0pF/gXGHfis=;
 b=WXLMoo9us1mE2CcHQIMnE8URETjbCdymKQCPRjzntJcFHdssf150CqOuW6gIUwqMRZ
 EqRTa6jti+E9nXEmt7gDXhcQAeETRM/exd9HDtfDEVPoqIy6icokhWtXa6kz7JD2ARyF
 6OpmO2tbfrhJYAuh9tKk9KWetSOUkuEdAWqDE/6YbqR5r0YSeY67p7nIBlnkcUhBClYY
 9fnHaMggua4I58UmPJi1nyuNXQsnoNGas7yDtjt89j/5ko/tRmJ+zHeg1Q7ILSYxextT
 AgIiLCJYyb6sLR1nZCnTiW/ItgAETqBvL1izoSUfcwhm0WRh8nt4zbIWx+V2QcGrgY3c
 AUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702904050; x=1703508850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2bGo1sVGElE8H+a2siy0iaGzyoRqnmbF0pF/gXGHfis=;
 b=MY5KwiP4UFupudfQb4ZD5rWFwETWncoqhAy/tvq7hxB4c+kCzMbRXvFQQF8FaOfy3A
 YIclk3hOjkCWsU+YCXxyiRjG0DhPxWXslvLK3mSfCDYiRJhvcEUIGsXDz2zx1eNzj6Th
 XB7bPMywEj6AQSclUgLx/vIdoImgsH0b+K3riTA17eO6MDEyYtnnCPaRQMscGMiJT0Mq
 Pl3ey+HPtCAq733DBtUoMb8u0rv0fmI6fbeOq2zQVaaHgNf26focISLlPThQ/FYFwJXv
 1+0bw120pLx3hW52Ugn5PoEPn0ucizZez9KYRWa+X7Y1smjMuXhkW3FHUNKttfsl/5+9
 2LEw==
X-Gm-Message-State: AOJu0Yxg1Fki2COBQn/N824mOx+O95xfB25totbPF4B2aNNjotLHo4kC
 I8cgi17P4iohtuc9BIlPFFSNpfKXAcby2Ui6JLQ=
X-Google-Smtp-Source: AGHT+IHXgSXcbyT6XoRZEUbBjDrFJf82pCLdRTM/89b1LxPgX4p2IauZng77dKK0W0ENhWg1a78LUQ==
X-Received: by 2002:a17:903:2793:b0:1d3:92db:24fa with SMTP id
 jw19-20020a170903279300b001d392db24famr5086910plb.1.1702904050559; 
 Mon, 18 Dec 2023 04:54:10 -0800 (PST)
Received: from grind.. ([179.93.21.205]) by smtp.gmail.com with ESMTPSA id
 c2-20020a170902848200b001d09c539c96sm7494897plo.229.2023.12.18.04.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 04:54:10 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v13 08/26] target/riscv: add rva22u64 profile definition
Date: Mon, 18 Dec 2023 09:53:16 -0300
Message-ID: <20231218125334.37184-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218125334.37184-1-dbarboza@ventanamicro.com>
References: <20231218125334.37184-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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
index b2e539f807..b9057c8da2 100644
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
2.43.0



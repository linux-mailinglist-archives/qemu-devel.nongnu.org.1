Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CFE7F6706
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 20:17:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6FB2-0008Ss-RQ; Thu, 23 Nov 2023 14:15:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6FAz-0008LY-0c
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 14:15:49 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6FAx-0003kG-11
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 14:15:48 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc2575dfc7so9013785ad.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 11:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700766944; x=1701371744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ulovx9Gb5ru7ZFkz+gHPuuib2emkH4We+Ds4Yk+nbEs=;
 b=NLceFD8ph1rBGcvOSFFgFYOk1cy+JQdqWEWp7PujR+muc6maxMlnQWF4Gqz0EEIIny
 B4lmcRG+X18FfrrnhYk5IEdOu1d6oJT/Y3G8r+JBPXZZFTLzDFDoUPagDlFpMbYRwb+y
 Ztou7qrlz+BxggDQgfqev+sYgPy3M9FyaNzrI9SBshHYen5pD+Q0Lzl3uXpQ99Hfp7Ky
 UIcz2p2F4+qmnjMHF9vkd9WOfEWWl5mMNaDBqLyENubz41J4XiJoDpPdUkc0w3RgmMa3
 ZA4BtP0Xu1OFkGOX+jSwblZH3tLiJpyWgfDFfKlhiZ5fBCAUUAOm+WOkwJixV+RsMHVc
 JUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700766944; x=1701371744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ulovx9Gb5ru7ZFkz+gHPuuib2emkH4We+Ds4Yk+nbEs=;
 b=DaT+ox99yp1nOXEuOwoDdtLmPA2OfYTggVrZr4glGJru29SXvNDIAeCqXL1CZB83Do
 48Qa7volNJ6/3zsa+cn1gBG3l/7q10AFu0OhUU4xeUcD6hoOAwohMU7c1v+ENI04cFsL
 xPWJQkJT437hX+GJjayPnR9KUvQX3VJIcVPSdlJS2tNP9n80UV/j8wmTKDnmXV8ORfBh
 3mUbzLqYBwgY1XFoX4Kr0qhkT+me83uW0b3Tfaqt324Y4LlwFBR6B+3FYnsHi9GSrOIR
 ZcwWkEPniRnSHJAjDDAupou89JGTozf/sKf3ZOg8r7E7nq5GDBVgK9qIpLJyXvKuWcVX
 r04Q==
X-Gm-Message-State: AOJu0YxbzJNJHH3/i0nK1FeQqhHWQ6OlzeuovvYkNI43hessyZSogTH/
 Ibu0J74xKfe/hcqQBwQ6hHck4glBIrCdyjiO0uA=
X-Google-Smtp-Source: AGHT+IHD0oDq70RTenfG1UkGNIV1uTD4hNApISIuR+xRkY9vwUj0JTRjVoYel0L0jiZGetPBQwmtQA==
X-Received: by 2002:a17:902:ea84:b0:1cf:65e1:b754 with SMTP id
 x4-20020a170902ea8400b001cf65e1b754mr423361plb.16.1700766944621; 
 Thu, 23 Nov 2023 11:15:44 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902eed500b001bc21222e34sm1680760plb.285.2023.11.23.11.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 11:15:44 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 2/7] target/riscv: add priv ver restriction to profiles
Date: Thu, 23 Nov 2023 16:15:27 -0300
Message-ID: <20231123191532.1101644-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123191532.1101644-1-dbarboza@ventanamicro.com>
References: <20231123191532.1101644-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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

Some profiles, like RVA22S64, has a priv_spec requirement.

Make this requirement explicit for all profiles. We'll validate this
requirement finalize() time and, in case the user chooses an
incompatible priv_spec while activating a profile, a warning will be
shown.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         |  1 +
 target/riscv/cpu.h         |  2 ++
 target/riscv/tcg/tcg-cpu.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 59b131c1fc..29a9f77702 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1537,6 +1537,7 @@ Property riscv_cpu_options[] = {
 static RISCVCPUProfile RVA22U64 = {
     .name = "rva22u64",
     .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVU,
+    .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
     .ext_offsets = {
         CPU_CFG_OFFSET(ext_zicsr), CPU_CFG_OFFSET(ext_zihintpause),
         CPU_CFG_OFFSET(ext_zba), CPU_CFG_OFFSET(ext_zbb),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5ff629650d..1f34eda1e4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -81,10 +81,12 @@ typedef struct riscv_cpu_profile {
     uint32_t misa_ext;
     bool enabled;
     bool user_set;
+    int priv_spec;
     const int32_t ext_offsets[];
 } RISCVCPUProfile;
 
 #define RISCV_PROFILE_EXT_LIST_END -1
+#define RISCV_PROFILE_ATTR_UNUSED -1
 
 extern RISCVCPUProfile *riscv_profiles[];
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ddf37b25f3..a26cc6f093 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -74,6 +74,20 @@ static void riscv_cpu_write_misa_bit(RISCVCPU *cpu, uint32_t bit,
     }
 }
 
+static const char *cpu_priv_ver_to_str(int priv_ver)
+{
+    switch (priv_ver) {
+    case PRIV_VERSION_1_10_0:
+        return "v1.10.0";
+    case PRIV_VERSION_1_11_0:
+        return "v1.11.0";
+    case PRIV_VERSION_1_12_0:
+        return "v1.12.0";
+    }
+
+    g_assert_not_reached();
+}
+
 static void riscv_cpu_synchronize_from_tb(CPUState *cs,
                                           const TranslationBlock *tb)
 {
@@ -764,11 +778,23 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
 static void riscv_cpu_validate_profile(RISCVCPU *cpu,
                                        RISCVCPUProfile *profile)
 {
+    CPURISCVState *env = &cpu->env;
     const char *warn_msg = "Profile %s mandates disabled extension %s";
     bool send_warn = profile->user_set && profile->enabled;
     bool profile_impl = true;
     int i;
 
+    if (profile->priv_spec != env->priv_ver) {
+        profile_impl = false;
+
+        if (send_warn) {
+            warn_report("Profile %s requires priv spec %s, "
+                        "but priv ver %s was set", profile->name,
+                        cpu_priv_ver_to_str(profile->priv_spec),
+                        cpu_priv_ver_to_str(env->priv_ver));
+        }
+    }
+
     for (i = 0; misa_bits[i] != 0; i++) {
         uint32_t bit = misa_bits[i];
 
@@ -1057,6 +1083,10 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
     profile->user_set = true;
     profile->enabled = value;
 
+    if (profile->enabled) {
+        cpu->env.priv_ver = profile->priv_spec;
+    }
+
     for (i = 0; misa_bits[i] != 0; i++) {
         uint32_t bit = misa_bits[i];
 
-- 
2.41.0



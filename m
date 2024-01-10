Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A86A082959A
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:03:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUSG-0001EI-2g; Wed, 10 Jan 2024 04:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSD-00011b-2c
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:54 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSA-00058y-FA
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:52 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6dde00025faso1220486a34.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877249; x=1705482049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zCII+an7GMHvfVyLgwi1oq/aKYZLFvT9aRNZVAATGeY=;
 b=IsKQJbPEWrD0AySpplQZbSSCAKq0UVIUOvpEt3Oj44OXeNZFjp2VbyUObtjGcuyqNY
 g4zCwMGyFD1lgjnHZKc7Bzps2FMWpkalGp7KUmp8jF77oggdOAqwMd25YmBcGV/2hhCk
 Ze9oWZqI8MLfsmvRJDonlC0vdechK7GMDfCy4iwUe9c+uAvs4TlpsnfCFnBz7m5pyTqs
 P5tg+P4cqrqNoQ7Je6ZOWWNSFh/cpzuXPH6s55k8xYVtai1Z3md1KpV4HBIn/JhdgAoD
 Wzg7PBBAKmgC2xwvXkppUCMgc8l1TNQM4tNr2ZhF0pk+tKZBds4IhtgaJXdRzIIGeD3N
 l4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877249; x=1705482049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zCII+an7GMHvfVyLgwi1oq/aKYZLFvT9aRNZVAATGeY=;
 b=C4f7hIGQjDHyZCtZ7vlTSH6q5z2H40767Z0JHEvesymE4QInszAp0hKfrAhB7cQ7/8
 wnjJwj+2X9QYVP97ugGzYu5K2uQ2Dvsj+9WmYAbsVPxygeI56cPvrKJP5/oIkxSPugNa
 4hl7zM71ROYNFpZz7E/ltjAf7XmGWDUXvibfzWpbKQoFlHL1xNDqMixeE3swdDhY6HR3
 dGvtKUzvB6HSCv698FgLClCA5rtc5JdNiSEeP1OoyPGcLI14Mc/uzgCS8nXXHWOgnS8D
 Ej6tBZK9ZB2XDsGPMSxkQJDN9FpqtgrMN55MdGjokzv2OZugqGGaeSBE197I0m5zuWDe
 sApQ==
X-Gm-Message-State: AOJu0YzitVUu2tEEDHXpzFkvmLr+5iseXZM6S2p6ZbKDxxSo1lGhdv24
 G5j7ebzftA9BoRJpo/L1NAh9u+xv8nEL+Ia5
X-Google-Smtp-Source: AGHT+IEZOejcCAwWqjO4JY6MU1R2DqZAQDm8GA3bmyIGtdqoyO+OGQmniC9++grFuFCf+jhHYvq0lQ==
X-Received: by 2002:a05:6359:5c20:b0:172:ca65:1d with SMTP id
 pu32-20020a0563595c2000b00172ca65001dmr488490rwb.18.1704877248463; 
 Wed, 10 Jan 2024 01:00:48 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:00:47 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 48/65] target/riscv: add priv ver restriction to profiles
Date: Wed, 10 Jan 2024 18:57:16 +1000
Message-ID: <20240110085733.1607526-49-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x32f.google.com
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

Some profiles, like RVA22S64, has a priv_spec requirement.

Make this requirement explicit for all profiles. We'll validate this
requirement finalize() time and, in case the user chooses an
incompatible priv_spec while activating a profile, a warning will be
shown.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231218125334.37184-21-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  2 ++
 target/riscv/cpu.c         |  1 +
 target/riscv/tcg/tcg-cpu.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5af1666dc0..3d1c347b71 100644
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
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0ec0d89070..563fd4f722 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1536,6 +1536,7 @@ Property riscv_cpu_options[] = {
 static RISCVCPUProfile RVA22U64 = {
     .name = "rva22u64",
     .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVU,
+    .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
     .ext_offsets = {
         CPU_CFG_OFFSET(ext_zicsr), CPU_CFG_OFFSET(ext_zihintpause),
         CPU_CFG_OFFSET(ext_zba), CPU_CFG_OFFSET(ext_zbb),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index e90d929ac1..41eef87e6e 100644
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
@@ -760,11 +774,24 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
 static void riscv_cpu_validate_profile(RISCVCPU *cpu,
                                        RISCVCPUProfile *profile)
 {
+    CPURISCVState *env = &cpu->env;
     const char *warn_msg = "Profile %s mandates disabled extension %s";
     bool send_warn = profile->user_set && profile->enabled;
     bool profile_impl = true;
     int i;
 
+    if (profile->priv_spec != RISCV_PROFILE_ATTR_UNUSED &&
+        profile->priv_spec != env->priv_ver) {
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
 
@@ -1053,6 +1080,10 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
     profile->user_set = true;
     profile->enabled = value;
 
+    if (profile->enabled) {
+        cpu->env.priv_ver = profile->priv_spec;
+    }
+
     for (i = 0; misa_bits[i] != 0; i++) {
         uint32_t bit = misa_bits[i];
 
-- 
2.43.0



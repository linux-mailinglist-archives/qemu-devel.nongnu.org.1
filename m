Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED717F66A7
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:52:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EoJ-0000Oz-TB; Thu, 23 Nov 2023 13:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6EoI-0000LF-5o
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:52:22 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6EoG-0000Ed-E2
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:52:21 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5bcfc508d14so803897a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700765538; x=1701370338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9L//mA22tIuhmtNLXxG7ubOHdo04CcrNlgyms3DZLTw=;
 b=Kojnt0CgCfNPMuXK+vS6tEDJDOGQz7VqP1TKHMyJBzOJT1vaXKqTA0RCe7uCXsc3Yb
 dMYkjGTb4r85070kkQMqwBtGBbu7dooddF7btPrpzASMdmlekUi1RyrOCNRegN2eJAzH
 GOUn8E44V4bhE1ySe+evINO+PtFgjA0BDaKiiUggfzS0B13u5p5vrOOte0T1TfttrWsq
 CCMoy3IJzfwsZjYFeZzV804a2aSZyXwXPdqaJt3wRLYHo2GkjkfjdTHzKA4EenXFKZ1c
 1B02TCIdbFagFaTrDTcVto0oTxLHTT3vFcDFy8/t9aku7Z0fcDNCBssgf3ZpjqsUsf57
 nJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700765538; x=1701370338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9L//mA22tIuhmtNLXxG7ubOHdo04CcrNlgyms3DZLTw=;
 b=cgCj6+MJDdXLPTppMVYHea+fFzFU1Q873ojvwu/KenoyevXwGqPCtfTO8e8cmPAzuK
 8nwNeyIrc9pYbgwCuhjJYr5FwKXPAKFGfs776f5HDXrDLqrg9aoNnnaqrnSWVEuqjOZU
 WRBAfmx4hFa39iUfjvqmAy7+V9ZO38YN7AKrvUehkohTCCbsx/PJ6Myz0KMkFYBvjJNx
 bxv9XQfAvBwqvBA508maM/CXJOgYXJQdqACEQjeriIalJHW3sUW0VhB92/amQ6iFjRtd
 53XucuJRtAA8bLQ2ACLjXj3qXTupgGUPPKE8NcZfcZ34TS0iAgdzJ3/0VS25qUDjJIeo
 erWQ==
X-Gm-Message-State: AOJu0YyET1rJMtC8RnMnKHd4q88PYthIwEx3x1q5sxzfURjS+qZKFicr
 RB0YTCO4/NfNaF4bIPnJhU4nYNv6ewezJrI1xX4=
X-Google-Smtp-Source: AGHT+IHoQ9JmgbeXSsbtC5/9Qfn5xoWcFjc6Fa18UX9leZEif9AXOTWN/WvCfCYePXqkdc9PXmj0+g==
X-Received: by 2002:a05:6a20:d388:b0:187:fe09:272a with SMTP id
 iq8-20020a056a20d38800b00187fe09272amr622527pzb.49.1700765538263; 
 Thu, 23 Nov 2023 10:52:18 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a17090282c400b001bb1f0605b2sm1662638plz.214.2023.11.23.10.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 10:52:17 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v11 16/18] target/riscv/tcg: validate profiles during
 finalize
Date: Thu, 23 Nov 2023 15:51:20 -0300
Message-ID: <20231123185122.1100436-17-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123185122.1100436-1-dbarboza@ventanamicro.com>
References: <20231123185122.1100436-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x531.google.com
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

Enabling a profile and then disabling some of its mandatory extensions
is a valid use. It can be useful for debugging and testing. But the
common expected use of enabling a profile is to enable all its mandatory
extensions.

Add an user warning when mandatory extensions from an enabled profile
are disabled in the command line. We're also going to disable the
profile flag in this case since the profile must include all the
mandatory extensions. This flag can be exposed by QMP to indicate the
actual profile state after the CPU is realized.

After this patch, this will throw warnings:

-cpu rv64,rva22u64=true,zihintpause=false,zicbom=false,zicboz=false

qemu-system-riscv64: warning: Profile rva22u64 mandates disabled extension zihintpause
qemu-system-riscv64: warning: Profile rva22u64 mandates disabled extension zicbom
qemu-system-riscv64: warning: Profile rva22u64 mandates disabled extension zicboz

Note that the following will NOT throw warnings because the profile is
being enabled last, hence all its mandatory extensions will be enabled:

-cpu rv64,zihintpause=false,zicbom=false,zicboz=false,rva22u64=true

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 69 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b3bba7887e..6c1e54f540 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -147,6 +147,26 @@ static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
     g_assert_not_reached();
 }
 
+static const char *cpu_cfg_ext_get_name(uint32_t ext_offset)
+{
+    const RISCVCPUMultiExtConfig *feat;
+    const RISCVIsaExtData *edata;
+
+    for (edata = isa_edata_arr; edata->name != NULL; edata++) {
+        if (edata->ext_enable_offset == ext_offset) {
+            return edata->name;
+        }
+    }
+
+    for (feat = riscv_cpu_named_features; feat->name != NULL; feat++) {
+        if (feat->offset == ext_offset) {
+            return feat->name;
+        }
+    }
+
+    g_assert_not_reached();
+}
+
 static bool cpu_cfg_offset_is_named_feat(uint32_t ext_offset)
 {
     const RISCVCPUMultiExtConfig *feat;
@@ -732,6 +752,54 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     riscv_cpu_disable_priv_spec_isa_exts(cpu);
 }
 
+static void riscv_cpu_validate_profile(RISCVCPU *cpu,
+                                       RISCVCPUProfile *profile)
+{
+    const char *warn_msg = "Profile %s mandates disabled extension %s";
+    bool send_warn = profile->user_set && profile->enabled;
+    bool profile_impl = true;
+    int i;
+
+    for (i = 0; misa_bits[i] != 0; i++) {
+        uint32_t bit = misa_bits[i];
+
+        if (!(profile->misa_ext & bit)) {
+            continue;
+        }
+
+        if (!riscv_has_ext(&cpu->env, bit)) {
+            profile_impl = false;
+
+            if (send_warn) {
+                warn_report(warn_msg, profile->name,
+                            riscv_get_misa_ext_name(bit));
+            }
+        }
+    }
+
+    for (i = 0; profile->ext_offsets[i] != RISCV_PROFILE_EXT_LIST_END; i++) {
+        int ext_offset = profile->ext_offsets[i];
+
+        if (!isa_ext_is_enabled(cpu, ext_offset)) {
+            profile_impl = false;
+
+            if (send_warn) {
+                warn_report(warn_msg, profile->name,
+                            cpu_cfg_ext_get_name(ext_offset));
+            }
+        }
+    }
+
+    profile->enabled = profile_impl;
+}
+
+static void riscv_cpu_validate_profiles(RISCVCPU *cpu)
+{
+    for (int i = 0; riscv_profiles[i] != NULL; i++) {
+        riscv_cpu_validate_profile(cpu, riscv_profiles[i]);
+    }
+}
+
 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 {
     CPURISCVState *env = &cpu->env;
@@ -750,6 +818,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     }
 
     riscv_cpu_validate_named_features(cpu);
+    riscv_cpu_validate_profiles(cpu);
 
     if (cpu->cfg.ext_smepmp && !cpu->cfg.pmp) {
         /*
-- 
2.41.0



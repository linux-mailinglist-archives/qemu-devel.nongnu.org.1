Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C907F9EC9
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 12:39:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7ZwR-0003vQ-V8; Mon, 27 Nov 2023 06:38:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r7ZwP-0003uZ-Kq
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 06:38:17 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r7ZwN-0005NB-Sv
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 06:38:17 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6cb66fbc63dso2801585b3a.0
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 03:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1701085094; x=1701689894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Pb1Caogol+24prXi47Ua7g4M4/tgt8iGoHokMfLRK4=;
 b=ozbjjnxJnL90LRMWazZvrT9Io7HLiA/PEvXkeej4ObPyeu5oABJeUYJdhLNmOdrPkq
 mk/tPY1DMYY+f3+TUX8AW1J6OMQByJvwWMvjjkMS4DMhfW5XcQ67DyDhH6iFVpVXDMqZ
 e1L+IiLq4+biKOg+QnIG0PsTy+jnoake+SUnAmzvuj+My149m2RD3sgyMtZaGxL/IYJL
 pnRvGKQAXTfTb/QUKErf4vs/2xqCASwQPM1PBzIXvkUbkXPM920K5M3Y0CZi9TEY8y2x
 tYtjTfRfxP7pu2ZWqNqOQh8knOth59BFagkOMPrLmaenOccAVW70xpIFoyEFAt3+lteq
 2nSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701085094; x=1701689894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Pb1Caogol+24prXi47Ua7g4M4/tgt8iGoHokMfLRK4=;
 b=KTq6izTuFjL5wE2XSslbLLEFKOBerSE029tICuEw4+lBK/NMl+X8IZF8RyybzDnmVM
 mp3KOh3k/5MN1XIcA++7Ngs0AckOdNhwPui29yZKR+4uNlJOA0/eBPE68wyQmW9gB4iL
 ToIIP60W17X9rv0z1b3fdWuPYrTFmF2j9C01q0Eu3s27cCM/6NfZhBDGx5yHWZrurrZ4
 4BLckNTxL00SYpfXiWlweTBMXMLNAv/4Bmcq0rmfVtMnnp4fSyZcIipRXA6o11bQ62lE
 2541HzKU/zpH+Eo8XYw++PfM6dcD/eT7KqJJ7qiUbbKWOMytUhk3kYfnmjESMDLAKBFx
 ktSA==
X-Gm-Message-State: AOJu0Yx/o2+J/ex33j7UAbQ9EnLwMg0Jw1lrn1AgQ6eObjsC6afhOn+a
 yOujNQJpgpaPzXquIWsV2jtKj01usmxY1gZPcTs=
X-Google-Smtp-Source: AGHT+IEXnuods7P5hG44eRu2clPUOdegcXXHHRcdn24r7dVT80PpFpIUy+EvmGPf//6JljbZ3JTs6w==
X-Received: by 2002:a05:6a20:748d:b0:18b:594a:284c with SMTP id
 p13-20020a056a20748d00b0018b594a284cmr19542435pzd.15.1701085093736; 
 Mon, 27 Nov 2023 03:38:13 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 q15-20020a63e94f000000b00578b40a4903sm7618323pgj.22.2023.11.27.03.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 03:38:13 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v2 5/8] target/riscv: add satp_mode profile support
Date: Mon, 27 Nov 2023 08:37:49 -0300
Message-ID: <20231127113752.1290265-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231127113752.1290265-1-dbarboza@ventanamicro.com>
References: <20231127113752.1290265-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x436.google.com
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

'satp_mode' is a requirement for supervisor profiles like RVA22S64.
User-mode/application profiles like RVA22U64 doesn't care.

Add 'satp_mode' to the profile description. If a profile requires it,
set it during cpu_set_profile(). We'll also check it during finalize()
to validate if the running config implements the profile.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c         |  1 +
 target/riscv/cpu.h         |  1 +
 target/riscv/tcg/tcg-cpu.c | 40 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2b79fe861b..a77118549b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1543,6 +1543,7 @@ static RISCVCPUProfile RVA22U64 = {
     .name = "rva22u64",
     .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVU,
     .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
+    .satp_mode = RISCV_PROFILE_ATTR_UNUSED,
     .ext_offsets = {
         CPU_CFG_OFFSET(ext_zicsr), CPU_CFG_OFFSET(ext_zihintpause),
         CPU_CFG_OFFSET(ext_zba), CPU_CFG_OFFSET(ext_zbb),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 485d2da3c2..6c5fceb5f5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -82,6 +82,7 @@ typedef struct riscv_cpu_profile {
     bool enabled;
     bool user_set;
     int priv_spec;
+    int satp_mode;
     const int32_t ext_offsets[];
 } RISCVCPUProfile;
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 4d25fc43d2..152f95718b 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -766,6 +766,31 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     riscv_cpu_disable_priv_spec_isa_exts(cpu);
 }
 
+#ifndef CONFIG_USER_ONLY
+static bool riscv_cpu_validate_profile_satp(RISCVCPU *cpu,
+                                            RISCVCPUProfile *profile,
+                                            bool send_warn)
+{
+    int satp_max = satp_mode_max_from_map(cpu->cfg.satp_mode.supported);
+
+    if (profile->satp_mode > satp_max) {
+        if (send_warn) {
+            bool is_32bit = riscv_cpu_is_32bit(cpu);
+            const char *req_satp = satp_mode_str(profile->satp_mode, is_32bit);
+            const char *cur_satp = satp_mode_str(satp_max, is_32bit);
+
+            warn_report("Profile %s requires satp mode %s, "
+                        "but satp mode %s was set", profile->name,
+                        req_satp, cur_satp);
+        }
+
+        return false;
+    }
+
+    return true;
+}
+#endif
+
 static void riscv_cpu_validate_profile(RISCVCPU *cpu,
                                        RISCVCPUProfile *profile)
 {
@@ -775,6 +800,13 @@ static void riscv_cpu_validate_profile(RISCVCPU *cpu,
     bool profile_impl = true;
     int i;
 
+#ifndef CONFIG_USER_ONLY
+    if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
+        profile_impl = riscv_cpu_validate_profile_satp(cpu, profile,
+                                                       send_warn);
+    }
+#endif
+
     if (profile->priv_spec != RISCV_PROFILE_ATTR_UNUSED &&
         profile->priv_spec != env->priv_ver) {
         profile_impl = false;
@@ -1079,6 +1111,14 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
         cpu->env.priv_ver = profile->priv_spec;
     }
 
+#ifndef CONFIG_USER_ONLY
+    if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
+        const char *satp_prop = satp_mode_str(profile->satp_mode,
+                                              riscv_cpu_is_32bit(cpu));
+        object_property_set_bool(obj, satp_prop, profile->enabled, NULL);
+    }
+#endif
+
     for (i = 0; misa_bits[i] != 0; i++) {
         uint32_t bit = misa_bits[i];
 
-- 
2.41.0



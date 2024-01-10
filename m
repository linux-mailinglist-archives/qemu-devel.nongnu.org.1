Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D28F829595
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:01:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUSQ-00026D-VJ; Wed, 10 Jan 2024 04:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSM-0001tS-Hf
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:02 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSK-0005Ed-J2
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:02 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3bbbc6bcc78so3507084b6e.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877259; x=1705482059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KaKPiKkewFoBbNsj0YJcEfP7lW0ZInIu6nUVz8TtC3E=;
 b=cJTzERS4bQGfc3qWmh01xth9G8tqxRa9+Lh+n3UfwD5kJE983pW7NFs1EZHif6L6T1
 p0RXLFqNVXORUHsQuTQGiV8Y+ZE5PB8J42+orYls501TDDjGIUeysAN5EPdb/ClNbSHl
 CQVJPMCEORlTmhw9RgmezKS0UcBDVtUd1gcSualXZdLFflrLaqDXJAZL/Tb99RTep9rv
 pvl2mLzxwkyIbcR7TEUaO1vH2AaNUgL0dIE9HsC8rYQaK0G8hvwjH9q6IlZ37CnGerZ7
 2vaHxUeb2PWvGcZfhDeQ8NEnjLkwM7j5gWu1iFsXb7T/YR6zrrV/uDBKes4741kPNDYd
 qs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877259; x=1705482059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KaKPiKkewFoBbNsj0YJcEfP7lW0ZInIu6nUVz8TtC3E=;
 b=uKmlqzebnnUeNS69HV6agIk7a9P9lDjpxaOYihMx9feEPh6IYK63wc38XSWBcNVH3n
 goMO60xOPyCqkTrw0FS1RCrvlTLjokgn1ok+ntHQ7tyc1TCPM9x/UXuPS7QPWEvVXhdm
 u5B0Ont2omVKGX2JkQ7+4MoqiWrx9/7SdYySRIzaMUR3CkrzsdqQS+/bJJx2j2dp2FKT
 q1UCYpAYDduysiBEVt79LGAWorjsOmIzjfJsjM6i1TAa2W2SfCMDQT/bz96EHJ6UO5Do
 Z46PAByy0QgWmVH66auSkXQC3glFwf33IuElAF0azoD/svq5DfkKShfoohKBi5pSh1MX
 X7aA==
X-Gm-Message-State: AOJu0YwjpvHaYvhCXmJYmdLczzwdFdpgInEv9R5xmGW4sr6jEymEIv3y
 C1my1OsyBLJDLJYACt1+PQlHeArrO+1cIJ6w
X-Google-Smtp-Source: AGHT+IFkL+uwTDqY0v7axRgdf8AZrJ/3mzCaSYGzl5VUeftjLxAi2H9CNgUnv7frW3y/4OYEwO4J7A==
X-Received: by 2002:a05:6808:4498:b0:3bd:3c27:800 with SMTP id
 eq24-20020a056808449800b003bd3c270800mr1040799oib.35.1704877259342; 
 Wed, 10 Jan 2024 01:00:59 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:00:58 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 51/65] target/riscv: add satp_mode profile support
Date: Wed, 10 Jan 2024 18:57:19 +1000
Message-ID: <20240110085733.1607526-52-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22f.google.com
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

'satp_mode' is a requirement for supervisor profiles like RVA22S64.
User-mode/application profiles like RVA22U64 doesn't care.

Add 'satp_mode' to the profile description. If a profile requires it,
set it during cpu_set_profile(). We'll also check it during finalize()
to validate if the running config implements the profile.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231218125334.37184-24-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  1 +
 target/riscv/cpu.c         |  1 +
 target/riscv/tcg/tcg-cpu.c | 40 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a0f768e77d..136030434e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -82,6 +82,7 @@ typedef struct riscv_cpu_profile {
     bool enabled;
     bool user_set;
     int priv_spec;
+    int satp_mode;
     const int32_t ext_offsets[];
 } RISCVCPUProfile;
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4d1fd7fd48..1aeb0fee1b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1542,6 +1542,7 @@ static RISCVCPUProfile RVA22U64 = {
     .name = "rva22u64",
     .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVU,
     .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
+    .satp_mode = RISCV_PROFILE_ATTR_UNUSED,
     .ext_offsets = {
         CPU_CFG_OFFSET(ext_zicsr), CPU_CFG_OFFSET(ext_zihintpause),
         CPU_CFG_OFFSET(ext_zba), CPU_CFG_OFFSET(ext_zbb),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 41eef87e6e..a0a3350e3e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -771,6 +771,31 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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
@@ -780,6 +805,13 @@ static void riscv_cpu_validate_profile(RISCVCPU *cpu,
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
@@ -1084,6 +1116,14 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
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
2.43.0



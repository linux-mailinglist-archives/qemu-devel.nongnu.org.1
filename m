Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DDD816EE6
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 13:56:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFD8z-0003Qo-Pg; Mon, 18 Dec 2023 07:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD8x-0003LG-9a
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:54:47 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD8v-0004zr-JX
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:54:47 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d3b4b803f4so3456495ad.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 04:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702904084; x=1703508884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5eMH0mHU2CrG+7HDKRD0uTcFjzj1Zx4SmiIPBKejYsA=;
 b=kN39q+LXSwcQ2QwsTafxyFtJdkrqafdC647yeJOtgSy28F0rJflFCw4Ft7pl2PJooU
 BMKq8bMmrsGpvRrhlgEgojUCatWPc+1enguyts0x2XpT7AV6XbdHv17KiwRjl3VoBAJo
 TDnFu/dGJlDtIGTVlbQZpEwu8lUm+Knkk6KOmt6SqWyr5nySyA2T/GTsH+oFBgM8xdGf
 PK0/14dp3IUHWkQSUWbw9aWosS0KCsJH07/nSid4uENqZFE6R5ZpcukaPTcappU3GhvE
 YrldWQhulqDR8XDKQWh4JBk3pIo0qCM/TKJ1FBSpNSeVsrJaa2BGsX5MglX5NF8QbZMj
 2TeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702904084; x=1703508884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5eMH0mHU2CrG+7HDKRD0uTcFjzj1Zx4SmiIPBKejYsA=;
 b=axANvDIT20eNPUbNGW8oQMmNg9xZpM/59BrIY/zr50ABQ8o4M1FgkoFiY8f4+LiH0n
 GZzollM1aPaYbQT9DrQCQZe0bMpJDj1o6hBtv+ccDH9XUiAizzrWSer7+zp5iQ5IF9Et
 4kxQnM5++JpyIPjS/+r5/5v0VrCSi/rRKcaSOew1Zx16x8Mle2+Pf34a802tVp088/tV
 rjl+6tt5clHB8BCMDRfPRkGIoYRfIyTNYZIRo779lnx8i2xxH+6JVjC43speRYBdXC6H
 82so/FanHEJ/lflp2Z57gTVZpRhOzfrCwUAqO/CqHWjrHxNC0QRYsiNifHP9zDxgL0kv
 BVmg==
X-Gm-Message-State: AOJu0YyweihJVTRWu2GtYI5iJhP1oTtJ+32qSTWPPu/sLt9wgjcYpX/c
 piyfMEslXgnooZtXI1ygf91zj9VDanhF9KkbVxI=
X-Google-Smtp-Source: AGHT+IH5C+w45UgTH9g+dO8BhIxZIfTI0PIDzs4kuT9Uqb8KcnMZtS/+/rxap2HJrivOSwqpGVjNiA==
X-Received: by 2002:a17:902:ce8b:b0:1cf:fe32:632f with SMTP id
 f11-20020a170902ce8b00b001cffe32632fmr10390034plg.22.1702904084093; 
 Mon, 18 Dec 2023 04:54:44 -0800 (PST)
Received: from grind.. ([179.93.21.205]) by smtp.gmail.com with ESMTPSA id
 c2-20020a170902848200b001d09c539c96sm7494897plo.229.2023.12.18.04.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 04:54:43 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v13 19/26] target/riscv: implement svade
Date: Mon, 18 Dec 2023 09:53:27 -0300
Message-ID: <20231218125334.37184-20-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218125334.37184-1-dbarboza@ventanamicro.com>
References: <20231218125334.37184-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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

'svade' is a RVA22S64 profile requirement, a profile we're going to add
shortly. It is a named feature (i.e. not a formal extension, not defined
in riscv,isa DT at this moment) defined in [1] as:

"Page-fault exceptions are raised when a page is accessed when A bit is
clear, or written when D bit is clear.".

As far as the spec goes, 'svade' is one of the two distinct modes of
handling PTE_A and PTE_D. The other way, i.e. update PTE_A/PTE_D when
they're cleared, is defined by the 'svadu' extension. Checking
cpu_helper.c, get_physical_address(), we can verify that QEMU is
compliant with that: we will update PTE_A/PTE_D if 'svadu' is enabled,
or throw a page-fault exception if 'svadu' isn't enabled.

So, as far as we're concerned, 'svade' translates to 'svadu must be
disabled'.

We'll implement it like 'zic64b': an internal flag that profiles can
enable. The flag will not be exposed to users.

[1] https://github.com/riscv/riscv-profiles/blob/main/profiles.adoc

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c         | 1 +
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/tcg/tcg-cpu.c | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a38d78b2d6..a76bc1b86a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1445,6 +1445,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
 };
 
 const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
+    MULTI_EXT_CFG_BOOL("svade", svade, true),
     MULTI_EXT_CFG_BOOL("zic64b", zic64b, true),
 
     DEFINE_PROP_END_OF_LIST(),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 90f18eb601..46b06db68b 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -116,6 +116,7 @@ struct RISCVCPUConfig {
     bool ext_smepmp;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
+    bool svade;
     bool zic64b;
 
     uint32_t mvendorid;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 04aedf3840..e395e2449e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -188,6 +188,9 @@ static void riscv_cpu_enable_named_feat(RISCVCPU *cpu, uint32_t feat_offset)
         cpu->cfg.cbop_blocksize = 64;
         cpu->cfg.cboz_blocksize = 64;
         break;
+    case CPU_CFG_OFFSET(svade):
+        cpu->cfg.ext_svadu = false;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -381,6 +384,8 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
     cpu->cfg.zic64b = cpu->cfg.cbom_blocksize == 64 &&
                       cpu->cfg.cbop_blocksize == 64 &&
                       cpu->cfg.cboz_blocksize == 64;
+
+    cpu->cfg.svade = !cpu->cfg.ext_svadu;
 }
 
 static void riscv_cpu_validate_g(RISCVCPU *cpu)
-- 
2.43.0



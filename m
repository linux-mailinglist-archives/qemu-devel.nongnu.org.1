Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 601628295BC
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:07:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUSA-0000rM-Uu; Wed, 10 Jan 2024 04:00:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUS7-0000jh-VW
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:48 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUS5-00056y-Vn
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:47 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6daa89a6452so2412264b3a.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877244; x=1705482044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jWqDADFnGT/rELbIwCmOw6Ap/aeZVVGdlGLkAswuX/o=;
 b=dboYn4bSuKV+kBUpD9YyrbzuLaBcfTPgXWtAeD+p+cUcQjtA718STWycgODTskkazj
 6UduyqzS833ksHrrzxGSLIo2GCa5louca1ZnJ3ChLX8GWvyRv4iDnfzeqGJz+0uzrHWN
 /uZ35QuLTj1JhXNQ9ZHU68ZpaQ9bDSYgheqjeAwN0jSCFrfSsL6Cwc7LK0BFg8csVOrG
 trLXNhuhUxvVbrnroIY1yQP2NViKj6book2hQUsMf97XrRSLl0czWQoeDuwKhUQigJsz
 2/PjE8IhpTVZqZWcuw0C4ALvVZ8K4NjARZNWSeTzdn9Rj8mBT+OOUCt9041NV5WmbuSh
 8WUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877244; x=1705482044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jWqDADFnGT/rELbIwCmOw6Ap/aeZVVGdlGLkAswuX/o=;
 b=miAm0UbPrXkaT80ehQTMyQcQ1E1qwwGkVkahmwlA8dEcbQPZAHT8U3PMVH+0azReMH
 9eaT3IpjST0FGiC5slJepKI++JCT/BVFv051EYFrOMgQYJwHZ6CK5qOqIFvBUontrbe2
 IRrN8ZFJxms918f1bIlqtyXH383AjkXTqI605y+NydRAiI0uKFG3DGhXW6QBslVoUMTD
 8Zeg6Qw1zwy4EkV8776pPDR85jWsKpYDVny8MvGCRkg8wv7s1bD4lrbCI1lX8WiUfrwS
 vgAXYbM6Pc/8Ab7ml15b22F9yW3TEYrKZBEITP9jkS4cYepGSN0RLv9Nll+7lgOJOx/e
 yLVA==
X-Gm-Message-State: AOJu0YxwCke87/x9TDFkSV9ReD3XVfMOmI9Sf/2SJjUZfWvBn0pymo9/
 Ql5vI550M6eCwCdj67fQ8NfrOPby1Nsps8SV
X-Google-Smtp-Source: AGHT+IGu5gC0sZ0f6pQhw9usCk2D61taGVBVdXAh8qege9rGOGuD5ppvNHa/nm2FoCWJSh0KSur6jw==
X-Received: by 2002:a05:6a00:ac1:b0:6d9:ac97:66a4 with SMTP id
 c1-20020a056a000ac100b006d9ac9766a4mr657476pfl.18.1704877244528; 
 Wed, 10 Jan 2024 01:00:44 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:00:44 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 47/65] target/riscv: implement svade
Date: Wed, 10 Jan 2024 18:57:15 +1000
Message-ID: <20240110085733.1607526-48-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231218125334.37184-20-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/cpu.c         | 1 +
 target/riscv/tcg/tcg-cpu.c | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 350ea44e50..780ae6ef17 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -117,6 +117,7 @@ struct RISCVCPUConfig {
     bool ext_smepmp;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
+    bool svade;
     bool zic64b;
 
     uint32_t mvendorid;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cd3c22e92b..0ec0d89070 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1444,6 +1444,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
 };
 
 const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
+    MULTI_EXT_CFG_BOOL("svade", svade, true),
     MULTI_EXT_CFG_BOOL("zic64b", zic64b, true),
 
     DEFINE_PROP_END_OF_LIST(),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f2a9558737..e90d929ac1 100644
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



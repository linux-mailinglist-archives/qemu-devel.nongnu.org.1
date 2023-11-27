Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4827B7F9ECB
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 12:39:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Zwc-0003yX-5z; Mon, 27 Nov 2023 06:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r7ZwZ-0003xi-RS
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 06:38:27 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r7ZwY-0005QQ-A1
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 06:38:27 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3b842e28917so1871161b6e.1
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 03:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1701085104; x=1701689904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmRYxbcrT44VCzWYmzhlhuQ/rR3RdlkH5p1bUIHDcZI=;
 b=ce+6E2/PlMKeV6iigaewFB0/Q1zaD8XXkPbAPkA4hsJ3ebvEFg6csHdS+dSbxrKa+O
 dnr+kIbgS6ym9a25LijO5w24SYVQVpRtGqWgebedBlZK9HR0q+lv/UCZk7isGuBqZFWj
 L4qjOQjW+pIdRiBFEIusAEhG5gcP57duEgPVU61tctiRp5XAFiBuOjpEE6WK0vKrsX3v
 PzVUaEGWm0eE/yimWkT4haSDt4aRbQQobvcV9yodf7Zib+N958faHvOw1fAjKhy/Q0jb
 WI9pUJf7uPcAUt20W1fNSQRvkr+VK8SGgxwWcyybX8ghaBQW9YCbTI/y3dYRenEtyCuN
 Zdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701085104; x=1701689904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tmRYxbcrT44VCzWYmzhlhuQ/rR3RdlkH5p1bUIHDcZI=;
 b=SQcgx9tKGAG+1xI2GtOcTWrBItq64iG/v52lmm1pxQogI8xc4cpTVE0wr5l/OgyU4P
 7HUKgfE8sS40pYshQoBnuZ8yFck6oQ46jeVNjqn+8SWuatpkvw83j53h0lVnW97acO/m
 +Gdzutz7tzxmixV/U1MsXypzBmxZNVfyy9uRHMmZwmlIlnq2KuQOPOAtHIoVesT7IpRc
 BF2812LtmLgK3/NlyYIEraKvTxSRSX9aOwk7b6GsTfHPWlIfMFtL7TadYqZRK4zHGIYL
 xe5cHIkhvYDvzMjj29GtTUBuJQ+MK0091AW24kzUMYTTKmfRHtQdK2n1qpyH0TLxeqY8
 IGGw==
X-Gm-Message-State: AOJu0Yy2Kn9C86H56YBSftCEIr9ivZlXLyxoChZAGUVG+ugfKfzgUbUK
 QZvP2j4DCg7y3LaqJnvP2TIPwdCiQcZb6dG2yuA=
X-Google-Smtp-Source: AGHT+IEdDLn4fANEtxaGtgSTCKtJtfHcr1BHcZmtfwltJCP0wiZnlQzWVfINsjoTTOckZUmkWoaYPA==
X-Received: by 2002:a05:6808:f90:b0:3a9:cfb5:462a with SMTP id
 o16-20020a0568080f9000b003a9cfb5462amr12354975oiw.36.1701085104231; 
 Mon, 27 Nov 2023 03:38:24 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 q15-20020a63e94f000000b00578b40a4903sm7618323pgj.22.2023.11.27.03.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 03:38:23 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v2 8/8] target/riscv: add rva22s64 cpu
Date: Mon, 27 Nov 2023 08:37:52 -0300
Message-ID: <20231127113752.1290265-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231127113752.1290265-1-dbarboza@ventanamicro.com>
References: <20231127113752.1290265-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add a new profile CPU 'rva22s64' to work as an alias of

-cpu rv64i,rva22s64

Like the existing rva22u64 CPU already does with the RVA22U64 profile.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu-qom.h | 1 +
 target/riscv/cpu.c     | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 12fe78fc52..9219c2fcc3 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -36,6 +36,7 @@
 #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x-rv128")
 #define TYPE_RISCV_CPU_RV64I            RISCV_CPU_TYPE_NAME("rv64i")
 #define TYPE_RISCV_CPU_RVA22U64         RISCV_CPU_TYPE_NAME("rva22u64")
+#define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fa056fb45f..99bdb96335 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1624,6 +1624,13 @@ static void rva22u64_profile_cpu_init(Object *obj)
 
     RVA22U64.enabled = true;
 }
+
+static void rva22s64_profile_cpu_init(Object *obj)
+{
+    rv64i_bare_cpu_init(obj);
+
+    RVA22S64.enabled = true;
+}
 #endif
 
 static const gchar *riscv_gdb_arch_name(CPUState *cs)
@@ -1968,6 +1975,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,  rv128_base_cpu_init),
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I, rv64i_bare_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64, rva22u64_profile_cpu_init),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64, rva22s64_profile_cpu_init),
 #endif
 };
 
-- 
2.41.0



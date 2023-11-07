Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D247E330B
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:34:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bs1-0003SC-NY; Mon, 06 Nov 2023 21:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Brn-0002uR-6D
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:59 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Brk-0002dT-Gh
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:58 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ccce410660so13155615ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324255; x=1699929055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7AOjskuJ0OqhtrWQzBvL+TP6RFFXtIftj6M+rs+JFM=;
 b=bo2qB/fgP6pOEel4qQ2HConMIBEuN2Z5xehjr+G9itYCChWlJhJ8upfBPzG+bvXBs7
 SRcSpO3CWi5NAhGPK8ad32JhWQJaY3BqhXJfT0+LRV94LAHGq6x6sAP/palnO27vjHzT
 9IWpSpaowjy2S7g1haTGLu4G8dWcFM7bTOJw4KnoLG6G17//Qofu29OxGnPiWW/4cxYb
 TUjK6cobK591ljyLgclKfIopCb9gIjgeByjCaZv9jVpPYFbMd24Is1rlnq+EHdqjXKk0
 /L2NJuUpolB2aUaleeoYHEuA+2mIToMXFUPq2y5IFq/3w2RDtpLgEWwsL3CpHuOwdlBn
 p1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324255; x=1699929055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f7AOjskuJ0OqhtrWQzBvL+TP6RFFXtIftj6M+rs+JFM=;
 b=AKCVGgeFm3dIA6ng+nx0uUdrD8jyEHEB+kMEPAkxH49nNIODwWzmw2h1Ftsa2yOj8J
 hrB7lPcZ/SxxWsYG2gLDxn7yRNwUONohUl0Ta9WFuwZwIIm2QfNhQQFJ/Y6YiThYPJTw
 Z+NMPE2s57ECGJBeUpK1Xknc0NOHctmVKZMmKlHa/LztN+XklSjiytvM4tBQQzWL5GVl
 z3geX3BEM7E8pSnV3Xn8k8LXECrnriwvZt7qFZi5s3IXQYolgi3MY9JCma/gQ2WQhJdq
 u5zO0NvSyFUVNRtTu0MwF6d4N2yKpkNkifDUmfS/nuye2z9Q51OG32y56XRuvNzTYq1g
 haQg==
X-Gm-Message-State: AOJu0YzHavRrJY4VLKqeHiJq5v5x6Tc3I9uu2BLHonta4+3SuDTAsHhb
 4ECa5jb3sP2kAmNIkJZEvK/ro+kXu+wxbw==
X-Google-Smtp-Source: AGHT+IG8Nt6oncZdyqqfT7syu28BZZdAqZt24yyF3Zqnq36648MZrobf95DDGRQPGYjr5y1UJ8QijA==
X-Received: by 2002:a17:903:22ca:b0:1c7:8446:d65c with SMTP id
 y10-20020a17090322ca00b001c78446d65cmr29144859plg.43.1699324254902; 
 Mon, 06 Nov 2023 18:30:54 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:30:54 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 17/49] target/riscv: add riscv_cpu_accelerator_compatible()
Date: Tue,  7 Nov 2023 12:29:13 +1000
Message-ID: <20231107022946.1055027-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

Add an API to check if a given CPU is compatible with the current
accelerator.

This will allow query-cpu-model-expansion to work properly in conditions
where QEMU supports both accelerators (TCG and KVM), QEMU is then
launched using TCG, and the API requests information about a KVM only
CPU (e.g. 'host' CPU).

KVM doesn't have such restrictions and, at least in theory, all CPUs
models should work with KVM. We will revisit this API in case we decide
to restrict the amount of KVM CPUs we support.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231018195638.211151-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         | 1 +
 target/riscv/tcg/tcg-cpu.h | 1 +
 target/riscv/cpu.c         | 9 +++++++++
 target/riscv/tcg/tcg-cpu.c | 7 ++++++-
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8c9ec59d82..8efc4d83ec 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -758,6 +758,7 @@ char *riscv_cpu_get_name(RISCVCPU *cpu);
 
 void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 void riscv_add_satp_mode_properties(Object *obj);
+bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
 
 /* CSR function table */
 extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
diff --git a/target/riscv/tcg/tcg-cpu.h b/target/riscv/tcg/tcg-cpu.h
index aa00fbc253..f7b32417f8 100644
--- a/target/riscv/tcg/tcg-cpu.h
+++ b/target/riscv/tcg/tcg-cpu.h
@@ -24,5 +24,6 @@
 
 void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp);
 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
+bool riscv_cpu_tcg_compatible(RISCVCPU *cpu);
 
 #endif
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 02db0834dd..8e0abe33d3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1063,6 +1063,15 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     mcc->parent_realize(dev, errp);
 }
 
+bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu)
+{
+    if (tcg_enabled()) {
+        return riscv_cpu_tcg_compatible(cpu);
+    }
+
+    return true;
+}
+
 #ifndef CONFIG_USER_ONLY
 static void cpu_riscv_get_satp(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 21a46f2a0e..6771617226 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -581,6 +581,11 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     }
 }
 
+bool riscv_cpu_tcg_compatible(RISCVCPU *cpu)
+{
+    return object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST) == NULL;
+}
+
 static bool riscv_cpu_is_generic(Object *cpu_obj)
 {
     return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
@@ -598,7 +603,7 @@ static bool tcg_cpu_realize(CPUState *cs, Error **errp)
     RISCVCPU *cpu = RISCV_CPU(cs);
     Error *local_err = NULL;
 
-    if (object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST)) {
+    if (!riscv_cpu_tcg_compatible(cpu)) {
         g_autofree char *name = riscv_cpu_get_name(cpu);
         error_setg(errp, "'%s' CPU is not compatible with TCG acceleration",
                    name);
-- 
2.41.0



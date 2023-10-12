Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0217C6402
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:20:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn52-0007F8-8N; Thu, 12 Oct 2023 00:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4p-000744-Qi
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:38 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4m-0002ld-Uz
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:34 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-690d8c05784so450833b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697084011; x=1697688811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NdEgXxa7hcTDIZ/8QewbQ1HOD8q11RxXYAXZn1RCqYw=;
 b=EIgWcFs64u9o6T9Nf/3IeHZ4l7OnI0sB66YR/HxA9Gpo7dPm70MWu3OL46mH4/Rzh9
 YFawXgPPciE64TaFriCS01aQhen/w4teuVC95rmP8wZ4XWrGya62TDRKk2OzoxU5gf+K
 sMisjbti5snnDBDnr2t3wT+QXESUDh6kzyOA3LzV7OWdeF12xoI2D4Unid0psJR1E6eN
 E8MqSGC5Hx7F8WgGcn+TNmOf+ywmHCJDhzdqith6xf9ZdwcNe5ri9VIhlmQjU2i44Zeh
 yOqaRTTBvtcNXFMz3UXURoB0l4vHjgqxqyD0TrPZQpLhMphdzVTegGQtJ1Dg8IPkr+Au
 aZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697084011; x=1697688811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NdEgXxa7hcTDIZ/8QewbQ1HOD8q11RxXYAXZn1RCqYw=;
 b=miCe+ppvCF0QXmcFsIwpoh74kUe1FBdHX8V4S9kiH6dr1ejpZpAvP8WjElwYx+nQ6+
 LzDZQC9RJG/Yx+VCiPFEl8ErEHVhvkYZSZsxpd1kqbSKwmDKMx9sdfLwtH7cGsqIgVBo
 wE2anSZ4ba0oFvjjf3EBUAjeTD2nFUwKu36KEhyCZqE+omXbE9NCZ4meSAK3p4N2xKId
 GOoUfXRa7F9XPod+D8RpkBC2xxqwSmuKwkxtD9DdAKNAkTh76vfs+eAvGl7kfomcSITK
 JOYcIITtgRhIN6htMgckeyJ12rARPizf2dwV8R7YWfre5rQAuStPViTinRttumOK1gdT
 hM9Q==
X-Gm-Message-State: AOJu0Yyax4uqGTjBgrvLvjO3rML3JOmzEVuixgcsj1JLHP4kxVsqrz6/
 BO1aQNoTsR+GF5e+d7mvjZcoVlwwKvprbA==
X-Google-Smtp-Source: AGHT+IFJTF6lH/vAF5OnI74UPeUfrqnbHkP9ccwFiQj8Q6P5s81vJXgoDHJErHK7QB+5L9tE0wCosw==
X-Received: by 2002:a05:6a20:549b:b0:161:2bed:6b3a with SMTP id
 i27-20020a056a20549b00b001612bed6b3amr22645748pzk.17.1697084011136; 
 Wed, 11 Oct 2023 21:13:31 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:13:30 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 42/54] target/riscv: add riscv_cpu_get_name()
Date: Thu, 12 Oct 2023 14:10:39 +1000
Message-ID: <20231012041051.2572507-43-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We'll introduce generic errors that will output a CPU type name via its
RISCVCPU pointer. Create a helper for that.

Use the helper in tcg_cpu_realizefn() instead of hardcoding the 'host'
CPU name.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230926183109.165878-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  1 +
 target/riscv/cpu.c         | 11 +++++++++++
 target/riscv/tcg/tcg-cpu.c |  4 +++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7291b84756..8298f8bf63 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -730,6 +730,7 @@ typedef struct isa_ext_data {
     int ext_enable_offset;
 } RISCVIsaExtData;
 extern const RISCVIsaExtData isa_edata_arr[];
+char *riscv_cpu_get_name(RISCVCPU *cpu);
 
 void riscv_add_satp_mode_properties(Object *obj);
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a7cc7aa6e2..cdeb24cb5e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -643,6 +643,17 @@ static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
+char *riscv_cpu_get_name(RISCVCPU *cpu)
+{
+    RISCVCPUClass *rcc = RISCV_CPU_GET_CLASS(cpu);
+    const char *typename = object_class_get_name(OBJECT_CLASS(rcc));
+
+    g_assert(g_str_has_suffix(typename, RISCV_CPU_TYPE_SUFFIX));
+
+    return g_strndup(typename,
+                     strlen(typename) - strlen(RISCV_CPU_TYPE_SUFFIX));
+}
+
 static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index a021ec833d..104e91846a 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -563,7 +563,9 @@ static bool tcg_cpu_realize(CPUState *cs, Error **errp)
     Error *local_err = NULL;
 
     if (object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST)) {
-        error_setg(errp, "'host' CPU is not compatible with TCG acceleration");
+        g_autofree char *name = riscv_cpu_get_name(cpu);
+        error_setg(errp, "'%s' CPU is not compatible with TCG acceleration",
+                   name);
         return false;
     }
 
-- 
2.41.0



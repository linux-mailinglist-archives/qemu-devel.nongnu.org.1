Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 638517DFC99
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 23:47:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qygRg-000710-7V; Thu, 02 Nov 2023 18:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qygRb-0006o7-2K
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 18:45:44 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qygRZ-0003Vd-7M
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 18:45:42 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a81ab75f21so18043387b3.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 15:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698965139; x=1699569939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bgD8BAJnIDmTlfiEkg+MaoRaVU+r3sI852Nxw01w8Tg=;
 b=I6V7kBq/ATmTbN0chGjIfTp8kb6jTSLLS+X3oiIdQ0nCX4HV8eqzNuf+bDyFm+XUO8
 tRcKeo/xMjlCrEwW523RgPI38djaKl0yVaG20TRaWRkCssjSz3bwlmg6EnLnEM9Eim9y
 bJ4wwJrbf9D1vksS1JmmPbPMwOu8PhjPkGFM2ouuzjI+C/29A1QgWMfgcJ/h/0uToKsP
 cvFVhvQf3Lby2KlPYpf3wdADTTw6GIO0TP1IuqjvkHIb1Suc1PXZLyfA7xfFvM4jJs/0
 pXLP09UdKPsgddnKisibO2gR7fitUF2E+Pp+Gn1Y1Z3Zm9myn9kVVJgDmDmBQjyJuai0
 H5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965139; x=1699569939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bgD8BAJnIDmTlfiEkg+MaoRaVU+r3sI852Nxw01w8Tg=;
 b=IcrnPDZMvgt1cCF8HQhx5NrrT3Roz4HB95VnCxxgcUZFQSNNj7Sa47hG8wb5xLnv9r
 +0sukir5NrLEN/OaD5gJlQcrTwL1slMZRFsSC5BHLYDF4z7UfhLBeLtuv6bcs4JR9m5A
 QCF7x0HDV1TB7Hosgb3Uf/FaAH8B+Mw5ZVrSCpAz6ycjFXY6+hMLepVDMACYn7aRMjHC
 TAPoKhu/iiISbBjtLXCHTG89Oxj2ADVfBCfkN8Vfvds1vvm537ggms8ZQQT0pYwtfMih
 /fhFZ3sdWwd+OgIMZKospVUx/yKti82WOffd4jGuwptz+jtHM+gH/WaBZ4MTQ01AJc6T
 8ZjQ==
X-Gm-Message-State: AOJu0Yy+/6zobAqR1l5d9VoZK4crdYLZE3ObfOpdCgBra8SlBFUlIZ37
 xaEaMo12HpQCCvRdz9u2M4C+rbKXSt5e0kLyOF0=
X-Google-Smtp-Source: AGHT+IHqxsfKbg+LaZce/YXTpLnO/sQCOpbYmo4tWNiPwfFMBjHfAYit+H4/5PWkOjJhqTvrFeGjsw==
X-Received: by 2002:a05:690c:ec6:b0:59b:54b5:7d66 with SMTP id
 cs6-20020a05690c0ec600b0059b54b57d66mr1471067ywb.34.1698965139435; 
 Thu, 02 Nov 2023 15:45:39 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 ce10-20020a05690c098a00b0059b24bd4f2asm259523ywb.57.2023.11.02.15.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 15:45:39 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 19/19] target/riscv/tcg: do not support profiles for 'max'
 CPU
Date: Thu,  2 Nov 2023 19:44:45 -0300
Message-ID: <20231102224445.527355-20-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102224445.527355-1-dbarboza@ventanamicro.com>
References: <20231102224445.527355-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1134.google.com
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

There's no gain in allowing the 'max' CPU to support profiles, since it
already contains everything that QEMU can support. And we'll open the
door for 'unorthodox' stuff like users disabling profiles of the 'max'
CPU.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 553fb337e7..9a964a426e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -825,6 +825,11 @@ static bool riscv_cpu_is_vendor(Object *cpu_obj)
     return object_dynamic_cast(cpu_obj, TYPE_RISCV_VENDOR_CPU) != NULL;
 }
 
+static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
+{
+    return object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_MAX) != NULL;
+}
+
 /*
  * We'll get here via the following path:
  *
@@ -1003,6 +1008,12 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
         return;
     }
 
+    if (riscv_cpu_has_max_extensions(obj)) {
+        error_setg(errp, "Profile %s is not available for the 'max' CPU",
+                   profile->name);
+        return;
+    }
+
     if (cpu->env.misa_mxl != MXL_RV64) {
         error_setg(errp, "Profile %s only available for 64 bit CPUs",
                    profile->name);
@@ -1251,11 +1262,6 @@ static void riscv_init_max_cpu_extensions(Object *obj)
     }
 }
 
-static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
-{
-    return object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_MAX) != NULL;
-}
-
 static void tcg_cpu_instance_init(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F5A7DFC8B
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 23:46:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qygQv-0006Ls-7J; Thu, 02 Nov 2023 18:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qygQs-0006Kw-MG
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 18:44:58 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qygQr-00035Z-1F
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 18:44:58 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5a84204e7aeso18253707b3.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 15:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698965095; x=1699569895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UgRWfBwtayel4L85jalnEfEZ38BIg1pZr2LRgGnFOd0=;
 b=Ts1DmK96R9/fzEkvcNe4FCWRh2qelFGJpelB5PZTkEKKynOCojUR64jr6iF6HUTTeI
 3E1BFE+Iv2y8YfKBNRX6LJizLvB6wDlvPyeLqmGmok/kSUL4y7nEONPIq2U2hfpOscaR
 Bm3fQZ4UoVIyQQ9Nt/NIYZLSbb9N4Fc5b19nyLtlGox2y9vPpDlhx+RXRVnQ37gMXaWB
 2ZSjHpsDgNf/m/Vv381v1NKv57T/BHYT8wlZlKSYbHVbmtk59leAOX3QjCt1GGZJvaO9
 +Dng5FoP3OYB5N3K18saLBfiz521uwxgKVlmJJWwiBDWmUUJjZW/mr9S51/Mq5ZTGVt3
 m/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965095; x=1699569895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UgRWfBwtayel4L85jalnEfEZ38BIg1pZr2LRgGnFOd0=;
 b=qwRm9x7muTXbcgUQ6QKDwuUAPyP9hA+Kp4iTSs/YwCX37MiBUjXEg2hM2lfAVzkAgd
 nwWsxRoxQj/kI5qtrt//q/W8fOuGCTHc6kjyfwUTB8+Ax6O05jKYjb+QPlV5vMczj1pF
 7SFlSf7+iYohMgN+HxR9l1ScuOj4vBpQmDFDB11ElT9IkWFhsQ5UizGVsl9z+gzaWwpb
 lsX7qLTrQaU3pNyaK29ZBHET5Wvai0U+mqVt5TAC1aVY/qMRW0st1v5yVuNYn7UAP/ZQ
 KY3ab0lOB53zbBlNY8B4RQXFCbWeBm3m/gV42zYG5ZRug0eVcG66AAHhCGpwA+34Wsm6
 C8xA==
X-Gm-Message-State: AOJu0YwXG5zcb1R9XY1ntw2uJGHLkMUiT8Aw2NQrdZPoXP28HxRcpVus
 s8GCzvffjHmW/8/6aNnh+/NTJV89yb43aHRbdKI=
X-Google-Smtp-Source: AGHT+IFX6GxYJH9QBvazUTjmFHogeDaJDBUREZ5C/s32SbnTMThsVN9BsZyV7X0YMRhntG8ZEL3eww==
X-Received: by 2002:a05:690c:86:b0:5a7:ba53:6544 with SMTP id
 be6-20020a05690c008600b005a7ba536544mr1314006ywb.12.1698965095301; 
 Thu, 02 Nov 2023 15:44:55 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 ce10-20020a05690c098a00b0059b24bd4f2asm259523ywb.57.2023.11.02.15.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 15:44:54 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 02/19] target/riscv/tcg: do not use "!generic" CPU checks
Date: Thu,  2 Nov 2023 19:44:28 -0300
Message-ID: <20231102224445.527355-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102224445.527355-1-dbarboza@ventanamicro.com>
References: <20231102224445.527355-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112d.google.com
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

Our current logic in get/setters of MISA and multi-letter extensions
works because we have only 2 CPU types, generic and vendor, and by using
"!generic" we're implying that we're talking about vendor CPUs. When adding
a third CPU type this logic will break so let's handle it beforehand.

In set_misa_ext_cfg() and set_multi_ext_cfg(), check for "vendor" cpu instead
of "not generic". The "generic CPU" checks remaining are from
riscv_cpu_add_misa_properties() and cpu_add_multi_ext_prop() before
applying default values for the extensions.

This leaves us with:

- vendor CPUs will not allow extension enablement, all other CPUs will;

- generic CPUs will inherit default values for extensions, all others
  won't.

And now we can add a new, third CPU type, that will allow extensions to
be enabled and will not inherit defaults, without changing the existing
logic.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 1a3351b142..08f8dded56 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -654,6 +654,11 @@ static bool riscv_cpu_is_generic(Object *cpu_obj)
     return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
 }
 
+static bool riscv_cpu_is_vendor(Object *cpu_obj)
+{
+    return object_dynamic_cast(cpu_obj, TYPE_RISCV_VENDOR_CPU) != NULL;
+}
+
 /*
  * We'll get here via the following path:
  *
@@ -716,7 +721,7 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
     target_ulong misa_bit = misa_ext_cfg->misa_bit;
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
-    bool generic_cpu = riscv_cpu_is_generic(obj);
+    bool vendor_cpu = riscv_cpu_is_vendor(obj);
     bool prev_val, value;
 
     if (!visit_type_bool(v, name, &value, errp)) {
@@ -730,7 +735,7 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
     }
 
     if (value) {
-        if (!generic_cpu) {
+        if (vendor_cpu) {
             g_autofree char *cpuname = riscv_cpu_get_name(cpu);
             error_setg(errp, "'%s' CPU does not allow enabling extensions",
                        cpuname);
@@ -835,7 +840,7 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
 {
     const RISCVCPUMultiExtConfig *multi_ext_cfg = opaque;
     RISCVCPU *cpu = RISCV_CPU(obj);
-    bool generic_cpu = riscv_cpu_is_generic(obj);
+    bool vendor_cpu = riscv_cpu_is_vendor(obj);
     bool prev_val, value;
 
     if (!visit_type_bool(v, name, &value, errp)) {
@@ -859,7 +864,7 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (value && !generic_cpu) {
+    if (value && vendor_cpu) {
         g_autofree char *cpuname = riscv_cpu_get_name(cpu);
         error_setg(errp, "'%s' CPU does not allow enabling extensions",
                    cpuname);
-- 
2.41.0



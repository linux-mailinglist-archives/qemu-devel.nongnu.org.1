Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A3B73EE42
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:04:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuIo-00033p-Nj; Mon, 26 Jun 2023 18:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qDuIA-0001dS-Rv
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:02:39 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qDuHz-0005tz-Ts
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:02:31 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1b0156a1c49so2185336fac.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 15:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687816946; x=1690408946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJQQ1L+QIqrO+QRyOETHpH3YJ7iCv70aVq9b92NcYKA=;
 b=OH35wG/WMFf4uUeM1HqdcyNuy1jWelBxoAoUVWtdqhL7D/1T7TiCi6LrVvw3q55G5G
 w4qcW2Dz4zuisJOS8tJV68eF7Ug5JajrynKF4NMGfUTrCcAiXX3t2zRr1IH0gJWY6w+8
 1ykRzNire5jvBdUCsUTOS0LQ+nQcCs+tTAoYujgXxEALuiI2+MNr8VYN6BpZUlQJkOnE
 0kVl5SQXtm23Zc6qZsHDNSJn9tZDry0xjAgi6GY9xsdGTg+89Q/ReUWbzRlJ/bq8K0WC
 NwNyx5k3DFEZ0yhLsAurYlhd+D4q5fx8vLcZWpjYXEoIwVjRx+cALqNkHQ40PyTfT8kD
 q/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687816946; x=1690408946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SJQQ1L+QIqrO+QRyOETHpH3YJ7iCv70aVq9b92NcYKA=;
 b=lkmN94z3cOidRYGGSUxip7Egv81FVoV/1YwItreLjsTZ3/q76i2QaSLcncBWxMCKcQ
 pGrT8jjLOErEciK2R0KAspJttHx3h7ns0LRX5QvbAxTFjPHulDoRhjTSgZ2nNpDmt35J
 prTh3uHHnrgoTsLHQD4H1IakmYWHbrU9463wqqTt1U4Aex/3k+EI5Yb3xgzxqyId/TUz
 9cP3D8mZoqGDKTzn6ItVhIbFTEiEsenCs05xgmbp/il+MPWFpDi8cfjTxt4zEehUvqS2
 cs/62XTndg1By6p2zfmw6SKllvWHs7wy5jKz3PMtFI4GgIOP79fcgf2vm3PpKzimknH6
 I8SQ==
X-Gm-Message-State: AC+VfDw8Xhk4CxXDbbPco7oHBD+LXD7pxtsk4zhLy64XjMHDSvl/IhCo
 K+T5osvdlN4TBZxm4Bd+wXeuBAoN8SihHyWNsuI=
X-Google-Smtp-Source: ACHHUZ4LNP9hxjCMOGzfpxAyMGHxVo07V/ixWUJZoJveyQ1MBQ7nFRaXwyD1vqweOtNNy12Y8uqgBg==
X-Received: by 2002:a05:6870:9513:b0:1ad:e92:62e1 with SMTP id
 u19-20020a056870951300b001ad0e9262e1mr13832383oal.54.1687816946458; 
 Mon, 26 Jun 2023 15:02:26 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a056870a10c00b001b03fbfa0c5sm1831419oae.39.2023.06.26.15.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 15:02:26 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 04/19] target/riscv/cpu.c: restrict 'mimpid' value
Date: Mon, 26 Jun 2023 19:01:54 -0300
Message-ID: <20230626220209.22142-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626220209.22142-1-dbarboza@ventanamicro.com>
References: <20230626220209.22142-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x30.google.com
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

Following the same logic used with 'mvendorid' let's also restrict
'mimpid' for named CPUs. Generic CPUs keep setting the value freely.

Note that we're getting rid of the default RISCV_CPU_MARCHID value. The
reason is that this is not a good default since it's dynamic, changing
with with every QEMU version, regardless of whether the actual
implementation of the CPU changed from one QEMU version to the other.
Named CPU should set it to a meaningful value instead and generic CPUs
can set whatever they want.

This is the error thrown for an invalid 'mimpid' value for the veyron-v1
CPU:

$ ./qemu-system-riscv64 -M virt -nographic -cpu veyron-v1,mimpid=2
qemu-system-riscv64: can't apply global veyron-v1-riscv-cpu.mimpid=2:
    Unable to change veyron-v1-riscv-cpu mimpid (0x111)

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b65958a887..33cc28acf1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -42,7 +42,6 @@
 #define RISCV_CPU_MARCHID   ((QEMU_VERSION_MAJOR << 16) | \
                              (QEMU_VERSION_MINOR << 8)  | \
                              (QEMU_VERSION_MICRO))
-#define RISCV_CPU_MIMPID    RISCV_CPU_MARCHID
 
 static const char riscv_single_letter_exts[] = "IEMAFDQCPVH";
 
@@ -1739,7 +1738,6 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
 
     DEFINE_PROP_UINT64("marchid", RISCVCPU, cfg.marchid, RISCV_CPU_MARCHID),
-    DEFINE_PROP_UINT64("mimpid", RISCVCPU, cfg.mimpid, RISCV_CPU_MIMPID),
 
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
@@ -1858,6 +1856,35 @@ static void cpu_get_mvendorid(Object *obj, Visitor *v, const char *name,
     visit_type_bool(v, name, &value, errp);
 }
 
+static void cpu_set_mimpid(Object *obj, Visitor *v, const char *name,
+                           void *opaque, Error **errp)
+{
+    bool dynamic_cpu = riscv_cpu_is_dynamic(obj);
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint64_t prev_val = cpu->cfg.mimpid;
+    uint64_t value;
+
+    if (!visit_type_uint64(v, name, &value, errp)) {
+        return;
+    }
+
+    if (!dynamic_cpu && prev_val != value) {
+        error_setg(errp, "Unable to change %s mimpid (0x%lx)",
+                   object_get_typename(obj), prev_val);
+        return;
+    }
+
+    cpu->cfg.mimpid = value;
+}
+
+static void cpu_get_mimpid(Object *obj, Visitor *v, const char *name,
+                           void *opaque, Error **errp)
+{
+    bool value = RISCV_CPU(obj)->cfg.mimpid;
+
+    visit_type_bool(v, name, &value, errp);
+}
+
 static void riscv_cpu_class_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
@@ -1892,6 +1919,9 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     object_class_property_add(c, "mvendorid", "uint32", cpu_get_mvendorid,
                               cpu_set_mvendorid, NULL, NULL);
 
+    object_class_property_add(c, "mimpid", "uint64", cpu_get_mimpid,
+                              cpu_set_mimpid, NULL, NULL);
+
     device_class_set_props(dc, riscv_cpu_properties);
 }
 
-- 
2.41.0



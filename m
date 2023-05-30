Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8CB716DF9
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:48:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q45Ir-0006VK-WF; Tue, 30 May 2023 15:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q45Ir-0006V9-4Q
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:46:45 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q45Ip-0004G7-IQ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:46:44 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-19a308a045aso2262003fac.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685476002; x=1688068002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4/mqWkXzyOSAPWFPm2dUxbXJBqNOFYv851p+8rCBTo=;
 b=pRvDRNbtbLCP5k7Rg3E8rpvX0kkiwD9B58bS59yCsavUbUSlYCS1J2jL0UfapzUKi/
 DgonOL8X+4iFl4bMvLrtCdBa3QuhL0073vcGj1obgZfqn1AvxxhJa5H09BmjWdScYBTu
 sMkj8N58HgkFeIuPagWyz0C3kxivZ92ahedkN9ngiedBd3x5F33hM7LcAXf/b/WD8G7Y
 PXQvfAAfZ1FMQEhc8UXxXiYcK4mCX4ELEW5+nkxPFanlPhzwLuKi55Tl7de7LAUUVX16
 SP5IpD/yAhfTJ5Nc8EQc5AfA7bMnaFpVrwV4uO61n01a3Cw+CiWjEvvX4XtaLwMwEBz0
 SxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685476002; x=1688068002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I4/mqWkXzyOSAPWFPm2dUxbXJBqNOFYv851p+8rCBTo=;
 b=LE5rNep1Awbm/39U0roIF9suQ8dH9g0/aDVWlg6XT8VgxrnhQKJjwY6/PveKX5jmvw
 wIPTa8fND6ncRKJ2ku+UP2iW2dkBJpn9+9hwisyoYyVrRnjdN+teHDwokZHkmo2h+Ohy
 Tsf2McUitOcXridAxAivQ1sCQnyfL9UpCO6FcvysVKWLhuD5FiIDcYxTFQTpYkxMltZT
 ZGxexGqAOpKgpPSk0Je60UUsDD+lekchdbg1FvVlWB1rMWbFOKBYvuHSDeEe5I0G9M2u
 CFbOaHcoyVor98x+gmBzTf7XvCn/dgM1daNLoZ5HbgI2ewljkM/X2nG+gJu9KL6u/Xpp
 jEAQ==
X-Gm-Message-State: AC+VfDx82xDAT/Tp4Vku/FHic/Dn+Pn0anEGQLnWDgzKlYocMgnyswYz
 2x+YVRe0rQ5aCSvvGjxdC4H41fE0m8/kzfaoJbc=
X-Google-Smtp-Source: ACHHUZ5VYxf4vI88JF0CBIRACGCOzLby6BMmNC6Z/yk/K6+HWSmvmt8XuFrxYGIG7wIwTNpbiJApfQ==
X-Received: by 2002:a05:6870:c803:b0:192:cb3d:c069 with SMTP id
 ee3-20020a056870c80300b00192cb3dc069mr1246884oab.2.1685476002102; 
 Tue, 30 May 2023 12:46:42 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (200-162-225-121.static-corp.ajato.com.br. [200.162.225.121])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056870a48300b0019fa8728b05sm342214oal.39.2023.05.30.12.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:46:41 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 03/16] target/riscv/cpu.c: restrict 'mvendorid' value
Date: Tue, 30 May 2023 16:46:10 -0300
Message-Id: <20230530194623.272652-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530194623.272652-1-dbarboza@ventanamicro.com>
References: <20230530194623.272652-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2b.google.com
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

We're going to change the handling of mvendorid/marchid/mimpid by the
KVM driver. Since these are always present in all CPUs let's put the
same validation for everyone.

It doesn't make sense to allow 'mvendorid' to be different than it
is already set in named (vendor) CPUs. Generic (dynamic) CPUs can have
any 'mvendorid' they want.

Change 'mvendorid' to be a class property created via
'object_class_property_add', instead of using the DEFINE_PROP_UINT32()
macro. This allow us to define a custom setter for it that will verify,
for named CPUs, if mvendorid is different than it is already set by the
CPU. This is the error thrown for the 'veyron-v1' CPU if 'mvendorid' is
set to an invalid value:

$ qemu-system-riscv64 -M virt -nographic -cpu veyron-v1,mvendorid=2
qemu-system-riscv64: can't apply global veyron-v1-riscv-cpu.mvendorid=2:
    Unable to change veyron-v1-riscv-cpu mvendorid (0x61f)

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 72f5433776..bcd69bb032 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1723,7 +1723,6 @@ static void riscv_cpu_add_user_properties(Object *obj)
 static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
 
-    DEFINE_PROP_UINT32("mvendorid", RISCVCPU, cfg.mvendorid, 0),
     DEFINE_PROP_UINT64("marchid", RISCVCPU, cfg.marchid, RISCV_CPU_MARCHID),
     DEFINE_PROP_UINT64("mimpid", RISCVCPU, cfg.mimpid, RISCV_CPU_MIMPID),
 
@@ -1810,6 +1809,32 @@ static const struct TCGCPUOps riscv_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
+static bool riscv_cpu_is_dynamic(Object *cpu_obj)
+{
+    return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
+}
+
+static void cpu_set_mvendorid(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    bool dynamic_cpu = riscv_cpu_is_dynamic(obj);
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint32_t prev_val = cpu->cfg.mvendorid;
+    uint32_t value;
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        return;
+    }
+
+    if (!dynamic_cpu && prev_val != value) {
+        error_setg(errp, "Unable to change %s mvendorid (0x%x)",
+                   object_get_typename(obj), prev_val);
+        return;
+    }
+
+    cpu->cfg.mvendorid = value;
+}
+
 static void riscv_cpu_class_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
@@ -1841,6 +1866,10 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     cc->gdb_get_dynamic_xml = riscv_gdb_get_dynamic_xml;
     cc->tcg_ops = &riscv_tcg_ops;
 
+    object_class_property_add(c, "mvendorid", "uint32", NULL,
+                              cpu_set_mvendorid,
+                              NULL, NULL);
+
     device_class_set_props(dc, riscv_cpu_properties);
 }
 
-- 
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9EB7AF31F
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 20:42:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlCzR-0007Oj-68; Tue, 26 Sep 2023 14:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qlCzH-0007KO-C5
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 14:40:47 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qlCzE-0006XU-OT
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 14:40:47 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5789ffc8ae0so6226359a12.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 11:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695753643; x=1696358443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oIH4svuG9rAz+nAW3v3qOrSx3mRDh32/ViA6suYeCik=;
 b=cCRvXcfu2HquAgLbfnOe7Tei3yvohTMdOmeREJlCt0oM102R81K+pPTr79xmlCUMyW
 dpaM7I4V2HcILHb/CsfkP+zc90i5DdbUQh6Wdfn4dr2mAQhTlvoPT7w5fG+pD6jJwgGt
 PLh7HXfSTbelz1nlur3DhOpDNjtbKp7lTi/+nETinW2FmWx72Rk9yIFl6Cs04taV9DKy
 g/xR70zBui+AEs1U8n+gw6cACr9jJEJPqxK9C4kUahsfUWuMZs32wIWuQHc1e7kf4dDg
 nSW0TgwV0E/Z5ruq9oxqp50jbNjWLeRVcpVKDY5gZGTQKl6PM4QYSBhH2s/HZL1hHV8r
 laJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695753643; x=1696358443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oIH4svuG9rAz+nAW3v3qOrSx3mRDh32/ViA6suYeCik=;
 b=Gw37ERki1V887QrhYfZyC9Qx4MsmIlouSaWFqrA5HKPlzEnonohb7Ava2gV52RB0rs
 Sp3R2n1yZuamZd6R/Twc0f2upIHJiPlyoIPZUQeJ6LWopPDyP9KlPJkK4YTll0Df5ObM
 5g860qUlSdoEoJuOkcGvjKedMNYaay28GlExHdK4sEaqwmQgoQJH1FE7+/ZOF+mZYZvt
 cPk2eN0KVx6WBRQE/rVmZRow59UdvRcGaT+6D41FRhuL/lXGkmi+OAVnilFqNZWTsko/
 yaXq6hC6bvfAiFCmDvhXFYVV4nUYdyq2oh2WtboVJ8Nq0ZJ0jU3EkOuuQacF28BHaoOS
 U1VQ==
X-Gm-Message-State: AOJu0YzQlSHHJryO26N0A5ZAfPdlg95VA/lB1r7FYmB4YEwXaaxBdue6
 PKk0BT0S3ZQGybldBg7XJfwjYPejXNStA2Fdt/I=
X-Google-Smtp-Source: AGHT+IGoVDU/Go59Z5Cg/sW2MLzZiT97AqAa6Gcm5PxqjBsHOXer+yPZLpg2Z+EHiFPAAI7q1zZoHw==
X-Received: by 2002:a05:6a20:1056:b0:14c:c9f6:d657 with SMTP id
 gt22-20020a056a20105600b0014cc9f6d657mr7809883pzc.22.1695753643200; 
 Tue, 26 Sep 2023 11:40:43 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 a11-20020a170902eccb00b001b9cdf11764sm11268306plh.31.2023.09.26.11.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 11:40:42 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 6/6] target/riscv/riscv-qmp-cmds.c: check CPU accel in
 query-cpu-model-expansion
Date: Tue, 26 Sep 2023 15:40:19 -0300
Message-ID: <20230926184019.166352-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926184019.166352-1-dbarboza@ventanamicro.com>
References: <20230926184019.166352-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use the recently added riscv_cpu_accelerator_compatible() to filter
unavailable CPUs for a given accelerator. At this moment this is the
case for a QEMU built with KVM and TCG support querying a binary running
with TCG:

qemu-system-riscv64 -S -M virt,accel=tcg -display none
    -qmp tcp:localhost:1234,server,wait=off

./qemu/scripts/qmp/qmp-shell localhost:1234

(QEMU) query-cpu-model-expansion type=full model={"name":"host"}
{"error": {"class": "GenericError", "desc": "'host' CPU not available with tcg"}}

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/riscv-qmp-cmds.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index 5b2d186c83..2f2dbae7c8 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -31,6 +31,8 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/visitor.h"
 #include "qom/qom-qobject.h"
+#include "sysemu/kvm.h"
+#include "sysemu/tcg.h"
 #include "cpu-qom.h"
 #include "cpu.h"
 
@@ -63,6 +65,17 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     return cpu_list;
 }
 
+static void riscv_check_if_cpu_available(RISCVCPU *cpu, Error **errp)
+{
+    if (!riscv_cpu_accelerator_compatible(cpu)) {
+        g_autofree char *name = riscv_cpu_get_name(cpu);
+        const char *accel = kvm_enabled() ? "kvm" : "tcg";
+
+        error_setg(errp, "'%s' CPU not available with %s", name, accel);
+        return;
+    }
+}
+
 static void riscv_obj_add_qdict_prop(Object *obj, QDict *qdict_out,
                                      const char *name)
 {
@@ -161,6 +174,13 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
 
     obj = object_new(object_class_get_name(oc));
 
+    riscv_check_if_cpu_available(RISCV_CPU(obj), &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        object_unref(obj);
+        return NULL;
+    }
+
     if (qdict_in) {
         riscv_cpuobj_validate_qdict_in(obj, model->props, qdict_in,
                                        &local_err);
-- 
2.41.0



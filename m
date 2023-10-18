Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ED77CE85A
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 21:58:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtCfI-0003tH-9s; Wed, 18 Oct 2023 15:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qtCfC-0003st-5V
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:57:06 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qtCfA-0001fY-MD
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:57:05 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-27d18475ed4so5497260a91.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 12:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697659023; x=1698263823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SOAxUmaqdKtbbLnRXBvRUUIo/9yaoaQnzCAPM1zDU9I=;
 b=QeFezOuhKbuSD4ui+6BKCXlMLkwgTozax+8l15BKtgfqM7IeHOOO9NhP9bUej178ZF
 6dRmLb2lQ9fqR16I664E6ZA8dvHVQgf/rnqGS43onBmwP0v5CYUn+rRevn/ZsJbDP0a/
 8keexBaRr2YbpjtwpGTgqRzWfIRbJKDVX8ZKw+1w/dpG0tQqbpf0w/D9oTat9y44LVFC
 /BieZgNHdSfX33CMUoUV0TPWnmIf02oQc+e1DJsolDsND7T/RlK7JME7qocXb5Up/qzz
 Q03Jzy5xa6BwIjmZ08gmt5aGIvL6qOfUZCTXV8KUmqP4AnytcKbW/ptOu1/Na3tHq8rJ
 RBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697659023; x=1698263823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SOAxUmaqdKtbbLnRXBvRUUIo/9yaoaQnzCAPM1zDU9I=;
 b=ifY/vr0z4aIyTLfuYmcvjWQM6N/BqHSWQuPd9Sm1ZkIcxa3TzJ5LMvqKzErTmpEplk
 Vlo7DoRAUXNc5xnoelD/ptApJ1b1aBzjp9gJWrzkUEkmmMeHdmfr3uZmHyzHD43c/zBy
 BmBXFwG3SMKAHAvczMG1GO+sa58xtItH3Ti5TpsmOQVHkVX+MoyMEB0IQhEMPhYLF3pY
 /eTjzgz5htXeyOGX3zMm4YviUxS1PJmYXzUvp7a1q7v3HyFaCQbL4307CKurqVUAbcCL
 HHyHYgMu28ghkWyA7Sfu5pLq/lDiURbVE4Wh/1frrWGZuvMvG/mHPB5uA8w/LeZlfcgK
 432w==
X-Gm-Message-State: AOJu0Yw32flh8SB2SYdspSqXkq+9hTUhAV3wAIipRZI2o+5UUzEE4PFs
 vTwgLAY/T0s1SSHuKkkf8JL+YStgX5h/aGDiA4g=
X-Google-Smtp-Source: AGHT+IGZaCwpN/MsvnLnxRo88axQa6jw6hlJSnD4kiuM/L2tfdwzeI+y7GU2hxuTwxhlOA6fqWnO2A==
X-Received: by 2002:a17:90b:3d07:b0:27d:5616:9907 with SMTP id
 pt7-20020a17090b3d0700b0027d56169907mr167365pjb.46.1697659022975; 
 Wed, 18 Oct 2023 12:57:02 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.45.186.249])
 by smtp.gmail.com with ESMTPSA id
 ku12-20020a17090b218c00b00268b439a0cbsm256359pjb.23.2023.10.18.12.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 12:57:02 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 6/6] target/riscv/riscv-qmp-cmds.c: check CPU accel in
 query-cpu-model-expansion
Date: Wed, 18 Oct 2023 16:56:38 -0300
Message-ID: <20231018195638.211151-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018195638.211151-1-dbarboza@ventanamicro.com>
References: <20231018195638.211151-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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



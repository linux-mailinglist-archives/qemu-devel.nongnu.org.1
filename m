Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 698347DFC8A
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 23:46:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qygR9-0006Rt-6A; Thu, 02 Nov 2023 18:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qygR6-0006RT-9i
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 18:45:12 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qygR4-0003Il-43
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 18:45:12 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a7b3d33663so17910807b3.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 15:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698965108; x=1699569908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9vkQpTeB3ayrchqiqPL77Nx2STXCsE/ldIKYWZcyJE=;
 b=gILa4O6UMiNwSkMh73RdkD9QRke6VYo50zRdZCzil02W6Hw/+1blMagvvhFgGxkgMn
 +ULAGvRyNtXRyqr83lbcrch6mCJgymm3zi+y76pj5sSRDG8lZ3cGO4QiLisBFG3P3tJN
 vkE/PCen15/r23LeAH35xodVaK4mDj4UU3HqwIX3UjxcrJ42l0abSaf9U95n1XyTx9QO
 VJhh8vDrYk2hl3e9Bz60FNzNFFNYGNwOiehRAlgofdfVLq71jhYIc12QNwwiTYgnU1Ju
 nBvbsWYsIJUdFf4vvoZxOlruHUBT8ykR9CV6uzofHFHXMLnRE4GVC9uaft52QreZaQBe
 ZxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965108; x=1699569908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W9vkQpTeB3ayrchqiqPL77Nx2STXCsE/ldIKYWZcyJE=;
 b=gvrP9OQxLP7YqBAAm0yuuhmetxcMukgX9iS6PohWmfjceAnZCqROwCa28qrFbJhhDq
 Rs7orPoYv+apQFlgBY6VXR+UTlCWGEJjiGZoOrYUWUklDnKFoK+v9MgbSt4F5u+u1XA0
 a8k2PY7VAZHluhmh9FtyaZm0EUvMAHpByCZlwArumks0wEfvgd5bCatnhBdSeBN/cJYf
 rhC7J8YsHHtXtLN2+5QPuyPONztz9Sq5bF8eR8NmZgidSijpogpxlcnMHUWudVjkRC/m
 oO+oBDgPVKygew9AZu42PY+bd81oJRKOKx2+5Zs5ymrD7FwEtlRyt77wn4/bnQ6gXw+J
 BRYw==
X-Gm-Message-State: AOJu0YxoD3T0UlUe+ThpKwCCnYbWnhOr/yqLxGPJExcbWISvErjmAbZQ
 a9k3xZr5/lVgy2fpPwXPwXpMHLjjZcPnmhiENkA=
X-Google-Smtp-Source: AGHT+IEeSQ9NAkrXshkA+GeWP6eGLqzmD1llBPVX1u+OHxNgI1cg7zEfebdC9iUN4xBwoYS1E3o55w==
X-Received: by 2002:a81:e20a:0:b0:5a7:d9e6:8fd4 with SMTP id
 p10-20020a81e20a000000b005a7d9e68fd4mr1034920ywl.12.1698965108111; 
 Thu, 02 Nov 2023 15:45:08 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 ce10-20020a05690c098a00b0059b24bd4f2asm259523ywb.57.2023.11.02.15.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 15:45:07 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 07/19] riscv-qmp-cmds.c: expose named features in
 cpu_model_expansion
Date: Thu,  2 Nov 2023 19:44:33 -0300
Message-ID: <20231102224445.527355-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102224445.527355-1-dbarboza@ventanamicro.com>
References: <20231102224445.527355-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112f.google.com
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

Named features (zic64b the sole example at this moment) aren't expose to
users, thus we need another way to expose them.

Go through each named feature, get its boolean value, do the needed
conversions (bool to qbool, qbool to QObject) and add it to output dict.

Another adjustment is needed: named features are evaluated during
finalize(), so riscv_cpu_finalize_features() needs to be mandatory
regardless of whether we have an input dict or not. Otherwise zic64b
will always return 'false', which is incorrect: the default values of
cache blocksizes ([cbom/cbop/cboz]_blocksize) are set to 64, satisfying
the conditions for zic64b.

Here's an API usage example after this patch:

 $ ./build/qemu-system-riscv64 -S -M virt -display none
    -qmp tcp:localhost:1234,server,wait=off

 $ ./scripts/qmp/qmp-shell localhost:1234
Welcome to the QMP low-level shell!
Connected to QEMU 8.1.50

(QEMU) query-cpu-model-expansion type=full model={"name":"rv64"}
{"return": {"model":
    {"name": "rv64", "props": {... "zic64b": true, ...}}}}

zic64b is set to 'true', as expected, since all cache sizes are 64
bytes by default.

If we change one of the cache blocksizes, zic64b is returned as 'false':

(QEMU) query-cpu-model-expansion type=full model={"name":"rv64","props":{"cbom_blocksize":128}}
{"return": {"model":
    {"name": "rv64", "props": {... "zic64b": false, ...}}}}

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/riscv-qmp-cmds.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index 2f2dbae7c8..5ada279776 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -26,6 +26,7 @@
 
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine-target.h"
+#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qobject-input-visitor.h"
@@ -99,6 +100,22 @@ static void riscv_obj_add_multiext_props(Object *obj, QDict *qdict_out,
     }
 }
 
+static void riscv_obj_add_named_feats_qdict(Object *obj, QDict *qdict_out)
+{
+    const RISCVCPUMultiExtConfig *named_cfg;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    QObject *value;
+    bool flag_val;
+
+    for (int i = 0; riscv_cpu_named_features[i].name != NULL; i++) {
+        named_cfg = &riscv_cpu_named_features[i];
+        flag_val = isa_ext_is_enabled(cpu, named_cfg->offset);
+        value = QOBJECT(qbool_from_bool(flag_val));
+
+        qdict_put_obj(qdict_out, named_cfg->name, value);
+    }
+}
+
 static void riscv_cpuobj_validate_qdict_in(Object *obj, QObject *props,
                                            const QDict *qdict_in,
                                            Error **errp)
@@ -129,11 +146,6 @@ static void riscv_cpuobj_validate_qdict_in(Object *obj, QObject *props,
         goto err;
     }
 
-    riscv_cpu_finalize_features(RISCV_CPU(obj), &local_err);
-    if (local_err) {
-        goto err;
-    }
-
     visit_end_struct(visitor, NULL);
 
 err:
@@ -191,6 +203,13 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
         }
     }
 
+    riscv_cpu_finalize_features(RISCV_CPU(obj), &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        object_unref(obj);
+        return NULL;
+    }
+
     expansion_info = g_new0(CpuModelExpansionInfo, 1);
     expansion_info->model = g_malloc0(sizeof(*expansion_info->model));
     expansion_info->model->name = g_strdup(model->name);
@@ -200,6 +219,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_extensions);
     riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_experimental_exts);
     riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_vendor_exts);
+    riscv_obj_add_named_feats_qdict(obj, qdict_out);
 
     /* Add our CPU boolean options too */
     riscv_obj_add_qdict_prop(obj, qdict_out, "mmu");
-- 
2.41.0



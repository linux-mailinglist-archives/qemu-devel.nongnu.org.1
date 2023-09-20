Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B2C7A8E97
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 23:39:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj4th-0005AU-A0; Wed, 20 Sep 2023 17:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qj4te-00058Q-Qi
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 17:38:10 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qj4td-0006Xh-85
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 17:38:10 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6c0c675cb03so219555a34.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695245888; x=1695850688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZB/Eo7+yUhj7MB+Xte6Mc3Nr/qRQpQ36eJpX2OrNeA=;
 b=di1RTnWFvQEUD3dFceROBDGdDEE9ZbeTFJuDXVwt0t08ooAaH9enytF746QJMU0ao6
 DqYFEfZoTEdMkQWBysR9NP+rpG9UPtqiM/ikIxLYumndY2ABfMJW12Fh85bcGEgq6yd0
 hicn4YqMuNlEspUmMenUhITxkjZVcGhRbG97nd7dKGZKA899q6OAay0I8EkrvC8M4JV2
 SNzAHQTcFiwAhe0vlR3NPpdglaGHgEFTJn332GCFIkt1diRpAK0aLDiNLp2UF86XXhHT
 nx1j6+vD2HiKqVl6vaRB1ASHAe3tP079G4i1nF/Hfg0NjQlVY/EnokLZd9fgFLe6veGF
 CH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695245888; x=1695850688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YZB/Eo7+yUhj7MB+Xte6Mc3Nr/qRQpQ36eJpX2OrNeA=;
 b=DqlW3jO6V/oXTmwC7JL/39hCYgbgj84QPD0LCZOPg5zK0Ow7zKbkF8b6GYx1cBf4dP
 SHDj1hICaS1oz0Gy69A3EbSMUYxcyBGyMRmCOMWE2v0BDcI+9trIkuntft7lfABbyg2p
 eoCwv9F/ttDneZfOhTrqbuc3mmEgiRpQ5zzi+OVTQb0pCKKrIqe1qLFHR5cwOP6iJ2z5
 g10FEAot8k2r+j+03asND0lida51AX2kKtCUquD9S4PMGieAOcsjtYuxp05BRWyDGypr
 pSs7DRcQOHfwFlhcPOQAwkKb76CrIeIaNhGRg0/ev2JK+z9yRIv3ZNdwMG/Ccc8ajJQL
 F1Xw==
X-Gm-Message-State: AOJu0YxWhGk/CpaVLGn35OzsaF8QgMaQMHSoLKk5eXbpQtWLsTC24oD1
 On9WaTYnhjmJ9cuMFp8UJS1r3w/508mUdP9l+cc=
X-Google-Smtp-Source: AGHT+IHA09yNF5sB1fGwLfJmr7d/3d2IkVuLDh+cYhvruCP+4rmdqw4nLgabx7EXJ9WH3MILTTfJWw==
X-Received: by 2002:a9d:7487:0:b0:6b9:cba0:93a9 with SMTP id
 t7-20020a9d7487000000b006b9cba093a9mr3671811otk.31.1695245887982; 
 Wed, 20 Sep 2023 14:38:07 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 e1-20020a9d7301000000b006b83a36c08bsm64415otk.53.2023.09.20.14.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 14:38:07 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 6/8] target/riscv: handle custom props in
 qmp_query_cpu_model_expansion
Date: Wed, 20 Sep 2023 18:37:41 -0300
Message-ID: <20230920213743.716265-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920213743.716265-1-dbarboza@ventanamicro.com>
References: <20230920213743.716265-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x334.google.com
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

Callers can add 'props' when querying for a cpu model expansion to see
if a given CPU model supports a certain criteria, and what's the
resulting CPU object.

If we have 'props' to handle, gather it in a QDict and use the new
riscv_cpuobj_validate_qdict_in() helper to validate it. This helper will
add the custom properties in the CPU object and validate it using
riscv_cpu_finalize_features(). Users will be aware of validation errors
if any occur, if not a CPU object with 'props' will be returned.

Here's an example with the veyron-v1 vendor CPU. Disabling vendor CPU
extensions is allowed, assuming the final config is valid. Disabling
'smstateen' is a valid expansion:

(QEMU) query-cpu-model-expansion type=full model={"name":"veyron-v1","props":{"smstateen":false}}
{"return": {"model": {"name": "veyron-v1", "props": {"zicond": false, ..., "smstateen": false, ...}

But enabling extensions isn't allowed for vendor CPUs. E.g. enabling 'V'
for the veyron-v1 CPU isn't allowed:

(QEMU) query-cpu-model-expansion type=full model={"name":"veyron-v1","props":{"v":true}}
{"error": {"class": "GenericError", "desc": "'veyron-v1' CPU does not allow enabling extensions"}}

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/riscv-qmp-cmds.c | 65 +++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index 2170562e3a..5b2d186c83 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -27,6 +27,9 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine-target.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qerror.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/visitor.h"
 #include "qom/qom-qobject.h"
 #include "cpu-qom.h"
 #include "cpu.h"
@@ -83,14 +86,58 @@ static void riscv_obj_add_multiext_props(Object *obj, QDict *qdict_out,
     }
 }
 
+static void riscv_cpuobj_validate_qdict_in(Object *obj, QObject *props,
+                                           const QDict *qdict_in,
+                                           Error **errp)
+{
+    const QDictEntry *qe;
+    Visitor *visitor;
+    Error *local_err = NULL;
+
+    visitor = qobject_input_visitor_new(props);
+    if (!visit_start_struct(visitor, NULL, NULL, 0, &local_err)) {
+        goto err;
+    }
+
+    for (qe = qdict_first(qdict_in); qe; qe = qdict_next(qdict_in, qe)) {
+        object_property_find_err(obj, qe->key, &local_err);
+        if (local_err) {
+            goto err;
+        }
+
+        object_property_set(obj, qe->key, visitor, &local_err);
+        if (local_err) {
+            goto err;
+        }
+    }
+
+    visit_check_struct(visitor, &local_err);
+    if (local_err) {
+        goto err;
+    }
+
+    riscv_cpu_finalize_features(RISCV_CPU(obj), &local_err);
+    if (local_err) {
+        goto err;
+    }
+
+    visit_end_struct(visitor, NULL);
+
+err:
+    error_propagate(errp, local_err);
+    visit_free(visitor);
+}
+
 CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
                                                      CpuModelInfo *model,
                                                      Error **errp)
 {
     CpuModelExpansionInfo *expansion_info;
+    const QDict *qdict_in = NULL;
     QDict *qdict_out;
     ObjectClass *oc;
     Object *obj;
+    Error *local_err = NULL;
 
     if (type != CPU_MODEL_EXPANSION_TYPE_FULL) {
         error_setg(errp, "The requested expansion type is not supported");
@@ -104,8 +151,26 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
         return NULL;
     }
 
+    if (model->props) {
+        qdict_in = qobject_to(QDict, model->props);
+        if (!qdict_in) {
+            error_setg(errp, QERR_INVALID_PARAMETER_TYPE, "props", "dict");
+            return NULL;
+        }
+    }
+
     obj = object_new(object_class_get_name(oc));
 
+    if (qdict_in) {
+        riscv_cpuobj_validate_qdict_in(obj, model->props, qdict_in,
+                                       &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            object_unref(obj);
+            return NULL;
+        }
+    }
+
     expansion_info = g_new0(CpuModelExpansionInfo, 1);
     expansion_info->model = g_malloc0(sizeof(*expansion_info->model));
     expansion_info->model->name = g_strdup(model->name);
-- 
2.41.0



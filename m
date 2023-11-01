Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C363E7DE6CF
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 21:45:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyI2y-0002jF-7h; Wed, 01 Nov 2023 16:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyI2w-0002ib-AI
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:42:38 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyI2u-0000jP-Ph
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:42:38 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-d9ad67058fcso200464276.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698871355; x=1699476155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9vkQpTeB3ayrchqiqPL77Nx2STXCsE/ldIKYWZcyJE=;
 b=NdaMsRw2ASRTVgM7N+2cxRZCtYtdWQr374oxYlLI/sERlaqSKUS2Fbs+s+tjk/wNiS
 KEuZyePFwTcH9Weq/GoSYRePenUFlHirjMqjbEFrOpM99Ci9uehmamv4PMYZWwnJezGa
 joStAxWaHGSwNaOe32eRYBK+AY4tWNNJc/ZB6w1icXYVG3tB3ooabhcuv9CGOQEiK3SC
 ua4qokUGyZRw1vr/jAWPocanntgrgZYMRnh5tBTNnTdbt4nO90JvxGbVW9UpLrdJHtle
 bw2/NaekxGHbdDiblrEwR2NniTZpkBqfP+b0MX+u5oCiC7tfciaAusmOQCki4qRz30pF
 61JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698871355; x=1699476155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W9vkQpTeB3ayrchqiqPL77Nx2STXCsE/ldIKYWZcyJE=;
 b=NLop4J5V9oam9KFoFeFRYyNjwkC0awsW+OsMnhyg2jypKLmkdPm4ADeUf0orMEqlSz
 PI7Sw8BbP4q53CQCv2j3OxCi6hZeZS5Rfi+MV04jxYzZxsVAtov+8ungKkDzR2cbZsYc
 o9jLGtdE7VJXJrIlcc5f5CWFsJx69wXF8LxnhMBg6v1W/RHMjJ6rn1IQHLZoqoBoWL9i
 K8xISzvZMWPqs0jUe/AOHaD6l9XIJW4kb8pyAxqsnrgq4fdo+xc1ZZTo6rdjP1WG1MyW
 sOlXT05ZBeKL2ejdZzpcHtOntsJrPgWyoXiocEcoLeVn+/vMGEMzXMdDKEKIZMODMM/X
 sdGQ==
X-Gm-Message-State: AOJu0YzxpUqKndDsYJiJIzqoMgFMmACxlUYmGNM5UbcEg+Pr4r+yk3Zc
 1OFuvsT+9pTebmrJh8lWf8YKS17TGEVoVseEHtY=
X-Google-Smtp-Source: AGHT+IHc5qggz4PIvKNfh/i8VC/UE4xVbbUFvBvW4Z5CEw0B49oDZ062tpEfhigRDXFT9+PvVVjT/g==
X-Received: by 2002:a25:e78f:0:b0:d91:b6e5:54dd with SMTP id
 e137-20020a25e78f000000b00d91b6e554ddmr14900959ybh.3.1698871355214; 
 Wed, 01 Nov 2023 13:42:35 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 z187-20020a2533c4000000b00d9cc49edae9sm329724ybz.63.2023.11.01.13.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 13:42:34 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 09/19] riscv-qmp-cmds.c: expose named features in
 cpu_model_expansion
Date: Wed,  1 Nov 2023 17:41:54 -0300
Message-ID: <20231101204204.345470-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101204204.345470-1-dbarboza@ventanamicro.com>
References: <20231101204204.345470-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yb1-xb2c.google.com
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CB08295B4
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:06:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNURu-0007GU-Qt; Wed, 10 Jan 2024 04:00:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNURO-0005Ye-Mu
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:03 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNURL-0004Ux-PD
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:01 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3bbd6f87959so3175899b6e.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877198; x=1705481998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3qVrRwLRlTrx1SwD0xe8cFa7D+a3gGK5pBXkRnnSzkg=;
 b=H1F49ItwxAw89n60utzdozSJI1BmDC/VszHK8oFyodMF/kgPePUAy6q1s9VLhAaMbL
 tEHTGUAVSqz6WCPPf4synY+/rE4ZATtF4e+Zdt9SWVI1HKx9VGdEU4/247mNFqkyXr+W
 YkQ9ei+i7ltwdevMAzqxIsNJ6dJLTKGGdRq5vvdBrS0UXjHz5yUKAYEU5UlVcj0d2GTG
 FvjE8BLw7zq70jDk4oMTHAb8oxr+fR6Q3dxTopKShRT97ZHC4SobCP4YLsiF8EZgjtBb
 zcp2Zsn65/M38zjdz2GU75T053BlCCevnHq30B3d0rI+4UIJXDY0SBnnL3j6VcRK1WSY
 RzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877198; x=1705481998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3qVrRwLRlTrx1SwD0xe8cFa7D+a3gGK5pBXkRnnSzkg=;
 b=WVEUdBaH7gobUHclK3eglkj0PbJneXhOCV0ZJqJrl4koDhtMsE9BvolOA2u/+y9ndj
 5QUzZugH/7PRiZG8IYaZa37wOMEIhBQcJ1g3LsyeIpUTAYnF9VrcfWDSvllkcZdfyRY5
 0wXpMWKpb4NO5z61qor3JWU1T4QiakP5MCjnofRMnZHBOGhCn6od4WP78i27VthgZUi8
 YVnKa02p/LlRWsqIRatEmZKzzAxJeb8pOGuMFAYv5w7dZbfyTyNvm7UU09k+SejsbDRr
 2aUeaa2RBFXBRjk4mag6utmQfYmcJAb2YoXoB06V5VxSgmiTdi2XFqreSRM9WpuMQEI1
 j0Vg==
X-Gm-Message-State: AOJu0Yy+h1WSJ8V2eDq/PqbGxCX16HJ8tghYzbqz4o4hBojbO0G0drDG
 3AubiTiw2t9p0rNbk+fZggarqbb5VDrnyha+
X-Google-Smtp-Source: AGHT+IGaF5gXV726h8jRpMhCqCWpuuHr8cckCF9kBnGrSBnAEM7A2ri1lc4E0IKg80eJd252GV+FWw==
X-Received: by 2002:a05:6808:b14:b0:3bc:154d:4c82 with SMTP id
 s20-20020a0568080b1400b003bc154d4c82mr783036oij.109.1704877198448; 
 Wed, 10 Jan 2024 00:59:58 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:59:58 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 35/65] riscv-qmp-cmds.c: expose named features in
 cpu_model_expansion
Date: Wed, 10 Jan 2024 18:57:03 +1000
Message-ID: <20240110085733.1607526-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231218125334.37184-8-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/riscv-qmp-cmds.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index c5551d2cfe..35f2b21163 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -26,6 +26,7 @@
 
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine-target.h"
+#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qobject-input-visitor.h"
@@ -98,6 +99,22 @@ static void riscv_obj_add_multiext_props(Object *obj, QDict *qdict_out,
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
@@ -128,11 +145,6 @@ static void riscv_cpuobj_validate_qdict_in(Object *obj, QObject *props,
         goto err;
     }
 
-    riscv_cpu_finalize_features(RISCV_CPU(obj), &local_err);
-    if (local_err) {
-        goto err;
-    }
-
     visit_end_struct(visitor, NULL);
 
 err:
@@ -190,6 +202,13 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
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
@@ -199,6 +218,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_extensions);
     riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_experimental_exts);
     riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_vendor_exts);
+    riscv_obj_add_named_feats_qdict(obj, qdict_out);
 
     /* Add our CPU boolean options too */
     riscv_obj_add_qdict_prop(obj, qdict_out, "mmu");
-- 
2.43.0



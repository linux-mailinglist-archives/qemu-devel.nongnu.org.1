Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AE47E3300
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:33:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bry-00039R-Id; Mon, 06 Nov 2023 21:31:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Brd-0002km-Qv
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:50 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Brb-0002YH-Ho
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:49 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c9b7c234a7so47265105ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324245; x=1699929045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RP+I+gk8nRyXPkTyFhRmEPscrPMhOYtjtiSaKHa59zo=;
 b=OlaBM0ujgjC1onLEwZ2MbU9eoWb/fsY1dUnK0Rj4dLN0bPcujsILXI+prjzUM0+0yp
 xisffac+0SjH2Uu5ffDkOhhPaTqlUya6rnd8No8+v6rzc11FmmMhgRYPCUIv607Z2eeb
 9cbqq13h1t5vaV9SlXr89kD9mJsYbKGaWT+TKiajB2JU1gJrSpwNU8DjVGi2d97wBptm
 QjEzbhlaE+HuCRN8NXN+/2n6rNbMBNpreJL3DROQU5O2mRU7YTQJdRTlo4kT4ZODm15T
 rUTKmCuE3o250KJvoIvPQdsmQWVRxYoJrJ1tMSe+E7EqYQeddYM31hfV2PywuS9mJ8SR
 4vVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324245; x=1699929045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RP+I+gk8nRyXPkTyFhRmEPscrPMhOYtjtiSaKHa59zo=;
 b=mNikayrP085dR9NUvp0xi4Xlf0gR7CvMB+6wTavSUrWQsaH1YGreq6oDYhRkQpzQ2J
 2RVDRpfGmD7gP2BqKoNIUjS0/LsG3BY3Irav0CdcyjWZHXysT7utmoIC03ATGah9gnfz
 6+q9jhjrEWllxNlMy343zVJjtqzBCuPKpke/U+eFzzrAAzvcUapSb1CpUfz1cxpkk1CJ
 2OX+a26Ha71lgoIjkA9KsVXAPUV5tPMgaKSJQk3WMCYIMAPy98R8mWdUTJ8D3lZWl4/T
 rtCCosL43rOgdc9sWu/1Q80j4K5qvyygAv3srVzzQJEBVVJB3GwOZ5agIgMRXswgeZfu
 AhhQ==
X-Gm-Message-State: AOJu0Yzyr96qsYbt6LjbrE/kOiGsS2AZhxQRAT+rE49DLBEYIO3iX15Z
 4o7KfFvr8R847hmwZ1zX2tPBxTYPjBa4tA==
X-Google-Smtp-Source: AGHT+IEJfuugWW0I4xlKjlL6PC/S4Js0hqq6BqW3AjZD+P3SgxCp3TifhGFIzkB9hQudRcjGOCPoXg==
X-Received: by 2002:a17:902:efc9:b0:1ca:20a0:7b08 with SMTP id
 ja9-20020a170902efc900b001ca20a07b08mr28812915plb.50.1699324245069; 
 Mon, 06 Nov 2023 18:30:45 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:30:44 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/49] qapi,risc-v: add query-cpu-model-expansion
Date: Tue,  7 Nov 2023 12:29:10 +1000
Message-ID: <20231107022946.1055027-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

This API is used to inspect the characteristics of a given CPU model. It
also allows users to validate a CPU model with a certain configuration,
e.g. if "-cpu X,a=3Dtrue,b=3Dfalse" is a valid setup for a given QEMU
binary. We'll start implementing the first part. The second requires
more changes in RISC-V CPU boot flow.

The implementation is inspired by the existing ARM
query-cpu-model-expansion impl in target/arm/arm-qmp-cmds.c. We'll
create a RISCVCPU object with the required model, fetch its existing
properties, add a couple of relevant boolean options (pmp and mmu) and
display it to users.

Here's an usage example:

./build/qemu-system-riscv64 -S -M virt -display none \
  -qmp  tcp:localhost:1234,server,wait=3Doff

./scripts/qmp/qmp-shell localhost:1234
Welcome to the QMP low-level shell!
Connected to QEMU 8.1.50

(QEMU)  query-cpu-model-expansion type=3Dfull model=3D{"name":"rv64"}
{"return": {"model": {"name": "rv64", "props": {"zicond": false, "x-zvfh": =
false, "mmu": true, "x-zvfbfwma": false, "x-zvfbfmin": false, "xtheadbs": f=
alse, "xtheadbb": false, "xtheadba": false, "xtheadmemidx": false, "smstate=
en": false, "zfinx": false, "Zve64f": false, "Zve32f": false, "x-zvfhmin": =
false, "xventanacondops": false, "xtheadcondmov": false, "svpbmt": false, "=
zbs": true, "zbc": true, "zbb": true, "zba": true, "zicboz": true, "xtheadm=
ac": false, "Zfh": false, "Zfa": true, "zbkx": false, "zbkc": false, "zbkb"=
: false, "Zve64d": false, "x-zfbfmin": false, "zk": false, "x-epmp": false,=
 "xtheadmempair": false, "zkt": false, "zks": false, "zkr": false, "zkn": f=
alse, "Zfhmin": false, "zksh": false, "zknh": false, "zkne": false, "zknd":=
 false, "zhinx": false, "Zicsr": true, "sscofpmf": false, "Zihintntl": true=
, "sstc": true, "xtheadcmo": false, "x-zvbb": false, "zksed": false, "x-zvk=
ned": false, "xtheadsync": false, "x-zvkg": false, "zhinxmin": false, "svad=
u": true, "xtheadfmv": false, "x-zvksed": false, "svnapot": false, "pmp": t=
rue, "x-zvknhb": false, "x-zvknha": false, "xtheadfmemidx": false, "x-zvksh=
": false, "zdinx": false, "zicbom": true, "Zihintpause": true, "svinval": f=
alse, "zcf": false, "zce": false, "zcd": false, "zcb": false, "zca": false,=
 "x-ssaia": false, "x-smaia": false, "zmmul": false, "x-zvbc": false, "Zife=
ncei": true, "zcmt": false, "zcmp": false, "Zawrs": true}}}}

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231018195638.211151-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 qapi/machine-target.json      |  6 ++-
 target/riscv/riscv-qmp-cmds.c | 75 +++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index c8d7d9868d..7b7149f81c 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -231,7 +231,8 @@
   'if': { 'any': [ 'TARGET_S390X',
                    'TARGET_I386',
                    'TARGET_ARM',
-                   'TARGET_LOONGARCH64' ] } }
+                   'TARGET_LOONGARCH64',
+                   'TARGET_RISCV' ] } }
=20
 ##
 # @query-cpu-model-expansion:
@@ -277,7 +278,8 @@
   'if': { 'any': [ 'TARGET_S390X',
                    'TARGET_I386',
                    'TARGET_ARM',
-                   'TARGET_LOONGARCH64' ] } }
+                   'TARGET_LOONGARCH64',
+                   'TARGET_RISCV' ] } }
=20
 ##
 # @CpuDefinitionInfo:
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index 5ecff1afb3..2170562e3a 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -24,8 +24,12 @@
=20
 #include "qemu/osdep.h"
=20
+#include "qapi/error.h"
 #include "qapi/qapi-commands-machine-target.h"
+#include "qapi/qmp/qdict.h"
+#include "qom/qom-qobject.h"
 #include "cpu-qom.h"
+#include "cpu.h"
=20
 static void riscv_cpu_add_definition(gpointer data, gpointer user_data)
 {
@@ -55,3 +59,74 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error *=
*errp)
=20
     return cpu_list;
 }
+
+static void riscv_obj_add_qdict_prop(Object *obj, QDict *qdict_out,
+                                     const char *name)
+{
+    ObjectProperty *prop =3D object_property_find(obj, name);
+
+    if (prop) {
+        QObject *value;
+
+        assert(prop->get);
+        value =3D object_property_get_qobject(obj, name, &error_abort);
+
+        qdict_put_obj(qdict_out, name, value);
+    }
+}
+
+static void riscv_obj_add_multiext_props(Object *obj, QDict *qdict_out,
+                                         const RISCVCPUMultiExtConfig *arr)
+{
+    for (int i =3D 0; arr[i].name !=3D NULL; i++) {
+        riscv_obj_add_qdict_prop(obj, qdict_out, arr[i].name);
+    }
+}
+
+CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType=
 type,
+                                                     CpuModelInfo *model,
+                                                     Error **errp)
+{
+    CpuModelExpansionInfo *expansion_info;
+    QDict *qdict_out;
+    ObjectClass *oc;
+    Object *obj;
+
+    if (type !=3D CPU_MODEL_EXPANSION_TYPE_FULL) {
+        error_setg(errp, "The requested expansion type is not supported");
+        return NULL;
+    }
+
+    oc =3D cpu_class_by_name(TYPE_RISCV_CPU, model->name);
+    if (!oc) {
+        error_setg(errp, "The CPU type '%s' is not a known RISC-V CPU type=
",
+                   model->name);
+        return NULL;
+    }
+
+    obj =3D object_new(object_class_get_name(oc));
+
+    expansion_info =3D g_new0(CpuModelExpansionInfo, 1);
+    expansion_info->model =3D g_malloc0(sizeof(*expansion_info->model));
+    expansion_info->model->name =3D g_strdup(model->name);
+
+    qdict_out =3D qdict_new();
+
+    riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_extensions);
+    riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_experimental_ex=
ts);
+    riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_vendor_exts);
+
+    /* Add our CPU boolean options too */
+    riscv_obj_add_qdict_prop(obj, qdict_out, "mmu");
+    riscv_obj_add_qdict_prop(obj, qdict_out, "pmp");
+
+    if (!qdict_size(qdict_out)) {
+        qobject_unref(qdict_out);
+    } else {
+        expansion_info->model->props =3D QOBJECT(qdict_out);
+    }
+
+    object_unref(obj);
+
+    return expansion_info;
+}
--=20
2.41.0



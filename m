Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFE07E32F4
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:32:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bs5-0003iZ-EX; Mon, 06 Nov 2023 21:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bs1-0003SW-0m
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:13 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Brx-0002n9-P9
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:12 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc5b705769so47200575ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324258; x=1699929058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=brc8LPoI6i56fPp8v/s+mfo+dQa+BkbCRd3TgBQFTJI=;
 b=TC7k8Q+zU0qXDyDlb5NdTgggNO+CJwzkMd2nUU3rpyrf0PmrxMVocjWNF0vep6uXt4
 AbNIU6uqoH4koBAD3fZuVUb9CYnuH4UDVagsaN95/cVO/+b87/TebovmbCg98zrywRcc
 gNkEWlzym3Pt8dp6idwySWi2yGCrVX4obo2o6cmc/sD8XZQZ5rhFvb++vv+qzQYAOSIo
 L/AKaTnV8riIrFg/EJMgAuXbTq8Ky0rfRUPfgsQwUDmp6m562H5mZGxfAy82OBWoBn+h
 4MzV1OsfEB0kTs+mUbOOUNMTTdIkCXymwpDb+kntY4e53W4eQLGPDuR0EJtu1O5vxYeG
 Wsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324258; x=1699929058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=brc8LPoI6i56fPp8v/s+mfo+dQa+BkbCRd3TgBQFTJI=;
 b=LBhzT3/C+VSjbFN5e28tV+J0RUXEmfsHu5qv12biLW/cka0g6iO0ihPFz1M6kvVc4M
 d4SA4PXe4vvfuvvcqQmrwo70HWxZ0V2P4I62PukFkPa2A2Dm1SK6la/PHxCYMKL9ABtN
 SRL4UbgyRDti34AFHn+Z5gw0SwWyMT7Eykp1vVyTb5bCenfCHT6mN+gkecmA6vv3ICkX
 EjpnliAlBB8oyI2nJ2XWcnpCg1tz1jZvLGYhBKXZobT57+zHmIdDCrD96gifBSzhWmCn
 AQJeLQGry2NP++d77X+qnF/J2SW2rhEafXmqOP/esiBGIH1Ehl7Ij4eJOuF7y+3UdfYg
 6mjA==
X-Gm-Message-State: AOJu0YzGHATFghOtSJct77AWj3CkDRLgf0Avp7zdB137X0F3naWE/eTA
 GGaXAtfKmMf+DIgUSgs3/hNjdjvPC659/A==
X-Google-Smtp-Source: AGHT+IE51BjhlViJZL9Fe6xIcWYc4f1nbGkAxyMV5IHWpeEpMjCI4FQ37UbCjqOnyrwBW+ZN+F4eFA==
X-Received: by 2002:a17:902:da87:b0:1cc:4124:7754 with SMTP id
 j7-20020a170902da8700b001cc41247754mr34094317plx.32.1699324258301; 
 Mon, 06 Nov 2023 18:30:58 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:30:57 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 18/49] target/riscv/riscv-qmp-cmds.c: check CPU accel in
 query-cpu-model-expansion
Date: Tue,  7 Nov 2023 12:29:14 +1000
Message-ID: <20231107022946.1055027-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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
Message-ID: <20231018195638.211151-7-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F5A75184D
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 07:47:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJp9k-0007jP-5B; Thu, 13 Jul 2023 01:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qJp9K-0007gb-NT
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 01:46:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qJp9I-0001Ty-Oo
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 01:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689227155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ctc54UK+2FaeECy107aW/TxlZ3i7LcNlV6WoFKBEmwA=;
 b=TUVD03iGFZ4RjCiExVL73KAMHiUpIfkMomH5ksV6VnKn7gqj5bc/np9lhPEWc9DgUOk56O
 OeiaaD9bwlYgyAtKBsrWwi641jH7pLCSTH32b25wF24OYeQ9hmor/yPAkZu8XQAATS2rK0
 GPclNX2YpJPpbspRYz4qW8xFo/STZw8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-EY3TQcYZPlmsPZCLVZU_TQ-1; Thu, 13 Jul 2023 01:45:51 -0400
X-MC-Unique: EY3TQcYZPlmsPZCLVZU_TQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FB2E104458D;
 Thu, 13 Jul 2023 05:45:51 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-126.bne.redhat.com [10.64.54.126])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C6FA5111DCE0;
 Thu, 13 Jul 2023 05:45:47 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, eduardo@habkost.net,
 peter.maydell@linaro.org, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, shan.gavin@gmail.com
Subject: [PATCH 1/3] machine: Factor CPU type invalidation out into helper
Date: Thu, 13 Jul 2023 15:45:00 +1000
Message-ID: <20230713054502.410911-2-gshan@redhat.com>
In-Reply-To: <20230713054502.410911-1-gshan@redhat.com>
References: <20230713054502.410911-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The CPU type invalidation logic in machine_run_board_init() is
independent enough. Lets factor it out into helper validate_cpu_type().
Since we're here, the relevant comments are improved a bit.

No functional change intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 hw/core/machine.c | 81 +++++++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 38 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index f0d35c6401..68b866c762 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1349,12 +1349,52 @@ out:
     return r;
 }
 
+static void validate_cpu_type(MachineState *machine)
+{
+    MachineClass *machine_class = MACHINE_GET_CLASS(machine);
+    ObjectClass *oc = object_class_by_name(machine->cpu_type);
+    CPUClass *cc = CPU_CLASS(oc);
+    int i;
+
+    /*
+     * Check if the user-specified CPU type is supported when the valid
+     * CPU types have been determined. Note that the user-specified CPU
+     * type is given by '-cpu' option.
+     */
+    if (!machine->cpu_type || !machine_class->valid_cpu_types) {
+        goto out_no_check;
+    }
+
+    for (i = 0; machine_class->valid_cpu_types[i]; i++) {
+        if (object_class_dynamic_cast(oc, machine_class->valid_cpu_types[i])) {
+            break;
+        }
+    }
+
+    if (!machine_class->valid_cpu_types[i]) {
+        /* The user-specified CPU type is invalid */
+        error_report("Invalid CPU type: %s", machine->cpu_type);
+        error_printf("The valid types are: %s",
+                     machine_class->valid_cpu_types[0]);
+        for (i = 1; machine_class->valid_cpu_types[i]; i++) {
+            error_printf(", %s", machine_class->valid_cpu_types[i]);
+        }
+        error_printf("\n");
+
+        exit(1);
+    }
+
+    /* Check if CPU type is deprecated and warn if so */
+out_no_check:
+    if (cc && cc->deprecation_note) {
+        warn_report("CPU model %s is deprecated -- %s",
+                    machine->cpu_type, cc->deprecation_note);
+    }
+}
 
 void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp)
 {
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
-    ObjectClass *oc = object_class_by_name(machine->cpu_type);
-    CPUClass *cc;
 
     /* This checkpoint is required by replay to separate prior clock
        reading from the other reads, because timer polling functions query
@@ -1405,42 +1445,7 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
         machine->ram = machine_consume_memdev(machine, machine->memdev);
     }
 
-    /* If the machine supports the valid_cpu_types check and the user
-     * specified a CPU with -cpu check here that the user CPU is supported.
-     */
-    if (machine_class->valid_cpu_types && machine->cpu_type) {
-        int i;
-
-        for (i = 0; machine_class->valid_cpu_types[i]; i++) {
-            if (object_class_dynamic_cast(oc,
-                                          machine_class->valid_cpu_types[i])) {
-                /* The user specificed CPU is in the valid field, we are
-                 * good to go.
-                 */
-                break;
-            }
-        }
-
-        if (!machine_class->valid_cpu_types[i]) {
-            /* The user specified CPU is not valid */
-            error_report("Invalid CPU type: %s", machine->cpu_type);
-            error_printf("The valid types are: %s",
-                         machine_class->valid_cpu_types[0]);
-            for (i = 1; machine_class->valid_cpu_types[i]; i++) {
-                error_printf(", %s", machine_class->valid_cpu_types[i]);
-            }
-            error_printf("\n");
-
-            exit(1);
-        }
-    }
-
-    /* Check if CPU type is deprecated and warn if so */
-    cc = CPU_CLASS(oc);
-    if (cc && cc->deprecation_note) {
-        warn_report("CPU model %s is deprecated -- %s", machine->cpu_type,
-                    cc->deprecation_note);
-    }
+    validate_cpu_type(machine);
 
     if (machine->cgs) {
         /*
-- 
2.41.0



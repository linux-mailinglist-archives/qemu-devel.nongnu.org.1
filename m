Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CB47627CA
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 02:35:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOST1-0001U8-Qx; Tue, 25 Jul 2023 20:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qOSSz-0001Sw-CC
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 20:33:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qOSSx-00035m-S8
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 20:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690331603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UfyYlAXPEO6rGCDdsc7We1YnnIDJV5ZWMB2m4Bc86dg=;
 b=aPRLirJ+dUgRw+dYFbmo9s1Roac1dhqQS7zMgYwx95uVN6/Kqwc7aHLGbYt3EkXvxeL0UO
 JAUcJXzSpCe33pIX4O+cJE9b+eUJT4lnVzPk4KH1Mf3rrSIu3mTEQ2nAbmg49M8uXkVByA
 U8omKwTm5J/ozuzR2t355AYpMH/6Ymg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-IObcQVRKOoOWnJXGLt_pnQ-1; Tue, 25 Jul 2023 20:33:19 -0400
X-MC-Unique: IObcQVRKOoOWnJXGLt_pnQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FFD41C09A4A;
 Wed, 26 Jul 2023 00:33:18 +0000 (UTC)
Received: from gshan.redhat.com (unknown [10.64.136.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CC13492C13;
 Wed, 26 Jul 2023 00:33:09 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, peter.maydell@linaro.org,
 b.galvani@gmail.com, strahinja.p.jankovic@gmail.com,
 sundeep.lkml@gmail.com, kfting@nuvoton.com, wuhaotsh@google.com,
 nieklinnenbank@gmail.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 laurent@vivier.eu, vijai@behindbytes.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 imammedo@redhat.com, cohuck@redhat.com, richard.henderson@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v2 1/8] machine: Use error handling when CPU type is checked
Date: Wed, 26 Jul 2023 10:31:58 +1000
Message-ID: <20230726003205.1599788-2-gshan@redhat.com>
In-Reply-To: <20230726003205.1599788-1-gshan@redhat.com>
References: <20230726003205.1599788-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

QEMU will be terminated if the specified CPU type isn't supported
in machine_run_board_init(). The list of supported CPU type is
maintained in mc->valid_cpu_types. The error handling can be used
to propagate error messages, to be consistent how the errors are
handled for other situations in the same function.

No functional change intended.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 hw/core/machine.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index f0d35c6401..d7e7f8f120 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1355,6 +1355,7 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
     ObjectClass *oc = object_class_by_name(machine->cpu_type);
     CPUClass *cc;
+    Error *local_err = NULL;
 
     /* This checkpoint is required by replay to separate prior clock
        reading from the other reads, because timer polling functions query
@@ -1423,15 +1424,16 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
 
         if (!machine_class->valid_cpu_types[i]) {
             /* The user specified CPU is not valid */
-            error_report("Invalid CPU type: %s", machine->cpu_type);
-            error_printf("The valid types are: %s",
-                         machine_class->valid_cpu_types[0]);
+            error_setg(&local_err, "Invalid CPU type: %s", machine->cpu_type);
+            error_append_hint(&local_err, "The valid types are: %s",
+                              machine_class->valid_cpu_types[0]);
             for (i = 1; machine_class->valid_cpu_types[i]; i++) {
-                error_printf(", %s", machine_class->valid_cpu_types[i]);
+                error_append_hint(&local_err, ", %s",
+                                  machine_class->valid_cpu_types[i]);
             }
-            error_printf("\n");
+            error_append_hint(&local_err, "\n");
 
-            exit(1);
+            error_propagate(errp, local_err);
         }
     }
 
-- 
2.41.0



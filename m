Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 479F7802999
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 01:49:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9x9P-0006tz-1b; Sun, 03 Dec 2023 19:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r9x99-0006Ni-0U
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 19:49:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.145.221.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r9x96-0001ul-QI
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 19:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701650951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:mime-version: content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JVyfjLzyQs0XZ2Tf2HNNgNKUbfHJiHRiECV6o6YVcyQ=;
 b=L4dq9BQWD9X3Jo49kGboLw0qCbUYxbKELsiK6sW3s7sVboNDrojs1T4lMyACCPRctmnS+H
 BSlS2qgygX/wsQZvZCrY776B2FHgxvpaOwl4pw6sOwTPg7XhdLjajtcZvmuFXNvxGA3s3B
 DPpYkufTmMIjYOEIw6fKfLkLRp2eX2g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-8Ayeq6h7MLm6Im-iWCNtyA-1; Sun, 03 Dec 2023 19:49:05 -0500
X-MC-Unique: 8Ayeq6h7MLm6Im-iWCNtyA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4DFE8314FD;
 Mon,  4 Dec 2023 00:49:03 +0000 (UTC)
Received: from gshan.redhat.com (unknown [10.64.136.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0C4E492BE0;
 Mon,  4 Dec 2023 00:48:55 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, peter.maydell@linaro.org,
 b.galvani@gmail.com, strahinja.p.jankovic@gmail.com, imammedo@redhat.com,
 kfting@nuvoton.com, wuhaotsh@google.com, nieklinnenbank@gmail.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 armbru@redhat.com, wangyanan55@huawei.com, vijai@behindbytes.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, shan.gavin@gmail.com
Subject: [PATCH v9 9/9] hw/riscv/shakti_c: Check CPU type in
 machine_run_board_init()
Date: Mon,  4 Dec 2023 10:47:26 +1000
Message-ID: <20231204004726.483558-10-gshan@redhat.com>
In-Reply-To: <20231204004726.483558-1-gshan@redhat.com>
References: <20231204004726.483558-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=216.145.221.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Set mc->valid_cpu_types so that the user specified CPU type can
be validated in machine_run_board_init(). We needn't to do it
by ourselves.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/shakti_c.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 12ea74b032..3888034c2b 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -28,7 +28,6 @@
 #include "exec/address-spaces.h"
 #include "hw/riscv/boot.h"
 
-
 static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
@@ -47,12 +46,6 @@ static void shakti_c_machine_state_init(MachineState *mstate)
     ShaktiCMachineState *sms = RISCV_SHAKTI_MACHINE(mstate);
     MemoryRegion *system_memory = get_system_memory();
 
-    /* Allow only Shakti C CPU for this platform */
-    if (strcmp(mstate->cpu_type, TYPE_RISCV_CPU_SHAKTI_C) != 0) {
-        error_report("This board can only be used with Shakti C CPU");
-        exit(1);
-    }
-
     /* Initialize SoC */
     object_initialize_child(OBJECT(mstate), "soc", &sms->soc,
                             TYPE_RISCV_SHAKTI_SOC);
@@ -82,9 +75,15 @@ static void shakti_c_machine_instance_init(Object *obj)
 static void shakti_c_machine_class_init(ObjectClass *klass, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(klass);
+    static const char * const valid_cpu_types[] = {
+        RISCV_CPU_TYPE_NAME("shakti-c"),
+        NULL
+    };
+
     mc->desc = "RISC-V Board compatible with Shakti SDK";
     mc->init = shakti_c_machine_state_init;
     mc->default_cpu_type = TYPE_RISCV_CPU_SHAKTI_C;
+    mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "riscv.shakti.c.ram";
 }
 
-- 
2.42.0



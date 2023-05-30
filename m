Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6529715DB4
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:45:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xhG-00083v-7Z; Tue, 30 May 2023 07:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3xh8-0007vo-4C
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:39:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3xh6-00048i-Kb
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685446754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ypSNjxk8rJUKShrG/cQHxTCZ8bHXJz6ssKLCoH3afkk=;
 b=MZeh1QPv1h1rGMLy/ajpIRwgQT/HHCFz6LgjGQLFW0EVOSph3XZrzCrz+Rj1Q3sFSQ/MXQ
 eJpGGrJKP1zULuOxhVha81zBkvN7q1+a51FfzkajPLQW9hRlAmyD5h7/lEUPwG1tnJmhRo
 V0ritnckNSnE42EcvPcLIFjmFkxTXOw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-4IePjxoQObOgdcDZpBNbfA-1; Tue, 30 May 2023 07:39:08 -0400
X-MC-Unique: 4IePjxoQObOgdcDZpBNbfA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7BB9101A53A;
 Tue, 30 May 2023 11:39:07 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D195040CFD48;
 Tue, 30 May 2023 11:39:04 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
Subject: [PATCH 06/10] hw/i386/pc: Use memory_devices_init()
Date: Tue, 30 May 2023 13:38:34 +0200
Message-Id: <20230530113838.257755-7-david@redhat.com>
In-Reply-To: <20230530113838.257755-1-david@redhat.com>
References: <20230530113838.257755-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

Let's use our new helper and stop always allocating ms->device_memory.
Once allcoated, we're sure that the size > 0 and that the base was
initialized.

Adjust the code in pc_memory_init() to check for machine->device_memory
instead of pcmc->has_reserved_memory and machine->device_memory->base.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bb62c994fa..920aa32b53 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1039,13 +1039,11 @@ void pc_memory_init(PCMachineState *pcms,
         exit(EXIT_FAILURE);
     }
 
-    /* always allocate the device memory information */
-    machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
-
     /* initialize device memory address space */
     if (pcmc->has_reserved_memory &&
         (machine->ram_size < machine->maxram_size)) {
         ram_addr_t device_mem_size;
+        hwaddr device_mem_base;
 
         if (machine->ram_slots > ACPI_MAX_RAM_SLOTS) {
             error_report("unsupported amount of memory slots: %"PRIu64,
@@ -1060,19 +1058,14 @@ void pc_memory_init(PCMachineState *pcms,
             exit(EXIT_FAILURE);
         }
 
-        pc_get_device_memory_range(pcms, &machine->device_memory->base, &device_mem_size);
+        pc_get_device_memory_range(pcms, &device_mem_base, &device_mem_size);
 
-        if ((machine->device_memory->base + device_mem_size) <
-            device_mem_size) {
+        if (device_mem_base + device_mem_size < device_mem_size) {
             error_report("unsupported amount of maximum memory: " RAM_ADDR_FMT,
                          machine->maxram_size);
             exit(EXIT_FAILURE);
         }
-
-        memory_region_init(&machine->device_memory->mr, OBJECT(pcms),
-                           "device-memory", device_mem_size);
-        memory_region_add_subregion(system_memory, machine->device_memory->base,
-                                    &machine->device_memory->mr);
+        memory_devices_init(machine, device_mem_base, device_mem_size);
     }
 
     if (pcms->cxl_devices_state.is_enabled) {
@@ -1120,7 +1113,7 @@ void pc_memory_init(PCMachineState *pcms,
 
     rom_set_fw(fw_cfg);
 
-    if (pcmc->has_reserved_memory && machine->device_memory->base) {
+    if (machine->device_memory) {
         uint64_t *val = g_malloc(sizeof(*val));
         PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
         uint64_t res_mem_end = machine->device_memory->base;
-- 
2.40.1



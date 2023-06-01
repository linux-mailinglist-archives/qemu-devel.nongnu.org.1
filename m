Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD754719BE4
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:21:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hFK-0003M6-68; Thu, 01 Jun 2023 08:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q4hCw-0000kr-Ag
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:15:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q4hCs-0006T6-Tt
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685621706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=01a1Sd5jMsqlgoeyZ4FfzaCz9q752Xj4qUaXbI+la08=;
 b=HB2r0rFT7UZ6rdVh5fZ4Az+J/eAn1GhmFpNLLC7wXe/wUAck38o0vSc4ONRGBnJDdP+s9i
 qsgJ2UiG976m/x1srvQWmcJNaRE1hY1VYMZj+gsTAznmB8xNZSuaAI4EfC/oMrNHrmwdkW
 9WjEa7pFqnk/Yd3nPL1+70u3k0BsWpA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-uzu-Ehg_NgCoanpMPAuJxQ-1; Thu, 01 Jun 2023 08:15:03 -0400
X-MC-Unique: uzu-Ehg_NgCoanpMPAuJxQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 970BB811E86;
 Thu,  1 Jun 2023 12:15:02 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.22.8.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1087B2166B25;
 Thu,  1 Jun 2023 12:15:00 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 07/10] hw/i386/acpi-build: Rely on machine->device_memory
 when building SRAT
Date: Thu,  1 Jun 2023 14:14:44 +0200
Message-Id: <20230601121447.272487-9-david@redhat.com>
In-Reply-To: <20230601121447.272487-1-david@redhat.com>
References: <20230601121447.272487-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

We're already looking at machine->device_memory when calling
build_srat_memory(), so let's simply avoid going via
PC_MACHINE_DEVMEM_REGION_SIZE to get the size and rely on
machine->device_memory directly.

Once machine->device_memory is set, we know that the size > 0. The code now
looks much more similar the hw/arm/virt-acpi-build.c variant.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/acpi-build.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 512162003b..9c74fa17ad 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1950,12 +1950,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     X86MachineState *x86ms = X86_MACHINE(machine);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
-    PCMachineState *pcms = PC_MACHINE(machine);
     int nb_numa_nodes = machine->numa_state->num_nodes;
     NodeInfo *numa_info = machine->numa_state->nodes;
-    ram_addr_t hotpluggable_address_space_size =
-        object_property_get_int(OBJECT(pcms), PC_MACHINE_DEVMEM_REGION_SIZE,
-                                NULL);
     AcpiTable table = { .sig = "SRAT", .rev = 1, .oem_id = x86ms->oem_id,
                         .oem_table_id = x86ms->oem_table_id };
 
@@ -2071,9 +2067,10 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
      * Memory devices may override proximity set by this entry,
      * providing _PXM method if necessary.
      */
-    if (hotpluggable_address_space_size) {
+    if (machine->device_memory) {
         build_srat_memory(table_data, machine->device_memory->base,
-                          hotpluggable_address_space_size, nb_numa_nodes - 1,
+                          memory_region_size(&machine->device_memory->mr),
+                          nb_numa_nodes - 1,
                           MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
     }
 
-- 
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDF67BB6A1
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:40:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9T-0005CZ-Jg; Fri, 06 Oct 2023 07:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj91-000535-4O
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8t-0000B2-Vk
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5OeUd6hJ67CdwRoUSGaWoyHSJmlOicoM8LgafBXjW9U=;
 b=eeVOCEdP3O2HTR1FvD/B9b4S/Dd4CfrCYBYYUwwLDjB2BjE1XQrL8Ytu8llUJDn4ul1xI1
 EBg2elqbFvQ9xRiLokQjwNR+ImmncT4RE0UCJ4iUZThIOEfU9TAeP0b4MTHUAeExxiFHa+
 NjnHk3lLhIPac90vEccsUdSvBxk2zH8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-q_34OTWnM1qFErINUE9ZgA-1; Fri, 06 Oct 2023 07:36:58 -0400
X-MC-Unique: q_34OTWnM1qFErINUE9ZgA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 891BF801E91;
 Fri,  6 Oct 2023 11:36:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 680C120268C8;
 Fri,  6 Oct 2023 11:36:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 606F421E690C; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Ani Sinha <anisinha@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>, mst@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 04/32] hw/i386: changes towards enabling -Wshadow=local for x86
 machines
Date: Fri,  6 Oct 2023 13:36:29 +0200
Message-ID: <20231006113657.3803180-5-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Ani Sinha <anisinha@redhat.com>

Code changes that addresses all compiler complaints coming from enabling
-Wshadow flags. Enabling -Wshadow catches cases of local variables shadowing
other local variables or parameters. These makes the code confusing and/or adds
bugs that are difficult to catch.

See also

   Subject: Help wanted for enabling -Wshadow=local
   Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
   https://lore.kernel.org/qemu-devel/87r0mqlf9x.fsf@pond.sub.org

CC: Markus Armbruster <armbru@redhat.com>
CC: Philippe Mathieu-Daude <philmd@linaro.org>
CC: mst@redhat.com

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-ID: <20231003102803.6163-1-anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/i386/acpi-microvm.c | 4 ++--
 hw/i386/pc.c           | 1 -
 hw/i386/x86.c          | 2 --
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index fec22d85c1..2909a73933 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -55,8 +55,8 @@ static void acpi_dsdt_add_virtio(Aml *scope,
 
     bus = sysbus_get_default();
     QTAILQ_FOREACH(kid, &bus->children, sibling) {
-        DeviceState *dev = kid->child;
-        Object *obj = object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MMIO);
+        Object *obj = object_dynamic_cast(OBJECT(kid->child),
+                                          TYPE_VIRTIO_MMIO);
 
         if (obj) {
             VirtIOMMIOProxy *mmio = VIRTIO_MMIO(obj);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index aad7e8ccd1..bb3854d1d0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1049,7 +1049,6 @@ void pc_memory_init(PCMachineState *pcms,
 
     if (machine->device_memory) {
         uint64_t *val = g_malloc(sizeof(*val));
-        PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
         uint64_t res_mem_end = machine->device_memory->base;
 
         if (!pcmc->broken_reserved_end) {
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index f034df8bf6..b3d054889b 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -365,8 +365,6 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     cpu_slot = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
     if (!cpu_slot) {
-        MachineState *ms = MACHINE(x86ms);
-
         x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
         error_setg(errp,
             "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
-- 
2.41.0



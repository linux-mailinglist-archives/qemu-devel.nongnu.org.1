Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B2C719BEB
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:21:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hFL-0003Pl-J0; Thu, 01 Jun 2023 08:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q4hCq-0000X5-71
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q4hCo-0006Qo-Cu
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685621701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0RKhtCL6G/zGQJCk7r406voVsLgpFKg3xhqMOecRflU=;
 b=WZ0ig6v4omMk+mNlBEOysYkKFuWIcp2qHTYUDl1nuB+FwOP/0gL3rfqFC3d+QR5RbQ9uPR
 p5FkEiiU3VMoPxmqkrPSrID9f3Xf8i9tydRR0jpX0PyLDwQID/x4i93oHaQqU8Ym2zT6/9
 ZKrDx3DX0D0c3DE+SQJSqgMmvIWqL/U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-Jc30OZYRM26HyIR9saF5Pg-1; Thu, 01 Jun 2023 08:14:59 -0400
X-MC-Unique: Jc30OZYRM26HyIR9saF5Pg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC2158028B1;
 Thu,  1 Jun 2023 12:14:58 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.22.8.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ACAE52166B25;
 Thu,  1 Jun 2023 12:14:57 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>
Subject: [PATCH v3 05/10] hw/loongarch/virt: Use machine_memory_devices_init()
Date: Thu,  1 Jun 2023 14:14:42 +0200
Message-Id: <20230601121447.272487-7-david@redhat.com>
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

Let's use our new helper. While at it, use VIRT_HIGHMEM_BASE.

Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/loongarch/virt.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index ceddec1b23..c1327a51c4 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -805,8 +805,8 @@ static void loongarch_init(MachineState *machine)
 
     /* initialize device memory address space */
     if (machine->ram_size < machine->maxram_size) {
-        machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
         ram_addr_t device_mem_size = machine->maxram_size - machine->ram_size;
+        hwaddr device_mem_base;
 
         if (machine->ram_slots > ACPI_MAX_RAM_SLOTS) {
             error_report("unsupported amount of memory slots: %"PRIu64,
@@ -821,14 +821,8 @@ static void loongarch_init(MachineState *machine)
             exit(EXIT_FAILURE);
         }
         /* device memory base is the top of high memory address. */
-        machine->device_memory->base = 0x90000000 + highram_size;
-        machine->device_memory->base =
-            ROUND_UP(machine->device_memory->base, 1 * GiB);
-
-        memory_region_init(&machine->device_memory->mr, OBJECT(lams),
-                           "device-memory", device_mem_size);
-        memory_region_add_subregion(address_space_mem, machine->device_memory->base,
-                                    &machine->device_memory->mr);
+        device_mem_base = ROUND_UP(VIRT_HIGHMEM_BASE + highram_size, 1 * GiB);
+        machine_memory_devices_init(machine, device_mem_base, device_mem_size);
     }
 
     /* Add isa io region */
-- 
2.40.1



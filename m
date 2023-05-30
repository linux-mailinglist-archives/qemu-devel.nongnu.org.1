Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EA2715D6D
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:40:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xhE-00082L-V4; Tue, 30 May 2023 07:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3xgw-0007uJ-Nj
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3xgu-000439-AN
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685446743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XinK48gMtdhK2Jrt5yYTeK2A0TRIxNMgvQ0AqBqN7hY=;
 b=O/sz5PchFqmIge4Eai9VcgWw7BOI5bh1TVF7hhqL4e8lDn7eZHQwO/st8VreBMrG/tLu/n
 WfjepI5apruEeoS3paZa9wyHxgtoLludDHRI3GAM9vfYUj3FTJk7C4jgBPuXBY+4Hbk4bh
 dtKMVOHEUiDtOFXnfEoG7fZKvkNNAqI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-AFB7OFj6NDWyUCmKhbY5Cw-1; Tue, 30 May 2023 07:38:57 -0400
X-MC-Unique: AFB7OFj6NDWyUCmKhbY5Cw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F5AD185A791;
 Tue, 30 May 2023 11:38:56 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CD1840CFD45;
 Tue, 30 May 2023 11:38:52 +0000 (UTC)
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
Subject: [PATCH 03/10] hw/arm/virt: Use memory_devices_init()
Date: Tue, 30 May 2023 13:38:31 +0200
Message-Id: <20230530113838.257755-4-david@redhat.com>
In-Reply-To: <20230530113838.257755-1-david@redhat.com>
References: <20230530113838.257755-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

Let's use our new helper. We'll add the subregion to system RAM now
earlier. That shouldn't matter, because the system RAM memory region should
already be alive at that point.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/arm/virt.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9b9f7d9c68..49bc8378ec 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1817,10 +1817,7 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
     virt_set_high_memmap(vms, base, pa_bits);
 
     if (device_memory_size > 0) {
-        ms->device_memory = g_malloc0(sizeof(*ms->device_memory));
-        ms->device_memory->base = device_memory_base;
-        memory_region_init(&ms->device_memory->mr, OBJECT(vms),
-                           "device-memory", device_memory_size);
+        memory_devices_init(ms, device_memory_base, device_memory_size);
     }
 }
 
@@ -2261,10 +2258,6 @@ static void machvirt_init(MachineState *machine)
 
     memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base,
                                 machine->ram);
-    if (machine->device_memory) {
-        memory_region_add_subregion(sysmem, machine->device_memory->base,
-                                    &machine->device_memory->mr);
-    }
 
     virt_flash_fdt(vms, sysmem, secure_sysmem ?: sysmem);
 
-- 
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC3E73B809
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:48:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgB5-0001VZ-R3; Fri, 23 Jun 2023 08:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCgAx-0001PU-Bb
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCgAv-0000k8-0e
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687524364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wAfqK7I+lleT5UMiePeQ4lUaY72HL9BjLt/aG0lNx6U=;
 b=I37XgC1lapj6m20xfnw+yIgiA8U4hDvy6/FECtZpL4k+qnL9v4ANIqS6OqpcpcM2x1K8H+
 RHUQdgtGlKGhnibqMP5rzBccTOZ7FtWeCPyhjHiAxFOfG8pS/nHDvsg4mtBaWE2m6SNYtg
 +ffWoUe1zZfopsUHd6N+FkY60JG45Zs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-Ra25uf2zNLGwsDy8-SNZZQ-1; Fri, 23 Jun 2023 08:45:59 -0400
X-MC-Unique: Ra25uf2zNLGwsDy8-SNZZQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8AD018CC201;
 Fri, 23 Jun 2023 12:45:58 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.22.32.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65D1F1121314;
 Fri, 23 Jun 2023 12:45:54 +0000 (UTC)
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
Subject: [PATCH v4 00/10] memory-device: Some cleanups
Date: Fri, 23 Jun 2023 14:45:43 +0200
Message-Id: <20230623124553.400585-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Essentially a resend with ACKs/RBs. If I don't get any more comments
I'll queue this to my mem-next tree next week.


Working on adding multi-memslot support for virtio-mem (teaching memory
device code about memory devices that can consume multiple memslots), I
have some preparatory cleanups in my queue that make sense independent of
the actual memory-device/virtio-mem extensions.

v3 -> v4:
- Added RBs and ACKs

v2 -> v3:
- "memory-device: Introduce machine_memory_devices_init()"
-- Declare the function in hw/boards.h
- "hw/loongarch/virt: Use machine_memory_devices_init()"
-- Use VIRT_HIGHMEM_BASE
-- No need to include memory-device.h
- "hw/i386/pc: Remove PC_MACHINE_DEVMEM_REGION_SIZ"
-- Add more details why it's ok to the patch description
- Adjust to memory_devices_init() -> machine_memory_devices_init()
- Add RBs

v1 -> v2:
- Allocate ms->device_memory only if the size > 0.
- Split it up and include more cleanups

David Hildenbrand (10):
  memory-device: Unify enabled vs. supported error messages
  memory-device: Introduce machine_memory_devices_init()
  hw/arm/virt: Use machine_memory_devices_init()
  hw/ppc/spapr: Use machine_memory_devices_init()
  hw/loongarch/virt: Use machine_memory_devices_init()
  hw/i386/pc: Use machine_memory_devices_init()
  hw/i386/acpi-build: Rely on machine->device_memory when building SRAT
  hw/i386/pc: Remove PC_MACHINE_DEVMEM_REGION_SIZE
  memory-device: Refactor memory_device_pre_plug()
  memory-device: Track used region size in DeviceMemoryState

 hw/arm/virt.c          |  9 +-----
 hw/i386/acpi-build.c   |  9 ++----
 hw/i386/pc.c           | 36 +++-------------------
 hw/loongarch/virt.c    | 12 ++------
 hw/mem/memory-device.c | 69 +++++++++++++++++++-----------------------
 hw/ppc/spapr.c         | 37 +++++++++++-----------
 hw/ppc/spapr_hcall.c   |  2 +-
 include/hw/boards.h    |  4 +++
 include/hw/i386/pc.h   |  1 -
 9 files changed, 67 insertions(+), 112 deletions(-)

-- 
2.40.1



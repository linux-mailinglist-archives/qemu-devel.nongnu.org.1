Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 882B07B50FA
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 13:15:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnGtC-0000iJ-86; Mon, 02 Oct 2023 07:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnGtA-0000hc-AK
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 07:15:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnGt8-0002vs-Se
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 07:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696245297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KKKfJWyeOK6baAM+8UgAVdaX+Pj2IpJG1CbFYPiena0=;
 b=SiEAXKmfMeZN3vrRzM7AVyNup/4uB0+C4AXrvmhKyRXEzlABbhVINJW1nXWqPez2BCCNGQ
 LeFECsVp4OLGlDRTTuoqOakum+AEubVhDynb0M1zFozwYCLp66RCBGp1J7lVY7WZ5g3RXk
 E6/iUa3faO8yZbF9fUsxNmRJwYzY4LE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-686-kVSdGOxoPyC8_MEC8KxV6g-1; Mon, 02 Oct 2023 07:14:45 -0400
X-MC-Unique: kVSdGOxoPyC8_MEC8KxV6g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 125C338145B7;
 Mon,  2 Oct 2023 11:12:07 +0000 (UTC)
Received: from localhost (unknown [10.39.208.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C1FCC15BB8;
 Mon,  2 Oct 2023 11:12:05 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, lersek@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 2/5] pc: remove needless includes
Date: Mon,  2 Oct 2023 15:11:50 +0400
Message-ID: <20231002111154.1002655-3-marcandre.lureau@redhat.com>
In-Reply-To: <20231002111154.1002655-1-marcandre.lureau@redhat.com>
References: <20231002111154.1002655-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The include list is gigantic, make it smaller.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/pc.c | 41 -----------------------------------------
 1 file changed, 41 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5d399b6247..c376c5032d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -24,79 +24,38 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
 #include "hw/char/serial.h"
 #include "hw/char/parallel.h"
-#include "hw/i386/topology.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/i386/vmport.h"
 #include "sysemu/cpus.h"
-#include "hw/block/fdc.h"
 #include "hw/ide/internal.h"
-#include "hw/ide/isa.h"
-#include "hw/pci/pci.h"
-#include "hw/pci/pci_bus.h"
-#include "hw/pci-bridge/pci_expander_bridge.h"
-#include "hw/nvram/fw_cfg.h"
 #include "hw/timer/hpet.h"
-#include "hw/firmware/smbios.h"
 #include "hw/loader.h"
-#include "elf.h"
-#include "migration/vmstate.h"
-#include "multiboot.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/intc/i8259.h"
-#include "hw/intc/ioapic.h"
 #include "hw/timer/i8254.h"
 #include "hw/input/i8042.h"
-#include "hw/irq.h"
 #include "hw/audio/pcspk.h"
-#include "hw/pci/msi.h"
-#include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/tcg.h"
-#include "sysemu/numa.h"
-#include "sysemu/kvm.h"
 #include "sysemu/xen.h"
 #include "sysemu/reset.h"
-#include "sysemu/runstate.h"
 #include "kvm/kvm_i386.h"
-#include "hw/xen/xen.h"
-#include "hw/xen/start_info.h"
-#include "ui/qemu-spice.h"
-#include "exec/memory.h"
-#include "qemu/bitmap.h"
-#include "qemu/config-file.h"
-#include "qemu/error-report.h"
-#include "qemu/option.h"
-#include "qemu/cutils.h"
-#include "hw/acpi/acpi.h"
 #include "hw/acpi/cpu_hotplug.h"
 #include "acpi-build.h"
-#include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
-#include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
-#include "qapi/error.h"
-#include "qapi/qapi-visit-common.h"
-#include "qapi/qapi-visit-machine.h"
-#include "qapi/visitor.h"
-#include "hw/core/cpu.h"
 #include "hw/usb.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
-#include "standard-headers/asm-x86/bootparam.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/virtio/virtio-md-pci.h"
 #include "hw/i386/kvm/xen_overlay.h"
 #include "hw/i386/kvm/xen_evtchn.h"
 #include "hw/i386/kvm/xen_gnttab.h"
 #include "hw/i386/kvm/xen_xenstore.h"
-#include "sysemu/replay.h"
-#include "target/i386/cpu.h"
 #include "e820_memory_layout.h"
-#include "fw_cfg.h"
 #include "trace.h"
 #include CONFIG_DEVICES
 
-- 
2.41.0



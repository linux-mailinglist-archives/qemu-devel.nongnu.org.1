Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 221A9B1E7F5
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Aug 2025 14:05:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukLny-0003wN-Sz; Fri, 08 Aug 2025 08:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ukLnL-00037G-EI
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:02:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ukLnH-00076j-Vc
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754654515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YXMLdRLh9YwCZzYtukXOYEZwJEsXhn/JEVu/46+KzWE=;
 b=RcjLsI/cch3XOG9x2b2K8HpZab4u+L+0Z4j0KOy+Ilvv+RQ4X0+IzXX5CWoGAk7EPojM5X
 al967fbWljVHJD0jisq/KfPai9FmgTvF/xDZX1Pc7r5lfM8RvwPlTRvdtkfN3AlVF4Sh7H
 DlA46+HSdwTyyWBBQGvKW7IHnVzl4po=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-30p6ruSMPAegFJ3c0K-Qew-1; Fri,
 08 Aug 2025 08:01:52 -0400
X-MC-Unique: 30p6ruSMPAegFJ3c0K-Qew-1
X-Mimecast-MFC-AGG-ID: 30p6ruSMPAegFJ3c0K-Qew_1754654511
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 017751800446; Fri,  8 Aug 2025 12:01:51 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F165E19560B0; Fri,  8 Aug 2025 12:01:48 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, mtosatti@redhat.com
Subject: [PATCH v3 03/10] hpet: switch to fain-grained device locking
Date: Fri,  8 Aug 2025 14:01:30 +0200
Message-ID: <20250808120137.2208800-4-imammedo@redhat.com>
In-Reply-To: <20250808120137.2208800-1-imammedo@redhat.com>
References: <20250808120137.2208800-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

as a step towards lock-less HPET counter read,
use per device locking instead of BQL.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/timer/hpet.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index cb48cc151f..ab5aa59ae4 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -38,6 +38,7 @@
 #include "hw/timer/i8254.h"
 #include "system/address-spaces.h"
 #include "qom/object.h"
+#include "qemu/lockable.h"
 #include "trace.h"
 
 struct hpet_fw_config hpet_fw_cfg = {.count = UINT8_MAX};
@@ -69,6 +70,7 @@ struct HPETState {
     SysBusDevice parent_obj;
     /*< public >*/
 
+    QemuMutex lock;
     MemoryRegion iomem;
     uint64_t hpet_offset;
     bool hpet_offset_saved;
@@ -428,6 +430,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
     trace_hpet_ram_read(addr);
     addr &= ~4;
 
+    QEMU_LOCK_GUARD(&s->lock);
     /*address range of all global regs*/
     if (addr <= 0xff) {
         switch (addr) {
@@ -482,6 +485,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
     int len = MIN(size * 8, 64 - shift);
     uint64_t old_val, new_val, cleared;
 
+    QEMU_LOCK_GUARD(&s->lock);
     trace_hpet_ram_write(addr, value);
     addr &= ~4;
 
@@ -679,8 +683,10 @@ static void hpet_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     HPETState *s = HPET(obj);
 
+    qemu_mutex_init(&s->lock);
     /* HPET Area */
     memory_region_init_io(&s->iomem, obj, &hpet_ram_ops, s, "hpet", HPET_LEN);
+    memory_region_enable_lockless_io(&s->iomem);
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-- 
2.47.1



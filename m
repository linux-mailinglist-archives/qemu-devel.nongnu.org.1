Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 377977E38D1
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:19:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J5j-00059C-Oh; Tue, 07 Nov 2023 05:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5c-00053i-6i
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5a-0002y9-Hv
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699352021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aDlG+KSLEUR999MUGfvGQca2+SnwdEFbcYEobQ5t/OA=;
 b=AFZaO3lJh5KYG9bPuTm94OJX/zLf0jvKMcttKh4kNur6SAgFc6MHaYEz8c+96SBavPoZak
 oZaFIEV1f8LVxWMNB9WgXOoJtms2p7pxxPwdiKOEwSERCS9xqqbydb8aGzBfwACtPY9p/R
 cFvsGaBXqbQoX4yASFQmq/eFrO0cBSE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-C1820GTMPvi0obUFbJnl5A-1; Tue, 07 Nov 2023 05:13:40 -0500
X-MC-Unique: C1820GTMPvi0obUFbJnl5A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32dee12c5b4so2987787f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:13:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699352019; x=1699956819;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aDlG+KSLEUR999MUGfvGQca2+SnwdEFbcYEobQ5t/OA=;
 b=tMl6PEpJxvVYtGfoRftACP7NKkRjDfBFaGJayY1uP23HP2pOhPlm3CG8RmUYqgXpz/
 CHpkKChwvwQ+XqW/up3xQj7j0cqjXBakW8akpQ+4eA24XT538U8egtB9viXL4ZrY6dEA
 NQ9Rrjr5osgfa/34qDNNjk0FHAmGGr+pm+zPbJOJ8OenPN1IZiq9Cd5sNzPAKeXO2D+E
 l1c1K2mEg06rl/Tq+9SC/ZSzJ9mrESShBDSq3yYE05JjgGUiwO7mllqu0j6h1JSCFalL
 pZGMt3JP3rl1rCreo+/Opq4LNVkpE9eQV1m4K8ss4Oud0I+t13h5lUfmvvMQ8CN3cbgJ
 Q7pg==
X-Gm-Message-State: AOJu0YzxpMXc6VhlVPENfKVZFwrS6qwpX6VBL+AMddgCoCrtwv6AGGBv
 zYjCJ+oqsBp8jFEi1kWbFhRa62aQ+ua3MDXWy7M5RlC+znh9nhmqUns52yf3IEbNgSOF7pRhILq
 v2IwslS8NxOsAbmtCFouSVPTASKeEhstJsobFALugSD+lQYa12b+DSp4RAak93+gMn37S
X-Received: by 2002:a05:6000:1842:b0:32f:73d2:f196 with SMTP id
 c2-20020a056000184200b0032f73d2f196mr24277254wri.35.1699352018959; 
 Tue, 07 Nov 2023 02:13:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBPPQTwFAYqGIMQ68KlIb1p0dJW3MEQlfgOKFcnxqs7aZAZgbgzRTSdJ1b/Etc9uE+XytuOw==
X-Received: by 2002:a05:6000:1842:b0:32f:73d2:f196 with SMTP id
 c2-20020a056000184200b0032f73d2f196mr24277242wri.35.1699352018613; 
 Tue, 07 Nov 2023 02:13:38 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 a15-20020a5d456f000000b0032fab28e9c9sm1910484wrc.73.2023.11.07.02.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:13:38 -0800 (PST)
Date: Tue, 7 Nov 2023 05:13:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 56/63] hw/cxl/mbox: Wire up interrupts for background completion
Message-ID: <43efb0bfad2b81b32fc19da442cbea2835cf38d4.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Davidlohr Bueso <dave@stgolabs.net>

Notify when the background operation is done. Note that for now background
commands are only supported on the main Type 3 mailbox.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20231023160806.13206-13-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |  1 +
 hw/cxl/cxl-device-utils.c   | 10 +++++++++-
 hw/cxl/cxl-mailbox-utils.c  | 31 ++++++++++++++-----------------
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 124ff969ec..2a813cdddd 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -193,6 +193,7 @@ typedef struct cxl_device_state {
     struct {
         MemoryRegion mailbox;
         uint16_t payload_size;
+        uint8_t mbox_msi_n;
         union {
             uint8_t mbox_reg_state[CXL_MAILBOX_REGISTERS_LENGTH];
             uint16_t mbox_reg_state16[CXL_MAILBOX_REGISTERS_LENGTH / 2];
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 51466a626b..61a3c4dc2e 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -357,10 +357,18 @@ static void device_reg_init_common(CXLDeviceState *cxl_dstate)
 
 static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
 {
-    /* 2048 payload size, with no interrupt */
+    const uint8_t msi_n = 9;
+
+    /* 2048 payload size */
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
                      PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
     cxl_dstate->payload_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE;
+    /* irq support */
+    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
+                     BG_INT_CAP, 1);
+    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
+                     MSI_N, msi_n);
+    cxl_dstate->mbox_msi_n = msi_n;
 }
 
 static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index f1226f8f39..f3fd97deb5 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -8,6 +8,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_events.h"
 #include "hw/pci/pci.h"
@@ -1076,28 +1078,16 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
 static void bg_timercb(void *opaque)
 {
     CXLCCI *cci = opaque;
-    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
-    uint64_t bg_status_reg = 0;
     uint64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
     uint64_t total_time = cci->bg.starttime + cci->bg.runtime;
 
     assert(cci->bg.runtime > 0);
-    bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
-                               OP, cci->bg.opcode);
 
     if (now >= total_time) { /* we are done */
-        uint64_t status_reg;
         uint16_t ret = CXL_MBOX_SUCCESS;
 
         cci->bg.complete_pct = 100;
-        /* Clear bg */
-        status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, BG_OP, 0);
-        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
-
-        bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
-                                   RET_CODE, ret);
-
-        /* TODO add ad-hoc cmd succesful completion handling */
+        cci->bg.ret_code = ret;
 
         qemu_log("Background command %04xh finished: %s\n",
                  cci->bg.opcode,
@@ -1108,14 +1098,21 @@ static void bg_timercb(void *opaque)
         timer_mod(cci->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
     }
 
-    bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
-                               PERCENTAGE_COMP, cci->bg.complete_pct);
-    cxl_dstate->mbox_reg_state64[R_CXL_DEV_BG_CMD_STS] = bg_status_reg;
-
     if (cci->bg.complete_pct == 100) {
+        /* TODO: generalize to switch CCI */
+        CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+        CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
+        PCIDevice *pdev = PCI_DEVICE(cci->d);
+
         cci->bg.starttime = 0;
         /* registers are updated, allow new bg-capable cmds */
         cci->bg.runtime = 0;
+
+        if (msix_enabled(pdev)) {
+            msix_notify(pdev, cxl_dstate->mbox_msi_n);
+        } else if (msi_enabled(pdev)) {
+            msi_notify(pdev, cxl_dstate->mbox_msi_n);
+        }
     }
 }
 
-- 
MST



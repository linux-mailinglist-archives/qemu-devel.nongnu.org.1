Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BDF7E38C2
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:19:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J5j-00056B-4X; Tue, 07 Nov 2023 05:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5a-0004yg-Fz
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5W-0002xl-G1
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699352017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DOMtNCG0j48PYjLMBwp//f827+iY78t4UfoTn9nV4MY=;
 b=H7mT6mFmi9Z37O6OOXKh/Lj9sLGGZ+dbQ9kOTtLQLPxP5OzV4tMy5fdWDz4Z7risKWsv74
 qlCTaNUTNvEpm7bHcjlLbh/+s9+SYi0wkfacAX6ajfp0j4WCKnXGkw2lj323TcEjWSBbW5
 WV7oca0xNBmQPv3AV/HCJ4o3ZQi6zhk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-ZO86sv6lMaaY6Q3UBpz5Cw-1; Tue, 07 Nov 2023 05:13:36 -0500
X-MC-Unique: ZO86sv6lMaaY6Q3UBpz5Cw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4084a9e637eso35051845e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:13:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699352014; x=1699956814;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DOMtNCG0j48PYjLMBwp//f827+iY78t4UfoTn9nV4MY=;
 b=sJZB4G29AnoyiPfhlZLOnD7Nhpj4eur1xn6lWKq8oHM2wNBBDtLtUONQHzuwa5/TxU
 X36oTtYzkLsilNJaLGJy4UmQ64lZrc+4FwMZ0U034AzkYVoSockjkPKAA/SUkSG5D2JG
 EP8wEFnZJMMdAI6Kyh+aGZ0NRYJHYzvGPaTdnfhhXn5PE5XG0BdpZZVpdXrBBdlVVzaN
 cWX0R28tY+dSlKbByCKtGHmuihncfscVj/xMTb1RL2XwhIGZUDIEgOLOMg0eSnJhMhGz
 X9uJNwVwcpCztvv4McMiCSng/6tMmlMTVgpEQAIIH8XoQCrwryRrRwMiGMA01TAu9DXM
 t6yA==
X-Gm-Message-State: AOJu0YzZoPV0UwppuAy9vbFpZbkiLqMWCV4AjlkqkpRCcy/yBtmOgyuT
 9rKcKqPKaR0ACQwR58CzX5bCpjVGXK3Py504s/WtT81KyxpdZqW0Q/BMx642PDedZu03eQ/7wpZ
 KhpX0gUDqq6qzi3wShYx+Am9uIHvgbv1Zvq+XtbXIX7L/IPEx6SSzWwaOAvqM00tpE0mH
X-Received: by 2002:a05:600c:4fc8:b0:404:f9c1:d5d7 with SMTP id
 o8-20020a05600c4fc800b00404f9c1d5d7mr1820537wmq.25.1699352014481; 
 Tue, 07 Nov 2023 02:13:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdM0PNybOIdRFQP61lZTYm7GvzzhA0+f1hLLsBbEefubNaLpxFpUejds/gRjfw5r29UxRxPg==
X-Received: by 2002:a05:600c:4fc8:b0:404:f9c1:d5d7 with SMTP id
 o8-20020a05600c4fc800b00404f9c1d5d7mr1820515wmq.25.1699352014091; 
 Tue, 07 Nov 2023 02:13:34 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6046000000b0032fc5f5abafsm1901459wrt.96.2023.11.07.02.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:13:33 -0800 (PST)
Date: Tue, 7 Nov 2023 05:13:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 55/63] hw/cxl/mbox: Add support for background operations
Message-ID: <221d2cfbdb5301f8f0cfbf26baf76544a5d71c27.1699351720.git.mst@redhat.com>
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

Support background commands in the mailbox, and update
cmd_infostat_bg_op_sts() accordingly. This patch does not implement mbox
interrupts upon completion, so the kernel driver must rely on polling to
know when the operation is done.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Message-Id: <20231023160806.13206-12-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h | 10 ++++
 hw/cxl/cxl-device-utils.c   | 24 ++++++++--
 hw/cxl/cxl-mailbox-utils.c  | 92 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 122 insertions(+), 4 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index fa73ed03e5..124ff969ec 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -149,6 +149,16 @@ typedef struct CXLCCI {
     } cel_log[1 << 16];
     size_t cel_size;
 
+    /* background command handling (times in ms) */
+    struct {
+        uint16_t opcode;
+        uint16_t complete_pct;
+        uint16_t ret_code; /* Current value of retcode */
+        uint64_t starttime;
+        /* set by each bg cmd, cleared by the bg_timer when complete */
+        uint64_t runtime;
+        QEMUTimer *timer;
+    } bg;
     size_t payload_max;
     /* Pointer to device hosting the CCI */
     DeviceState *d;
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index f8938678c7..51466a626b 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -82,6 +82,25 @@ static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
     case 4:
         return cxl_dstate->mbox_reg_state32[offset / size];
     case 8:
+        if (offset == A_CXL_DEV_BG_CMD_STS) {
+            uint64_t bg_status_reg;
+            bg_status_reg = FIELD_DP64(0, CXL_DEV_BG_CMD_STS, OP,
+                                       cci->bg.opcode);
+            bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
+                                       PERCENTAGE_COMP, cci->bg.complete_pct);
+            bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
+                                       RET_CODE, cci->bg.ret_code);
+            /* endian? */
+            cxl_dstate->mbox_reg_state64[offset / size] = bg_status_reg;
+        }
+        if (offset == A_CXL_DEV_MAILBOX_STS) {
+            uint64_t status_reg = cxl_dstate->mbox_reg_state64[offset / size];
+            if (cci->bg.complete_pct) {
+                status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, BG_OP,
+                                        0);
+                cxl_dstate->mbox_reg_state64[offset / size] = status_reg;
+            }
+        }
         return cxl_dstate->mbox_reg_state64[offset / size];
     default:
         g_assert_not_reached();
@@ -114,8 +133,7 @@ static void mailbox_mem_writeq(uint64_t *reg_state, hwaddr offset,
     case A_CXL_DEV_MAILBOX_CMD:
         break;
     case A_CXL_DEV_BG_CMD_STS:
-        /* BG not supported */
-        /* fallthrough */
+        break;
     case A_CXL_DEV_MAILBOX_STS:
         /* Read only register, will get updated by the state machine */
         return;
@@ -339,7 +357,7 @@ static void device_reg_init_common(CXLDeviceState *cxl_dstate)
 
 static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
 {
-    /* 2048 payload size, with no interrupt or background support */
+    /* 2048 payload size, with no interrupt */
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
                      PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
     cxl_dstate->payload_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index de63fc1a28..f1226f8f39 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -963,6 +963,8 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
 #define IMMEDIATE_LOG_CHANGE (1 << 4)
+#define SECURITY_STATE_CHANGE (1 << 5)
+#define BACKGROUND_OPERATION (1 << 6)
 
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [EVENTS][GET_RECORDS] = { "EVENTS_GET_RECORDS",
@@ -1011,10 +1013,19 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
         cmd_get_physical_port_state, ~0, 0 },
 };
 
+/*
+ * While the command is executing in the background, the device should
+ * update the percentage complete in the Background Command Status Register
+ * at least once per second.
+ */
+
+#define CXL_MBOX_BG_UPDATE_FREQ 1000UL
+
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                             size_t len_in, uint8_t *pl_in, size_t *len_out,
                             uint8_t *pl_out, bool *bg_started)
 {
+    int ret;
     const struct cxl_cmd *cxl_cmd;
     opcode_handler h;
 
@@ -1031,7 +1042,81 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
-    return (*h)(cxl_cmd, pl_in, len_in, pl_out, len_out, cci);
+    /* Only one bg command at a time */
+    if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
+        cci->bg.runtime > 0) {
+        return CXL_MBOX_BUSY;
+    }
+
+    ret = (*h)(cxl_cmd, pl_in, len_in, pl_out, len_out, cci);
+    if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
+        ret == CXL_MBOX_BG_STARTED) {
+        *bg_started = true;
+    } else {
+        *bg_started = false;
+    }
+
+    /* Set bg and the return code */
+    if (*bg_started) {
+        uint64_t now;
+
+        cci->bg.opcode = (set << 8) | cmd;
+
+        cci->bg.complete_pct = 0;
+        cci->bg.ret_code = 0;
+
+        now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+        cci->bg.starttime = now;
+        timer_mod(cci->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
+    }
+
+    return ret;
+}
+
+static void bg_timercb(void *opaque)
+{
+    CXLCCI *cci = opaque;
+    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
+    uint64_t bg_status_reg = 0;
+    uint64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    uint64_t total_time = cci->bg.starttime + cci->bg.runtime;
+
+    assert(cci->bg.runtime > 0);
+    bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
+                               OP, cci->bg.opcode);
+
+    if (now >= total_time) { /* we are done */
+        uint64_t status_reg;
+        uint16_t ret = CXL_MBOX_SUCCESS;
+
+        cci->bg.complete_pct = 100;
+        /* Clear bg */
+        status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, BG_OP, 0);
+        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
+
+        bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
+                                   RET_CODE, ret);
+
+        /* TODO add ad-hoc cmd succesful completion handling */
+
+        qemu_log("Background command %04xh finished: %s\n",
+                 cci->bg.opcode,
+                 ret == CXL_MBOX_SUCCESS ? "success" : "aborted");
+    } else {
+        /* estimate only */
+        cci->bg.complete_pct = 100 * now / total_time;
+        timer_mod(cci->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
+    }
+
+    bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
+                               PERCENTAGE_COMP, cci->bg.complete_pct);
+    cxl_dstate->mbox_reg_state64[R_CXL_DEV_BG_CMD_STS] = bg_status_reg;
+
+    if (cci->bg.complete_pct == 100) {
+        cci->bg.starttime = 0;
+        /* registers are updated, allow new bg-capable cmds */
+        cci->bg.runtime = 0;
+    }
 }
 
 void cxl_init_cci(CXLCCI *cci, size_t payload_max)
@@ -1050,6 +1135,11 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
             }
         }
     }
+    cci->bg.complete_pct = 0;
+    cci->bg.starttime = 0;
+    cci->bg.runtime = 0;
+    cci->bg.timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                 bg_timercb, cci);
 }
 
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
-- 
MST



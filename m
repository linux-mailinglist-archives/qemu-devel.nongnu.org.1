Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A14007E38FD
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:23:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J5H-0003v4-IX; Tue, 07 Nov 2023 05:13:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5F-0003jD-7R
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5D-0002vE-Ee
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rHJ2D9xDQ+Tz1Walx9bxOs4xv1lSe9aYQe31wj9f+X4=;
 b=EX/Yay4A6kAkvjkdB+JL1weLalM0j7l37ytw99yy2XexzvxwHa9rFyyjJIUX1bCu1jeiWv
 wINqgygORssrPiFApDUqAUGTdOojKQuTFGLcZ9cAFByOjM9MBWExHJsnKDYQFt+jFh1X8g
 MXyeYRXr9hkvOQPb61MBkI+9AbGEf24=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-dqkCUYrNOLudS2RohifygA-1; Tue, 07 Nov 2023 05:13:07 -0500
X-MC-Unique: dqkCUYrNOLudS2RohifygA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507cee14477so6345442e87.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:13:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351985; x=1699956785;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHJ2D9xDQ+Tz1Walx9bxOs4xv1lSe9aYQe31wj9f+X4=;
 b=vank7+KDMel6uQsDTCiVCUV6ALbLJno61EhWOgzjerAkqOCkWdLptZ8PdfS/C6qPP+
 12Plvbubmj5YRJgqYUw+LpG4aQZ+q87PwRUze8eFrjE2Ps0qct7gyea9QMyKoGh71mzn
 SKjDgUBcojMbYgiEAmXoveG2Qu3hrCwTC6iy4FX603/zei0SiLwTj/0m9rG1p9MdjVgo
 iwIF9NMmTd+qfL2uxoCe1WVJ2lJzOV8X/1mD6IYwBIhpzJaLUIDE4lP1lvgVuCzCXeVX
 ftSmStdbuTQkM8gbqcMVHV4UcU0Ave2XI3eoGTfMz0XloJKlS3Nc0AozO5YshT/N8aoP
 pc4w==
X-Gm-Message-State: AOJu0Yy7d1dWMtEBp9sO4Wu5sFujiC1hAOo7pv36l/n/YJ2VPGZXVK5D
 1hBU4ihF2JACSX1B2J98hFQ7ooRvjYN/kirylqIq+R+CoS8cHSTxRV75KvIQyRK6AL5nKby2xL4
 MbuDjAt7OiqdAblQZI3S+YkDL0Gf5xthvc/I9DjeC1Ui+nOFGsy8RLKOFzuiIHDL1mkR5
X-Received: by 2002:ac2:4895:0:b0:500:7a21:3e78 with SMTP id
 x21-20020ac24895000000b005007a213e78mr21711213lfc.55.1699351984906; 
 Tue, 07 Nov 2023 02:13:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/1Xq/Xtj63MJNVrhBDSXc9b1k2lsyfFwg0eYdixVsYpNQ7DQawXkHEELARVtVCRFp6KD/ug==
X-Received: by 2002:ac2:4895:0:b0:500:7a21:3e78 with SMTP id
 x21-20020ac24895000000b005007a213e78mr21711197lfc.55.1699351984570; 
 Tue, 07 Nov 2023 02:13:04 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 j19-20020a05600c191300b004090ca6d785sm15305739wmq.2.2023.11.07.02.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:13:04 -0800 (PST)
Date: Tue, 7 Nov 2023 05:13:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 48/63] hw/cxl/mbox: Generalize the CCI command processing
Message-ID: <c9460561edbd8b2d4adbf1f7c5cb4ad4d210de4c.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

By moving the parts of the mailbox command handling that are CCI type
specific out to the caller, make the main handling code generic. Rename it
to cxl_process_cci_message() to reflect this new generality.

Change the type3 mailbox handling (reused shortly for the switch
mailbox CCI) to take a snapshot of the mailbox input data rather
than operating on it in place.  This reduces the chance of bugs
due to aliasing going forwars.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Message-Id: <20231023160806.13206-5-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |  5 +++-
 hw/cxl/cxl-device-utils.c   | 44 +++++++++++++++++++++++++++++++-
 hw/cxl/cxl-mailbox-utils.c  | 51 ++++++++-----------------------------
 3 files changed, 57 insertions(+), 43 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 779ca85319..6f8040b5ff 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -260,7 +260,10 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
 void cxl_init_cci(CXLCCI *cci, size_t payload_max);
-void cxl_process_mailbox(CXLCCI *cci);
+int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
+                            size_t len_in, uint8_t *pl_in,
+                            size_t *len_out, uint8_t *pl_out,
+                            bool *bg_started);
 
 #define cxl_device_cap_init(dstate, reg, cap_id, ver)                      \
     do {                                                                   \
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 327949a805..eb86634250 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -157,7 +157,49 @@ static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
 
     if (ARRAY_FIELD_EX32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
                          DOORBELL)) {
-        cxl_process_mailbox(cci);
+        uint64_t command_reg =
+            cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD];
+        uint8_t cmd_set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD,
+                                     COMMAND_SET);
+        uint8_t cmd = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND);
+        size_t len_in = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
+        uint8_t *pl = cxl_dstate->mbox_reg_state + A_CXL_DEV_CMD_PAYLOAD;
+        /*
+         * Copy taken to avoid need for individual command handlers to care
+         * about aliasing.
+         */
+        g_autofree uint8_t *pl_in_copy = NULL;
+        size_t len_out = 0;
+        uint64_t status_reg;
+        bool bg_started = false;
+        int rc;
+
+        pl_in_copy = g_memdup2(pl, len_in);
+        if (len_in == 0 || pl_in_copy) {
+            /* Avoid stale data  - including from earlier cmds */
+            memset(pl, 0, CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+            rc = cxl_process_cci_message(cci, cmd_set, cmd, len_in, pl_in_copy,
+                                         &len_out, pl, &bg_started);
+        } else {
+            rc = CXL_MBOX_INTERNAL_ERROR;
+        }
+
+        /* Set bg and the return code */
+        status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, BG_OP,
+                                bg_started ? 1 : 0);
+        status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, ERRNO, rc);
+        /* Set the return length */
+        command_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_CMD, COMMAND_SET, cmd_set);
+        command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD,
+                                 COMMAND, cmd);
+        command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD,
+                                 LENGTH, len_out);
+
+        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD] = command_reg;
+        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
+        /* Tell the host we're done */
+        ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
+                         DOORBELL, 0);
     }
 }
 
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 5484dfbbf1..239acc659d 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -754,58 +754,27 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_clear_poison, 72, 0 },
 };
 
-void cxl_process_mailbox(CXLCCI *cci)
+int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
+                            size_t len_in, uint8_t *pl_in, size_t *len_out,
+                            uint8_t *pl_out, bool *bg_started)
 {
-    uint16_t ret = CXL_MBOX_SUCCESS;
     const struct cxl_cmd *cxl_cmd;
-    uint64_t status_reg = 0;
     opcode_handler h;
-    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
-    uint64_t command_reg = cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD];
 
-    uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
-    uint8_t cmd = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND);
-    uint16_t len_in = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
-    uint8_t *pl = cxl_dstate->mbox_reg_state + A_CXL_DEV_CMD_PAYLOAD;
-    /*
-     * Copy taken to avoid need for individual command handlers to care
-     * about aliasing.
-     */
-    g_autofree uint8_t *pl_in_copy = NULL;
-    size_t len_out = 0;
-
-    pl_in_copy = g_memdup2(pl, len_in);
-    /* Avoid stale data - including from earlier commands */
-    memset(pl, 0, CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+    *len_out = 0;
     cxl_cmd = &cci->cxl_cmd_set[set][cmd];
     h = cxl_cmd->handler;
-    if (h) {
-        if (len_in == cxl_cmd->in || cxl_cmd->in == ~0) {
-            ret = (*h)(cxl_cmd, pl, len_in, pl, &len_out, cci);
-            assert(len_out <= cci->payload_max);
-        } else {
-            ret = CXL_MBOX_INVALID_PAYLOAD_LENGTH;
-        }
-    } else {
+    if (!h) {
         qemu_log_mask(LOG_UNIMP, "Command %04xh not implemented\n",
                       set << 8 | cmd);
-        ret = CXL_MBOX_UNSUPPORTED;
+        return CXL_MBOX_UNSUPPORTED;
     }
 
-    /* Set the return code */
-    status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, ERRNO, ret);
+    if (len_in != cxl_cmd->in && cxl_cmd->in != ~0) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
 
-    /* Set the return length */
-    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET, 0);
-    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND, 0);
-    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH, len_out);
-
-    cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD] = command_reg;
-    cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
-
-    /* Tell the host we're done */
-    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
-                     DOORBELL, 0);
+    return (*h)(cxl_cmd, pl_in, len_in, pl_out, len_out, cci);
 }
 
 void cxl_init_cci(CXLCCI *cci, size_t payload_max)
-- 
MST



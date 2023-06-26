Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E6073DF37
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:30:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlKI-0000zp-8U; Mon, 26 Jun 2023 08:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKG-0000zQ-DZ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKE-0002Zh-Qn
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s4Nn0d4t8O+zA9gTBqamJX6fozHQh9bN5sN8K/Y3DoY=;
 b=T+6F7leeHdbUEQb/Zg5TiEsKR7qtDG9jVSM9lCvv7PZMHjRZX9apWsPtF5UJewtQFb/faT
 lY/m/a/g7B0FVZ+Gas06lLUszdxv/7mO1y/zjaNu8Cuz32a/fdxUOJBe8eZQhBPUKI7gB9
 qGES7KtbqLE7yRxjDcka7jEwUXtFZfk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-nwMJv44bOQCRBsdgRhGg6A-1; Mon, 26 Jun 2023 08:28:09 -0400
X-MC-Unique: nwMJv44bOQCRBsdgRhGg6A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f7e4dc0fe5so19020905e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782487; x=1690374487;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s4Nn0d4t8O+zA9gTBqamJX6fozHQh9bN5sN8K/Y3DoY=;
 b=ZospJIKbtWdrZTTOg1+tZPC8V/qYnW8J5/pfnY4x2DZkHj79aOYYdhPcVtdyFBQ1YM
 xLd+czzFo4Wtt3dTTvwEGTRtWeZdvfCrLv4red0f0HRdphB3g6/cK8fLB0+V/pmn9PXS
 7nyVJYCbprEmHcV5ah7Y1kh4YjI051Vz0aQotrC4SnmT15C/iMs5Ho/lUT9QRTofMGv0
 ZEAVqzEoAn1tXF8Wvb+k8O9rxUsA1X389qxseGVaBdFHokVMLpcKj2OEFu/vqLAdhil9
 1m+9rq84fBeKkCld6khEl3leLi2ejjiecP/Tu1stEYpNPwCaTwdlPOmHGwcxR6EV5oFU
 6/lg==
X-Gm-Message-State: AC+VfDzdnqVFS4kT1Gt+YYqTfsFLlK1A49jVgiD0uQAPsVOlVRcmUjZa
 hBR9ZD9Wq9AdhmsrbizcVKUA6VATRNeXhbLQAOYeFv6B8Ojc90Wyx9yZ/1R4/xmYEspy4N5XwOe
 yc2hVlrbWoPRnupkqwS14iRk4yOPdGEXZ0QICzmYIl18ZLOnscLkBFglX/p2TOpBaoNUj
X-Received: by 2002:a7b:c392:0:b0:3fa:8fb1:50fe with SMTP id
 s18-20020a7bc392000000b003fa8fb150femr2728126wmj.15.1687782487372; 
 Mon, 26 Jun 2023 05:28:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4lMSjZUQoOc0wEFqnF0xkv1Ez7xHeDyQLDrxdsbrz5KM7riWg3m2DLrt6GiBxbO58l7/eX1A==
X-Received: by 2002:a7b:c392:0:b0:3fa:8fb1:50fe with SMTP id
 s18-20020a7bc392000000b003fa8fb150femr2728110wmj.15.1687782487118; 
 Mon, 26 Jun 2023 05:28:07 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 z3-20020a5d4d03000000b0030aec5e020fsm7219705wrt.86.2023.06.26.05.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:28:06 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:28:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 06/53] hw/cxl: Move CXLRetCode definition to cxl_device.h
Message-ID: <2f6b8c8f420d90579b29a96f46630e241dd2c1cc.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Following patches will need access to the mailbox return code
type so move it to the header.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20230530133603.16934-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h | 28 ++++++++++++++++++++++++++++
 hw/cxl/cxl-mailbox-utils.c  | 28 ----------------------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 16993f7098..9f8ee85f8a 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -83,6 +83,34 @@
     (CXL_DEVICE_CAP_REG_SIZE + CXL_DEVICE_STATUS_REGISTERS_LENGTH +     \
      CXL_MAILBOX_REGISTERS_LENGTH + CXL_MEMORY_DEVICE_REGISTERS_LENGTH)
 
+/* 8.2.8.4.5.1 Command Return Codes */
+typedef enum {
+    CXL_MBOX_SUCCESS = 0x0,
+    CXL_MBOX_BG_STARTED = 0x1,
+    CXL_MBOX_INVALID_INPUT = 0x2,
+    CXL_MBOX_UNSUPPORTED = 0x3,
+    CXL_MBOX_INTERNAL_ERROR = 0x4,
+    CXL_MBOX_RETRY_REQUIRED = 0x5,
+    CXL_MBOX_BUSY = 0x6,
+    CXL_MBOX_MEDIA_DISABLED = 0x7,
+    CXL_MBOX_FW_XFER_IN_PROGRESS = 0x8,
+    CXL_MBOX_FW_XFER_OUT_OF_ORDER = 0x9,
+    CXL_MBOX_FW_AUTH_FAILED = 0xa,
+    CXL_MBOX_FW_INVALID_SLOT = 0xb,
+    CXL_MBOX_FW_ROLLEDBACK = 0xc,
+    CXL_MBOX_FW_REST_REQD = 0xd,
+    CXL_MBOX_INVALID_HANDLE = 0xe,
+    CXL_MBOX_INVALID_PA = 0xf,
+    CXL_MBOX_INJECT_POISON_LIMIT = 0x10,
+    CXL_MBOX_PERMANENT_MEDIA_FAILURE = 0x11,
+    CXL_MBOX_ABORTED = 0x12,
+    CXL_MBOX_INVALID_SECURITY_STATE = 0x13,
+    CXL_MBOX_INCORRECT_PASSPHRASE = 0x14,
+    CXL_MBOX_UNSUPPORTED_MAILBOX = 0x15,
+    CXL_MBOX_INVALID_PAYLOAD_LENGTH = 0x16,
+    CXL_MBOX_MAX = 0x17
+} CXLRetCode;
+
 typedef struct cxl_device_state {
     MemoryRegion device_registers;
 
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index e3401b6be8..d7e114aaae 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -68,34 +68,6 @@ enum {
         #define CLEAR_POISON           0x2
 };
 
-/* 8.2.8.4.5.1 Command Return Codes */
-typedef enum {
-    CXL_MBOX_SUCCESS = 0x0,
-    CXL_MBOX_BG_STARTED = 0x1,
-    CXL_MBOX_INVALID_INPUT = 0x2,
-    CXL_MBOX_UNSUPPORTED = 0x3,
-    CXL_MBOX_INTERNAL_ERROR = 0x4,
-    CXL_MBOX_RETRY_REQUIRED = 0x5,
-    CXL_MBOX_BUSY = 0x6,
-    CXL_MBOX_MEDIA_DISABLED = 0x7,
-    CXL_MBOX_FW_XFER_IN_PROGRESS = 0x8,
-    CXL_MBOX_FW_XFER_OUT_OF_ORDER = 0x9,
-    CXL_MBOX_FW_AUTH_FAILED = 0xa,
-    CXL_MBOX_FW_INVALID_SLOT = 0xb,
-    CXL_MBOX_FW_ROLLEDBACK = 0xc,
-    CXL_MBOX_FW_REST_REQD = 0xd,
-    CXL_MBOX_INVALID_HANDLE = 0xe,
-    CXL_MBOX_INVALID_PA = 0xf,
-    CXL_MBOX_INJECT_POISON_LIMIT = 0x10,
-    CXL_MBOX_PERMANENT_MEDIA_FAILURE = 0x11,
-    CXL_MBOX_ABORTED = 0x12,
-    CXL_MBOX_INVALID_SECURITY_STATE = 0x13,
-    CXL_MBOX_INCORRECT_PASSPHRASE = 0x14,
-    CXL_MBOX_UNSUPPORTED_MAILBOX = 0x15,
-    CXL_MBOX_INVALID_PAYLOAD_LENGTH = 0x16,
-    CXL_MBOX_MAX = 0x17
-} CXLRetCode;
-
 struct cxl_cmd;
 typedef CXLRetCode (*opcode_handler)(struct cxl_cmd *cmd,
                                    CXLDeviceState *cxl_dstate, uint16_t *len);
-- 
MST



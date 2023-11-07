Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD577E38B0
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:18:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J69-0005MX-Ve; Tue, 07 Nov 2023 05:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J62-0005Lr-7b
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:14:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5s-0002yy-JV
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699352039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hpjO7cqX1+zgW+Zy/8FDSdSBEl0cy3TqXeEl7yOst3E=;
 b=HbzeKnyEaVSiN8wsJNvaPt/Avk/f0qfS21vjUSFZNLyWBOYENYTEtwWX+ngnvGQCLH6jhj
 GjVKhcJ/SzlGT2UOChAcTWdfcvBma9N6OmCI1FczgdpLxy3gtil9NiQmKLA/tHlkf4RRIN
 xr4BJhEKGTgxGEjqMCtDsRlVdXgrKAE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-e3V5hI3APMSA-rX997ooIA-1; Tue, 07 Nov 2023 05:13:48 -0500
X-MC-Unique: e3V5hI3APMSA-rX997ooIA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-408f9cee5e8so35170575e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:13:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699352027; x=1699956827;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hpjO7cqX1+zgW+Zy/8FDSdSBEl0cy3TqXeEl7yOst3E=;
 b=VxKm4EruksK9ubbzuO6ghLBAkIGR6/p54crWFHwtFqpjGZF2rB5ZtTSllVKYzK/BdV
 a4YiQZ1rEehBm1c7OhTU79Fmo9bfNSFpcSZgcoXFRX1x5AYwUnTmUce2zUu0iWNN1ZH4
 TAOemxz1jsBHhxhMj3K4LQG643fsXnfYy626YRbUwizBalTTxuFEyEHKJn6rW9f4DRjf
 ce2KgEG7aI5jw9rF077mvQ7vDOFH22/Ugd+RSst56P69qRsVQrI+1oyD6isNqu89hDgU
 osGwJdbJC43kEhDUGVR0rtcVW+0i3OO6nJyNlKa03iGh3mEpmnAQwMqj2H+pzSjAwgbc
 UPKQ==
X-Gm-Message-State: AOJu0YzYMSVsk6os+ql00TvnhwEzGWdT31CM1C0MFtWmsvViVMwrMtBz
 Mj+Cs2dnXJpQN/QcGrBexUHSFluKVPc1I0JW1z+Qqi2cFF53y68mDVSXHJnKo0G0TzAB+q6KNAV
 S0UYl1KdMwxYHtBatcMmOq3zBhADe+bo3az2zz6v/5kHSg6oqxIDQ2F3w7dx28QX3OR6G
X-Received: by 2002:a05:600c:3588:b0:401:eb0:a974 with SMTP id
 p8-20020a05600c358800b004010eb0a974mr1636954wmq.3.1699352027186; 
 Tue, 07 Nov 2023 02:13:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHD6nj5bJtdYKknzfj1oTRjtJDKsu0Ls9b0H5K9d8cHcnaPrRmRhLg6k5piKwjpDxR9vytp/g==
X-Received: by 2002:a05:600c:3588:b0:401:eb0:a974 with SMTP id
 p8-20020a05600c358800b004010eb0a974mr1636943wmq.3.1699352026890; 
 Tue, 07 Nov 2023 02:13:46 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 i20-20020a05600c355400b0040839fcb217sm15227132wmq.8.2023.11.07.02.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:13:46 -0800 (PST)
Date: Tue, 7 Nov 2023 05:13:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 58/63] hw/cxl/mbox: Add Get Background Operation Status Command
Message-ID: <9dd15ab6e6b35db6ff166e5016b0c2042c5439c6.1699351720.git.mst@redhat.com>
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

For now, provide this command on type 3 main mailbox only.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20231023160806.13206-15-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2463f239af..2b78136588 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -50,6 +50,7 @@
 enum {
     INFOSTAT    = 0x00,
         #define IS_IDENTIFY   0x1
+        #define BACKGROUND_OPERATION_STATUS    0x2
     EVENTS      = 0x01,
         #define GET_RECORDS   0x0
         #define CLEAR_RECORDS   0x1
@@ -452,6 +453,36 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.0 8.2.9.1.2 */
+static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
+                                         uint8_t *payload_in,
+                                         size_t len_in,
+                                         uint8_t *payload_out,
+                                         size_t *len_out,
+                                         CXLCCI *cci)
+{
+    struct {
+        uint8_t status;
+        uint8_t rsvd;
+        uint16_t opcode;
+        uint16_t returncode;
+        uint16_t vendor_ext_status;
+    } QEMU_PACKED *bg_op_status;
+    QEMU_BUILD_BUG_ON(sizeof(*bg_op_status) != 8);
+
+    bg_op_status = (void *)payload_out;
+    memset(bg_op_status, 0, sizeof(*bg_op_status));
+    bg_op_status->status = cci->bg.complete_pct << 1;
+    if (cci->bg.runtime > 0) {
+        bg_op_status->status |= 1U << 0;
+    }
+    bg_op_status->opcode = cci->bg.opcode;
+    bg_op_status->returncode = cci->bg.ret_code;
+    *len_out = sizeof(*bg_op_status);
+
+    return CXL_MBOX_SUCCESS;
+}
+
 /* 8.2.9.2.1 */
 static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                uint8_t *payload_in,
@@ -1111,6 +1142,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
 
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
+    [INFOSTAT][BACKGROUND_OPERATION_STATUS] = { "BACKGROUND_OPERATION_STATUS",
+        cmd_infostat_bg_op_sts, 0, 0 },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 0,
                          IMMEDIATE_POLICY_CHANGE },
-- 
MST



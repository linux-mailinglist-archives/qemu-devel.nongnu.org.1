Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1577E38E0
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:21:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J5A-0003i9-8J; Tue, 07 Nov 2023 05:13:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J58-0003hy-Hi
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J56-0002ug-Q2
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XNWOwrs5zagROUa4HX64Ay0lI5qsgsRbHzYFsj3DF2M=;
 b=HluVkj8SZ4C0mRePade1JZSTMtF2nQDk4MQogRCmQyUHcxNIwslBjGl5AuG4/9n8LkdKfy
 woXMdnc8/9IkcMH4EK9vDV1u5n2so7CKd1PWmMUDJRZ7Jn7vVokaIt8hzInYVn8D7/oKvX
 uJTS+VQ3kYIfqAwAm1ssbV3Q2NhJxtM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-HI7tHKkRMbaYl-Z5m3-EXA-1; Tue, 07 Nov 2023 05:13:11 -0500
X-MC-Unique: HI7tHKkRMbaYl-Z5m3-EXA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4090181eec2so35038105e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:13:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351989; x=1699956789;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XNWOwrs5zagROUa4HX64Ay0lI5qsgsRbHzYFsj3DF2M=;
 b=gwlZsLIsZ1hXU+zyzTJ6aVvvvcc9bRhU7v0UzWWGutq+cztIyXnrLd1vlOqU4WHfxp
 ZzlljdhWJS6VntGmi1iBbJ7FhlxTAJ232bqWMBjemTvSsKSmwXnsEpWfenMgeGWO54kY
 DBtVNoKUhZH6mU8DVBfKS1EIN4eknukDzyoeLBuKjbLlyrxXgz05QedjOI8adHFPmC7x
 vDMRC6IzZfUMibiRYOuz3aaHfmbRoN7A2jxYc0SosMNr92EuIiLoPvrFPqSYDKObN2lR
 5lPc2B1F7+TVCvo1+3dZmdpetZrqZvJgd/J/1NFwtfesVi35IPwraahA8UQ1jKRuMfpq
 bbuw==
X-Gm-Message-State: AOJu0YyyXTu2xY4r3qGbfLEQ9ytRBUtpb2tbc0GcvigRlmjxU5NIYNbO
 5ofYgZYIIKcmJH8UswK240hnkFZrZywwsHRBVYAW3n9wKBZWdj8pkwn2KW7QoAnPR+aoT1rnLwB
 jXjq7enm8ExG3KkOhdF3s6Ac3EL5moFHYm+DIxTHYbn/aoQjlbVE31yPIwo6W74CgkmEO
X-Received: by 2002:adf:dd92:0:b0:32d:b051:9a29 with SMTP id
 x18-20020adfdd92000000b0032db0519a29mr24906993wrl.2.1699351989251; 
 Tue, 07 Nov 2023 02:13:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWKI+UfPL9KHklMVnUEvErMsrD69UE+sCnOzSDtHvUlof3bkaM0zc/iCJVwnAs3AIq4waZBw==
X-Received: by 2002:adf:dd92:0:b0:32d:b051:9a29 with SMTP id
 x18-20020adfdd92000000b0032db0519a29mr24906971wrl.2.1699351988827; 
 Tue, 07 Nov 2023 02:13:08 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 y14-20020a056000108e00b0032dbf6bf7a2sm1897532wrw.97.2023.11.07.02.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:13:08 -0800 (PST)
Date: Tue, 7 Nov 2023 05:13:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 49/63] hw/pci-bridge/cxl_upstream: Move defintion of device to
 header.
Message-ID: <2710d49a7c8b9b117a46847c7ace5eb21d48e882.1699351720.git.mst@redhat.com>
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

To avoid repetition of switch upstream port specific data in the
CXLDeviceState structure it will be necessary to access the switch USP
specific data from mailbox callbacks. Hence move it to cxl_device.h so it
is no longer an opaque structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Message-Id: <20231023160806.13206-6-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci-bridge/cxl_upstream_port.h | 18 ++++++++++++++++++
 hw/pci-bridge/cxl_upstream.c              | 11 +----------
 2 files changed, 19 insertions(+), 10 deletions(-)
 create mode 100644 include/hw/pci-bridge/cxl_upstream_port.h

diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
new file mode 100644
index 0000000000..b02aa8f659
--- /dev/null
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -0,0 +1,18 @@
+
+#ifndef CXL_USP_H
+#define CXL_USP_H
+#include "hw/pci/pcie.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/cxl/cxl.h"
+
+typedef struct CXLUpstreamPort {
+    /*< private >*/
+    PCIEPort parent_obj;
+
+    /*< public >*/
+    CXLComponentState cxl_cstate;
+    DOECap doe_cdat;
+    uint64_t sn;
+} CXLUpstreamPort;
+
+#endif /* CXL_SUP_H */
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index b81bb5fec9..36737189c6 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -14,6 +14,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/pci-bridge/cxl_upstream_port.h"
 /*
  * Null value of all Fs suggested by IEEE RA guidelines for use of
  * EU, OUI and CID
@@ -30,16 +31,6 @@
 #define CXL_UPSTREAM_PORT_DVSEC_OFFSET \
     (CXL_UPSTREAM_PORT_SN_OFFSET + PCI_EXT_CAP_DSN_SIZEOF)
 
-typedef struct CXLUpstreamPort {
-    /*< private >*/
-    PCIEPort parent_obj;
-
-    /*< public >*/
-    CXLComponentState cxl_cstate;
-    DOECap doe_cdat;
-    uint64_t sn;
-} CXLUpstreamPort;
-
 CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp)
 {
     return &usp->cxl_cstate;
-- 
MST



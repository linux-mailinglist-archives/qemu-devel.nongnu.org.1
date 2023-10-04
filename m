Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F417B7ACB
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:53:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxXu-0002Mg-27; Wed, 04 Oct 2023 04:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxWD-0008QU-Ip
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxW8-0002R0-Gc
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3U17/oa5P7mPsBmst5AlGCXHwzW+EDnuhpAyDnkjh7s=;
 b=BY500f+GVgZ+pxZ5GUhOp+V3bybd+ch6VbsC48qCCLeiI+cIo+8cL4YcbHNgCEVS9yLNoM
 xx9c1DJK4F2MUm0AXYVIg/ZrD7TELLE/+c6Zy+5K74PY9EkcylNfop+t7C/1aBi2DxtexQ
 hADafCAxDMM+7MkUHdB6+iBANrDbKBw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-IMJAfIE9MNab5axiKFC1Lg-1; Wed, 04 Oct 2023 04:45:52 -0400
X-MC-Unique: IMJAfIE9MNab5axiKFC1Lg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fef3606d8cso14737485e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409150; x=1697013950;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3U17/oa5P7mPsBmst5AlGCXHwzW+EDnuhpAyDnkjh7s=;
 b=qKd1tenAjg5uz/Xpn6BfJbQ5YxAcS0Skd7EmEcLcNFV4rM0wkor9PqBTZhmSVych4R
 9nxvu5xH1sL+AtKnR89FX2zZNNFfk5tc5qJ203UHDNNhBg79aMLiQelOWIWhHMA3RbVY
 uUtp7XIqe/N1oylg9J3A9/NQV2LZd2m6wXPax/wEb55llMx/Hop3YrbXhDk5IHalloz6
 fLd68xWw8aOdHTCuUOM/zplG/xywq1d0+3DvOldAkkN+f19OA5M05WJwMyf0zGTYzRbs
 B+Xxl32G5i9SMURrsdWHhqtiKsKhdQ/vEPgdjhAChVGIE56WocOFgIPFmORFIy8QesFE
 1I+w==
X-Gm-Message-State: AOJu0YwUnoFX/7AwRddEjiDx5cZHaTiCJBVS4i6evVSeuY0jf/yWFqCQ
 ePDXLsuNGgmWrD+jLRZtEArFtfMRT2f9TKwPYKGmJCSsCZqNhhX615bfACHa62yY64vjtRzZxJb
 LGWxmaZaYcqDs95e1bDq/raynWSaehRmZvO0sU+53ma5+NtwzW5BLC1uaB3MYEQYjhben
X-Received: by 2002:a7b:c394:0:b0:403:31a:77b9 with SMTP id
 s20-20020a7bc394000000b00403031a77b9mr1618114wmj.37.1696409150795; 
 Wed, 04 Oct 2023 01:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwbwDVFfJ+zenqRA+nGTa6gwh/YKDlH+5YC66n7OeR3g4rAkrwbCFrFWaDFYmZixQDEIHDbw==
X-Received: by 2002:a7b:c394:0:b0:403:31a:77b9 with SMTP id
 s20-20020a7bc394000000b00403031a77b9mr1618095wmj.37.1696409150512; 
 Wed, 04 Oct 2023 01:45:50 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 r2-20020a05600c320200b0040641ce36a8sm1307307wmp.1.2023.10.04.01.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:45:49 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:45:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 49/63] hw/pci-bridge/cxl-upstream: Add serial number extended
 capability support
Message-ID: <8ad87a4505cd681117655593ea1add578252fdb5.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Will be needed so there is a defined serial number for
information queries via the Switch CCI.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20230913133615.29876-1-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-bridge/cxl_upstream.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 2b9cf0cc97..a57806fb31 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -14,14 +14,21 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+/*
+ * Null value of all Fs suggested by IEEE RA guidelines for use of
+ * EU, OUI and CID
+ */
+#define UI64_NULL (~0ULL)
 
 #define CXL_UPSTREAM_PORT_MSI_NR_VECTOR 2
 
 #define CXL_UPSTREAM_PORT_MSI_OFFSET 0x70
 #define CXL_UPSTREAM_PORT_PCIE_CAP_OFFSET 0x90
 #define CXL_UPSTREAM_PORT_AER_OFFSET 0x100
-#define CXL_UPSTREAM_PORT_DVSEC_OFFSET \
+#define CXL_UPSTREAM_PORT_SN_OFFSET \
     (CXL_UPSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
+#define CXL_UPSTREAM_PORT_DVSEC_OFFSET \
+    (CXL_UPSTREAM_PORT_SN_OFFSET + PCI_EXT_CAP_DSN_SIZEOF)
 
 typedef struct CXLUpstreamPort {
     /*< private >*/
@@ -30,6 +37,7 @@ typedef struct CXLUpstreamPort {
     /*< public >*/
     CXLComponentState cxl_cstate;
     DOECap doe_cdat;
+    uint64_t sn;
 } CXLUpstreamPort;
 
 CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp)
@@ -326,7 +334,9 @@ static void cxl_usp_realize(PCIDevice *d, Error **errp)
     if (rc) {
         goto err_cap;
     }
-
+    if (usp->sn != UI64_NULL) {
+        pcie_dev_ser_num_init(d, CXL_UPSTREAM_PORT_SN_OFFSET, usp->sn);
+    }
     cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET;
     cxl_cstate->pdev = d;
     build_dvsecs(cxl_cstate);
@@ -366,6 +376,7 @@ static void cxl_usp_exitfn(PCIDevice *d)
 }
 
 static Property cxl_upstream_props[] = {
+    DEFINE_PROP_UINT64("sn", CXLUpstreamPort, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLUpstreamPort, cxl_cstate.cdat.filename),
     DEFINE_PROP_END_OF_LIST()
 };
-- 
MST



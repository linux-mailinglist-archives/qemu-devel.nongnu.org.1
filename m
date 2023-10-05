Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E607B9A5E
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:48:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFJJ-0000OB-T0; Wed, 04 Oct 2023 23:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFIm-0008Cw-A5
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFIi-0000bp-7U
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3U17/oa5P7mPsBmst5AlGCXHwzW+EDnuhpAyDnkjh7s=;
 b=PxS8s8OQM0RSyNsLpunKiiN6+p6ErXVi6aiCOY3NoQ5pOSDDKFGPQutwAbhzptJtQ8ltya
 9w8InTkPY8DnIeQ0HhZvsDdC1+QytYGJU6yyarq1XvFG+l+tsDwDHP1Q2kAnY0tiBLJNZm
 z8UK9128fmkeTDoebprOEPSbll36eXs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-G_KB-wgQPN2pqyQrsloEhw-1; Wed, 04 Oct 2023 23:45:10 -0400
X-MC-Unique: G_KB-wgQPN2pqyQrsloEhw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32337a3929aso403651f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477508; x=1697082308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3U17/oa5P7mPsBmst5AlGCXHwzW+EDnuhpAyDnkjh7s=;
 b=li2pEYK1rosNfBOA5yHW+xHbuXRHZSNk4w+pLU9FJh2n/Pik39oTJXVLkqgvYleCLS
 j3tfnFfdxNxjWtrOR4sAl3aZ7d4mhNEzicL6SVg9L+up8Ck+A/b528qpolHee3hekxtN
 1ZdA3iPUQNuIR7gSUXOLA4nycILJebZmsiV4sWlJ6i985H4X1eLVxod9V/kSsdQs+lUO
 v2qufOuxmOnaQGKCfY/jAOmazY/udRHmmeAqyHNaX6V7V1r1DGX8jWatMnwllH4cB7o4
 popJR4Ws2Gi87E7/58oF9Rb+bPwJ8dsfVzAzqF+iBYu32PmLT9M8UmZ/6Fuj6czIj3LP
 RKAA==
X-Gm-Message-State: AOJu0Yz1lWr1U1nwsJosm6xmq7oc8+CfHoMJvZ2de6AKCBgPgKxvRmBu
 SNGlcJ2yvWO4oQtfFzTo76ONAvf1kuMLGLah1LlZtYGHTe6X8bs/Sm43UM69RrJmK4IihpKb9QV
 s2LVQNbOA2GqdJKjeUXRj2/jFkIOZEvUg5T+HKsOFlnlf/tMb2GeLFnKdlLH+Q2LVa25I
X-Received: by 2002:adf:f20d:0:b0:31f:e2b9:de1f with SMTP id
 p13-20020adff20d000000b0031fe2b9de1fmr3779996wro.24.1696477508757; 
 Wed, 04 Oct 2023 20:45:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE11gglLdUSjG6ufCbkM13wv2/9Psq/6J3Qc28v99/ercWCgOKVP1idItCtrYq6oMjmkBc7oA==
X-Received: by 2002:adf:f20d:0:b0:31f:e2b9:de1f with SMTP id
 p13-20020adff20d000000b0031fe2b9de1fmr3779983wro.24.1696477508476; 
 Wed, 04 Oct 2023 20:45:08 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 p3-20020a5d4583000000b0032008f99216sm624915wrq.96.2023.10.04.20.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:45:07 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:45:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v2 39/53] hw/pci-bridge/cxl-upstream: Add serial number
 extended capability support
Message-ID: <2c9ec2a827f5d36e9cf3c55d931cc0dca2f12092.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
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



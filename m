Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E837E38A8
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:17:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J5S-0004Wc-Ph; Tue, 07 Nov 2023 05:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5Q-0004WB-4k
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5O-0002wu-KP
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699352009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TacgJjHON2zMurw0kdT8D8vIJYf8KlviQ9Ggn3SKROs=;
 b=GsVvM4dFtAcxRYXiTmh49FuPMWBVymVu4XsHyHniEqTlwHqDN+BWN2uOILQZge2EKqtFqA
 PGPOL5hC1cZX7ZzMh9QhtxK/wFv2wnuAbloiPhkqyIRZroZKq74FzB0wOuGqtXqvl+qs+i
 gT5aLEJP27MFdNA5+r3nIn6fv8dcAx4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-G4J68aW-NNm_n9nVpKihZQ-1; Tue, 07 Nov 2023 05:13:28 -0500
X-MC-Unique: G4J68aW-NNm_n9nVpKihZQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32f7943913aso2856765f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699352006; x=1699956806;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TacgJjHON2zMurw0kdT8D8vIJYf8KlviQ9Ggn3SKROs=;
 b=r5R1ACZtVXiLgwaenEP0u7WRu00nW+SPDc9BC9RIcGbEIgBTUkb85mhUDJq2QXHTCF
 qEUE5NBUVSS54IiHteHtovtVrrJKVlH+rf1anXVfF6kUSntslqG/cqfUedKBPVDhM/sE
 mKCUEtoyRajZsaafQkSXPCdOITwnz4dyApKLdNfaEi1yaN5Pzo3GuVXoyTDiDzViMaSd
 /HRgChj6cR3xTzR+HWRmr2p+wPnzPJrMpIaYPZTVdM/wl21EOS/f1kbASdEdvAft+Dbo
 ZD2nA/Fjw/JO53vI/g6pKpiIJRAkleYG+Co6xd6jBmmbp4RYaxjJ5Gsf5f9LLBFtahsI
 4ymQ==
X-Gm-Message-State: AOJu0YxgOzVk9QUYWP91dqONJVqwMk8F60f5y8YIF6iosDzMitqQ9Yu/
 iadO/1beRkdIcRp8GjUTfVlNBASs+nlwjiwXwCyaXdF/w9HjXcW7kFfJ9dQHWNVmAIE8R408UzD
 ZCtN8tKVrLHOcvbjo/mr6HAzA7Sec4BGUAQCLECe5NUhav2UowuNjaOb5KN0pdIEsID29
X-Received: by 2002:adf:e543:0:b0:32d:b2e0:ed79 with SMTP id
 z3-20020adfe543000000b0032db2e0ed79mr22658249wrm.67.1699352006366; 
 Tue, 07 Nov 2023 02:13:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnVOu7VOOsx8p89AEA5YrCBnibAD5+7WZHLNY1RfU0plyB6L0v2gPwDk2KDfqdOO7/eDFdBQ==
X-Received: by 2002:adf:e543:0:b0:32d:b2e0:ed79 with SMTP id
 z3-20020adfe543000000b0032db2e0ed79mr22658237wrm.67.1699352006107; 
 Tue, 07 Nov 2023 02:13:26 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 e12-20020adffd0c000000b0032196c508e3sm1941181wrr.53.2023.11.07.02.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:13:25 -0800 (PST)
Date: Tue, 7 Nov 2023 05:13:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 53/63] hw/pci-bridge/cxl_downstream: Set default link width
 and link speed
Message-ID: <314f5033c639ebe8218078a17513935747f15d9d.1699351720.git.mst@redhat.com>
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

Without these being set the PCIE Link Capabilities register has
invalid values in these two fields.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20231023160806.13206-10-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-bridge/cxl_downstream.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 8d99e1e96d..405a133eef 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -210,6 +210,19 @@ static void cxl_dsp_exitfn(PCIDevice *d)
     pci_bridge_exitfn(d);
 }
 
+static void cxl_dsp_instance_post_init(Object *obj)
+{
+    PCIESlot *s = PCIE_SLOT(obj);
+
+    if (!s->speed) {
+        s->speed = QEMU_PCI_EXP_LNK_2_5GT;
+    }
+
+    if (!s->width) {
+        s->width = QEMU_PCI_EXP_LNK_X1;
+    }
+}
+
 static void cxl_dsp_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -230,6 +243,7 @@ static const TypeInfo cxl_dsp_info = {
     .name = TYPE_CXL_DSP,
     .instance_size = sizeof(CXLDownstreamPort),
     .parent = TYPE_PCIE_SLOT,
+    .instance_post_init = cxl_dsp_instance_post_init,
     .class_init = cxl_dsp_class_init,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
-- 
MST



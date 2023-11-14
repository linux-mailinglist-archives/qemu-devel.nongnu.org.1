Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ACE7EA890
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 03:10:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2is9-0001MQ-KS; Mon, 13 Nov 2023 21:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2is8-0001LM-2t; Mon, 13 Nov 2023 21:09:48 -0500
Received: from mail-pj1-f53.google.com ([209.85.216.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2is6-0007aq-NT; Mon, 13 Nov 2023 21:09:47 -0500
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2801d7f46f9so4411143a91.3; 
 Mon, 13 Nov 2023 18:09:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699927785; x=1700532585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pnXe1Tp9eRoBQn7pI22tFabU1RSpPOFV8giEL0/CmJw=;
 b=ErrnDCyGYQZMKXDQLfZquRIOJjhQ5tMipzslhwgi25v7u2MxBs6n0BOxFchDGvBvtq
 4j4LMa4YuRcnnw86FBKdosw1otLeNVpeSzx8YiGYf6IprcoCHjLdQuGq28wjdT7VrbDP
 aU2Luuwn5q3hfiGQlhyd2vBnigQoq1h0tTmzoSwxKdlVdiJJBLmxV/tGuY9nxAxY38Xl
 Tw+eLe5T7r4fV+TOtTHWCt8xuc4MCXNYKYwZflT7+zRZxdyaiDXxuDHsyw07hyPTtlCu
 WQH8qiEF438AHCvpcUzCLckommXrzl27NxlPinzwSvnJ3cghLFcmFQ2Onnc9GtyElKYn
 cxmA==
X-Gm-Message-State: AOJu0Yz1HOOlRbVeQLVwUC0WY2rOvzZZBM0FM1l5YFvJltIgUp8xZh+z
 C5kun1G3HVbgC+j8CuxP52eAFPdfeijggw==
X-Google-Smtp-Source: AGHT+IFbxGDzVfu1z5Rm23aY3D+RQF2Lz+Uuq5Qv1x57LJuNnhsZ/iP6Yb9Rh4msR/HtpJvyVkF7lQ==
X-Received: by 2002:a17:90b:3783:b0:280:9074:eb3d with SMTP id
 mz3-20020a17090b378300b002809074eb3dmr6106221pjb.22.1699927784791; 
 Mon, 13 Nov 2023 18:09:44 -0800 (PST)
Received: from localhost.localdomain ([2601:642:4c01:2f7:5d09:c219:9099:a639])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a17090ae58d00b0027d12b1e29dsm6175362pjz.25.2023.11.13.18.09.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 18:09:44 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:Virt)
Subject: [PATCH v5 07/14] hw/arm/virt: connect TPM to platform bus
Date: Mon, 13 Nov 2023 18:09:17 -0800
Message-ID: <20231114020927.62315-8-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114020927.62315-1-j@getutm.app>
References: <20231114020927.62315-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.216.53; envelope-from=osy86dev@gmail.com;
 helo=mail-pj1-f53.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Joelle van Dyne <j@getutm.app>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/arm/virt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 85e3c5ba9d..36e2506420 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2811,6 +2811,13 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
         vms->virtio_iommu_bdf = pci_get_bdf(pdev);
         create_virtio_iommu_dt_bindings(vms);
     }
+
+#ifdef CONFIG_TPM
+    if (object_dynamic_cast(OBJECT(dev), TYPE_TPM_IF)) {
+        tpm_sysbus_plug(TPM_IF(dev), OBJECT(vms->platform_bus_dev),
+                        vms->memmap[VIRT_PLATFORM_BUS].base);
+    }
+#endif
 }
 
 static void virt_dimm_unplug_request(HotplugHandler *hotplug_dev,
-- 
2.41.0



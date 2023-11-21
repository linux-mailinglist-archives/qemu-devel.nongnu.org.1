Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF08E7F3520
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 18:42:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5UkJ-0008CP-KB; Tue, 21 Nov 2023 12:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5UkH-0008BM-9I
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:41:09 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5UkF-0001F9-Au
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:41:09 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-332cc1f176bso1048023f8f.2
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 09:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700588466; x=1701193266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7clgUrwYfFvC52qM6G31UyIfG1h1zTHGo1j4Nprhx9Y=;
 b=WxNqJo97gUwNfvU3T7dZZh3Sn7eXvfPtmQ3EMHu513H7pEu9CcaQFGlwwMjGMe50n9
 3ry5sUp8uvFrHU331/s/a2uYNTOlZONmrsohUBYXTmTA6suE0gszJ0Q52U5UKvXhjQfc
 4NQFhbuK27YWyPoeXBjRCjkSBYLC0GRXDD1wBCOmSO05SqfL7H98/HtPDOPdmDh1IUCM
 GC1AEd6F7lWGmRAO+mEwr3QOFeaJJn02D7a/S47c8PlUrsXbQAT6YQwmGkOQ9cIyVylc
 D4vAXoaFJVWo3if2YUTBhD44fYLlQZN1o8b91Wucv2oEa8TYlwkeQDF4ODA1X73m3Lq6
 X5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700588466; x=1701193266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7clgUrwYfFvC52qM6G31UyIfG1h1zTHGo1j4Nprhx9Y=;
 b=dKTYSEXm3qN1njM5g3i9QsoYmPLeQvccDqyWwOB+J7/wP7S9VnKYzJGGPOyHz3apyP
 H4aj2UNrmkCrONp3Drxu7tALVp8QWLsORKWXoEpspod8El0yr+yn+L3ZPWBgprDyzAVG
 KmC23kJmc+VSc3Rzom8u0/XmKtW2KPF02oEgKNhqPstLWOUquzOCh7XNhHRuLXwKIJgT
 1IpUBf1fUNy0xWDMjS3xvDXBzgnwr6+h+VpwuvnMplNYadB2v/SP70fi4p/RPv28MfsY
 mwffEM6IV5q2cnTPe4IXYZaQbc2O7vmZomT5E/dz21Zqamb9mvr1ufQE3XMjx9wWnKqF
 UC4Q==
X-Gm-Message-State: AOJu0YxfE4+XaZHbBwylxLrlAEf+J1k9nZoagxutQInL+Vpf2goXphFa
 /ws8nrmiif7YxtVmKQP7TCuC1j5PejQ5L++5cN8=
X-Google-Smtp-Source: AGHT+IFAeqeyxkEPOW3hl/cQ5TtHveg1sD3Kq/CUZ02FyErAGOSGI0PXfubb6dB2lAP1lbhgdSNwww==
X-Received: by 2002:adf:f291:0:b0:331:338c:c74d with SMTP id
 k17-20020adff291000000b00331338cc74dmr5864753wro.70.1700588465831; 
 Tue, 21 Nov 2023 09:41:05 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-219.dsl.sta.abo.bbox.fr.
 [176.184.8.219]) by smtp.gmail.com with ESMTPSA id
 m5-20020a5d6a05000000b0032d2489a399sm14777202wru.49.2023.11.21.09.41.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Nov 2023 09:41:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH-for-8.2? 2/6] hw/virtio: Free
 VirtIOIOMMUPCI::vdev.reserved_regions[] on finalize()
Date: Tue, 21 Nov 2023 18:40:47 +0100
Message-ID: <20231121174051.63038-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231121174051.63038-1-philmd@linaro.org>
References: <20231121174051.63038-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Commit 0be6bfac62 ("qdev: Implement variable length array properties")
added the DEFINE_PROP_ARRAY() macro with the following comment:

  * It is the responsibility of the device deinit code to free the
  * @_arrayfield memory.

Commit 8077b8e549 added:

  DEFINE_PROP_ARRAY("reserved-regions", VirtIOIOMMUPCI,
                    vdev.nb_reserved_regions, vdev.reserved_regions,
                    qdev_prop_reserved_region, ReservedRegion),

but forgot to free the 'vdev.reserved_regions' array. Do it in the
instance_finalize() handler.

Cc: qemu-stable@nongnu.org
Fixes: 8077b8e549 ("virtio-iommu-pci: Add array of Interval properties") # v5.1.0+
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-iommu-pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index 9459fbf6ed..cbdfe4c591 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -95,10 +95,18 @@ static void virtio_iommu_pci_instance_init(Object *obj)
                                 TYPE_VIRTIO_IOMMU);
 }
 
+static void virtio_iommu_pci_instance_finalize(Object *obj)
+{
+    VirtIOIOMMUPCI *dev = VIRTIO_IOMMU_PCI(obj);
+
+    g_free(dev->vdev.prop_resv_regions);
+}
+
 static const VirtioPCIDeviceTypeInfo virtio_iommu_pci_info = {
     .generic_name  = TYPE_VIRTIO_IOMMU_PCI,
     .instance_size = sizeof(VirtIOIOMMUPCI),
     .instance_init = virtio_iommu_pci_instance_init,
+    .instance_finalize = virtio_iommu_pci_instance_finalize,
     .class_init    = virtio_iommu_pci_class_init,
 };
 
-- 
2.41.0



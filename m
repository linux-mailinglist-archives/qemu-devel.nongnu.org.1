Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E9B7FA7A0
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 18:09:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7f65-0007SX-Bq; Mon, 27 Nov 2023 12:08:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f60-0007Qp-KS
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:33 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f5y-0004d8-Us
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:32 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40b4734b975so7801185e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 09:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701104909; x=1701709709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qtgG7nMoh/J0Wuwlj0UEmo0xDREAKAgqHzHLy2baaAs=;
 b=tHpm/FIbMSk76asN/NPxAIqbBY2sTRA/+K4/ECCf4J23jaswiYsw4rTu69Sb1D+Kpn
 gsW5s8f7GpWOCyW+2Fcp9t22nj8rGRMSQnK7UkF2vPNNqu6UnIBOH+yqKUKHIFSHZpLY
 KaUdaomqc1rfU24ZBgePb1+RzXZUGq4huSem6Idq144a5ww/TNDxVrUzY5HkS/q2viGQ
 YdJrhdyIthl1cyoKSGDLrTC/pxhfRIbvDGplFk6+qDjlWytxZJttCAkKQBzMH8NrqLvh
 sYLyMJJCQFELiXC33RkzHJcsTAMDyAIk8JrEuB0C4hPw4N/DUUQfCoWiseGwpQXlMUFh
 2vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701104909; x=1701709709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qtgG7nMoh/J0Wuwlj0UEmo0xDREAKAgqHzHLy2baaAs=;
 b=cDuJERAMQFVRvVOu5PfySP7OLROYmX3ZPbb+subUysyz7csAEJh/UBJXYVYo1Ep7XV
 m3p8FpyUZ6r9jdgSm+5BYzpNDj/iE1gIxKTggTOyt8YDputg8wqPWhYdgxMyC59Pmxi0
 zoAc0+dKoWi+P5Gv0OlteSv5nJi/V4isjSCc/cJK6ikensZkcjICnbO7kzPKRYXnFPoC
 x211iRgnCRyefWxSifql8vupXMB4RKR7sRZI3D1a9g8dOIGVfSrGLHRcUZTtfML7JMgb
 Qgms6WyLvsdLIihrPYUcbhUbVyRYZTnAfTWN3sA8Zx4hHPYtbv0A/nfPefPUeXuLabOJ
 pwGw==
X-Gm-Message-State: AOJu0Yw94UBbIsXEL+n0hX52vfXUEr7hRnRgI+zcmbFvAkUJITT/xLBb
 kqTN5pxEclbLzeO3Ma0jhNG30mgctUr4bcyckec=
X-Google-Smtp-Source: AGHT+IFI95OCuo/NzHfu++Hwvcqtwnv7kWHHKLyJZoSdqe0rmFlF80OSPswbui0qYqzRs1hByj2xLQ==
X-Received: by 2002:a05:600c:19ca:b0:40b:367a:806 with SMTP id
 u10-20020a05600c19ca00b0040b367a0806mr8757538wmq.20.1701104909282; 
 Mon, 27 Nov 2023 09:08:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 fl8-20020a05600c0b8800b004030e8ff964sm15353216wmb.34.2023.11.27.09.08.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 09:08:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/13] hw/virtio: Free VirtIOIOMMUPCI::vdev.reserved_regions[]
 on finalize()
Date: Mon, 27 Nov 2023 17:08:16 +0000
Message-Id: <20231127170823.589863-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127170823.589863-1-peter.maydell@linaro.org>
References: <20231127170823.589863-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20231121174051.63038-3-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/virtio/virtio-iommu-pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index 9459fbf6edf..cbdfe4c591c 100644
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
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC9770E1EB
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:37:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1V0e-0003bz-By; Tue, 23 May 2023 12:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V0c-0003Ye-CI
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:37:14 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V0a-0001ns-0S
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:37:14 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f603d4bc5bso423745e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859829; x=1687451829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jOy+bpjsejzgIsMY1OLxW7QAM00Xe6+x59PGJ+hgH1E=;
 b=zV1yNfESHvrbx1agacksVxD2eLAG/q/hcFrusyvAxnJeBaJD2nmfjFfx3Lb998fZNT
 fKIwI0tPG9ziotHJnpDT/pNCpv1e6PycHAOPhBO6ftGMm9PrG9IyQNES8cU6CMN/FGKm
 4Kd43uib7dcdXQIUA4SSbYuNaII+XNbbIuD2kkUY9PlXBWQdNdx3o6nPX8Uie1LNsdIh
 EQAiu4q3nNKCzOx16GW8CCw9etZeuovr5U0DupzNTLMvfQl7fNB51RKvRMR01V2Gztko
 aqEHIl4wOg6H5qXmDMyu/geWNWtbZfmz76wwIgk2n/cFuzGYX/1fWUrQ+9+8SbGL02zB
 jFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859829; x=1687451829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jOy+bpjsejzgIsMY1OLxW7QAM00Xe6+x59PGJ+hgH1E=;
 b=V5sYQ9GtqGf5aTe+nkYEkWcXcnGgSaIHdVGre3FgFK/Gla7SD1uLB456XzoUN6Hjz8
 xF8xRbPYrirU+WX6J5G6JiJ3zWpQpQv0nVaV5Ho7dVZSSWujWXHtXGxOYyeAAulFCEFc
 hwXH66oNmJIn4/LZZcPdDBM35Ed3LSHtxvxtXf+09HrT53MrBxWtKYRTggw5CW8ZoN3y
 psIa+j5/HUBRLOXpjF7GiSG2TNfWci1rM7WeWpgUNnrOzkxYLZnFA13OneDzxGGNJTI9
 qKpD7EKhlMABxz19NLH4gHQ3bkdSrdA/3uV4t4gD0vmcCP0TjmMMMeLWDKchNY/Az16f
 PCxQ==
X-Gm-Message-State: AC+VfDzhN9JblPYjSyjhXYvqgJDAYuavaVIUn+RzXCsqZQymHe5h2+gl
 k6T+oYk3sIxAUgWO0eIf6F+qGqy2smsW0n605Rc=
X-Google-Smtp-Source: ACHHUZ4aqtAqbH5hdt6f03jur07idltn2jSp69YjwRSazOStED6x3njgSk8v5qn4hE8aVxkOEV1TQg==
X-Received: by 2002:a05:600c:245:b0:3f6:7d2:9859 with SMTP id
 5-20020a05600c024500b003f607d29859mr4117636wmj.6.1684859829155; 
 Tue, 23 May 2023 09:37:09 -0700 (PDT)
Received: from localhost.localdomain
 (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr. [176.184.48.94])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a1c6a08000000b003f606c4ad33sm5816462wmc.32.2023.05.23.09.37.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 May 2023 09:37:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PATCH 10/11] hw/virtio: Build various target-agnostic objects just
 once
Date: Tue, 23 May 2023 18:35:59 +0200
Message-Id: <20230523163600.83391-11-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230523163600.83391-1-philmd@linaro.org>
References: <20230523163600.83391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

The previous commit remove the unnecessary "virtio-access.h"
header. These files no longer have target-specific dependency.
Move them to the generic 'softmmu_ss' source set.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/block/dataplane/meson.build |  2 +-
 hw/scsi/meson.build            | 10 +++++++---
 hw/virtio/meson.build          | 11 ++++++-----
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/block/dataplane/meson.build b/hw/block/dataplane/meson.build
index 78d7ac1a11..dec73e7486 100644
--- a/hw/block/dataplane/meson.build
+++ b/hw/block/dataplane/meson.build
@@ -1,2 +1,2 @@
-specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
+softmmu_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
 specific_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen-block.c'))
diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
index d88f7450e8..12a1ca644f 100644
--- a/hw/scsi/meson.build
+++ b/hw/scsi/meson.build
@@ -1,5 +1,6 @@
 scsi_ss = ss.source_set()
 specific_scsi_ss = ss.source_set()
+virtio_scsi_ss = ss.source_set()
 specific_virtio_scsi_ss = ss.source_set()
 
 scsi_ss.add(files(
@@ -15,13 +16,16 @@ scsi_ss.add(when: 'CONFIG_MEGASAS_SCSI_PCI', if_true: files('megasas.c'))
 scsi_ss.add(when: 'CONFIG_MPTSAS_SCSI_PCI', if_true: files('mptsas.c', 'mptconfig.c', 'mptendian.c'))
 scsi_ss.add(when: 'CONFIG_VMW_PVSCSI_SCSI_PCI', if_true: files('vmw_pvscsi.c'))
 
-specific_virtio_scsi_ss.add(files('virtio-scsi.c', 'virtio-scsi-dataplane.c'))
+virtio_scsi_ss.add(files('virtio-scsi-dataplane.c'))
+virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi.c'))
+virtio_scsi_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-user-scsi.c'))
+
+specific_virtio_scsi_ss.add(files('virtio-scsi.c'))
 specific_virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI_COMMON', if_true: files('vhost-scsi-common.c'))
-specific_virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi.c'))
-specific_virtio_scsi_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-user-scsi.c'))
 
 specific_scsi_ss.add(when: 'CONFIG_SPAPR_VSCSI', if_true: files('spapr_vscsi.c'))
 specific_scsi_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: specific_virtio_scsi_ss)
+scsi_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: virtio_scsi_ss)
 
 softmmu_ss.add_all(when: 'CONFIG_SCSI', if_true: scsi_ss)
 specific_ss.add_all(when: 'CONFIG_SCSI', if_true: specific_scsi_ss)
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 54c90c24fb..16e64e1cf1 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -2,13 +2,18 @@ softmmu_virtio_ss = ss.source_set()
 softmmu_virtio_ss.add(files('virtio-bus.c'))
 softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('virtio-pci.c'))
 softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_MMIO', if_true: files('virtio-mmio.c'))
+softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto.c'))
+softmmu_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK_COMMON', if_true: files('vhost-vsock-common.c'))
+softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
+softmmu_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c'))
 
 specific_virtio_ss = ss.source_set()
 specific_virtio_ss.add(files('virtio.c'))
 specific_virtio_ss.add(files('virtio-config-io.c', 'virtio-qmp.c'))
 
 if have_vhost
-  specific_virtio_ss.add(files('vhost.c', 'vhost-backend.c', 'vhost-iova-tree.c'))
+  softmmu_virtio_ss.add(files('vhost.c'))
+  specific_virtio_ss.add(files('vhost-backend.c', 'vhost-iova-tree.c'))
   if have_vhost_user
     specific_virtio_ss.add(files('vhost-user.c'))
   endif
@@ -20,20 +25,16 @@ else
 endif
 
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
-specific_virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK_COMMON', if_true: files('vhost-vsock-common.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
-specific_virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vhost-user-i2c.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
 specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPIO'], if_true: files('vhost-user-gpio-pci.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c'))
 
 virtio_pci_ss = ss.source_set()
 virtio_pci_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-pci.c'))
-- 
2.38.1



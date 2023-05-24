Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA93470F31F
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:39:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kxW-00014N-Nd; Wed, 24 May 2023 05:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kxV-0000yD-2A
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:39:05 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kxR-0006zu-Sy
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:39:04 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3095557dd99so532986f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684921140; x=1687513140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mq4YpeTTGgX3+hW0ZwEiJf3J4kjmHxbt+ccYiWbLpbg=;
 b=HyxCj8+KfTT7qH8JyGXM1WCSmjGlPtqr3zhnUarUPcMGKOddeKk/dv4z292dLAegVa
 IRGMpIhkntvAZ5w5xBS9JKXRhx3fNN8XsLkqkYRGgGSOzM9qTT0tKSYTemY9uHEKigwH
 aMIawwkKzVc+xKkc/0n5USZC2/vc4LfdVSglSs5QVmMxy2yUCdUbqfr8bEsm4Zs4b1VN
 TqB1nmATTE9WQPaEXNu8BTNuRre+2qs9jyta/g516tJduLsYsWdUeF1xPZIJ2fQ6bion
 J3hZlu/7+iRSGtCsdDEJqIr3/2Roi1gS8wykwjlxxM1KAKXE+OjQTsnTE/hTyhlRyJkn
 /9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684921140; x=1687513140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mq4YpeTTGgX3+hW0ZwEiJf3J4kjmHxbt+ccYiWbLpbg=;
 b=PDg5Fm6L1SLLUwM3jxJEBf/FPBP2MArfIq6HfV88isP0fc4H4kA9u8Rs3rdm/wjrTb
 fkg5ls5ecLqeHAgEBacn7beWCsUIT0SYsr8DGff1tjtbl046uS19A0Y0Ktib7O/nTEzw
 anz9QY9fqlUyILwfBjZ4QWhPXUeA2FUigLKM8Z+wulzKLdK9WFnUPfgsvQVtxZZ5b3pI
 ymPZP8ARd4TmgJs+SU1PYm41ipkGaUSiPG2TCnnMTY5EVP9XtDDCY4S6acylWqfT9SX7
 CThu+iLzgIZF0kL++bO4jNLcxIzccHh3a/ZRFkEUUQuhJ/hj2f2nUuBcTBhQ0FFSwx9M
 5AnA==
X-Gm-Message-State: AC+VfDzyJRFbCgPGA+ASNqvXGfruavAgIJXyzcpNWOGiRwrTMrJMFQnx
 DBvFy7aK/atsKCusM+H3edIh4R0tI4uUgk5iUq7bAA==
X-Google-Smtp-Source: ACHHUZ4AvGOukVHn/+bZ5TAoNO5IaqzrTM9lmUdH6Iifw2s2UGq0hsOmyrnupIiXuIOqmUbg9m+N/A==
X-Received: by 2002:a5d:4109:0:b0:309:4ba8:f76e with SMTP id
 l9-20020a5d4109000000b003094ba8f76emr10834680wrp.26.1684921139882; 
 Wed, 24 May 2023 02:38:59 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-246.dsl.sta.abo.bbox.fr. [176.184.31.246])
 by smtp.gmail.com with ESMTPSA id
 c12-20020adfe70c000000b003078cd719ffsm13824436wrm.95.2023.05.24.02.38.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 02:38:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 10/10] hw/virtio: Build various target-agnostic objects
 just once
Date: Wed, 24 May 2023 11:37:44 +0200
Message-Id: <20230524093744.88442-11-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524093744.88442-1-philmd@linaro.org>
References: <20230524093744.88442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
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
index bde72df19c..4c8fa50783 100644
--- a/hw/scsi/meson.build
+++ b/hw/scsi/meson.build
@@ -1,5 +1,6 @@
 scsi_ss = ss.source_set()
 specific_scsi_ss = ss.source_set()
+virtio_scsi_ss = ss.source_set()
 specific_virtio_scsi_ss = ss.source_set()
 
 scsi_ss.add(files(
@@ -15,12 +16,15 @@ scsi_ss.add(when: 'CONFIG_MEGASAS_SCSI_PCI', if_true: files('megasas.c'))
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
 
 specific_scsi_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: specific_virtio_scsi_ss)
+scsi_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: virtio_scsi_ss)
 
 specific_scsi_ss.add(when: 'CONFIG_SPAPR_VSCSI', if_true: files('spapr_vscsi.c'))
 
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



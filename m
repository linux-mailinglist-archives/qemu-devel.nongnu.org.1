Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C044070F323
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:39:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kxd-0001pl-Lz; Wed, 24 May 2023 05:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kxa-0001cm-8p
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:39:10 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kxK-0006yp-Jy
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:39:09 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-30957dd7640so380658f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684921132; x=1687513132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L/JwS6FTcZAmFyGBOIMDJAjNiVsKo6s2wZtG1yzHHqw=;
 b=QM3vZeIe6leYAJm5DeIPrWHTxipcM8aYEAUvaIIDc+sxYZy9UIcF9PixOmpuvNMHNt
 2buVQhTnX04izYYSDvGv18R8rKoF26AFBxYbms3gSrD8foSGps3JjHG8vqztbxsMy52p
 AP+avTn6pYm+fyW+CHVEtOYUPNG2Us2qv8FpPoqc2LxOitxsGEAu6IOwWWBCTB8+KsRg
 HIEgkLj+0QsLooI5/AsDtzOI/LUxGsqWF1w0IaRool33mOruwE8ZN+hY8N7uvhQb2mHw
 TE3vaJuqaDXwS5npJD5AYdU/JQ2onKwJRxrkPK+tGqDVIj2Q03Z4s0iOg2yF1rssd8Xn
 vV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684921132; x=1687513132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L/JwS6FTcZAmFyGBOIMDJAjNiVsKo6s2wZtG1yzHHqw=;
 b=VCHmfMKI49sjsSl6aP8RjgMPzbS6bWqCUBSKyDTCoaFC5ivgwpK3wJ4RYrGGZmWj9e
 3HXPFVZE6oUTdPfu7aNbN/jXOL21ErDISqRsrhhgtrMrEn2X+gXAvdkEGWM6Jvnmi3bP
 Fe+73IBz+W2k41tRgF8mA2njfKF2LsXantyN0njPd+8VsSjeMoShYlH9d/fZZ8I4g70G
 g/6qJ5EWrpT8P0VeU20Wcd1nXwoCHan/wsrdpFFWeLQArGLUA3gKpDhWmbRKA8AYLFn0
 oT/NahKl19o3FmWf33jGjqFY5WSiVkjZNzP6FqnS5MCzlpLFpWLzu9Bz9bi3pZUIrS23
 dmVw==
X-Gm-Message-State: AC+VfDwrhmyd8dE8djXu0J1pvnbXBsm2cHUvP7y1dm5fedYUZjuQiovX
 W1DWex404TmaT5ZKYnWHRIITSbDd+t4k0PPnARImaA==
X-Google-Smtp-Source: ACHHUZ6mAGDUHOmJ0FnzLm44Bcwq9f0OTmyF7lGkNTnlcI8Y9Y48973dJ8ntk1jVYaV5yPzNHA5krQ==
X-Received: by 2002:adf:e60b:0:b0:309:a4e:52d3 with SMTP id
 p11-20020adfe60b000000b003090a4e52d3mr13323734wrm.5.1684921132727; 
 Wed, 24 May 2023 02:38:52 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-246.dsl.sta.abo.bbox.fr. [176.184.31.246])
 by smtp.gmail.com with ESMTPSA id
 j16-20020adff550000000b0030aa9e4fda3sm1768532wrp.12.2023.05.24.02.38.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 02:38:52 -0700 (PDT)
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
Subject: [PATCH v2 09/10] hw/virtio: Remove unnecessary 'virtio-access.h'
 header
Date: Wed, 24 May 2023 11:37:43 +0200
Message-Id: <20230524093744.88442-10-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524093744.88442-1-philmd@linaro.org>
References: <20230524093744.88442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

None of these files use the VirtIO Load/Store API declared
by "hw/virtio/virtio-access.h". This header probably crept
in via copy/pasting, remove it.

Note, "virtio-access.h" is target-specific, so any file
including it also become tainted as target-specific.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Thomas Huth <thuth@redhat.com>
---
 hw/block/dataplane/virtio-blk.c | 1 -
 hw/s390x/virtio-ccw.c           | 1 -
 hw/scsi/vhost-scsi.c            | 1 -
 hw/scsi/vhost-user-scsi.c       | 1 -
 hw/scsi/virtio-scsi-dataplane.c | 1 -
 hw/virtio/vdpa-dev.c            | 1 -
 hw/virtio/vhost-vdpa.c          | 1 -
 hw/virtio/vhost-vsock-common.c  | 1 -
 hw/virtio/vhost.c               | 1 -
 hw/virtio/virtio-crypto.c       | 1 -
 hw/virtio/virtio-iommu.c        | 1 -
 hw/virtio/virtio-mem.c          | 1 -
 12 files changed, 12 deletions(-)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index af1c24c40c..03ecb51664 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -19,7 +19,6 @@
 #include "qemu/main-loop.h"
 #include "qemu/thread.h"
 #include "qemu/error-report.h"
-#include "hw/virtio/virtio-access.h"
 #include "hw/virtio/virtio-blk.h"
 #include "virtio-blk.h"
 #include "block/aio.h"
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index f44de1a8c1..17c548b84f 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -22,7 +22,6 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/virtio/virtio-access.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/s390x/adapter.h"
 #include "hw/s390x/s390_flic.h"
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 6a0fd0dfb1..443f67daa4 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -26,7 +26,6 @@
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/virtio/virtio-access.h"
 #include "hw/fw-path-provider.h"
 #include "hw/qdev-properties.h"
 #include "qemu/cutils.h"
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index b7a71a802c..ee99b19e7a 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -26,7 +26,6 @@
 #include "hw/virtio/vhost-backend.h"
 #include "hw/virtio/vhost-user-scsi.h"
 #include "hw/virtio/virtio.h"
-#include "hw/virtio/virtio-access.h"
 #include "chardev/char-fe.h"
 #include "sysemu/sysemu.h"
 
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index f3214e1c57..21344c7cfe 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -19,7 +19,6 @@
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/virtio/virtio-access.h"
 
 /* Context: QEMU global mutex held */
 void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 01b41eb0f1..e08e830006 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -25,7 +25,6 @@
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/virtio/virtio-access.h"
 #include "hw/virtio/vdpa-dev.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/runstate.h"
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index b3094e8a8b..3c575a9a6e 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -26,7 +26,6 @@
 #include "cpu.h"
 #include "trace.h"
 #include "qapi/error.h"
-#include "hw/virtio/virtio-access.h"
 
 /*
  * Return one past the end of the end of section. Be careful with uint64_t
diff --git a/hw/virtio/vhost-vsock-common.c b/hw/virtio/vhost-vsock-common.c
index e89af9b329..321262f6b3 100644
--- a/hw/virtio/vhost-vsock-common.c
+++ b/hw/virtio/vhost-vsock-common.c
@@ -12,7 +12,6 @@
 #include "standard-headers/linux/virtio_vsock.h"
 #include "qapi/error.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/virtio/virtio-access.h"
 #include "qemu/error-report.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/vhost.h"
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 23da579ce2..7f3c727777 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -23,7 +23,6 @@
 #include "qemu/log.h"
 #include "standard-headers/linux/vhost_types.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/virtio/virtio-access.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file-types.h"
 #include "sysemu/dma.h"
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index c729a1f79e..a6d7e1e8ec 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -21,7 +21,6 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-crypto.h"
 #include "hw/qdev-properties.h"
-#include "hw/virtio/virtio-access.h"
 #include "standard-headers/linux/virtio_ids.h"
 #include "sysemu/cryptodev-vhost.h"
 
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 85905a9e3d..1bbad23f4a 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -32,7 +32,6 @@
 #include "standard-headers/linux/virtio_ids.h"
 
 #include "hw/virtio/virtio-bus.h"
-#include "hw/virtio/virtio-access.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci.h"
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 74e63bd47a..12ea58d5ad 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -20,7 +20,6 @@
 #include "sysemu/reset.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/virtio/virtio-access.h"
 #include "hw/virtio/virtio-mem.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-- 
2.38.1



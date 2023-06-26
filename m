Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5A873DF49
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:32:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlLw-0003G8-3X; Mon, 26 Jun 2023 08:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlL5-0002QS-BR
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlL1-00032w-Su
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmYTDPAI2xgJjGZMucMrx6UGF1BWykf5qDnfD2qNmBs=;
 b=CMdQ7W/lYiWS//lw17PD3cVnwSPJucXJ41onxsxBXHGLWADJpN+wRc/snDFBRhhccdcjXC
 K/bJid8p1BxeNbkAjhiaX2045R08thkmfP4yfJ7x2RwsW1Fzf7YjuKN4mQeKnpYDU62t4Q
 InVMi6vLK4Q7sg1hexy7fGr7YYLsmfk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-pE9RZE-_NxSM-k5QQK8b3A-1; Mon, 26 Jun 2023 08:28:57 -0400
X-MC-Unique: pE9RZE-_NxSM-k5QQK8b3A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fa8f8fb7b3so27935215e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782536; x=1690374536;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cmYTDPAI2xgJjGZMucMrx6UGF1BWykf5qDnfD2qNmBs=;
 b=DaeNmwY3G7MivMcyJa6Z8/f9oQP0V8ycY3S1Fm792MEpO1+cZM+zvHJpByThPo6j8y
 cVZNtYjd7PPpT6d+eDPZyh7/HU1zhn6hYTu2qnN7ohw718xyxZyOYxMLp7IBTqprxPlB
 d7jfGZO9s2k1gJT8niD0L8Q173quMoA7e6IZ4eWZhD+Nj2b2ZnrrkDicvI419kXaAozk
 CFGegDLmuP8ZLN9BWQZt9Ry3Cef9g42DGLXa25NV3keWpB/Z1HJ0iJbm/6Izm0DHQN+p
 lTD3FqjwuZhyvFc7jdvNnw5i9kAM2IJAcCRVblo1YW6cMxdaj1O29eMsYrqG7fQuqyAV
 mhBQ==
X-Gm-Message-State: AC+VfDyBuqVF3M39YwCTo1gPIl5YkypVHxpnBiUsNbFXPnliJ6j/TLGN
 0A98UclqsvzEWLG5RzzHaPKn1TLHMixvRGELLTzW/jpoKEN7tX/TdIx6rRNPSWxV6gR0qBgFinK
 d8f2y2NmJfACYq5Eu7psp3YooXpmH/PDjRNXlAc7TBy9s+Coo0GtH949LGcpsIaPo+mBK
X-Received: by 2002:a05:600c:28e:b0:3fa:8aed:d57f with SMTP id
 14-20020a05600c028e00b003fa8aedd57fmr5192259wmk.24.1687782536270; 
 Mon, 26 Jun 2023 05:28:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ItFnmCy4mk7X9UK0cRG8CIvcsJxajw3gfBC1SzxWeKRBpOicd4RlXn3UXR3EDEepdTuE0pg==
X-Received: by 2002:a05:600c:28e:b0:3fa:8aed:d57f with SMTP id
 14-20020a05600c028e00b003fa8aedd57fmr5192229wmk.24.1687782535945; 
 Mon, 26 Jun 2023 05:28:55 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 c21-20020a7bc855000000b003f8fac0ad4bsm7510243wml.17.2023.06.26.05.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:28:55 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:28:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PULL 21/53] hw/virtio: Remove unnecessary 'virtio-access.h' header
Message-ID: <4ee4667ded5841ff9278d4e4a4c765a3220023bf.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

None of these files use the VirtIO Load/Store API declared
by "hw/virtio/virtio-access.h". This header probably crept
in via copy/pasting, remove it.

Note, "virtio-access.h" is target-specific, so any file
including it also become tainted as target-specific.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230524093744.88442-10-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
index b90456c08c..c227b39408 100644
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
index d55de4c8ca..1e684beebe 100644
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
MST



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F18B7B7AC9
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:53:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxTu-0002Wb-Nh; Wed, 04 Oct 2023 04:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxTs-0002Up-Ll
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:43:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxTk-0000vM-OP
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3t8WNSkxqBpAo+9P1uf7C/JabXh9XbItEnrkHWLRDt4=;
 b=bIj2oem/9ecK0SQm0er8YiUviINECY+KUT+P9OxVXOsVlRjgmt0+YHwJeEhgEkJdC5noPL
 /Ll2XfN+V6BFDLq84zkF/zyWGQUKByTx/iu2WAvALLckHENr4JegSodLOyJ8dFmb+XrnXO
 MLFfBHznvC+WvqcGEPXhhS4b2PWtv44=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-Ly1weHnyMJ-FduMSBTJ23w-1; Wed, 04 Oct 2023 04:43:34 -0400
X-MC-Unique: Ly1weHnyMJ-FduMSBTJ23w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32320b3ee93so1406342f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409013; x=1697013813;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3t8WNSkxqBpAo+9P1uf7C/JabXh9XbItEnrkHWLRDt4=;
 b=o1jlDSxRl9bOFpOP0uqI6OS9VnNSTt1zcJg2b7pob22N62FyZOasCCxKoyw23o41pD
 exTN3k2m+UiVVJ4/V2l9kGuA5FQNrXoSRLaVtpW5UyoQtQ546VMPQy3Po6u5CNObn5JN
 mltkqvbCPFtZvZrnlUxxVVI/ysZ0SnGC3kuBQu8z6/vxlfkqv0ncY+iryeqI2kjCyR8r
 fZWYK6OHrQWIK4pTsSfTXGrBA5xM2Dfuu24p46M5XVahRGB4KSNhqhBdb7ypboYwWf9i
 iZL1PprrTjj2OGlPTuzny9gad22L8LysVTelvz++JArmKly7irBAYgISYUtpTbJZadVt
 Srvg==
X-Gm-Message-State: AOJu0YxJnOC6XPiMPv943Q+wx+G3wbBctyJkoWTJKVUgI0kgeYa5PTWc
 pWSOA28uj5TIqw5FE1CqM72+ycXVBZVe3E4ywndJ+RoN598YXIeQOXlkoZ9sg53DdgaMn++quns
 zq7+Of7ENvNoPrRG9v6ZrXLwEXtTtQXgmykM8v59pEVcIf0VAh9QETXmZNZJouHenbuU7
X-Received: by 2002:a5d:494f:0:b0:31a:d266:3d62 with SMTP id
 r15-20020a5d494f000000b0031ad2663d62mr1479509wrs.54.1696409012807; 
 Wed, 04 Oct 2023 01:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/dL8t3xsuUBtUPo4CXq85OnH5hJB3JZABcjb7Br6fFllu2IyfTFCDaKROg9dXohCN6XLvVA==
X-Received: by 2002:a5d:494f:0:b0:31a:d266:3d62 with SMTP id
 r15-20020a5d494f000000b0031ad2663d62mr1479490wrs.54.1696409012456; 
 Wed, 04 Oct 2023 01:43:32 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 e31-20020a5d595f000000b0031fbbe347e1sm3456960wri.65.2023.10.04.01.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:43:31 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:43:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 07/63] hw/virtio/meson: Rename softmmu_virtio_ss[] ->
 system_virtio_ss[]
Message-ID: <d44a150d054e15d83801959e46cdfafa6aa83612.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Similarly to commit de6cd7599b ("meson: Replace softmmu_ss
-> system_ss"), rename the virtio source set common to all
system emulation as 'system_virtio_ss[]'. This is clearer
because softmmu can be used for user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230710100510.84862-1-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/meson.build | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 9737450afd..4e81d10834 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -1,28 +1,28 @@
-softmmu_virtio_ss = ss.source_set()
-softmmu_virtio_ss.add(files('virtio-bus.c'))
-softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('virtio-pci.c'))
-softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_MMIO', if_true: files('virtio-mmio.c'))
-softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto.c'))
-softmmu_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK_COMMON', if_true: files('vhost-vsock-common.c'))
-softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
-softmmu_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c'))
+system_virtio_ss = ss.source_set()
+system_virtio_ss.add(files('virtio-bus.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('virtio-pci.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_MMIO', if_true: files('virtio-mmio.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto.c'))
+system_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK_COMMON', if_true: files('vhost-vsock-common.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
+system_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c'))
 
 specific_virtio_ss = ss.source_set()
 specific_virtio_ss.add(files('virtio.c'))
 specific_virtio_ss.add(files('virtio-config-io.c', 'virtio-qmp.c'))
 
 if have_vhost
-  softmmu_virtio_ss.add(files('vhost.c'))
+  system_virtio_ss.add(files('vhost.c'))
   specific_virtio_ss.add(files('vhost-backend.c', 'vhost-iova-tree.c'))
   if have_vhost_user
     specific_virtio_ss.add(files('vhost-user.c'))
   endif
   if have_vhost_vdpa
-    softmmu_virtio_ss.add(files('vhost-vdpa.c'))
+    system_virtio_ss.add(files('vhost-vdpa.c'))
     specific_virtio_ss.add(files('vhost-shadow-virtqueue.c'))
   endif
 else
-  softmmu_virtio_ss.add(files('vhost-stub.c'))
+  system_virtio_ss.add(files('vhost-stub.c'))
 endif
 
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
@@ -68,7 +68,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MD', if_true: files('virtio-md-pci.c'))
 
 specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
 
-system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: softmmu_virtio_ss)
+system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
 system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('vhost-stub.c'))
 system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('virtio-stub.c'))
 system_ss.add(when: 'CONFIG_ALL', if_true: files('vhost-stub.c'))
-- 
MST



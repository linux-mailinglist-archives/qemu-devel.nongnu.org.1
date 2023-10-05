Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5617B9A41
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:43:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFGM-0001GO-8o; Wed, 04 Oct 2023 23:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFGK-0001E1-3d
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:42:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFGI-0007zC-Fw
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3t8WNSkxqBpAo+9P1uf7C/JabXh9XbItEnrkHWLRDt4=;
 b=aCtCcmVbPHygB1qNdAsPR/sRPwzb5JqWacz+2aOTpj9tYWGlJcf6rp0kWSPMvJMgjkanMA
 nOWGraDRt01lKgmLX/UcXPxQYZ2d26gxAGB43j+k7HHybS/w+3Geuwt7BlpaP2jsf52i0+
 PB43l43WjTBSZRIi0XoY/uSK8281vKM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-frtlXVBzOq2KzkqcusBzlQ-1; Wed, 04 Oct 2023 23:42:52 -0400
X-MC-Unique: frtlXVBzOq2KzkqcusBzlQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4065d52a83aso4021055e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477371; x=1697082171;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3t8WNSkxqBpAo+9P1uf7C/JabXh9XbItEnrkHWLRDt4=;
 b=bEPvgI5sffLdErIB8e+0P60xOzSKuu8YtDpW0omhihNQ3z/n92sHj8JPRM4mes2VWj
 qGGIjHVOrzpB26qP9xzaF0xGryTEpoEzXDE4V4YCskzpNGZJ7eXFnEcssLCj0Adg+UuG
 P7pI+qDEZN1KtvtJvRTLxBszvmuTefd+SST5vEAsNIk+c+BTmdH3o2ziHEfFf1hb4Koi
 zPoA77yti/XLfyk8wKFrKWjxkiONuspCT1tzGj9MwoNojZkpEgGkZoiWSjVx687cQym3
 H/BDBdCDKhbjwLM90sxE4m58FlrzbT1Gc1tlALLrWrQnauoLtLIeQNrn5mtodCq9dE4Z
 C3Gg==
X-Gm-Message-State: AOJu0YwwCYdhhm1tcuCMgO4GjXHOg1YocF8jPSOOeLplOKSTHlQ/Qmqz
 vCVfDfJreHyzQ3b6YxzIWQJ6C2gbmV9nPf1uNoOwGSb24+Z/2lR0awI/kXiJOzSpCoeLeEJqNwx
 SLg+xZRMBEoAKl/zcBpk7kJ1UvAxO5Hf0r7JGCOqLqNZmJmEEr2bC8sq6XiVkpdIi+Tkt
X-Received: by 2002:a7b:cb8b:0:b0:3fb:e189:3532 with SMTP id
 m11-20020a7bcb8b000000b003fbe1893532mr3965523wmi.20.1696477371024; 
 Wed, 04 Oct 2023 20:42:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhptBq09U6H74taCgkBZ3196h/1OywTKVg9WXSOuBaM6jhGzaGk+ZpLZbSZZ8kEzLXs2/M7A==
X-Received: by 2002:a7b:cb8b:0:b0:3fb:e189:3532 with SMTP id
 m11-20020a7bcb8b000000b003fbe1893532mr3965513wmi.20.1696477370734; 
 Wed, 04 Oct 2023 20:42:50 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 10-20020a05600c228a00b004065d72ab19sm2831323wmf.0.2023.10.04.20.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:42:50 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:42:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL v2 07/53] hw/virtio/meson: Rename softmmu_virtio_ss[] ->
 system_virtio_ss[]
Message-ID: <f05356f84d2e3cb4f6437716cc9b5dc59baf769d.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
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



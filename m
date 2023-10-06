Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1797BB628
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:16:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoinU-0000AT-Si; Fri, 06 Oct 2023 07:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinF-0008Fe-Ii
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoin5-0000Jp-Qa
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09gHDcSD3eULArN3NZoI14fwVaKeRIz+n+d4TcIpJ3c=;
 b=SKJUT7Vzh4xUNk6LHiWVcWbWlCVqDc5HcEnBp70eqp1KrUv029bcYJJwj+KbuTdEEzgodV
 nyhNrtSF53iD0datAMhqpXHkzdKirvT6e5E/yv9lcuDf5AK5PeQmAWfDpMQj78/Pir8GMP
 dyyV3aLtYujRKbSednvmz6NyVoThzZc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-x47MB7EjMW2D1pskb4GiiQ-1; Fri, 06 Oct 2023 07:14:41 -0400
X-MC-Unique: x47MB7EjMW2D1pskb4GiiQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9b65d7079faso154473166b.1
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590879; x=1697195679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=09gHDcSD3eULArN3NZoI14fwVaKeRIz+n+d4TcIpJ3c=;
 b=JHEtxnkg4+jmcV+9IaCarSERZsSsWwf1xDkMrdW3N1atNUBYvuUY13xdzyzKAoPzg0
 EnTSG9yPhuZb95N3gWeQMyVMwk7dcd4qQB2E075F0pO+q1M97kBY+7uitB3ZuOHEjP46
 wzr5M+GFolfW8T3RBDR8q8M+VTRJuyizijpYqYc9CpVSUA29jhJQSawYkYBn/JICfIYV
 WNgm3NxXZY45YpOkqufYaXa4C8PcsY4+Jd83i7DSLXXa3nAQVK0Uyjlw6vYxVPuQPSYW
 qpokgPItWbDuPGdzt1mApMkqNAPzXPZ7r94vsqJ/iYtPOYRXsHy6wFK44e1i9UTpJMoU
 LJ7w==
X-Gm-Message-State: AOJu0YwRvMqV8B2MFaThf78ecAnDgLLYc+HiYX+DVTW2UnoRErgnYQ6T
 QgpgXkEgrH+sRhDRF5EZieWLow8G50LFpYX6i/FoHwMxnwM9NzMubbLTtzYHXcUETlFVRqV07Gf
 HERdxtkOieIB5j1gUldgGg8+V7oRkSqXQ0jtGfjk3o3AyQkY07prTLnMgNPhy0QcWKn1UAVxk/P
 k=
X-Received: by 2002:a17:906:7695:b0:9a9:f042:dec0 with SMTP id
 o21-20020a170906769500b009a9f042dec0mr7678385ejm.38.1696590879664; 
 Fri, 06 Oct 2023 04:14:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAmyvXar3xi+4IQR21rk/zDPhd+IrilKSf1QJQpqIaicRP5AUmlmuYSc9XkeO4LBu2MWWXew==
X-Received: by 2002:a17:906:7695:b0:9a9:f042:dec0 with SMTP id
 o21-20020a170906769500b009a9f042dec0mr7678371ejm.38.1696590879332; 
 Fri, 06 Oct 2023 04:14:39 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a17090637cc00b0099bc80d5575sm2640330ejc.200.2023.10.06.04.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/26] hw/virtio/meson: Rename softmmu_virtio_ss ->
 system_virtio_ss
Date: Fri,  6 Oct 2023 13:14:00 +0200
Message-ID: <20231006111412.13130-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

See commit de6cd7599b ("meson: Replace softmmu_ss -> system_ss")
for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004090629.37473-11-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/meson.build | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 13e7c6c272b..aad506fe521 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -1,18 +1,18 @@
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
@@ -21,7 +21,7 @@ if have_vhost
     specific_virtio_ss.add(files('vhost-vdpa.c', 'vhost-shadow-virtqueue.c'))
   endif
 else
-  softmmu_virtio_ss.add(files('vhost-stub.c'))
+  system_virtio_ss.add(files('vhost-stub.c'))
 endif
 
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
@@ -67,7 +67,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MD', if_true: files('virtio-md-pci.c'))
 
 specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
 
-system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: softmmu_virtio_ss)
+system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
 system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('vhost-stub.c'))
 system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('virtio-stub.c'))
 system_ss.add(when: 'CONFIG_ALL', if_true: files('vhost-stub.c'))
-- 
2.41.0



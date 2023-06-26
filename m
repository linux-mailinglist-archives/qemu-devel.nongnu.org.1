Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF0673DF68
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:39:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlNJ-00066D-Iy; Mon, 26 Jun 2023 08:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKr-0002CF-Of
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKo-0002zV-Se
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UxG3vkztDABFKvGFJuiCrBUuGxHDzYPIW6GxfE8K+J0=;
 b=TSddZMnLu+YXOfm0ut1JT1NL8EXkJ3etaMr3/9iUvTbueLxo0nfkbH1S8wd0+SYYo6BpCq
 PLPJZb9zlvk/mqfS3sFvG91K1fa/0Z7gJ9FUt5iOJ7MSlRRDlKYRiPNCvfqJh6vJE6bqyI
 vYT+t4lBKghNqBvGlxwbVWhXXlUlQWU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-6TMIWX7CNlqdtwGEamHPFw-1; Mon, 26 Jun 2023 08:28:44 -0400
X-MC-Unique: 6TMIWX7CNlqdtwGEamHPFw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f810b4903fso19812955e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782523; x=1690374523;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UxG3vkztDABFKvGFJuiCrBUuGxHDzYPIW6GxfE8K+J0=;
 b=TZmxz6xNrAaFgGURWi9tyu+uZUM0UtX2bhb1vZKrkaZYnqYgConPxz2EczsxfBu2+h
 zHV9DXOz8yQmpqAKMIKNGDSvFIMpEiDra6Q8rP64+lyBQ3CZb5318Xb6Q7Sa3gPf9EXj
 cQH8CK7av9JmB1cbVVu+Zdwx2uIYq5O7tqf5HHTSgHFitCrjXAs4qLXcF8hBZyFv9m3M
 G4vVDAUhcLRwzOPcNGhDLRIJEQZat5fygqTRujnn5VGziHHU20ulIeTLWQ0B8O5jogeL
 0IdhcIMWAnIU05aQdwMGbiZsHd5dLd5a9Jow+ZILP9Xo3ZQRKikTGb8Uz8j7uHfMFeTg
 XDow==
X-Gm-Message-State: AC+VfDzXtT1aKZWvh7W91sMkFmqlmD1kua96Yu6/Gd62csNd9Ic/DMoW
 vSx5ccQMfPqtcDVAJgtGQbMadmUuq4mLvjUUt0GrawHlyeQif+wpnODQSM1sbeORElj2Z/oUGKg
 hfnxPqHE1dQmx2cJjJOZvBLOausCQ4N2PYyD4r3qH5LQ1qCadlf9kKXtL/Ql37opq6KWH
X-Received: by 2002:a05:600c:21c5:b0:3fa:1af8:6ebf with SMTP id
 x5-20020a05600c21c500b003fa1af86ebfmr10093464wmj.0.1687782523429; 
 Mon, 26 Jun 2023 05:28:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4X77oYzVG3Xio+A82hu7u3UCWzmVI45CIOcaja/0YcnL/EPxZQyUDecni+59AIVZc3g3wAWg==
X-Received: by 2002:a05:600c:21c5:b0:3fa:1af8:6ebf with SMTP id
 x5-20020a05600c21c500b003fa1af86ebfmr10093447wmj.0.1687782523203; 
 Mon, 26 Jun 2023 05:28:43 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 a10-20020a1cf00a000000b003f8fb02c413sm7601442wmb.8.2023.06.26.05.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:28:42 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:28:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 17/53] hw/virtio: Introduce VHOST_VSOCK_COMMON symbol in Kconfig
Message-ID: <6df956299a751c1eff03a8ea791a0182a688a7cc.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Instead of adding 'vhost-vsock-common.c' twice (for VHOST_VSOCK
and VHOST_USER_VSOCK), have it depend on VHOST_VSOCK_COMMON,
selected by both symbols.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230524093744.88442-6-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/virtio/Kconfig     | 6 ++++++
 hw/virtio/meson.build | 5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 89e9e426d8..de7a35429a 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -56,14 +56,20 @@ config VIRTIO_MEM
     depends on VIRTIO_MEM_SUPPORTED
     select MEM_DEVICE
 
+config VHOST_VSOCK_COMMON
+    bool
+    depends on VIRTIO
+
 config VHOST_VSOCK
     bool
     default y
+    select VHOST_VSOCK_COMMON
     depends on VIRTIO && VHOST_KERNEL
 
 config VHOST_USER_VSOCK
     bool
     default y
+    select VHOST_VSOCK_COMMON
     depends on VIRTIO && VHOST_USER
 
 config VHOST_USER_I2C
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index e83c37fffd..a6ea5beae7 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -23,8 +23,9 @@ specific_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-bal
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c', 'vhost-vsock-common.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c', 'vhost-vsock-common.c'))
+specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK_COMMON', if_true: files('vhost-vsock-common.c'))
+specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
+specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
-- 
MST



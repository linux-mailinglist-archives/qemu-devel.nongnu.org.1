Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3092670F31B
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:38:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kwy-0006UV-AB; Wed, 24 May 2023 05:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kwv-0006BC-9l
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:38:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kws-0006rS-C7
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:38:28 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f607839b89so6273495e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684921104; x=1687513104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wU1WpV67IYL3BYTiEXvsZGAK6CKVN9GrbnEP+5A6mow=;
 b=K/8Moi5dWE1duPrGDhW6dB+k0c1N+pKp8ldP/tKrPO8rws9weB9QWcclS22pQ5ORuj
 t9a0u9MHQbhdRn4eAWNZVShyQS1nIKB0UBOYU+P7LNf/OEP1/YtXxnulhPn021W/Jg0L
 7CDD2LaRfUUv01XS5yIL3DJYOOKHR3C8cmg9dO8fN0cSv8KFBMYdYFjGKa9Qt8FrS+f6
 VXC9Y2pOh7GgDHFQglAj4zc7lWT8OY6zi4e2kgFiuNfwrBlY1/l0cD9yaxRPDg8iYjvp
 0/e1R6BLYHs2TG6v5Gle+8SNKBQaBvUjlLkQI4OFUjL85F9KoGEdhkoAj4pvhlPwAg6F
 3RDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684921104; x=1687513104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wU1WpV67IYL3BYTiEXvsZGAK6CKVN9GrbnEP+5A6mow=;
 b=bnHtdfdDtkrHIq87w7tvOZkpCwQUSD20AEiz5MUrBQehP0OnPEL640Jo14A1i77KGK
 Z1uoaaQa0eYXqjZC234KrTft/T6OHxkEALwaq1/hjik8Pqf9YxGHPMitjIOYuLS+uIBT
 sK/STSbWCFzT6MGU9AEec7pZCTEkTztqXsHXcPreQtRuLBoiZNuF5pF/PyrANY+6XVPC
 AbbR2KKxh+iYL5E0ptr7rrCEJSu2CZOSjHX+jS4g5WRZAqoLucwAY5ETeIruQDTzf2J6
 4m0QQzR/9aDKnsi+T4gUwWbJJ40aZXUgUcvswB8TXh7ZdN69ShpsxsezCRg0Pe16O5xm
 8wxw==
X-Gm-Message-State: AC+VfDzBwq3kjiyRlt0UnMWeKG/1NQ3LauaXlLoPavfwIv6GLZvDHaeE
 WkFyZwuabuwC40OdEmYtj1P1hXkG/zWgoy+QTaj6KQ==
X-Google-Smtp-Source: ACHHUZ5+zFKvgYUMUc3LbcHXjC8s8bMB5kDhPfmGe8HFUo3v7qhumskRGMZguvtWQoHmgtygLljRJg==
X-Received: by 2002:adf:d092:0:b0:307:c471:7b38 with SMTP id
 y18-20020adfd092000000b00307c4717b38mr11216415wrh.59.1684921104399; 
 Wed, 24 May 2023 02:38:24 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-246.dsl.sta.abo.bbox.fr. [176.184.31.246])
 by smtp.gmail.com with ESMTPSA id
 k16-20020a5d5190000000b003078c535277sm13766984wrv.91.2023.05.24.02.38.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 02:38:23 -0700 (PDT)
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
Subject: [PATCH v2 05/10] hw/virtio: Introduce VHOST_VSOCK_COMMON symbol in
 Kconfig
Date: Wed, 24 May 2023 11:37:39 +0200
Message-Id: <20230524093744.88442-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524093744.88442-1-philmd@linaro.org>
References: <20230524093744.88442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Instead of adding 'vhost-vsock-common.c' twice (for VHOST_VSOCK
and VHOST_USER_VSOCK), have it depend on VHOST_VSOCK_COMMON,
selected by both symbols.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
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
index bdec78bfc6..54c90c24fb 100644
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
2.38.1



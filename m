Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F8870F31E
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:39:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kx9-0007OC-V1; Wed, 24 May 2023 05:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kx8-0007KY-5y
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:38:42 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kx6-0006us-90
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:38:41 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f607059b4eso6495055e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684921118; x=1687513118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y71HOv/BFUZkHdZXVOBhlaxJVZQ7sC8HQC7IQ2KJf9Q=;
 b=YGZTM+c7sLE0JiKyq7AgHGt+phLWINb+zVpdHtMaN+WBJJmBi3qaj91c1HH/Qba+dz
 pftvqQTTP1321ruQch2JqfUkO0gnDHk/16Lhh4Ljo/ZveaHAqnl6bMfE04TOJZy13+8g
 cEy2pGTYCjcjJBnWudC6KlprwdBcZRGcO7qocJJWymAA751/o1lIrMC/8O7/jMu+vPQb
 9cGfkfJt5S0RtxSmyNCUWdw7aqbGchlsU7XnP47RkIJKq4p5EW7qtasPgAnl3E8cvkm4
 LiyeEfG0Xi0QrVw6MvZWTs8wajhJUkVTcHEk8C0tOSZEP2aNW9X341UijcY+xit+p00Z
 eIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684921118; x=1687513118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y71HOv/BFUZkHdZXVOBhlaxJVZQ7sC8HQC7IQ2KJf9Q=;
 b=Hbg/MHIi1YhMoJ99IqkfNmrazNpCWsLDWyzpisyQvGaXPamdAyM9l5f69GZ+3OH+C0
 JnBvaoGyJWEGH7wOd2IBsFiJLGOy+66q7MBU+BN6rLgR8Ed/8QOAz6ijplbA3JAxwkXG
 sz0gaKGKWxC/yRdgkXwVGO/9jHLAQF6qyotf0jJQhPTpQZzSBt0+CiAH9+lAEFfuO461
 +UoHn+cTOlkaaSveNtLPpzu+e0MSpQg3QuNYy8FoLYs8q0kZbRqhcIBjcTfc8yBUsHuk
 LOphLi53z8NBkTAxPkdwt3AKwgs0CGcB/S2lfnfWYCvD3tYkRSzkA5nDVXOvS3RMw+2c
 jwaQ==
X-Gm-Message-State: AC+VfDw75nfI26CYgW7lEna/FNT7bpFdvNRRF1yEjVFeyNDHBPVy4XEU
 Cs3aWtsxaxxnjiRnSeEyOim4zX1aYZlAOiLARfu4yw==
X-Google-Smtp-Source: ACHHUZ4InGUVxY496ApUzCVRzRcf31lN/0Po/KZlQp0oYEGy/KA/fSZME899G9nLPt1uw9slJjjGOQ==
X-Received: by 2002:a1c:7503:0:b0:3f4:fffc:cd74 with SMTP id
 o3-20020a1c7503000000b003f4fffccd74mr12493082wmc.16.1684921118195; 
 Wed, 24 May 2023 02:38:38 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-246.dsl.sta.abo.bbox.fr. [176.184.31.246])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a7bc38f000000b003f6028a4c85sm1699924wmj.16.2023.05.24.02.38.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 02:38:37 -0700 (PDT)
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
Subject: [PATCH v2 07/10] hw/virtio/vhost-vsock: Include missing
 'virtio/virtio-bus.h' header
Date: Wed, 24 May 2023 11:37:41 +0200
Message-Id: <20230524093744.88442-8-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524093744.88442-1-philmd@linaro.org>
References: <20230524093744.88442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Instead of having "virtio/virtio-bus.h" implicitly included,
explicitly include it, to avoid when rearranging headers:

  hw/virtio/vhost-vsock-common.c: In function ‘vhost_vsock_common_start’:
  hw/virtio/vhost-vsock-common.c:51:5: error: unknown type name ‘VirtioBusClass’; did you mean ‘VirtioDeviceClass’?
     51 |     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
        |     ^~~~~~~~~~~~~~
        |     VirtioDeviceClass
  hw/virtio/vhost-vsock-common.c:51:25: error: implicit declaration of function ‘VIRTIO_BUS_GET_CLASS’; did you mean ‘VIRTIO_DEVICE_CLASS’? [-Werror=implicit-function-declaration]
     51 |     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
        |                         ^~~~~~~~~~~~~~~~~~~~
        |                         VIRTIO_DEVICE_CLASS

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/virtio/vhost-vsock-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/vhost-vsock-common.c b/hw/virtio/vhost-vsock-common.c
index d2b5519d5a..e89af9b329 100644
--- a/hw/virtio/vhost-vsock-common.c
+++ b/hw/virtio/vhost-vsock-common.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "standard-headers/linux/virtio_vsock.h"
 #include "qapi/error.h"
+#include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 #include "qemu/error-report.h"
 #include "hw/qdev-properties.h"
-- 
2.38.1



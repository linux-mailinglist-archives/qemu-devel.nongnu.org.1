Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDA673DF6A
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:39:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlMQ-00055O-85; Mon, 26 Jun 2023 08:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKy-0002MU-Qa
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKw-000324-Ii
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m/fSQrh3AqOqxqH5X37BkjIgkbSIkWL7nr6LD5BoZqM=;
 b=SoaRlU2STDLk0aoQifscK3BuczGR9J6Hu4t5UkomySGpSb6My0T9xzmw9BnDO4JW8E8P2f
 v4wnxIFLlQXNMHPduqnjTYz04oE1ax0eKsBGcS4bkPygQ3yfW1EJj2SJxm6SK+VlztfyUH
 o/HEvEE5kMVPJGwzQ67G2L/dqnRWI+M=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-DD7622xVPZStV1k54H8f7w-1; Mon, 26 Jun 2023 08:28:51 -0400
X-MC-Unique: DD7622xVPZStV1k54H8f7w-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4fb7b4be07bso324198e87.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782529; x=1690374529;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m/fSQrh3AqOqxqH5X37BkjIgkbSIkWL7nr6LD5BoZqM=;
 b=ebujaBUp9ATbdglteifVtPotVNhFnmWW4ybOeI3wghx+iN1hnpFPHsUFNKppXQDA7T
 J2qR40r0Umk5hD9M0OzkqlEkmYLaRS/NuFKX1c7TdEVJPsyODHMckPs42k4AzJscBz2A
 Ymd9djcKN5PItDvnAHooOtbFJ6gq7dhizJcF2eIMzxlHwEVxFfF3yNVQB8MiM7TKhRKo
 I9aHejDcaDlGr7oHYstrkeVUhY8ulprdoI/sXuxWobZa6yQp8vy3ShTWlU0R/RxqXEaN
 QMpi9kZWJeQe7SK4T2LhwBfsXJ684SbKQEp3KOlBgTjhrJh3yZZpakd1SYcnaet+pN0U
 gadw==
X-Gm-Message-State: AC+VfDyCdtXvYcJVQNxYXTqNilbc6SKciiG9nay/Z3LC6dT6KAR7ZUPp
 nAn/W5I89VJDd38U+V54BoANss6OKmYyekNtcMfxUJBu9CIlqSqnb46nnZzmy4fiHiYFPSBdouR
 xyPFbfaPuO1jFbXMCrwJ+bAnZX+AhW5Ywh6BD9tPAh2mvhxdKgnPyTPqUu/gOhNZKNVkY
X-Received: by 2002:a19:e34a:0:b0:4f8:4263:42f with SMTP id
 c10-20020a19e34a000000b004f84263042fmr16129645lfk.17.1687782529105; 
 Mon, 26 Jun 2023 05:28:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6s+n685Bgv6neJStv7gUPMikrpj39BrByux7Ez36TeeziHONAx9BjzDIeyB+A2JO29TBpOhg==
X-Received: by 2002:a19:e34a:0:b0:4f8:4263:42f with SMTP id
 c10-20020a19e34a000000b004f84263042fmr16129634lfk.17.1687782528767; 
 Mon, 26 Jun 2023 05:28:48 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 r13-20020a05600c284d00b003f733c1129fsm7551958wmb.33.2023.06.26.05.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:28:48 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:28:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 19/53] hw/virtio/vhost-vsock: Include missing
 'virtio/virtio-bus.h' header
Message-ID: <a64da64ac671e81f3bae0fbf4e99fe7f8b65b668.1687782442.git.mst@redhat.com>
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
Message-Id: <20230524093744.88442-8-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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
MST



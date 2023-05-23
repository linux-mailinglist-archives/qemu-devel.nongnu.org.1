Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E21370E1E0
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:37:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1V0N-0001Rh-Ow; Tue, 23 May 2023 12:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V0G-0001LC-7B
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:36:52 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V0E-0001eA-Hc
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:36:51 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-307d20548adso4948353f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859809; x=1687451809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ARGSsskAzbNf6Eoe5vnNjy3BZ9ekI/e2OhJrhhOQCeI=;
 b=UhsLXZuE4j95CJXfokwF8F2rVR1tcR5g0HdMI34XZC56sgm4X2HyVdQAXKgNW6S11i
 pBk42U62Gu9lH1xaUGg9mwkYpfQ6xJ1/H23/HnmydvaLW0WrjjXxQUSp0AmlCNwj/lB3
 c4nmI1Q2722C6BJVhS3F9tPwjkotosbttkymZqVxzDA8hk6kQMA1kX+OYPvVZFq/V9lI
 oQkfqwmNAwvCEr6UNyY6CHFbVSJmwez3UfRB3uzRZXH3sz3FV9peqDS3kljp0ePOyz33
 zSPN0xT1t0xQU2jQCMCygvQh2tAQPSYKWRCNoR8hcetyCsZ5MKJOzyVCrIw7GeUyr1KM
 RVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859809; x=1687451809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ARGSsskAzbNf6Eoe5vnNjy3BZ9ekI/e2OhJrhhOQCeI=;
 b=T3d0Se2+r51NkvEsZ/ohI4guWZO04wG5Uxyn9FzTSgaoSpmMg8nGMqWh3jYDJlX9Nr
 5sv5zJ06ZM6GE3KXb2lUJ6HVepoaWMKhPd5Qh6n5XDLnGCb8CPjWUt9Fhp54OOW7yAIp
 8ZytzsQ/UKEkuweZEii9cv+N3cCpuAp01vjZwH/tqZI0T12HNAeBw1FMryoAtce2tfR1
 Gdi4j6YYTo8WiOAoPyCBxUpJv9Hiex9Ng+YUtbVMNGBUmLosknAwhBGEIR/By2LsTPPy
 OG/9ox9M+LqNh8O2YthSce+rTbvTpd2xrlb/yJfgs++rSPDgOgJnTSPcqTTzaEuF1seU
 +hvA==
X-Gm-Message-State: AC+VfDxi4zRzOXC6SSISkADFjrlo2mndJ3wdB2TieBHnsPOB/tDYLdpv
 F2w6EDAwEeb2tap7PClPcs6MGKGYd61NY1Vadtg=
X-Google-Smtp-Source: ACHHUZ7bbnTt2H+KRG3LoKBEgWpJilKlmBcPmz4ZLylX9vtH1St0BVJBii/KO3tNfMHY5lzjrz9b5w==
X-Received: by 2002:a5d:5392:0:b0:309:4ba8:86a0 with SMTP id
 d18-20020a5d5392000000b003094ba886a0mr10909440wrv.17.1684859809520; 
 Tue, 23 May 2023 09:36:49 -0700 (PDT)
Received: from localhost.localdomain
 (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr. [176.184.48.94])
 by smtp.gmail.com with ESMTPSA id
 i11-20020a05600c290b00b003f605814850sm6373445wmd.37.2023.05.23.09.36.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 May 2023 09:36:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PATCH 07/11] hw/virtio/vhost-vsock: Include missing
 'virtio/virtio-bus.h' header
Date: Tue, 23 May 2023 18:35:56 +0200
Message-Id: <20230523163600.83391-8-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230523163600.83391-1-philmd@linaro.org>
References: <20230523163600.83391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
explicit it, to avoid when rearranging headers:

  hw/virtio/vhost-vsock-common.c: In function ‘vhost_vsock_common_start’:
  hw/virtio/vhost-vsock-common.c:51:5: error: unknown type name ‘VirtioBusClass’; did you mean ‘VirtioDeviceClass’?
     51 |     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
        |     ^~~~~~~~~~~~~~
        |     VirtioDeviceClass
  hw/virtio/vhost-vsock-common.c:51:25: error: implicit declaration of function ‘VIRTIO_BUS_GET_CLASS’; did you mean ‘VIRTIO_DEVICE_CLASS’? [-Werror=implicit-function-declaration]
     51 |     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
        |                         ^~~~~~~~~~~~~~~~~~~~
        |                         VIRTIO_DEVICE_CLASS

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C875D70E1E8
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:37:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1V0V-000285-Mb; Tue, 23 May 2023 12:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V0O-0001um-D8
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:37:01 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V0L-0001lQ-HA
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:36:59 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f608ba2e06so677465e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859816; x=1687451816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=luIo+lkzsxjF6N0yYuJHc36ZlG6WILVPK31glw0xKRo=;
 b=tE2UUXBm33oIEe0XEpblnEM7JzqV9XCjQZzyhAePMlEpUCE8g0uZ4fX7XKqdfJjMeu
 ap8q0QFIm028KDEAiIJ0UuEochkCJEqulDwrgB0C3icbbcGFjDW3OU3mbc6dzrZF5skZ
 3SApBPNYaw74iz5ByolZFX2/7HnpvNBDv1O7Q4iTULtVNlrTRuIQuTOe+VDijtfOtlZQ
 SzQTjQC81vME0XSgkFBEVjjkjBef1OztSdfu56R7FQU8CcTN+RjiHxRQ4lPGYXh6lny0
 ANfd+uxmwohIsuePF8koaVsMIEgjYe9FymbzOaw7eZXAfAz5rIY40P1DXzLON3KLVt9o
 ufgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859816; x=1687451816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=luIo+lkzsxjF6N0yYuJHc36ZlG6WILVPK31glw0xKRo=;
 b=MwvtPwztUC4vqZ6/Gqif/bIDSJOfO9081Ae8s/exwRigiPblC2pWqoGQ1sEvcC3Ig5
 SHJmjIV8IPhtgKBIx1DArqpVm3RsprgBbn9R2HafzlgkpUfc+IvTxAZfRvkp1zZwVyhx
 WJho56pvaqFGCDeP/QVDQDSl78lpRIyNxK78yO7UXXFCVN4eSwwUuMkrkCQx3GnVOteY
 DtnndDk+LizA3BwfKTqyom5wrbWWrRSTHxOl/0bq6rwzxFbmxleJuShaGelOqj5zYUAP
 g0GN2Ou0venKyPGaO4pqhrWYvjYbQV75v3ZkB6c6HJmKXjEr4Vvt5XPnyAkol2jikkXk
 oEVQ==
X-Gm-Message-State: AC+VfDwXGTBcxwtKtye+HwZ9uC+UbnSOPBaBhA5WXg3H/+WFuqGlhw8j
 GJ8/0eMTS0VL1qbC9GaTFDeK7k+VAkCHehl9nTE=
X-Google-Smtp-Source: ACHHUZ6efSHHMIQJRhwCIzQ1BEMGTOBmqfAp9f2LqlPJrNl4G4ewqXa+YTqkBph4jK7O+AVvEuYe2Q==
X-Received: by 2002:a1c:6a04:0:b0:3f6:c8c:7048 with SMTP id
 f4-20020a1c6a04000000b003f60c8c7048mr2002074wmc.20.1684859816021; 
 Tue, 23 May 2023 09:36:56 -0700 (PDT)
Received: from localhost.localdomain
 (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr. [176.184.48.94])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a1c7714000000b003f606869603sm5993391wmi.6.2023.05.23.09.36.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 May 2023 09:36:55 -0700 (PDT)
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
Subject: [PATCH 08/11] hw/virtio/virtio-iommu: Use target-agnostic
 qemu_target_page_mask()
Date: Tue, 23 May 2023 18:35:57 +0200
Message-Id: <20230523163600.83391-9-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230523163600.83391-1-philmd@linaro.org>
References: <20230523163600.83391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

In order to have virtio-iommu.c become target-agnostic,
we need to avoid using TARGET_PAGE_MASK. Get it with the
qemu_target_page_mask() helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 1cd258135d..85905a9e3d 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/iov.h"
+#include "exec/target_page.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "sysemu/kvm.h"
@@ -1164,7 +1165,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
      * in vfio realize
      */
     s->config.bypass = s->boot_bypass;
-    s->config.page_size_mask = TARGET_PAGE_MASK;
+    s->config.page_size_mask = qemu_target_page_mask();
     s->config.input_range.end = UINT64_MAX;
     s->config.domain_range.end = UINT32_MAX;
     s->config.probe_size = VIOMMU_PROBE_SIZE;
-- 
2.38.1



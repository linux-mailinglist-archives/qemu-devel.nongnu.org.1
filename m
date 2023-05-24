Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF07570F322
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:39:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kxH-0007tO-GE; Wed, 24 May 2023 05:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kxF-0007oY-NK
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:38:49 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kxD-0006xf-AF
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:38:49 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-309550263e0so547523f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684921125; x=1687513125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rA2E0VH092ZQeXxfwZplt9KPxzZ4le7EuV+DMB+BMgk=;
 b=bzdCTHDsrFLbd4FeluP1rhAMBAe2glkBNYTtOouvC2Ix8rLijsTEWUSChBgsJTrl1a
 XBQDoXcB0BfwcN2hQaHEpjBuXmd/XlkIGbtoGjpn3/PIq5VV9jdSFD40Eex7fstf0KE1
 Cg2aOFbO4sN0WtF4Jol8j9HMPZmsyYuFLpn46+ILTpKvGS4ExuYQLykA4cqBGlvbz1IZ
 9Z7SAj3zV6ECrmcI+9ZVCa7WDjJYX2lJ2z2POjjbiZvhpJuGhQDBdvb9hrg7dgob2Yrs
 FahIT5loF6cdmkhEWHww8gdwLiA0why4oM6DEWd11pWfCLWlM1zfwsgwcmsOvn3qRUrl
 PUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684921125; x=1687513125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rA2E0VH092ZQeXxfwZplt9KPxzZ4le7EuV+DMB+BMgk=;
 b=A/+2svSm0LhVjzDyq7fbJ7rJHyCBtPLKGnrHQvAkBsPa74IWFjB9cdUq04wZlHDYT7
 H1TCFZk3U3BXYn+iIWF7vOM2pmcNT6QGnDGPcXzmtyL/7/azHzy++VnPYAon9+6VPXEm
 GBZTanaqa71Xbd5S3+XV84HuSDD/WZayC89zfgAcsFEuKuFtkAzm/jtjWCOxkIZxRJGs
 WFFY4/oaVPLnS+QyrOP1R96TOghCDFIqiJ2VE321pm8E5H3dfRWckKD2YIZ7xpvKR7Up
 PeDTV2F3TrCFioR5XXyMLuCChjctHukdfagnP+Aun0Q53QhH+AzQ+JFgNfFwjWdUuSKS
 tCZw==
X-Gm-Message-State: AC+VfDyKWLDaDSQqTYQkfpNozKNslyShO5Wt+mht64dGJxvEGO04NqDa
 YRG76eV6bcrPw+xbxf8M7Xlb0mcnKt+5TvxXl5PjrQ==
X-Google-Smtp-Source: ACHHUZ6TYI0DOmuhsVAEhHLB5hzw3penXJFGd/CLW6IZ6v5pLoUxmF8Sxkq1uYjmWqDHz3nXh43zhw==
X-Received: by 2002:adf:ee44:0:b0:309:421a:192c with SMTP id
 w4-20020adfee44000000b00309421a192cmr11263859wro.7.1684921125488; 
 Wed, 24 May 2023 02:38:45 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-246.dsl.sta.abo.bbox.fr. [176.184.31.246])
 by smtp.gmail.com with ESMTPSA id
 n1-20020a5d4001000000b003062ad45243sm13930442wrp.14.2023.05.24.02.38.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 02:38:44 -0700 (PDT)
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
Subject: [PATCH v2 08/10] hw/virtio/virtio-iommu: Use target-agnostic
 qemu_target_page_mask()
Date: Wed, 24 May 2023 11:37:42 +0200
Message-Id: <20230524093744.88442-9-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524093744.88442-1-philmd@linaro.org>
References: <20230524093744.88442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
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



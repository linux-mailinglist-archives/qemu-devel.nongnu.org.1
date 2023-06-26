Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C89473E22F
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:32:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlMU-0005S8-1U; Mon, 26 Jun 2023 08:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlL0-0002NU-LZ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKx-00032E-9a
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p3R7bbX1OVcHwyYU8dbH6MaxjId8JlY7Jg13CA3d3Lg=;
 b=A+afMQ0UqVRO/Io7gVdV+QfcOxb1Jv7mNq1EiSh+lTdQ1WQdkdqcjzeC1/02oFgiwvIlPm
 Ly8ZphUx+GIe+JXt8WaGwUpwGn8f0lRb7ds3H9khSlCEeNiqAfJ0cFn4NZuuWr2ywyCVG/
 FfgbpDiYsgorTUwBWgYQkE/2HS7to44=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-e7PrP15wP5qFLmZW_dgkbw-1; Mon, 26 Jun 2023 08:28:53 -0400
X-MC-Unique: e7PrP15wP5qFLmZW_dgkbw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-313f371b0d9so385488f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782532; x=1690374532;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p3R7bbX1OVcHwyYU8dbH6MaxjId8JlY7Jg13CA3d3Lg=;
 b=kXw4CCwjznRnHLJbakA+sB9CkxIne1OPh1ka1AWxv5VF96zCwiMHIZNjMBPuc0JyRc
 TGuYmpL1/Fbe0SX3N6RSoEmdBP61BP8z1aBpGpOJPfsXM7dPGhU+vQdA86lD31Qj6h4t
 /5MjSa4uVDBc+/fSyBlYvid3AH6wEn0q2mupPgwZJj8nojJytDQWNrfrssN2QJwDQqkA
 wXgLv6so8pXbqlYjTRiLMNfEt+vn8twQr5ae+32TAo38mWOXugvV39ntQzNA+8I4Q6wJ
 IvowcsHAxVWriemk9bKqvDBH4ejMCB0bd+nl/0ytrR9qDX8ICYosQVWoHfZIB8BZEfs1
 /sew==
X-Gm-Message-State: AC+VfDxKFhUrTBprzKCsJB+dEfPOP0dFOCb0o0tZciUSFy+vxIb4Zs9/
 qwxJ92m2GwoaZjKJi47PbjymMHFupi8OSxBIMQoEkQsEfPpsfskwR9Y92WmCEVywb5NFnUhwIVa
 zBcCJSDpxL7VQnmMKBAS3OoCL7Gw54Lpatgw5Oi+snZsxHI+FW+B+gOW+rQiwYX4MKGo8
X-Received: by 2002:adf:f80e:0:b0:313:f3c5:dac9 with SMTP id
 s14-20020adff80e000000b00313f3c5dac9mr1227676wrp.41.1687782531995; 
 Mon, 26 Jun 2023 05:28:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7CC101Wem0BBXxxb3gOEYR8TXBR01iYeCC0mbMy2bH5DeeRiw4iNu8eBcJV+ZtyIw3X7Szfg==
X-Received: by 2002:adf:f80e:0:b0:313:f3c5:dac9 with SMTP id
 s14-20020adff80e000000b00313f3c5dac9mr1227660wrp.41.1687782531723; 
 Mon, 26 Jun 2023 05:28:51 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 v11-20020a5d610b000000b00313e2abfb8dsm6719036wrt.92.2023.06.26.05.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:28:51 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:28:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 20/53] hw/virtio/virtio-iommu: Use target-agnostic
 qemu_target_page_mask()
Message-ID: <e414ed2c47da70381a66846cf9353f7612daa4b8.1687782442.git.mst@redhat.com>
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

In order to have virtio-iommu.c become target-agnostic,
we need to avoid using TARGET_PAGE_MASK. Get it with the
qemu_target_page_mask() helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20230524093744.88442-9-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
MST



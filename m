Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AC97E38BE
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:18:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J4Y-0002X0-Rk; Tue, 07 Nov 2023 05:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J4W-0002Ix-9m
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:12:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J4U-0002kL-Je
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CEno9zW8w+VAHCwT91u0hyw6S/t7zwBF7SdlgJpC+g4=;
 b=LRwEUdMkIEkaDsDbe9hErZIBlFWOkBm/1uVGmdvgMz6iUJVvKL2XQyFvSRyt824z3jWdxs
 ffQoS4UJ5GlGSmPZAIev/p1+7KXxFYh2MANkazNCtyd1zxlb4L2b12ZHYK5lfwNdg8Dda7
 w7/H/FO+GtKAL9w5YBJjGHi3q1Mz8ts=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-GOfWu8AEM0uo1rgWx_htXA-1; Tue, 07 Nov 2023 05:12:31 -0500
X-MC-Unique: GOfWu8AEM0uo1rgWx_htXA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4084001846eso36203325e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351950; x=1699956750;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CEno9zW8w+VAHCwT91u0hyw6S/t7zwBF7SdlgJpC+g4=;
 b=V9tirodCeR0muGMoFHBcx8ptuAtye4B0zWARvIdYe8xIZAjSON4ea9zUyDRx4Q2Wfz
 kXS2juKolno5NMkYqJKLr75632FtpLMGuflQOlN+uUjoJ94Cqje5NutbnPmlYi8MQVdt
 hOx3bwdxjOWtPIfF77m204fttT+tTK5eCr7REHlhlx1rCVl4UNYj4Jg/4oH9GnPXBGl7
 l1N078eSx3gH6OBDCbP6t0h0NjmWdfaLrkOUi8n/kh8M/7VHxoWruFq6MQXpfTc4hu6q
 BvxjefVKwvX2cIxO0PIxZxo4MdmKgHuGmREcWwZOtKdFuHo0qCk98sjplCwzmvT/E7sU
 k1QA==
X-Gm-Message-State: AOJu0Yy8+nsoP7TB2aHvFlEQFsEll94VYDJo/ca6GzanaEAsBd6MaS7C
 fiEnZOaGBCsbC+wvmriEqO1+JlRL+GCspaocn5OeqX21N5Hr37NE3pz5YuCDwooCw9P8nkS6OYW
 0GAklWEcp0/qLc92K+s/iJ8LQllDYwDhnbEAhV8KN7NkZMSbW3OXqO0ZebUS0Gr4fyaPB
X-Received: by 2002:adf:e7d0:0:b0:32d:a0a9:4785 with SMTP id
 e16-20020adfe7d0000000b0032da0a94785mr24297173wrn.7.1699351950035; 
 Tue, 07 Nov 2023 02:12:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS5QI35Q9dbS6WrsmQ+HIyXxbQzJ7uuXg3FpPOtwcx/Wy1xqi2hVra/07sJQBVtEl/1GRr3A==
X-Received: by 2002:adf:e7d0:0:b0:32d:a0a9:4785 with SMTP id
 e16-20020adfe7d0000000b0032da0a94785mr24297159wrn.7.1699351949763; 
 Tue, 07 Nov 2023 02:12:29 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 t8-20020a0560001a4800b0032d8034724esm1899356wry.94.2023.11.07.02.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:12:29 -0800 (PST)
Date: Tue, 7 Nov 2023 05:12:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fan Ni <fan.ni@samsung.com>
Subject: [PULL 40/63] hw/cxl: Use a switch to explicitly check size in
 caps_reg_read()
Message-ID: <629df5cc23cc9aec5d115cc9be3456458e2b44fa.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Bring this read function inline with the others that do
check for unexpected size values.

Also reduces line lengths to sub 80 chars.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Message-Id: <20231023140210.3089-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-device-utils.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index bd68328032..eb7195272e 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -32,10 +32,13 @@ static uint64_t caps_reg_read(void *opaque, hwaddr offset, unsigned size)
 {
     CXLDeviceState *cxl_dstate = opaque;
 
-    if (size == 4) {
-        return cxl_dstate->caps_reg_state32[offset / sizeof(*cxl_dstate->caps_reg_state32)];
-    } else {
-        return cxl_dstate->caps_reg_state64[offset / sizeof(*cxl_dstate->caps_reg_state64)];
+    switch (size) {
+    case 4:
+        return cxl_dstate->caps_reg_state32[offset / size];
+    case 8:
+        return cxl_dstate->caps_reg_state64[offset / size];
+    default:
+        g_assert_not_reached();
     }
 }
 
-- 
MST



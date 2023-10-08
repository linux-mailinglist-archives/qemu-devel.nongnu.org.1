Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C447E7BCC67
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 07:31:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpMMs-0004ED-Qk; Sun, 08 Oct 2023 01:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpMMY-00048I-IX
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:30:01 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpMMS-00077o-2w
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:29:55 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1dcf357deedso2285448fac.0
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 22:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696742990; x=1697347790;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZJMBYYnCWEwvRg2gfLk3cTIM7Y+WdKEHdFL7B88ioM=;
 b=zcFZei04EXtfNX/Mm0SLChHQoTTpkpTGe3wa30tY6TdcPBBeNYFzLrD8FtM1cPyNIa
 0cMBu+GATQJeFQICaaUWB9PaZ6RwozPE1YKns3xr7j60j9GE0J/rddwJitxYXZGpu8j4
 hkaBbsFREPrpyD5soYhDsBij4IAr3TmabXaQJXFo4szV4VHsnkHtikjo3YwdHXGR5nVa
 tgvszcFVENhUhbV5oW3FrepCBegZQVPI8DCSjajYiSnITzA6iq/NyPIn1dl5L+6OZpEn
 XLP/K++/kLGa+vzH/rBsCm0J7eYvp+kYpbZ8AsQzQ8LPz/+aj07p9h/2ag9291xnFjVU
 4pmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696742990; x=1697347790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CZJMBYYnCWEwvRg2gfLk3cTIM7Y+WdKEHdFL7B88ioM=;
 b=hAGxuQlZpCbG5ny/lyMzfPoiZ8qh5de4HmMQbCCwOFm2itOA1wMCNUtEBehBNB+saU
 QBH+dfiixJTWr8JbYmxy8ddaRbOjcAhGLhrDvIenb2hrFILEXCAk7FH5/feo9lZcNkUY
 KeT3lSsOuEAvVvrXSb5RfpOt0Fd+/3+xcPVudrX+eorRmtsRy9XRidyzDALwtvhkwP19
 2PwW2+4SRnJOkfTKHVTpPna+qRTNB4X1iNLXEfUfGabQSOMVwBt0Idog/GjDdxyVdQUb
 ki+gGuS1CxJuilpzeUfuqanNtGfbeJYWYpqrBlP1QW06N1eg+wlhRKaTrPihR9MF8USy
 vN4A==
X-Gm-Message-State: AOJu0YwhYwWKJuzROv5WuTol7wRJWgHk3Q8IIE0MrwpikbqEpo+/XY2b
 Nb1iXoXAzXIVLllzbrYfKIjMGsoqtkVYxLW/FPxf9A==
X-Google-Smtp-Source: AGHT+IHC1ftcxJO1ZVUEbpvBRHQLq0YwGEq7dFJefUBY6BlbiHYGrFVcCB24zQJZBgYj6VE8cOadJw==
X-Received: by 2002:a05:6870:6709:b0:1e5:525a:88a1 with SMTP id
 gb9-20020a056870670900b001e5525a88a1mr10964768oab.56.1696742990301; 
 Sat, 07 Oct 2023 22:29:50 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 iw7-20020a170903044700b001c5f62a639asm6762241plb.196.2023.10.07.22.29.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Oct 2023 22:29:49 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 6/6] virtio-net: Do not clear VIRTIO_NET_F_RSS
Date: Sun,  8 Oct 2023 14:29:15 +0900
Message-ID: <20231008052917.145245-7-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231008052917.145245-1-akihiko.odaki@daynix.com>
References: <20231008052917.145245-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::34;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x34.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Even if eBPF is not available, virtio-net can perform RSS on the
user-space if vhost is disabled although such a configuration results in
a warning. If vhost is enabled, the configuration will be rejected when
realizing the device. Therefore, VIRTIO_NET_F_RSS should not be cleared
even if eBPF is not loaded.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 05f9abdbcd..3bb4bf136d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -775,9 +775,6 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         return features;
     }
 
-    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
-    }
     features = vhost_net_get_features(get_vhost_net(nc->peer), features);
     vdev->backend_features = features;
 
-- 
2.42.0



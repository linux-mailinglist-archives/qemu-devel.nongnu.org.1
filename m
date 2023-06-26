Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE72A73E143
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:57:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlOl-0007lx-7V; Mon, 26 Jun 2023 08:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlMC-0004aO-Cg
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlMA-0003RF-CL
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fYcNucAmy67ddGjZ1HVGjT8M/yKQGxtNy1Ul1xPHkms=;
 b=VdhuaCiX8Ft/xaRuOJlkM715cihiSaRdrO59rufPiuhTSSws32MhN3Xu2wdhZ0H8dHMNSK
 QMjXMYWP2SXWCs1FZ0kOELBbsNrZ79o3xiSJzNFvYKcDxZBw+gEOffBnOnsTzZjM9Msus3
 oYbiXH7i7W+uuWmuWG9G3HBkBKe6Ue4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-lMloNVK8OCWD6VYTjjN7Gg-1; Mon, 26 Jun 2023 08:30:04 -0400
X-MC-Unique: lMloNVK8OCWD6VYTjjN7Gg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-313e557a824so653867f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782602; x=1690374602;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fYcNucAmy67ddGjZ1HVGjT8M/yKQGxtNy1Ul1xPHkms=;
 b=LkWqMSpxwrrdcYI4yllCEosYAnzDUd5751RSI3Y090AweaXIBP7qa1cwzyGrE4MXMz
 6Zcky/18/xpHHa4sfp8GfzxRQVS232fU2DdP0E7gA0MxTjAFDiQGHqXjJzHkoBeEQ9gH
 RYY5VbwnLKPnWjZTZuV6zmlCdOBYQsNcorMm+GUvHw5WsXP3F9ktvno9f5KousA3E7PG
 v5KIVY/KBL0l5gEBp26kpkIaNPYD+DvO0gbEjjTC7B8brDp0H9GVe8qG+7AOHUZ4k8yc
 I2qJZqNb/0L41uKVFkrdEPH4lvJTw+KH8McYmIfBxJQsyiW0u83PoFwM2OHCTDGVEPsS
 wZ0Q==
X-Gm-Message-State: AC+VfDwkNaKCGRiPaa8jlGYIDUOzvEr1G6PS9hvzg+CXSvvgTW5+bRUm
 1qg0RJzx81lfdMRrTQPF8TRu0A0906CuFdvKpGbMnxRds2ijPi4vaIxvrBKp5ITZsRdGQUpjC6l
 fCPdE6yVo/OuXQAwzn08bB+aVkcd4+bIe4vWKwTlg1ATGBWpNHXQk2BeOtBxqX6qr+FUh
X-Received: by 2002:adf:facc:0:b0:313:f4be:82c0 with SMTP id
 a12-20020adffacc000000b00313f4be82c0mr1037629wrs.34.1687782602711; 
 Mon, 26 Jun 2023 05:30:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ERcErLVwS2ect6rJmCxtK4hiEIadh/nyqiL6Stztc8WyEiXYOONBaEpWmC/ZnXlCpYr4ctw==
X-Received: by 2002:adf:facc:0:b0:313:f4be:82c0 with SMTP id
 a12-20020adffacc000000b00313f4be82c0mr1037616wrs.34.1687782602457; 
 Mon, 26 Jun 2023 05:30:02 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 r13-20020adfe68d000000b0030fb4b55c13sm7242434wrm.96.2023.06.26.05.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:30:02 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:30:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL 44/53] vdpa: mask _F_CTRL_GUEST_OFFLOADS for vhost vdpa devices
Message-ID: <38bcfb9398753cfbff6baa170c0aaeee2525f90c.1687782442.git.mst@redhat.com>
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

From: Eugenio Pérez <eperezma@redhat.com>

QEMU does not emulate it so it must be disabled as long as the backend
does not support it.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20230602173328.1917385-1-eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 49221937a1..75352efa39 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -58,6 +58,7 @@ const int vdpa_feature_bits[] = {
     VIRTIO_F_VERSION_1,
     VIRTIO_NET_F_CSUM,
     VIRTIO_NET_F_GUEST_CSUM,
+    VIRTIO_NET_F_CTRL_GUEST_OFFLOADS,
     VIRTIO_NET_F_GSO,
     VIRTIO_NET_F_GUEST_TSO4,
     VIRTIO_NET_F_GUEST_TSO6,
-- 
MST



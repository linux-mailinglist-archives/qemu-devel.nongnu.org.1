Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB7F7B9A44
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:43:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFGc-0001Vy-9f; Wed, 04 Oct 2023 23:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFGb-0001Va-8Z
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:43:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFGZ-0008AX-Kr
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lc/nKWVTsa5uQri9/4hS3uQQgaFw+KjqHoK0q8BNN2c=;
 b=aHlD1I12R6sP91Zb5O9bFQ5pDGxT4SBTq3KGi/xBRm0Scif+o5+LdzmYIb+ThGxbzBG/nn
 EdcNt933LIzfnhhUs7eX0eIkEd1mEnd7KmPDzs06y5HN/2erFiW81NgPYQDAqvBKnd3GO5
 +LXsWl8GHB/ndzLSVZvr2NKuDDwRJsI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-RGtS5GBHPRe7MiLcJgOMpA-1; Wed, 04 Oct 2023 23:43:09 -0400
X-MC-Unique: RGtS5GBHPRe7MiLcJgOMpA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40554735995so3752295e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477388; x=1697082188;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lc/nKWVTsa5uQri9/4hS3uQQgaFw+KjqHoK0q8BNN2c=;
 b=KZcBk4za82RJAfcmEJ91H0UupOhZG9a9q7nCJF9CJQlF+GNHEj4o0hKA3EXFppXlLu
 MZbBWTd3ktl58dS0E9VhD3Q+2uuIhyLNSGDfW+jIWAu99pabs5NO96qNAY+ci2TkodMS
 udOfNQdHtj4wD8P737ge9TKmav8nvPx61Zz3QJrWoorBG6Zct2PH+3+XO8KLzb0k6UWw
 2HmKYCz3NR4IGIQ5rqVXMaHT6Af4Ajxpob/C2DYI1Do6Pk0de/tZMh41hAqHicwBia0V
 9vehUzKX5mPGDE619870FnaHLg67mKzVnNebTJ7SapYssMFWuj8tC+DcY5GUcev6CCwI
 qmcg==
X-Gm-Message-State: AOJu0YwK96t7mqaK55Nkh8MhlwqtUBQpAREmUwt3KwK/0ZMdq5lz0ISk
 uHDbs2tEgO5bjRpVPHow9L02qxpYli1b4SzxfYRx6VYbR0gpK/FdPybw6jpnaoNiS1qDuO6ZAtC
 Mo0SQG8k6a3ECSk9SpuAbJNtUySw729aj1daTTPM5jEAq0b/GS4l70lydQiYsnYaoWyPO
X-Received: by 2002:a05:600c:2116:b0:405:4743:de12 with SMTP id
 u22-20020a05600c211600b004054743de12mr3770332wml.21.1696477387791; 
 Wed, 04 Oct 2023 20:43:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0bdZRJGUwQjd879tDSCorUVGoJj6NbB+CMWtUFXxYXZgT/mQu8lVQAbMF6C/Embl3xCtLtw==
X-Received: by 2002:a05:600c:2116:b0:405:4743:de12 with SMTP id
 u22-20020a05600c211600b004054743de12mr3770314wml.21.1696477387484; 
 Wed, 04 Oct 2023 20:43:07 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 y4-20020adff144000000b0032769103ae9sm622606wro.69.2023.10.04.20.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:43:06 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:43:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL v2 11/53] virtio-net: Expose MAX_VLAN
Message-ID: <e19751a32f140a232fafb037e703abb961a94abb.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hawkins Jiawei <yin31149@gmail.com>

vhost-vdpa shadowed CVQ needs to know the maximum number of
vlans supported by the virtio-net device, so QEMU can restore
the VLAN state in a migration.

Co-developed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <ca03403319c6405ea7c400836a572255bbc9ceba.1690106284.git.yin31149@gmail.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-net.h | 6 ++++++
 hw/net/virtio-net.c            | 2 --
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index e07a723027..55977f01f0 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -38,6 +38,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(VirtIONet, VIRTIO_NET)
 /* Maximum VIRTIO_NET_CTRL_MAC_TABLE_SET unicast + multicast entries. */
 #define MAC_TABLE_ENTRIES    64
 
+/*
+ * The maximum number of VLANs in the VLAN filter table
+ * added by VIRTIO_NET_CTRL_VLAN_ADD
+ */
+#define MAX_VLAN    (1 << 12)   /* Per 802.1Q definition */
+
 typedef struct virtio_net_conf
 {
     uint32_t txtimer;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 1c31374334..29e33ea5ed 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -49,8 +49,6 @@
 
 #define VIRTIO_NET_VM_VERSION    11
 
-#define MAX_VLAN    (1 << 12)   /* Per 802.1Q definition */
-
 /* previously fixed value */
 #define VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE 256
 #define VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE 256
-- 
MST



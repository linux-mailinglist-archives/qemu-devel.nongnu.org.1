Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAD67B7A6A
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:44:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxUG-0002zj-PV; Wed, 04 Oct 2023 04:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxU0-0002rC-9p
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:43:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxTy-0000zH-N5
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lc/nKWVTsa5uQri9/4hS3uQQgaFw+KjqHoK0q8BNN2c=;
 b=JSuSsnCakjvMwMVq5a19n/aDUcDOHc+ej2EZ+IuO8LngrjWaaRW7iIZrmJnCajINZCaMF9
 nQGAu751aDwryAYRRRr3NIvtYlYO9bpD3EqQs3eqC81ovwmhnWuBbemLaN4E+eaC0/Pbtq
 U+gzsstvvRJkJ5JoL/cWVnh+FolNlEI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-0ypvfVBINSadPLR5STvn9Q-1; Wed, 04 Oct 2023 04:43:48 -0400
X-MC-Unique: 0ypvfVBINSadPLR5STvn9Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32006e08483so1343888f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409027; x=1697013827;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lc/nKWVTsa5uQri9/4hS3uQQgaFw+KjqHoK0q8BNN2c=;
 b=V2vJIBezxskRGfu9Na/bpW2FZDlcPOs/Z2DDnYxVKs8Gcancj3oHxBfgV8JE0L20zA
 oioQPAaISZwYTJ+ovwmjiYZT5Y1MeQ6YgRUZ+myfwkPbDh9dNxnyevx0+2jSHVlyypsQ
 8w2uGNyDEJJhTSXo15uqnxWSHUxSeVoTWiNgBC828UL+52EUVIYFmWDtbWozMbBvJKBm
 YpUZUXRo1sbNlznWCbOTt78lNbNiywsnWcHXY6FWzTnEvfgfBr8d2+TeF4sJ2wo4fppu
 UINaSkony6ca3Z8Zb0HxQrKe07s2j6DY6+ceo2VwrIbYUVpvoa1nvyBDCMsN4tl5q8U0
 l8Qw==
X-Gm-Message-State: AOJu0YxM2vQrkXNj09zUjpGynAd3Iysu8jAEhzPs2LEtF9WrMkNmVV6I
 HKJ6HEeh8teOE7Cf2jNN1KVA6BmlLa/G+YUzv2udHfncMpD+3jWcJpRlqkqM/L3oWqMTkeUdUoY
 coHI2tfCPEHDLsQ1Oi66nlm548ksDl3wFOuYrqzt0GXxKAsXpFOydZ4vjBpbSNJ19m7N0
X-Received: by 2002:adf:de11:0:b0:317:573c:1314 with SMTP id
 b17-20020adfde11000000b00317573c1314mr1321409wrm.58.1696409026999; 
 Wed, 04 Oct 2023 01:43:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMLlG+6cNVCAxEQIH+/zlmgRC6LRnqRj0jUwuKXfzz/Lt7Uvmy0peVVtyNLYUS+jmtEB8xmg==
X-Received: by 2002:adf:de11:0:b0:317:573c:1314 with SMTP id
 b17-20020adfde11000000b00317573c1314mr1321387wrm.58.1696409026583; 
 Wed, 04 Oct 2023 01:43:46 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 m4-20020adffa04000000b0031980783d78sm3452302wrr.54.2023.10.04.01.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:43:46 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:43:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 11/63] virtio-net: Expose MAX_VLAN
Message-ID: <89985bef9aed3d4c21ed4be725011413fef7717a.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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



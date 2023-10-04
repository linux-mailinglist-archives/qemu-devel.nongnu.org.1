Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C1D7B7A6E
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:44:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxUI-0003Kz-5l; Wed, 04 Oct 2023 04:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxU2-0002s3-Um
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:43:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxU0-00011S-He
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xmwyCqt8icMRW9/CJm9tRrO8FYpjZBridEVVOxYrjKY=;
 b=AgXEOZpTl+ajJYwJ7vM8xZqOgmnjDt0tUYM9nSzvl86CLUB81MzrKkbr4MWkZ1ilgJ9Hgr
 uhDIuz+1ajNch3D+OBxQv1cU00VauplfRKr0i8Oyachii8xkXwZWQc3psNO09Ic87vpPOi
 qu6apWnszsiDUP5bOdDg5ByybrA72ng=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-LpuEQGroOhy9asC7PPX1Bw-1; Wed, 04 Oct 2023 04:43:45 -0400
X-MC-Unique: LpuEQGroOhy9asC7PPX1Bw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40554735995so13644765e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409024; x=1697013824;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xmwyCqt8icMRW9/CJm9tRrO8FYpjZBridEVVOxYrjKY=;
 b=iXjVCmiWAruvxzVZx+n6Yl4CT9R0iybnzrHwS/3FISqy1KuyaCj7X78xrPl/9Bi23j
 ctNBvyQjXqVG65ipYP0MPaDKwsy/YYDqMlsT74XbS3WkYtJllUFQMf9Yd2PtMu245VUo
 JdRQYyoXPsb5afwF2391iSzoioRXabhLjsCZvzfI7a2p/CgFC9CRF05JaWMrv6ICYc1T
 SlkxDA1Ixfa6Um1EaT0k9azuRhEpb5Q65XeD4WRMh8OB1vAk33IqmcW+GAUvBJESYg6n
 gsmj2HGVdZCSLPPfJPElA0YA2aw+jhWTzzWdZ9dvKTvILU38wt/bwN4KfRoSQSGbzrEi
 fyvw==
X-Gm-Message-State: AOJu0Yzcp0SaDhp2FMTA9kxcZ0OXgUwt/BPjT2v0sW1C6TjK6Zn2AOb7
 57aK7mMOxNmUEpoYQHzqtr1rxIcbCO20C2CFn6GGlZf1eQKcGJk+m7m6QjWGzU0ClJ/8zGiEkUY
 3BwrSwQ2thb1xNWoTaPMzPvGuR5gzEmp1HTk0YGC5jOiGmk/nAKZwCnx5NpXT3mWRogb5
X-Received: by 2002:a05:600c:2287:b0:400:57d1:4911 with SMTP id
 7-20020a05600c228700b0040057d14911mr1622133wmf.16.1696409023934; 
 Wed, 04 Oct 2023 01:43:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFxjGPOlbYPK722wrKsqHUhq1fcSkvjCI1d33IJa0g3MdSCSbfNFNGO+aSyVOZvkHB7K6+aA==
X-Received: by 2002:a05:600c:2287:b0:400:57d1:4911 with SMTP id
 7-20020a05600c228700b0040057d14911mr1622121wmf.16.1696409023633; 
 Wed, 04 Oct 2023 01:43:43 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 b7-20020a5d5507000000b003247f732c11sm3458772wrv.76.2023.10.04.01.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:43:43 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:43:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 10/63] virtio-net: do not reset vlan filtering at set_features
Message-ID: <5f614ab599f29d351156f7a654a27ec0f717e092.1696408966.git.mst@redhat.com>
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

This function is called after virtio_load, so all vlan configuration is
lost in migration case.

Just allow all the vlan-tagged packets if vlan is not configured, and
trust device reset to clear all filtered vlans.

Fixes: 0b1eaa8803 ("virtio-net: Do not filter VLANs without F_CTRL_VLAN")
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Hawkins Jiawei <yin31149@gmail.com>
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <95af0d013281282f48ad3f47f6ad1ac4ca9e52eb.1690106284.git.yin31149@gmail.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 5a0201c423..1c31374334 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1029,9 +1029,7 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
         vhost_net_save_acked_features(nc->peer);
     }
 
-    if (virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
-        memset(n->vlans, 0, MAX_VLAN >> 3);
-    } else {
+    if (!virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
         memset(n->vlans, 0xff, MAX_VLAN >> 3);
     }
 
-- 
MST



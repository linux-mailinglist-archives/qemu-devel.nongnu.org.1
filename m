Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 206F47B9A79
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:49:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFGr-0001gk-Dq; Wed, 04 Oct 2023 23:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFGp-0001fg-7K
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:43:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFGf-0008DV-JK
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xmwyCqt8icMRW9/CJm9tRrO8FYpjZBridEVVOxYrjKY=;
 b=LkX/X7wMOHi3RpdOyFh2B7mG88C/XEszfQXLXXBU0/zGVJU773dLxkqHFePf/0KG4YAzqB
 6aIJAzllXLco/cbSFVuHkJaPv2h6V1DMI0WJptWWHCAcuKcpcemlQr/7g6pLKSbmczDTAG
 GlFvpQ1Rp47hXxekpXfsj2sJaFnyF7U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-l-A_UL7gNHavtFSqa2CFpg-1; Wed, 04 Oct 2023 23:43:05 -0400
X-MC-Unique: l-A_UL7gNHavtFSqa2CFpg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3231f43fc5eso384951f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477384; x=1697082184;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xmwyCqt8icMRW9/CJm9tRrO8FYpjZBridEVVOxYrjKY=;
 b=PaXysRosxt7V+vdFgVI1vneyWkHruvWw7QWjJnNp/yIEz+ftdgTUJoM0tCKHBOpKCO
 bH8xQbH6zhf45NTnSOkSX/FPZvVSV4bC4Emn6b3utnPOILwZ3PoSrPCcQc+k2QZQAaNF
 4kUcIqtwf33pDYzYH+YtH4xNIBs1SALHK1Rv1oVCABWE0mZC7TzBHgZ6MVy550+Z3U2b
 r2zGHjREkdF3JUeOQWuVXyPW9OaU8z5Dz9nOLX9hDYLj/46p801hHN7zKGKqJAay3gS6
 IgnrxgsE+9IC921jE7+22PLWQXyPDcWCPzpIYkMTvKhxCCnpCxvFMW5xFEBQAuKoI/z1
 6HQA==
X-Gm-Message-State: AOJu0Yzm3YyTMhQqCelot/RRKG4MV0yo8ZDevPL9ub04p48a7CFA80o9
 0Fnnny1z0IRTzH+k6vEIHIbiGRKK7al1wnDAUvCV0w4e5sMFsgmiVWMVvmfrSmd1EEOlE2M+VlY
 49Oe5DpKCYAHOa6UrgPC9r4ODXd7cKZ7FypXkOEWXaRG6wOzWWGGK1l7zImmgfx0cww/0
X-Received: by 2002:adf:f443:0:b0:316:f3cf:6f12 with SMTP id
 f3-20020adff443000000b00316f3cf6f12mr3496083wrp.48.1696477383993; 
 Wed, 04 Oct 2023 20:43:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUObUMAMCbZZg7meidTWmHDU/fJMJCzpcUOQFzKRfc2BTFTEZPbRqe/IqReL0kExaeL8VPsQ==
X-Received: by 2002:adf:f443:0:b0:316:f3cf:6f12 with SMTP id
 f3-20020adff443000000b00316f3cf6f12mr3496071wrp.48.1696477383705; 
 Wed, 04 Oct 2023 20:43:03 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 p1-20020adfce01000000b003258934a4bfsm630832wrn.36.2023.10.04.20.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:43:03 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:42:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL v2 10/53] virtio-net: do not reset vlan filtering at
 set_features
Message-ID: <06b636a1e2ad12ab130edcbb0ccf995118440706.1696477105.git.mst@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



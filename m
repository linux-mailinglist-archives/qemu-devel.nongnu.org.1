Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9244174100F
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:29:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETLf-0001B5-L5; Wed, 28 Jun 2023 07:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qETLd-0001AT-Lb
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:28:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qETLc-0005Fu-8p
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687951711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Fa2L91g01EkMx5Ea7xbkjawYZyKpq4OZw5pmoFHyvGY=;
 b=CeW+RA/Uht12Rmj2TMFxYno3g4hnosfz5x2fs9urx6tauF/KMq2NPI+rbNRGH7vcA9lKpC
 X3GYD/FkTS+kIvKv2JEvgpQj3Jyghge+SLnKcB0LX2EmhHRRT3tUl8s+zSFmIGoE2E2ynt
 Ph3CxrD7wB9HFponoE3gcXq3Mb0aDvc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-fLMSQERAPY6APSyjfEhQlQ-1; Wed, 28 Jun 2023 07:28:29 -0400
X-MC-Unique: fLMSQERAPY6APSyjfEhQlQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6687243be0cso4874093b3a.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 04:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687951709; x=1690543709;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fa2L91g01EkMx5Ea7xbkjawYZyKpq4OZw5pmoFHyvGY=;
 b=ct1gkqGzWhWUQ/MKMUyHhgX8Q090t2FkZ450KW6+tT13vMA4hmt+f4iDuAxReKPXU0
 73ClsRl8v9QuXPwKA+wvY6xIJJKbJZf1/0kCGCSjJWFW/NSL3QloHOYYL8PVQxFL1sgA
 9HRViW3qVsiOMUBuEs3D/gbqhZ8a1TD5b3ud6RbMZyb6GTag9ImcL3WZmjv1VYxzZXaD
 cEtC9D3scsEJBKdrSyXgaPs4K+YEaEIUnlaxrvLf18Ko0CxNPSVbsNbu3KgzGr4gfHqs
 z+Zw4Fzgmpx+X95bLb82HogbDsLE0UorCeGgQsZ6PITTFXLSU7Z83p/k+q3FFJcT8SB9
 SPPQ==
X-Gm-Message-State: AC+VfDxtIFEZ66fUGcZkfRigCKV3siNEkASEvQsVMWCMvUjIR0dVn2l9
 OAasZvI6mwcwWXepSNLySqAKSuVupdQ7Ao4o+xuEWpT5trZr3lkHsCKZRxqyGrG2JldikzfeaI9
 Q/E0BbcUbb7dVGGs=
X-Received: by 2002:a05:6a00:ac3:b0:666:e621:d83e with SMTP id
 c3-20020a056a000ac300b00666e621d83emr41443975pfl.13.1687951708815; 
 Wed, 28 Jun 2023 04:28:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6rGAahCl+1vsJQvAoeWQTHu3fWNvKdeZdN8FqvKoG3s2YcNCQsLrYkPztWtA9oulmlwz7XrQ==
X-Received: by 2002:a05:6a00:ac3:b0:666:e621:d83e with SMTP id
 c3-20020a056a000ac300b00666e621d83emr41443965pfl.13.1687951708511; 
 Wed, 28 Jun 2023 04:28:28 -0700 (PDT)
Received: from localhost.localdomain ([115.96.122.163])
 by smtp.googlemail.com with ESMTPSA id
 v8-20020a62a508000000b0066684d8115bsm7049913pfm.178.2023.06.28.04.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 04:28:28 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: peter.maydell@linaro.org, lvivier@redhat.com, clg@redhat.com,
 Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] net/vhost-net: do not assert on null pointer return from
 tap_get_vhost_net()
Date: Wed, 28 Jun 2023 16:58:04 +0530
Message-Id: <20230628112804.36676-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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

When 'vhost=off' or no vhost specific options at all are passed for the tap
net-device backend, tap_get_vhost_net() can return NULL. The function
net_init_tap_one() does not call vhost_net_init() on such cases and therefore
vhost_net pointer within the tap device state structure remains NULL. Hence,
assertion here on a NULL pointer return from tap_get_vhost_net() would not be
correct. Remove it and fix the crash generated by qemu upon initialization in
the following call chain :

qdev_realize() -> pci_qdev_realize() -> virtio_device_realize() ->
virtio_bus_device_plugged() -> virtio_net_get_features() -> get_vhost_net()

fixes: 0e994668d00c9c ("vhost_net: add an assertion for TAP client backends")
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/net/vhost_net.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 6db23ca323..6b958d6363 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -507,7 +507,12 @@ VHostNetState *get_vhost_net(NetClientState *nc)
     switch (nc->info->type) {
     case NET_CLIENT_DRIVER_TAP:
         vhost_net = tap_get_vhost_net(nc);
-        assert(vhost_net);
+        /*
+         * tap_get_vhost_net() can return NULL if a tap net-device backend is
+         * created with 'vhost=off' option, 'vhostforce=off' or no vhost or
+         * vhostforce or vhostfd options at all. Please see net_init_tap_one().
+         * Hence, we omit the assertion here.
+         */
         break;
 #ifdef CONFIG_VHOST_NET_USER
     case NET_CLIENT_DRIVER_VHOST_USER:
-- 
2.39.1



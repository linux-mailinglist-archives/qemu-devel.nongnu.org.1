Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09382734B0B
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 06:16:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB6IZ-0002YQ-4m; Mon, 19 Jun 2023 00:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qB6IT-0002YD-O3
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 00:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qB6IS-0006IT-A5
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 00:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687148117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ekYRMi9tbmL7kAsiIwFz+PcaMLKC+XPaP3LviPc1b0w=;
 b=NPjsJIHv86qN/ZZI7ETfJI/MrhyZ0L7LybWwdrInJ341sLsDi/i2eeUn31L8ikp21gHctz
 ls+SLXyKeTbo6CEN4wlKOypUQNZKctkATqD0bMZqaWJjmngIljT+y+scudx93JUC8UMqu6
 HSMwq9/rRsXmD4kIP2mVX2hM/QNsPO0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-AoSvLSwbN-q8kz_VIiIwkg-1; Mon, 19 Jun 2023 00:15:13 -0400
X-MC-Unique: AoSvLSwbN-q8kz_VIiIwkg-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-25e18dac4a3so1221249a91.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 21:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687148112; x=1689740112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ekYRMi9tbmL7kAsiIwFz+PcaMLKC+XPaP3LviPc1b0w=;
 b=fT3nA4KmJ3oylkIkJJw4bTlww2MzqlOYgK6hl1EZe84Au2gnKj9yxfaKvuTE+cbr/6
 OgkFEESv0vzM0eXf0Ru8V0PpTU+uno6wpSiN+5AR125XyG+hWdK3C0JTKAR1j2iISljr
 6O7PrvDcxKipnecn0A5MvQG7IIqhMGbhiJsK0RF5H5lbT1c9c98YGEwkaP6FHTIZ1baw
 WFJne95QXs172XHHaAn9AjyI5uMpu+Zdv0SWLIEHIaozjSL7K8linNiDQ1WrcwuxtMEB
 sdnVW5v8fMsb+N0wqHKa5bmozTWOnFfE82m5uuTjG0JHZyos4Hs4NRGGeS6BdDqurlCv
 aGhg==
X-Gm-Message-State: AC+VfDyry/6hC9MtryFnZ8TFSYko8bmKjYWYzNW783jC4faE6pTCi5Cc
 p/xfF+wKUsMuc0mwbY4K0I4YNO3LFzmXTc+8Bc65nlmfkDULN9v9zghki6TgznM3UJ+1iUaAgH/
 w/Jnzd1ZFt4g5R7c=
X-Received: by 2002:a17:90b:f94:b0:25b:8bed:d139 with SMTP id
 ft20-20020a17090b0f9400b0025b8bedd139mr7092135pjb.25.1687148112432; 
 Sun, 18 Jun 2023 21:15:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6cHsbfeHYTlxIMB06aACmk/cSo5p48CizU2mEFplDy0H7Tjsh7ZSiGsgcAFS8cQjNWS3p9xA==
X-Received: by 2002:a17:90b:f94:b0:25b:8bed:d139 with SMTP id
 ft20-20020a17090b0f9400b0025b8bedd139mr7092121pjb.25.1687148112055; 
 Sun, 18 Jun 2023 21:15:12 -0700 (PDT)
Received: from localhost.localdomain ([115.96.121.2])
 by smtp.googlemail.com with ESMTPSA id
 u11-20020a17090a410b00b0025023726fc4sm4712073pjf.26.2023.06.18.21.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jun 2023 21:15:11 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: imammedo@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] vhost_net: add an assertion for TAP client backends
Date: Mon, 19 Jun 2023 09:45:01 +0530
Message-Id: <20230619041501.111655-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

An assertion was missing for tap vhost backends that enforces a non-null
reference from get_vhost_net(). Both vhost-net-user and vhost-net-vdpa
enforces this. Enforce the same for tap. Unit tests pass with this change.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/net/vhost_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index c4eecc6f36..6db23ca323 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -507,6 +507,7 @@ VHostNetState *get_vhost_net(NetClientState *nc)
     switch (nc->info->type) {
     case NET_CLIENT_DRIVER_TAP:
         vhost_net = tap_get_vhost_net(nc);
+        assert(vhost_net);
         break;
 #ifdef CONFIG_VHOST_NET_USER
     case NET_CLIENT_DRIVER_VHOST_USER:
-- 
2.39.1



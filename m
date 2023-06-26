Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE2273E083
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:22:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlMM-0004Wk-Ff; Mon, 26 Jun 2023 08:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLE-0002Ua-Qm
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlL8-000347-UW
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6BUv4I7dG+GE3/QdNWJM+8uNg6qHOIFVxP5tkVLDkfE=;
 b=ZD2gGeJh8n3MKy8OiKJWDx4vs5DLqcdIry01zv2PjT5GNO5Tzs/WuP5cU7lcZ8oKtEUeno
 HUkrAdzZOXlLc+bZNdi0dehKzNiVGmroMDfE71qtcbi8pv++EMgCB26/GFdZ0/fMqXRSUD
 TaucYNKsQ/IyE1hOxAeIGTVJUCjkOog=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-ku1ItySFNMeLtKPursybVg-1; Mon, 26 Jun 2023 08:29:04 -0400
X-MC-Unique: ku1ItySFNMeLtKPursybVg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31283f4d22fso1183964f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782542; x=1690374542;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6BUv4I7dG+GE3/QdNWJM+8uNg6qHOIFVxP5tkVLDkfE=;
 b=bMs+d8HDfNPNWuhSLnGAAcbYo2wY9Oirh1hgDCQWMcwsbgmqCVdz26crrwsfpQ9dkY
 VUIAa8SXXO9ukjuKUi2f2GcNHZjnwfQ0ut6AWM8oLPJfxcHCHJXt73KcRceorwhGQDKK
 beYu7uV/UcQ6rn6KlWKXQtJ8UjaSG8p4alGlVQIy83MIdERhqHCpUmuFqJHSDGN5hgV2
 QW3Pn5kkVAnsm0Y8FzOAifrh0Z+REUgT4ZJCqQmRcq9PlADHAW7X3+eczneLDb2dUkwC
 ALYtWhmOGEeVnRkevVgzu7oA6WM9hGI0wTjKyB/ivDi7qwtIoZLGazWoTHorJA7wPRUp
 JHVw==
X-Gm-Message-State: AC+VfDxOOJ+JkvuRErOxAOx5cbPBCSs8Ex83Ze7MfcDSCJFuXNi+82if
 NPw9BGfdqMnUFrIyyfc5JjL5+9CPA256PznfQ/Bb2asrfqR/VD4CmJ10gKmFU9xeYjLZAcrH9iG
 3kM49vTagAhg64XQw6z6hU/MBH0jovG8J3tLEFaNuE+GlcDQ0ODknxp3xIfXjY5LBg73i
X-Received: by 2002:a05:6000:1001:b0:313:e971:53af with SMTP id
 a1-20020a056000100100b00313e97153afmr3230461wrx.32.1687782542024; 
 Mon, 26 Jun 2023 05:29:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5pJ14OiuaxwW64vtAmIesshoMB8LCjUlm7g3/nMVQf6ts0FY5FOb4u+FrD0fyj3hvaxm59Cg==
X-Received: by 2002:a05:6000:1001:b0:313:e971:53af with SMTP id
 a1-20020a056000100100b00313e97153afmr3230446wrx.32.1687782541781; 
 Mon, 26 Jun 2023 05:29:01 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 o7-20020adfeac7000000b003095bd71159sm7377490wrn.7.2023.06.26.05.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:29:01 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:28:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad Pandit <pjp@fedoraproject.org>, Peter Xu <peterx@redhat.com>,
 qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>
Subject: [PULL 23/53] vhost: release memory_listener object in error path
Message-ID: <1e3ffb34f764f8ac4c003b2b2e6a775b2b073a16.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From: Prasad Pandit <pjp@fedoraproject.org>

vhost_dev_start function does not release memory_listener object
in case of an error. This may crash the guest when vhost is unable
to set memory table:

  stack trace of thread 125653:
  Program terminated with signal SIGSEGV, Segmentation fault
  #0  memory_listener_register (qemu-kvm + 0x6cda0f)
  #1  vhost_dev_start (qemu-kvm + 0x699301)
  #2  vhost_net_start (qemu-kvm + 0x45b03f)
  #3  virtio_net_set_status (qemu-kvm + 0x665672)
  #4  qmp_set_link (qemu-kvm + 0x548fd5)
  #5  net_vhost_user_event (qemu-kvm + 0x552c45)
  #6  tcp_chr_connect (qemu-kvm + 0x88d473)
  #7  tcp_chr_new_client (qemu-kvm + 0x88cf83)
  #8  tcp_chr_accept (qemu-kvm + 0x88b429)
  #9  qio_net_listener_channel_func (qemu-kvm + 0x7ac07c)
  #10 g_main_context_dispatch (libglib-2.0.so.0 + 0x54e2f)

Release memory_listener objects in the error path.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
Message-Id: <20230529114333.31686-2-ppandit@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Fixes: c471ad0e9b ("vhost_net: device IOTLB support")
Cc: qemu-stable@nongnu.org
Acked-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/vhost.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 7f3c727777..7e1f556994 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2003,6 +2003,9 @@ fail_vq:
     }
 
 fail_mem:
+    if (vhost_dev_has_iommu(hdev)) {
+        memory_listener_unregister(&hdev->iommu_listener);
+    }
 fail_features:
     vdev->vhost_started = false;
     hdev->started = false;
-- 
MST



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD987D01C7
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:36:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXgN-0007KR-CW; Thu, 19 Oct 2023 14:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfX-0006qz-13
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfV-0000nw-F4
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pK7tbuaeKJdZf3nB4jRfGMSAPSPT/dWMGPTuzqv6QUY=;
 b=KB4g2CukQJBpxtzMXC0ETipMDbIAAkctm6Qm2SU6UNa7wDWRvqWxdx1bH8yrv+7IqtBi0d
 EKv+qgo7JG8pwsnvfc15QvI48FdYMxvWU4j+83JeFnXwdwdtdjyERKyjza1cza6sn71/B/
 BQXowfHbeGfzosNOLEFR9MuVsW0pwcQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-TeffTC28MweHHfSNtL3XoQ-1; Thu, 19 Oct 2023 14:22:42 -0400
X-MC-Unique: TeffTC28MweHHfSNtL3XoQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4084a9e637eso4716985e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739761; x=1698344561;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pK7tbuaeKJdZf3nB4jRfGMSAPSPT/dWMGPTuzqv6QUY=;
 b=lKLUPMLDZ2Mk0q20KdJIc4FSfvWR32JG8SYzcVM3NdL5jPGMFBdNkU8J2r/6zCouYN
 80ohlICYi7rhMnSiaA9WD6fb5R3gCq4Nl3mSXKrDXGRyZc9yqXua3J4lMIfUbRlTbY4Z
 5XD/vRYyk8mnkhD50io210rGL5jTLpdW90ekMn0BktdaW/T4gqLiVKWseb+zt0cTdKfr
 qZnXWUM7EVykGty4BCc6+C03K8wRmBIy1S19zFphYPyY1hz1K4VhMdyxKQ/thEYuvbAl
 M7AcGlVS5EZKwBXUdKdMNPqIHi7MuTFl84NPvOM2eAGfYfdm6xEwjvdApd9ERKBBgEHJ
 Gt+g==
X-Gm-Message-State: AOJu0YyVxjqtFfNGxHDmuu5lXv8WrcGhhmOMeyRSmrGY1q8UPscosqsi
 FIqa8VsgOwutrupKknT3HxEoytqJDJOyKLHQujlupTV809VhB7HXhfnlSlLd0/CfKnufj0XorEQ
 lOuchkwYxzKZ02o+DRDfiQ6AdREPW/xQPp2wXRGwNLzeA6PdaeUHDqsdmSJ9BTe3V+6Hh
X-Received: by 2002:a05:600c:319b:b0:406:52f1:7e6f with SMTP id
 s27-20020a05600c319b00b0040652f17e6fmr2579218wmp.12.1697739761442; 
 Thu, 19 Oct 2023 11:22:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYMbLqzykA3HFNnDdYlUxOwixKahJuQhywjpaJVVJdTEd6H1zxD+bCGinFiklL+On2FOobJg==
X-Received: by 2002:a05:600c:319b:b0:406:52f1:7e6f with SMTP id
 s27-20020a05600c319b00b0040652f17e6fmr2579208wmp.12.1697739761192; 
 Thu, 19 Oct 2023 11:22:41 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a05600c3b8d00b004053e9276easm5099376wms.32.2023.10.19.11.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:22:40 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:22:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Hanna Czenczek <hreitz@redhat.com>
Subject: [PULL v2 33/78] vhost-backend: remove vhost_kernel_reset_device()
Message-ID: <c4c8c5616c6d2b7c139a08c31adee7195721a9dc.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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

From: Stefan Hajnoczi <stefanha@redhat.com>

vhost_kernel_reset_device() invokes RESET_OWNER, which disassociates the
owner process from the device. The device is left non-operational since
SET_OWNER is only called once during startup in vhost_dev_init().

vhost_kernel_reset_device() is never called so this latent bug never
appears. Get rid of vhost_kernel_reset_device() for now. If someone
needs it in the future they'll need to implement it correctly.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20231004014532.1228637-3-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---
 hw/virtio/vhost-backend.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 8e581575c9..17f3fc6a08 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -197,11 +197,6 @@ static int vhost_kernel_set_owner(struct vhost_dev *dev)
     return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
 }
 
-static int vhost_kernel_reset_device(struct vhost_dev *dev)
-{
-    return vhost_kernel_call(dev, VHOST_RESET_OWNER, NULL);
-}
-
 static int vhost_kernel_get_vq_index(struct vhost_dev *dev, int idx)
 {
     assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
@@ -322,7 +317,6 @@ const VhostOps kernel_ops = {
         .vhost_get_features = vhost_kernel_get_features,
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
         .vhost_set_owner = vhost_kernel_set_owner,
-        .vhost_reset_device = vhost_kernel_reset_device,
         .vhost_get_vq_index = vhost_kernel_get_vq_index,
         .vhost_vsock_set_guest_cid = vhost_kernel_vsock_set_guest_cid,
         .vhost_vsock_set_running = vhost_kernel_vsock_set_running,
-- 
MST



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D15B7D221D
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:23:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUg9-0003f5-5E; Sun, 22 Oct 2023 05:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUg7-0003Wm-Ck
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUg5-0000O5-E2
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pK7tbuaeKJdZf3nB4jRfGMSAPSPT/dWMGPTuzqv6QUY=;
 b=XKotDTlwdWirtK1lYmG4WspawlY6xtRCYAsgVpMfEQ2/0zav4FM1GF3pigmMA5P668b9E5
 Zgv2dcNkHpQ7Cn0lNZ+OigmxTDxfzU4nCzsVFGBSnV/y/pTKqmoI9KHV4pY/+i05fgnXv2
 9QoFkLRKxvg8kUmxIpvjAaAF46m/AJo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-nqAfZzn1Mi6SjQXPpCA4Ng-1; Sun, 22 Oct 2023 05:23:18 -0400
X-MC-Unique: nqAfZzn1Mi6SjQXPpCA4Ng-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-408f9cee5e8so3746445e9.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966596; x=1698571396;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pK7tbuaeKJdZf3nB4jRfGMSAPSPT/dWMGPTuzqv6QUY=;
 b=UEVMs+p/rFu/mM4IFvj86+RXg9gTyaqUfRfPezOkW2rwbufPjKL6Lcw6mOjeX7C+kV
 OG4DTFpO38q9LqyPgcpUV5hidk0W9ELAkMk/5B5o1PYeak3OHL4iW0A2F5zTYWAEViqk
 lOsa0Opb7NaQomtGVqQu2CVxC2qEPnlpZ2Dffyv10x5ixOWPT8bZmWT5HPpP6yr2MkrQ
 NlkPbPKTNISTZMaUyL407xUMxJ4YTxidBQfR1gidn+1v3V+ACbMdLMUOuAeWaQCM01yG
 RbrPnoNxDObPVhknLAKaAkn3EKgDnJ8HnbTAvx61EQplGh+a7svEgOJSbzQafG8sGACd
 eGjA==
X-Gm-Message-State: AOJu0YxKgLrrVItNyGnJ2uvTlLhxtP8SSLBzUTZlNJWFuljKVBMWJkfc
 kvAz21nP0eHh4hokLMn/uww1F672cJguvODga/IIwLgcwv414z9C5Sgld2O4fhtD80wlGy7ZIeM
 Rq14SzHbUy4j/sHWL0wKD5C8fwTN7vh+c6UUPAwFG4csmSiTEeZyqKG2dUk3/t3CGlCPL
X-Received: by 2002:a05:600c:1992:b0:401:daf2:2735 with SMTP id
 t18-20020a05600c199200b00401daf22735mr4822359wmq.31.1697966596716; 
 Sun, 22 Oct 2023 02:23:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAAnf8HTcsDXqPqdzhu7fwm29zPUVyWrv0ApOznfEmvYuuwQm39Swk57QHqrubqf4ZBSezmw==
X-Received: by 2002:a05:600c:1992:b0:401:daf2:2735 with SMTP id
 t18-20020a05600c199200b00401daf22735mr4822345wmq.31.1697966596389; 
 Sun, 22 Oct 2023 02:23:16 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 e7-20020a05600c218700b00407efbc4361sm11203120wme.9.2023.10.22.02.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:23:15 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:23:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Hanna Czenczek <hreitz@redhat.com>
Subject: [PULL v3 17/62] vhost-backend: remove vhost_kernel_reset_device()
Message-ID: <e6383293eb01928692047e617665a742cca87e23.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
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



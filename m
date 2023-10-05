Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 285697B9A6B
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:48:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFJD-0008Qj-7r; Wed, 04 Oct 2023 23:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFIl-0008Ct-VL
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFIi-0000dy-7r
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TiDNScbhBDu1OBLTc4HNPqS+XxNNdWzPEzlFooKGhj8=;
 b=Jqn14Zs4Z4mPdg3hMURARgkCIKgH2nOEdxEcwlksZkfuNEETyRAf3uC0T1R2UM2CW5/S6J
 B12QJyolbJBMsMiTYRtWf/iEh0zNd7kx/zcFFrWIvTh9f3YpqkH8wzHMvugO6MrSaIAdts
 qUGYNg3Jc+tgRDxdkroKKd9G+52K6cg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-0MKmYAl1OC6BvlbD7RULNA-1; Wed, 04 Oct 2023 23:45:21 -0400
X-MC-Unique: 0MKmYAl1OC6BvlbD7RULNA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-323334992fbso472309f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477519; x=1697082319;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TiDNScbhBDu1OBLTc4HNPqS+XxNNdWzPEzlFooKGhj8=;
 b=kUWxYF5waPDzbtkoQNrRuDGpZMS07zJ21fDR2bT351BbKWe3m85tZFxgt9RvDpLWEc
 0oh0SYm8hhFffbJwVTthFsjHpQJl62iXA9tvEX/CL1pmHTZ0liiwLKV26wScVEVR24Th
 2NlpxB26HGrVNtrJKF+lqqVPzUQVPcN8A+Vw/V5bQ257diUpmGp8LGZX9s3KE4I0qPJe
 GkLB0reJsvQxwF4nalczzH8ivi0gWUPUJu/1cb4+HgmAeqIvPt0BDukZqS/am/iP76/D
 3xptvycsShPI2YB2oMsjjNFNYmFFkrxNYBMel6AEW/m93h7g9S7GKGyiRte3FvHdgiQn
 VEsg==
X-Gm-Message-State: AOJu0YyFTMx7eXrxaHafrz56F+5R8Wn0zc1VupnnY5fkloAM7tWbYdKX
 hTBUbZxnkT1yUH9ztzV4Kk+83kHBncFKOEjA31dguubtOGc80xDvhDYEhKukt4TZTmhzhNl7ZRR
 +wB+fn36UcmRDO5cGBMJw4hGtYe7D6WAeR4h0ylToO+4XZa6kLWFBCijmuzKHPZ7d1AHk
X-Received: by 2002:a5d:504e:0:b0:321:71ae:736c with SMTP id
 h14-20020a5d504e000000b0032171ae736cmr3817364wrt.7.1696477519589; 
 Wed, 04 Oct 2023 20:45:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBQXroXk4qv6caQeGRtcdtZDrmif4fjG9mLJKF0TrmfVg4x+8V5tLNekyglYmJomgdrOK4rg==
X-Received: by 2002:a5d:504e:0:b0:321:71ae:736c with SMTP id
 h14-20020a5d504e000000b0032171ae736cmr3817352wrt.7.1696477519313; 
 Wed, 04 Oct 2023 20:45:19 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 n7-20020a5d6b87000000b003232f167df5sm621445wrx.108.2023.10.04.20.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:45:18 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:45:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL v2 42/53] vdpa net: follow VirtIO initialization properly at
 cvq isolation probing
Message-ID: <845ec38ae1578dd2d42ff15c9979f1bf44b23418.1696477105.git.mst@redhat.com>
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

From: Eugenio Pérez <eperezma@redhat.com>

This patch solves a few issues.  The most obvious is that the feature
set was done previous to ACKNOWLEDGE | DRIVER status bit set.  Current
vdpa devices are permissive with this, but it is better to follow the
standard.

Fixes: 152128d646 ("vdpa: move CVQ isolation check to net_init_vhost_vdpa")
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20230915170836.3078172-4-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index b688877f90..939c984d5b 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1345,8 +1345,7 @@ static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t features,
     uint64_t backend_features;
     int64_t cvq_group;
     uint8_t status = VIRTIO_CONFIG_S_ACKNOWLEDGE |
-                     VIRTIO_CONFIG_S_DRIVER |
-                     VIRTIO_CONFIG_S_FEATURES_OK;
+                     VIRTIO_CONFIG_S_DRIVER;
     int r;
 
     ERRP_GUARD();
@@ -1361,15 +1360,22 @@ static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t features,
         return 0;
     }
 
-    r = ioctl(device_fd, VHOST_SET_FEATURES, &features);
+    r = ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
     if (unlikely(r)) {
-        error_setg_errno(errp, errno, "Cannot set features");
+        error_setg_errno(errp, -r, "Cannot set device status");
         goto out;
     }
 
+    r = ioctl(device_fd, VHOST_SET_FEATURES, &features);
+    if (unlikely(r)) {
+        error_setg_errno(errp, -r, "Cannot set features");
+        goto out;
+    }
+
+    status |= VIRTIO_CONFIG_S_FEATURES_OK;
     r = ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
     if (unlikely(r)) {
-        error_setg_errno(errp, -r, "Cannot set status");
+        error_setg_errno(errp, -r, "Cannot set device status");
         goto out;
     }
 
-- 
MST



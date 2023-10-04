Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB877B7AC0
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:52:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxYM-0003tA-Uw; Wed, 04 Oct 2023 04:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxWt-0000dj-CT
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxWV-0002Y3-Px
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TiDNScbhBDu1OBLTc4HNPqS+XxNNdWzPEzlFooKGhj8=;
 b=fZXN5tMfQUShR0fBbJPvMiWep17li6eSBJ/q6jPNIEhMKiJbFk5PTw6FDWtoh8aFczSyCs
 8gI9hyahawwJZWCnIWOgCwWxNQapOJAd14ASqw0pc+nk+raaOe9ewfH9lozteHj9cbIq3n
 MLERwRgdWZCwMkThWHef1KeD6ys4ReY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-evKk1MSwNX6crNby7ga_tQ-1; Wed, 04 Oct 2023 04:46:01 -0400
X-MC-Unique: evKk1MSwNX6crNby7ga_tQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4053d832d51so12997855e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409160; x=1697013960;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TiDNScbhBDu1OBLTc4HNPqS+XxNNdWzPEzlFooKGhj8=;
 b=kkRJPLwhK8r6+AikS1LWG14GleRVynyShBrbt9ERnuVPHfSWLkfTi3mNuI9yhJCVqK
 tZm0jK0Ky+fBvKlRWDR3YmajhfNZJ8qBIpVtwx0kOP0S0tIe5GWBnXwyVsSgffYs8eb9
 bhr15RklL3OWiamRa7Xw92+rMCWY6jr9bXCdouJXVKajSXUtrQJ5DnoWTtSrMv6lJS1S
 pbDhtMV/30oKlFtfooIG+lJ89VMDPKd3ow/cSuAvf3SP2im6tdwEOIlsWPt5+ALEbmnn
 je539tW0XvXwy1jR//1l/RPeFXV34RNyShU5Nh82l5lYHyb7xkhvMzWxelo72jfEIKo5
 bTcg==
X-Gm-Message-State: AOJu0Yz8MpYBk421ldrGWTi0hJPJe65MYJJxP4bh7Q6yF82kcPqATcAB
 A4RptQHiX6mj1jb3oq8Ms50nDI5x0mT6tl5J96neUUIPeuVVRrUArPg4E3pTvQaPpDlvBuPnUAc
 7WARFQLyKzT/tVmsFCao9RxJCxRxMKvBxw5kpoXwxkerWQUAN2gSHQFNDKYBLs8Gqgmic
X-Received: by 2002:a05:600c:143:b0:405:377f:5417 with SMTP id
 w3-20020a05600c014300b00405377f5417mr1525269wmm.39.1696409159858; 
 Wed, 04 Oct 2023 01:45:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJFO+vPNmpkV5hNBmoLGmADCWGBvd+Rni4S0RFvxXgXZbCZOv6LOh1ohKH8G5VFwG1XcLH3Q==
X-Received: by 2002:a05:600c:143:b0:405:377f:5417 with SMTP id
 w3-20020a05600c014300b00405377f5417mr1525252wmm.39.1696409159499; 
 Wed, 04 Oct 2023 01:45:59 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 o4-20020adfcf04000000b00326f0ca3566sm3414547wrj.50.2023.10.04.01.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:45:58 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:45:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 52/63] vdpa net: follow VirtIO initialization properly at cvq
 isolation probing
Message-ID: <1a01317172f01d910210dc49309944a8f87d4467.1696408966.git.mst@redhat.com>
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



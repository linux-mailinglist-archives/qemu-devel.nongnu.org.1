Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 776F47CE1C3
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:54:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8rU-00033J-ID; Wed, 18 Oct 2023 11:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8rT-000335-32
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8rR-0006Ks-Az
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Aub/+wNbCvirFXr2bctIYe5dvlzn9T6vBOGQpLtPcEM=;
 b=KkVtPwkbQQvLpdEk1Va0rmkJTFx21T0jfSira//Cl+af7ScJ6svP66tmyO3lGcYeIFjQ/+
 89HOcgqJyiEQ1qzHJDJIONJH6zEtgGzASS+F/ydspb5Xf1r5wMSBgWWIFi7ovc03Ct3wOB
 yakuZK6cnlj5dhOGGTLMTcyhfMqSbLg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-06Llt9_SPDCXNlBWmLQcpw-1; Wed, 18 Oct 2023 11:53:26 -0400
X-MC-Unique: 06Llt9_SPDCXNlBWmLQcpw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c50c873604so49619531fa.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644404; x=1698249204;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Aub/+wNbCvirFXr2bctIYe5dvlzn9T6vBOGQpLtPcEM=;
 b=AxmPvCNx6qRs2Pm0XazhldrdHMwzX4ExqwwhHdTCbFBZ7lAzdSJGDcN0OVnnCnETad
 jVFzXlk7SnVCcJcZVSeIazcsNzpOeiFDJr0SGPXR7AzPuZO0xfE09efK7FhA0bPOZQ03
 eJCvXWNuLIdLslDYq24MIlvN/9oQt0upnbOsab9Fr+caWreVXTcQmtgx88VpXbal+8uR
 jvkLdYPx73Hq7u/nrxcKYvo6HrSU2RQqTSXdDrpWEoiBHuXooJ2ma/pcYBK6WPUDS9gG
 18MHv29m7xjesimDrfIQbpy8ix2BMULlNUM5TmMvUbEyQgacmOBTwJoyPmRYaWpOQmvA
 f3MA==
X-Gm-Message-State: AOJu0YyBgiqPsc1FSrbxUfQ5fZjMiiYegmuRKwypVMBjhMQFbco31LKt
 JjzT0vaNZePddP/3JqeLHA6xrrxcq2yrOcWJ262bGNb9ejRrdei626Teq1HpplB0Uo8T/Mk4dhe
 d13G4/Gk3xJ8dwclYbQRfQmTEvgw5G6dsk63JQz8EMIDjFYOgMpyEvsK+i+OtJAUAlIJoJG4=
X-Received: by 2002:a2e:9113:0:b0:2c5:2103:604b with SMTP id
 m19-20020a2e9113000000b002c52103604bmr4151391ljg.2.1697644404404; 
 Wed, 18 Oct 2023 08:53:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhLBx8nDuCD0KRa6kFmDPiirBytCFwi2rejXZ0npCdYQU6ZeQGaDdq6PKDHCf/unbEFNIfVg==
X-Received: by 2002:a2e:9113:0:b0:2c5:2103:604b with SMTP id
 m19-20020a2e9113000000b002c52103604bmr4151374ljg.2.1697644403980; 
 Wed, 18 Oct 2023 08:53:23 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 n13-20020adffe0d000000b0032d9382e6e0sm2390693wrr.45.2023.10.18.08.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:53:23 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:53:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 01/83] vdpa: Use iovec for vhost_vdpa_net_cvq_add()
Message-ID: <0e6bff0d43bf04c6e7a16c2775879816ca056b3d.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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

Next patches in this series will no longer perform an
immediate poll and check of the device's used buffers
for each CVQ state load command. Consequently, there
will be multiple pending buffers in the shadow VirtQueue,
making it a must for every control command to have its
own buffer.

To achieve this, this patch refactor vhost_vdpa_net_cvq_add()
to accept `struct iovec`, which eliminates the coupling of
control commands to `s->cvq_cmd_out_buffer` and `s->status`,
allowing them to use their own buffer.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <8a328f146fb043f34edb75ba6d043d2d6de88f99.1697165821.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 939c984d5b..618758596a 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -618,22 +618,14 @@ static void vhost_vdpa_net_cvq_stop(NetClientState *nc)
     vhost_vdpa_net_client_stop(nc);
 }
 
-static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s, size_t out_len,
-                                      size_t in_len)
+static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s,
+                                    const struct iovec *out_sg, size_t out_num,
+                                    const struct iovec *in_sg, size_t in_num)
 {
-    /* Buffers for the device */
-    const struct iovec out = {
-        .iov_base = s->cvq_cmd_out_buffer,
-        .iov_len = out_len,
-    };
-    const struct iovec in = {
-        .iov_base = s->status,
-        .iov_len = sizeof(virtio_net_ctrl_ack),
-    };
     VhostShadowVirtqueue *svq = g_ptr_array_index(s->vhost_vdpa.shadow_vqs, 0);
     int r;
 
-    r = vhost_svq_add(svq, &out, 1, &in, 1, NULL);
+    r = vhost_svq_add(svq, out_sg, out_num, in_sg, in_num, NULL);
     if (unlikely(r != 0)) {
         if (unlikely(r == -ENOSPC)) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No space on device queue\n",
@@ -659,6 +651,15 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
         .cmd = cmd,
     };
     size_t data_size = iov_size(data_sg, data_num);
+    /* Buffers for the device */
+    const struct iovec out = {
+        .iov_base = s->cvq_cmd_out_buffer,
+        .iov_len = sizeof(ctrl) + data_size,
+    };
+    const struct iovec in = {
+        .iov_base = s->status,
+        .iov_len = sizeof(*s->status),
+    };
 
     assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl));
 
@@ -669,8 +670,7 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
     iov_to_buf(data_sg, data_num, 0,
                s->cvq_cmd_out_buffer + sizeof(ctrl), data_size);
 
-    return vhost_vdpa_net_cvq_add(s, data_size + sizeof(ctrl),
-                                  sizeof(virtio_net_ctrl_ack));
+    return vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
 }
 
 static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
@@ -1248,10 +1248,15 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
         .iov_base = s->cvq_cmd_out_buffer,
     };
     /* in buffer used for device model */
-    const struct iovec in = {
+    const struct iovec model_in = {
         .iov_base = &status,
         .iov_len = sizeof(status),
     };
+    /* in buffer used for vdpa device */
+    const struct iovec vdpa_in = {
+        .iov_base = s->status,
+        .iov_len = sizeof(*s->status),
+    };
     ssize_t dev_written = -EINVAL;
 
     out.iov_len = iov_to_buf(elem->out_sg, elem->out_num, 0,
@@ -1285,7 +1290,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
             goto out;
         }
     } else {
-        dev_written = vhost_vdpa_net_cvq_add(s, out.iov_len, sizeof(status));
+        dev_written = vhost_vdpa_net_cvq_add(s, &out, 1, &vdpa_in, 1);
         if (unlikely(dev_written < 0)) {
             goto out;
         }
@@ -1301,7 +1306,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
     }
 
     status = VIRTIO_NET_ERR;
-    virtio_net_handle_ctrl_iov(svq->vdev, &in, 1, &out, 1);
+    virtio_net_handle_ctrl_iov(svq->vdev, &model_in, 1, &out, 1);
     if (status != VIRTIO_NET_OK) {
         error_report("Bad CVQ processing in model");
     }
-- 
MST



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 013FC78D436
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 10:49:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbGsq-0008H3-20; Wed, 30 Aug 2023 04:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qbGsn-0008Gs-TH
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:49:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qbGsl-0007Rq-Iu
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693385337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g7NLSUdk8FpNVRrr7pYga8bjxO1eGzE6sZ8Z4GqWmTE=;
 b=O+1ygke0LS8pkb3l5TYTOAu7YFh9OocS1t2MO8InT7faAUPmAKd/HLmZ6aVuxGlvFAdHH2
 FuCNLAP/RCrizPrsD+cfFS/jgtDOqQqZfSbiC0l9eSwKYBq634LAYX9V+vQ2ygCgk92zUM
 6538xSKK5m9S+lLlzWjzc7lbFHLk+XI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-SS7547CZM5aPxUgwyg8YNg-1; Wed, 30 Aug 2023 04:48:55 -0400
X-MC-Unique: SS7547CZM5aPxUgwyg8YNg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-52bdadd5497so698421a12.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 01:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693385334; x=1693990134;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7NLSUdk8FpNVRrr7pYga8bjxO1eGzE6sZ8Z4GqWmTE=;
 b=huKaqAyoURcZswNmOY2H3PiB//r8TnunbXq87WgfkFDQEDGvd2LvbeuNkxujuxuVCR
 BuMmoIPJSxJmUGTVdPRrWDnf+DTEnKKLZRSOmNMkx2DcSWlwhZQFJEY5PdMh/D9zFF1l
 NkIorqgu0/asppFUZOr+QebDH+uj7PTNQ90pwFCLZJ8Iw//lOR0CBf5VPd6bFUSsHB19
 wrCKX8KHwTARAT5HCfH7dIc2zBeYhZ71XKHER6rrtauYF+K9QyACf8fZTY5evl/MZ6Nf
 a5d3wRg1auHmL7zlqVH0wlaKXuZCRF3FuNuvpRicEHn4slxqBj655Z6tO6445sRh2+/2
 uPZQ==
X-Gm-Message-State: AOJu0Yxy+216Q6nC4vgQDQx2wOHzWEFQyWXOrlfIOHJjoNJPKellc3Mv
 KBh1f+SjyHh/i+1De5rW9JZVpVnw0AgWl2hmY6Al2WgYpdO+u+AGTTsCpy1vqzhkOlA/MuxdbId
 ET/i4F7/dZ7UvmW8=
X-Received: by 2002:aa7:c685:0:b0:525:70b3:72c2 with SMTP id
 n5-20020aa7c685000000b0052570b372c2mr1456242edq.14.1693385334764; 
 Wed, 30 Aug 2023 01:48:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERzHVPDBSNf1TgZgqA23TaUc8SdKrB3TLBwExId1Gjvoi9ODk3WrCQsn+cOhFVhJ6WUhuPNQ==
X-Received: by 2002:aa7:c685:0:b0:525:70b3:72c2 with SMTP id
 n5-20020aa7c685000000b0052570b372c2mr1456233edq.14.1693385334436; 
 Wed, 30 Aug 2023 01:48:54 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 bo24-20020a0564020b3800b005232e637c24sm6527864edb.84.2023.08.30.01.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 01:48:53 -0700 (PDT)
Date: Wed, 30 Aug 2023 10:48:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, 
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>
Subject: Re: [PATCH 0/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
Message-ID: <3hc3j6klx6f3wveap72mebb26iratugg5z64ol3xikt3zigiyh@fd5yilpjuq44>
References: <20230827182937.146450-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230827182937.146450-1-lersek@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Sun, Aug 27, 2023 at 08:29:30PM +0200, Laszlo Ersek wrote:
>The last patch in the series states and fixes the problem; prior patches
>only refactor the code.

Thanks for the fix and great cleanup!

I fully reviewed the series and LGTM.

An additional step that we can take (not in this series) crossed my
mind, though. In some places we repeat the following pattern:

     vhost_user_write(dev, &msg, NULL, 0);
     ...

     if (reply_supported) {
         return process_message_reply(dev, &msg);
     }

So what about extending the vhost_user_write_msg() added in this series
to support also this cases and remove some code.
Or maybe integrate vhost_user_write_msg() in vhost_user_write().

I mean something like this (untested):

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 01e0ca90c5..9ee2a78afa 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1130,13 +1130,19 @@ static int vhost_user_get_features(struct vhost_dev *dev, uint
64_t *features)
      return 0;
  }

+typedef enum {
+    NO_REPLY,
+    REPLY_IF_SUPPORTED,
+    REPLY_FORCED,
+} VhostUserReply;
+
  /* Note: "msg->hdr.flags" may be modified. */
  static int vhost_user_write_msg(struct vhost_dev *dev, VhostUserMsg *msg,
-                                bool wait_for_reply)
+                                VhostUserReply reply)
  {
      int ret;

-    if (wait_for_reply) {
+    if (reply != NO_REPLY) {
          bool reply_supported = virtio_has_feature(dev->protocol_features,
                                            VHOST_USER_PROTOCOL_F_REPLY_ACK);
          if (reply_supported) {
@@ -1149,7 +1155,7 @@ static int vhost_user_write_msg(struct vhost_dev *dev, VhostUserMsg *msg,
          return ret;
      }

-    if (wait_for_reply) {
+    if (reply != NO_REPLY) {
          uint64_t dummy;

          if (msg->hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
@@ -1162,7 +1168,9 @@ static int vhost_user_write_msg(struct vhost_dev 
*dev, VhostUserMsg *msg,
          * Send VHOST_USER_GET_FEATURES which makes all backends
          * send a reply.
          */
-        return vhost_user_get_features(dev, &dummy);
+        if (reply == REPLY_FORCED) {
+            return vhost_user_get_features(dev, &dummy);
+        }
      }

      return 0;
@@ -2207,9 +2228,6 @@ static bool vhost_user_can_merge(struct vhost_dev *dev,
  static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
  {
      VhostUserMsg msg;
-    bool reply_supported = virtio_has_feature(dev->protocol_features,
-                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
-    int ret;
  
      if (!(dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_NET_MTU))) {
          return 0;
@@ -2219,21 +2237,9 @@ static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
      msg.payload.u64 = mtu;
      msg.hdr.size = sizeof(msg.payload.u64);
      msg.hdr.flags = VHOST_USER_VERSION;
-    if (reply_supported) {
-        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
-    }
-
-    ret = vhost_user_write(dev, &msg, NULL, 0);
-    if (ret < 0) {
-        return ret;
-    }
  
      /* If reply_ack supported, backend has to ack specified MTU is valid */
-    if (reply_supported) {
-        return process_message_reply(dev, &msg);
-    }
-
-    return 0;
+    return vhost_user_write_msg(dev, &msg, REPLY_IF_SUPPORTED);
  }
  
  static int vhost_user_send_device_iotlb_msg(struct vhost_dev *dev,
@@ -2313,10 +2319,7 @@ static int vhost_user_get_config(struct vhost_dev *dev, uint8_t *config,
  static int vhost_user_set_config(struct vhost_dev *dev, const uint8_t *data,
                                   uint32_t offset, uint32_t size, uint32_t flags)
  {
-    int ret;
      uint8_t *p;
-    bool reply_supported = virtio_has_feature(dev->protocol_features,
-                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
  
      VhostUserMsg msg = {
          .hdr.request = VHOST_USER_SET_CONFIG,
@@ -2329,10 +2332,6 @@ static int vhost_user_set_config(struct vhost_dev *dev, const uint8_t *data,
          return -ENOTSUP;
      }
  
-    if (reply_supported) {
-        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
-    }
-
      if (size > VHOST_USER_MAX_CONFIG_SIZE) {
          return -EINVAL;
      }
@@ -2343,16 +2342,7 @@ static int vhost_user_set_config(struct vhost_dev *dev, const uint8_t *data,
      p = msg.payload.config.region;
      memcpy(p, data, size);
  
-    ret = vhost_user_write(dev, &msg, NULL, 0);
-    if (ret < 0) {
-        return ret;
-    }
-
-    if (reply_supported) {
-        return process_message_reply(dev, &msg);
-    }
-
-    return 0;
+    return vhost_user_write_msg(dev, &msg, REPLY_IF_SUPPORTED);
  }

Thanks,
Stefano



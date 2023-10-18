Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F145B7CE20B
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:01:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8wJ-00009l-KN; Wed, 18 Oct 2023 11:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8ta-0002nP-FC
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8tW-0006rF-CG
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E99g4CTTfhJ51zXlgqHdg/7C/6fC/h1geeLvGMNmvCc=;
 b=cssE6n46M0yr31XaW6fxuVPBj2ceey/6eYMtXaOKuQcz2xieXsTw2j/WbypMxf3H17eiYu
 c70nj/vemGuJOgHoznYp26bpYdasKdLA9Xi0mNn1XpF57uDLzGLrc4ZXiJ8OHlV+4OqaSI
 WMH/VJA7zVUAzGR6x9e4mtwCUtH4G1k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-emroDSigMkygkpRJzwzE_g-1; Wed, 18 Oct 2023 11:55:36 -0400
X-MC-Unique: emroDSigMkygkpRJzwzE_g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32d58708cd5so4254841f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644534; x=1698249334;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E99g4CTTfhJ51zXlgqHdg/7C/6fC/h1geeLvGMNmvCc=;
 b=uF4OmeKXhJe9NXiSpmjeuwq6ZydfwKEMwY7wyyakDNe/GiO/XGOjcWLQd8JmtCZGdz
 pDCUdDG1JynorCQUXBCC6XNszfLhFq4lO5pF9FEaPkd8RqwNIJhMjmumLl7i1NEKG/T+
 Qa/EIgyyiaOckebmr+heQOK2/oHZWK7I5hSOLJgnUWtt2OkA2+L0csQIGbsPIs0H4L7U
 PcyZwNH5c8aHd1PLEbCmGZodCEFOmuLBqm820xHOCgT/HIvT+UghOPrHSTiEv2vdSHEr
 B8Nk06aQ1F2HrJ30i01OUakV7hb4kcGDoyD1jAGuJl4BkwRbbVsTlT6mHpBpgKXGCNpD
 BxGw==
X-Gm-Message-State: AOJu0Yw6YqFF6F2bWs9cv2Jr1CKYFejG8uwgIt+8MaOBbwMemC+4qKjy
 U4Yo7IISvp7QFbN6OIcOcTGd5j1SavkbY2B1Fv72LTk6bymD4vtMq8hyiAetl7cJQVSYjgEXUWR
 6ZAbROH2UgkiSPjwI1BeScUKkEAyGnDWwRGuHG8R4CGSh1KdFItcCxbCkFhSDA2++SeZZLwk=
X-Received: by 2002:a05:6000:10a:b0:32d:82b4:1957 with SMTP id
 o10-20020a056000010a00b0032d82b41957mr4191910wrx.40.1697644534472; 
 Wed, 18 Oct 2023 08:55:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHWV5rSVJ0CiyhKKzLpH+ItnBouwoiBE5k7CQkyL0JsNcBIuou4CRqG0BaVSDoQS3cg7MLGQ==
X-Received: by 2002:a05:6000:10a:b0:32d:82b4:1957 with SMTP id
 o10-20020a056000010a00b0032d82b41957mr4191886wrx.40.1697644534114; 
 Wed, 18 Oct 2023 08:55:34 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 x3-20020adff0c3000000b0032dc74c093dsm2373998wro.103.2023.10.18.08.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:55:33 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:55:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Albert Esteve <aesteve@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 30/83] vhost-user: tighten "reply_supported" scope in
 "set_vring_addr"
Message-ID: <af367c0813ed9c8ec1c95b3494fb57c7e3afb47a.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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

From: Laszlo Ersek <lersek@redhat.com>

In the vhost_user_set_vring_addr() function, we calculate
"reply_supported" unconditionally, even though we'll only need it if
"wait_for_reply" is also true.

Restrict the scope of "reply_supported" to the minimum.

This is purely refactoring -- no observable change.

Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
Cc: Eugenio Perez Martin <eperezma@redhat.com>
Cc: German Maglione <gmaglione@redhat.com>
Cc: Liu Jiang <gerry@linux.alibaba.com>
Cc: Sergio Lopez Pascual <slp@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20231002203221.17241-3-lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 3e33a2e9e0..6c7b4cc75c 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1321,17 +1321,18 @@ static int vhost_user_set_vring_addr(struct vhost_dev *dev,
         .hdr.size = sizeof(msg.payload.addr),
     };
 
-    bool reply_supported = virtio_has_feature(dev->protocol_features,
-                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
-
     /*
      * wait for a reply if logging is enabled to make sure
      * backend is actually logging changes
      */
     bool wait_for_reply = addr->flags & (1 << VHOST_VRING_F_LOG);
 
-    if (reply_supported && wait_for_reply) {
-        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
+    if (wait_for_reply) {
+        bool reply_supported = virtio_has_feature(dev->protocol_features,
+                                          VHOST_USER_PROTOCOL_F_REPLY_ACK);
+        if (reply_supported) {
+            msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
+        }
     }
 
     ret = vhost_user_write(dev, &msg, NULL, 0);
-- 
MST



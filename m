Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E178E74E1EE
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:08:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwT-0002lR-Nb; Mon, 10 Jul 2023 19:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwM-0002WF-Uw
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwI-0004a0-Di
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1yF9+I+eRXG7++9iT7lOKTZwoXP1PUCE8vxaJW/z4w=;
 b=gmP8WiT4E1fgozuNfqZ+3FbtbRSA22bOfVVMAOx3i4X5YVa7q7IlN+a5ZnM1Zv+rr4fW1d
 1SeTm1V+2U+vppt9KiRqm61NmVNqKwSeBv+qS+w23CsJ5H+i3MRoMRgY7+GZu67cnczt28
 2PTPhblHVViGyqaqpCH1IGt3v/DIZUY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-I8xdiB1iPoeAMqEPn6qD5Q-1; Mon, 10 Jul 2023 19:04:53 -0400
X-MC-Unique: I8xdiB1iPoeAMqEPn6qD5Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fbfc766a78so24389415e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030292; x=1691622292;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b1yF9+I+eRXG7++9iT7lOKTZwoXP1PUCE8vxaJW/z4w=;
 b=lIGsQjXRSJI8JrmPh9h3CN5HhnifiF+0OMKLf0T2mtvjRcVVglluXIpUDzSPYdssqY
 BraP0VthjOjK8NNRTWLq2Ta9L/MSC26yE4vqnfCvv3stkx5qmsaqtLAioZGuNB4PFSoZ
 X5ehRKmqf0onc3Ft6NTISB9Am8i1eM3fgWcqpuOMYl8ngIJavZleEUTRZy86PodwwWRo
 KJwc9g46bY9DiqkphirXhMwcj4K9ZbSq6cuti2GVjHQdK/s34SpxWjq9l2IJqP1rnA+L
 jy3KpFqoPxSB5P4AyeLXxa2yj0YGJvX9v2L4uqtoeoMGCV8sb/yt4iwUhRchXVGTcUMi
 rdcg==
X-Gm-Message-State: ABy/qLYyUVt4oNyn5GEKse3qYk4VXFqlk4eIrbHulhk0/hqinTwAfp5Y
 LR0haCyhQI90JuTRYpOj1gSAVj5E6Ge2ZIevtWp4KgDY9fNGUPTLOoMURHugP8RBB6uMNXDKA2Y
 hBZYW8DAm1Z23xypnfIBMnefpwm7AQVI/vrlxDMLOgvsYffttitekPJbQwrzod3kZUT11
X-Received: by 2002:a1c:e915:0:b0:3fb:b5dc:dab1 with SMTP id
 q21-20020a1ce915000000b003fbb5dcdab1mr11486440wmc.39.1689030291890; 
 Mon, 10 Jul 2023 16:04:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHcsOQcBI8OYETib//Ak0I4t52L+vCBxsvExkrcBMFu4ukf+sVc30LL7gnHgJPlFF9oSy83nQ==
X-Received: by 2002:a1c:e915:0:b0:3fb:b5dc:dab1 with SMTP id
 q21-20020a1ce915000000b003fbb5dcdab1mr11486421wmc.39.1689030291518; 
 Mon, 10 Jul 2023 16:04:51 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 f18-20020a7bcd12000000b003fa999cefc0sm919598wmj.36.2023.07.10.16.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:04:51 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:04:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 50/66] include: attempt to document device_class_set_props
Message-ID: <e57fc3dec9508cfa81c1bedcaa6b7469995ac6a5.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
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

From: Alex Bennée <alex.bennee@linaro.org>

I'm still not sure how I achieve by use case of the parent class
defining the following properties:

  static Property vud_properties[] = {
      DEFINE_PROP_CHR("chardev", VHostUserDevice, chardev),
      DEFINE_PROP_UINT16("id", VHostUserDevice, id, 0),
      DEFINE_PROP_UINT32("num_vqs", VHostUserDevice, num_vqs, 1),
      DEFINE_PROP_END_OF_LIST(),
  };

But for the specialisation of the class I want the id to default to
the actual device id, e.g.:

  static Property vu_rng_properties[] = {
      DEFINE_PROP_UINT16("id", VHostUserDevice, id, VIRTIO_ID_RNG),
      DEFINE_PROP_UINT32("num_vqs", VHostUserDevice, num_vqs, 1),
      DEFINE_PROP_END_OF_LIST(),
  };

And so far the API for doing that isn't super clear.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230710153522.3469097-2-alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/qdev-core.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 06cadfc492..196ebf6d91 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -926,6 +926,15 @@ BusState *sysbus_get_default(void);
 char *qdev_get_fw_dev_path(DeviceState *dev);
 char *qdev_get_own_fw_dev_path_from_handler(BusState *bus, DeviceState *dev);
 
+/**
+ * device_class_set_props(): add a set of properties to an device
+ * @dc: the parent DeviceClass all devices inherit
+ * @props: an array of properties, terminate by DEFINE_PROP_END_OF_LIST()
+ *
+ * This will add a set of properties to the object. It will fault if
+ * you attempt to add an existing property defined by a parent class.
+ * To modify an inherited property you need to use????
+ */
 void device_class_set_props(DeviceClass *dc, Property *props);
 
 /**
-- 
MST



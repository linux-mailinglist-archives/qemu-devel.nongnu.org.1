Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A16774E1A4
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:03:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzu0-0002q1-5W; Mon, 10 Jul 2023 19:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzty-0002pZ-1q
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:02:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIztw-000478-MT
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jZcq1DYmpi4vNgb1KecH/E6OuJO5OkwSaIFJsUnElEQ=;
 b=DJEomSBFV3Nd5+Tvxl2snBAW7YaM6tKi4H9ZY/q2ej/ypTNFOsavkMWyTREoJc3CETm476
 dvEKyUk0T67qluHz04T23JHz9HN3jzmEGUNvMU7gfQoSZo3T+xUemKnjdPzF9XTT84Svw2
 4OlHSOLBpUyuHRQrojJO3FPwb1JahMo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137--YE-EWcVMdm4yPVaa40PSA-1; Mon, 10 Jul 2023 19:02:38 -0400
X-MC-Unique: -YE-EWcVMdm4yPVaa40PSA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-313c930ee0eso2725106f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030157; x=1691622157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZcq1DYmpi4vNgb1KecH/E6OuJO5OkwSaIFJsUnElEQ=;
 b=H600q21LA/f1tyR5JQ382LQbcqzEASZUjJUcC0x5VCaXA+8aQSlIwKdCT1HkUQhf/3
 5yCpGKyHZQXwz9fTf8fheTAfYOVJEQgtMUV8BF7+ZrUMtVnbhkZ0tOQaH6+2pWHnuWq9
 hSbvmHhRbALXR3gGyuSX5dj2ExnXGViZHhrt2iSu6BWqSKsKO7fJc1CBoVcBQkYx6bI0
 4Dxd3Yz/p9URSmCHxwvfxVZihTmiRCd4v4b2yMensZsvIUEf1RYWmmJbPIQHANAPU+ET
 zbT2J7Fy+h9fv9II05nvXyr0vC9LmCDhMbNf7A1iscxO2kSpU6DnPcZ+7gPoR1dpUfdg
 g2ug==
X-Gm-Message-State: ABy/qLYArrM6hHTr1P4cqYZzf/r4lU32FZkBMn08LbOFedHttDaQtlRL
 Hb11hx9xm+nRfc9QU+4yoWJI8XgGVH6nXpqP7b3zKLn8WPM8zmC12EjlDsQ1FrD04FX/IqyNVOJ
 79B8amttWlH0fwFLG9y7/7cUPzlbew9JSOw6TfDy51ssfvr5IzQOkFYQ/5+EsO38jXuZo
X-Received: by 2002:a5d:428c:0:b0:311:db0:8aff with SMTP id
 k12-20020a5d428c000000b003110db08affmr10914590wrq.70.1689030157084; 
 Mon, 10 Jul 2023 16:02:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlECt2IhUizJKTo9wXXS7xdGmHGqTODkkBnz/UTzcEJNFDoxmEdtuJ0V3bmZQMhTIYQcILEY4g==
X-Received: by 2002:a5d:428c:0:b0:311:db0:8aff with SMTP id
 k12-20020a5d428c000000b003110db08affmr10914575wrq.70.1689030156867; 
 Mon, 10 Jul 2023 16:02:36 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 z8-20020adff1c8000000b003141e86e751sm611531wro.5.2023.07.10.16.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:02:36 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:02:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Viktor Prutyanov <viktor@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 03/66] virtio-net: pass Device-TLB enable/disable events to
 vhost
Message-ID: <cd9b8346884353ba9ae6560b44b7cccdf00a6633.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From: Viktor Prutyanov <viktor@daynix.com>

If vhost is enabled for virtio-net, Device-TLB enable/disable events
must be passed to vhost for proper IOMMU unmap flag selection.

Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20230626091258.24453-3-viktor@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 04783f5b94..d51067123b 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3951,6 +3951,7 @@ static void virtio_net_class_init(ObjectClass *klass, void *data)
     vdc->vmsd = &vmstate_virtio_net_device;
     vdc->primary_unplug_pending = primary_unplug_pending;
     vdc->get_vhost = virtio_net_get_vhost;
+    vdc->toggle_device_iotlb = vhost_toggle_device_iotlb;
 }
 
 static const TypeInfo virtio_net_info = {
-- 
MST



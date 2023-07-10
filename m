Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4F874DEFE
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 22:16:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIxIU-0001U6-D8; Mon, 10 Jul 2023 16:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIxIR-0001TK-Hh
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 16:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIxIQ-0005ed-03
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 16:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689020144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v5Pv3CgfzkkT7rilm0tBJGNo2aPft2S9/Hpo6fIjjks=;
 b=jCnvR7nVxii1QdI5QVbitT04GKuho4WUzGFTpAw7KE0q5zK5QsybLTBR8amIS7MxxNZO9F
 SO7CTfCf/504BUaQ+VpnHuaEFDkkdnzW5XqchEtxVg26IHVfy2FuM1NJXf2wsIvqCUclVd
 ojVMsQQrsOdVqkfzovKXxO3zx60hGOE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-hxeWbv_uMbWwoubFecZZAA-1; Mon, 10 Jul 2023 16:15:43 -0400
X-MC-Unique: hxeWbv_uMbWwoubFecZZAA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fbb0c01e71so29194515e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 13:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689020142; x=1691612142;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v5Pv3CgfzkkT7rilm0tBJGNo2aPft2S9/Hpo6fIjjks=;
 b=REahznP4ie9EsaO27thhZmMZccNWOii9IMCDarb+D5T3Uq0yhr1hBuJka4hPfe/cSS
 q7W2HZyPgwiXa01QJqS2cw9IxqdRG6JqC7vBHEJO9e3arH0OQK7guNuGygXyTnkunbiY
 ESCYkJtR5HRmlRYpp9utCdlpgHzdO5DIxDWRBinEmhvNnSo/r7KjZwm1bcKl3vLGXf9Z
 G1Od3ngCdnIB/f/TyX1s9fCu9XuykEz8U7AJSZJngK7KQ+1/9IX7oEQ8agePBufzRahl
 rrb66wZJ8Bz6GT0oxoi+euwHBiHK6IWeBdwkb2ocbzv4xq1ZdC0tMwkwGQHa0QAeoYfi
 jAWg==
X-Gm-Message-State: ABy/qLbcEf/irill/IzE+iuUvNOpokzbmjWGpKF0ZMHLNJFPN6RxdOTD
 ntnhhN2ZrF0YRoCU4XUQRA+/HNcOx/ivFl+nehM1upybCDfPYMGlGk0ncNby015ofLUjakUIdOR
 0ObeplYUD0JWQMYo=
X-Received: by 2002:a1c:7c17:0:b0:3fb:4055:1ddd with SMTP id
 x23-20020a1c7c17000000b003fb40551dddmr11146630wmc.28.1689020142142; 
 Mon, 10 Jul 2023 13:15:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFtNsi5W/l7Zk9a1yx4fr6PdSypvrsDJWFK9gzoFUju1iodVJkQ710XHJE8LF+dgVUtXekE5Q==
X-Received: by 2002:a1c:7c17:0:b0:3fb:4055:1ddd with SMTP id
 x23-20020a1c7c17000000b003fb40551dddmr11146614wmc.28.1689020141814; 
 Mon, 10 Jul 2023 13:15:41 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 18-20020a05600c025200b003fbca942499sm11105118wmj.14.2023.07.10.13.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 13:15:41 -0700 (PDT)
Date: Mon, 10 Jul 2023 16:15:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3 07/20] virtio: add vhost-user-base and a generic
 vhost-user-device
Message-ID: <20230710161447-mutt-send-email-mst@kernel.org>
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
 <20230710153522.3469097-8-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710153522.3469097-8-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

> +static const TypeInfo vud_info = {
> +    .name = TYPE_VHOST_USER_DEVICE,
> +    .parent = TYPE_VHOST_USER_BASE,
> +    .instance_size = sizeof(VHostUserBase),
> +    .class_init = vud_class_init,
> +    .class_size = sizeof(VHostUserBaseClass),

I wish you didn't tie the refactoring in with new functionality.
I applied but blocked creating these for now with:

Subject: [PATCH] vhost-user-device: block creating instances
Message-Id: <b10d1e585adf8a5348bd886333a8c55dcdef6048.1689020067.git.mst@redhat.com>

block this until we are ready to commit to this command line.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user-device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-device.c
index 2b028cae08..ded97b6d70 100644
--- a/hw/virtio/vhost-user-device.c
+++ b/hw/virtio/vhost-user-device.c
@@ -369,6 +369,7 @@ static const TypeInfo vud_info = {
     .instance_size = sizeof(VHostUserBase),
     .class_init = vud_class_init,
     .class_size = sizeof(VHostUserBaseClass),
+    .abstract = true
 };

 static void vu_register_types(void)

-- 
MST



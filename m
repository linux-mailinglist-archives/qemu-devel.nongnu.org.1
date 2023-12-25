Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF2D81E186
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 17:08:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHnTe-0000aH-JC; Mon, 25 Dec 2023 11:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rHnTZ-0000a6-Tq
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 11:06:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rHnTX-00052q-Vq
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 11:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703520402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VeJ55kWpoN+pdUQVgNIalBFWlB/CKueS4oXXMOno/Xc=;
 b=Rk9eQGPUCMZQ0IV9oZbS1QtwXnlHK3Zcb/o+5j8BTJSt13GsbSbZSgpncKJTx4fCcROz74
 bn3GjObr5QrDOBE+AHR7ryEqEdhyT5acPLej3g5x8zlJ/rlcD1sKRQ0A0POkELNBQKI4P+
 X0ZDzuHu4ClNNCsPyXUn2LAidNueFQ4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-uu4czPi6M_WEG2U3Sgnnzg-1; Mon, 25 Dec 2023 11:06:40 -0500
X-MC-Unique: uu4czPi6M_WEG2U3Sgnnzg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40d5970422cso3945e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Dec 2023 08:06:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703520399; x=1704125199;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VeJ55kWpoN+pdUQVgNIalBFWlB/CKueS4oXXMOno/Xc=;
 b=Za6lRYdFzjwQ4sM07SQqdMcpRetejgA4LG2QKN7rSoVQ5T22WXmtCEv72CKjnOMopf
 QGdj0aYX4pIVRikPYMuUZ5MUwIfgoxOVrzDNS0QiYyxGHpSmyGDZybho0zlbSddvsdyC
 sS9SXKefxY/kRSqBTs35Br4EQQ9Idkd8VwP0mSe8FRmo4wt3hfjgPL3dwH0ltiHNy7bp
 blJnsmvVNNCtvc9Za8/89RSXSMhVGD4ajFX5z3X4Onim5NTH4Y6zBvdce83d7Xn9NuM0
 ascOXJEajakKJiX7gXIccZGK7t/ZTyq2fj+nv0yPh89ZaAAC9G1CExN7cz7swiZSEz/z
 AlDg==
X-Gm-Message-State: AOJu0Ywx4wx3QSUiAorJAjmo6lBogh7Qbcy3PcktahghOY7sDyN43grC
 +IsT0VmU4TNlewAn2fGLObWhY24s2yZSde4kpiWiJalwceTLPHg1jbsV0161VyCcQEldk4+jcIW
 MxqltyhsXJrtl77aLsbWvQBY=
X-Received: by 2002:a05:600c:4f46:b0:40d:50a7:a62f with SMTP id
 m6-20020a05600c4f4600b0040d50a7a62fmr2696163wmq.50.1703520399438; 
 Mon, 25 Dec 2023 08:06:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKasEn7NL56qEgd9YpefwTItPlDBfXSe8ZRLeY7GDXJmy1d50+PW6Tyc1sDsYCv2y6AahIIg==
X-Received: by 2002:a05:600c:4f46:b0:40d:50a7:a62f with SMTP id
 m6-20020a05600c4f4600b0040d50a7a62fmr2696156wmq.50.1703520399111; 
 Mon, 25 Dec 2023 08:06:39 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a05600c4f1400b003feae747ff2sm10974968wmq.35.2023.12.25.08.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 08:06:38 -0800 (PST)
Date: Mon, 25 Dec 2023 11:06:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Leo Yan <leo.yan@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v3 0/4] virtio: Refactor vhost input stub
Message-ID: <20231225110608-mutt-send-email-mst@kernel.org>
References: <20231120043721.50555-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120043721.50555-1-leo.yan@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.977,
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

On Mon, Nov 20, 2023 at 12:37:17PM +0800, Leo Yan wrote:
> This series is to refactor vhost stub vhost-user-input.
> 
> Since vhost input stub requires set_config() callback for communication
> event configurations between the backend and the guest, patch 01 is a
> preparison for support set_config() callback in vhost-user-base.
> 
> The patch 02 is to add documentation for vhost-user-input.
> 
> The patch 03 is to move virtio input stub from the input folder to the
> virtio folder.

Thanks!
Now the release is out I'd like to apply this - can you please rebase on latest master and
repost?

> The patch 04 derives vhost-user-input from vhost-user-base.  We reuse
> the common code from vhhost-user-base as possible and the input stub is
> simplized significantly.
> 
> This patch set has been tested with the backend daemon:
> 
>   # ./build/contrib/vhost-user-input/vhost-user-input \
> 		     -p /dev/input/event20 -s /tmp/input.sock
> 
> The series is based on "[PATCH v8 0/7] virtio: cleanup
> vhost-user-generic and reduce c&p" which introduces vhost-user-base.
> Based-on: <20231107180752.3458672-1-alex.bennee@linaro.org>
> 
> Changes from v2:
> - Created reference for shared memory object and updated
>   vhost-user-input.rst respectively. (Marc-André)
> 
> Changes from v1:
> - Fixed typo in vhost-user-input.rst.
> - Updated MAINTAINERS for new added input document and
>   changing folder for vhost-user-input.c. (Manos)
> 
> 
> Leo Yan (4):
>   hw/virtio: Support set_config() callback in vhost-user-base
>   docs/system: Add vhost-user-input documentation
>   hw/virtio: Move vhost-user-input into virtio folder
>   hw/virtio: derive vhost-user-input from vhost-user-base
> 
>  MAINTAINERS                              |   3 +-
>  docs/system/device-emulation.rst         |   1 +
>  docs/system/devices/vhost-user-input.rst |  45 ++++++++
>  docs/system/devices/vhost-user.rst       |   4 +-
>  hw/input/meson.build                     |   1 -
>  hw/input/vhost-user-input.c              | 136 -----------------------
>  hw/virtio/meson.build                    |   4 +-
>  hw/virtio/vhost-user-base.c              |  17 +++
>  hw/virtio/vhost-user-input-pci.c         |   3 -
>  hw/virtio/vhost-user-input.c             |  58 ++++++++++
>  include/hw/virtio/virtio-input.h         |   6 +-
>  11 files changed, 132 insertions(+), 146 deletions(-)
>  create mode 100644 docs/system/devices/vhost-user-input.rst
>  delete mode 100644 hw/input/vhost-user-input.c
>  create mode 100644 hw/virtio/vhost-user-input.c
> 
> -- 
> 2.39.2



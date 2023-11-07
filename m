Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4777E383E
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:54:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0ImA-0001hr-AB; Tue, 07 Nov 2023 04:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0Ily-0001gb-3l
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:53:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0Ilv-0007Ue-EE
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699350802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=92eCk32RtdbQ+XVFMfVIMlSjhF/MLLKiZmqB7y0SqCI=;
 b=fBjo6EelWw8R1mrhWVw3yQ2B7Fadk8/Tgz/Sm6hflQ+Ha3a7+oY4cNJT4Haa2BPAeFi4ie
 8+IXZBEMcUkV1uIsF5SRcHiU4EdZX5HyJFCcjrBy11ee4F1aqVxmyWjFfgnj14AXwegcOJ
 HXADRordneabmGFdEfN5cRKyo9ZCicM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-dlM9OiB1PuO0ABeh1NApsQ-1; Tue, 07 Nov 2023 04:53:21 -0500
X-MC-Unique: dlM9OiB1PuO0ABeh1NApsQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4091c9bdb8eso39468005e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 01:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699350799; x=1699955599;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=92eCk32RtdbQ+XVFMfVIMlSjhF/MLLKiZmqB7y0SqCI=;
 b=oa3OBN2fZszpVHF+q0XLPmTkllA5An2IvUmFOS9rsuMwVyudLpbRWAwVIsDpsXwquP
 9MtVQ+11xyrjObL+VvmWR7WhhlkW3JaZNYzoPvrja/GiOe5GaZ8GVCztYhK7cHUBrE0d
 8ZmG8EyKkfiifEyMe3JVrL6FVkM5tYVuq03hL6kX8dMyvsPfHKuWKRHfz/G8iYsTn6P/
 iO+K7oMpHAxWBRcT7EYuS1TTfwIXg8po5jbR7MwPhJEtAu2ZrWBWaSEDEOqKeQGpM6Yl
 NkeUmW1jySaOZuwx2OwD8UrZmuDwOD+SosFO+vM0VZkL7hLxtKt7j+K61uiG9msNwfaZ
 CGcA==
X-Gm-Message-State: AOJu0YyRE/FnZ+KygGAYWQj9LI5QU14SVXjaKbOHHbMOtY5Pj6aaPUob
 Oyb15yyAOU+GY0HVEguDZCsNV82VJ9Z0rdkdQ47IklFBNvDSNVvjTWYUxSyEgD/gp+NB/YCSZLz
 H0kBHnLwGbum1y4ofsa1IP5k=
X-Received: by 2002:a05:600c:3c97:b0:406:5a14:5c1e with SMTP id
 bg23-20020a05600c3c9700b004065a145c1emr2374878wmb.1.1699350799646; 
 Tue, 07 Nov 2023 01:53:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSINkGFwLkbL+HVypBixc8uuyLoovdLt5oiE+2RVqbHbLl2oIr9GnkNfAuLMscABoBId7gMQ==
X-Received: by 2002:a05:600c:3c97:b0:406:5a14:5c1e with SMTP id
 bg23-20020a05600c3c9700b004065a145c1emr2374857wmb.1.1699350799261; 
 Tue, 07 Nov 2023 01:53:19 -0800 (PST)
Received: from redhat.com ([2.55.35.37]) by smtp.gmail.com with ESMTPSA id
 fb14-20020a05600c520e00b0040841e79715sm14673338wmb.27.2023.11.07.01.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 01:53:18 -0800 (PST)
Date: Tue, 7 Nov 2023 04:53:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, virtio-fs@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Erik Schilling <erik.schilling@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v6 0/6] virtio: cleanup vhost-user-generic and reduce c&p
Message-ID: <20231107045207-mutt-send-email-mst@kernel.org>
References: <20231106191515.2801863-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231106191515.2801863-1-alex.bennee@linaro.org>
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

On Mon, Nov 06, 2023 at 07:15:09PM +0000, Alex Bennée wrote:
> A lot of our vhost-user stubs are large chunks of boilerplate that do
> (mostly) the same thing. This series continues the cleanups by
> splitting the vhost-user-base and vhost-user-generic implementations.
> After adding a new vq_size property the rng, gpio and i2c vhost-user
> devices become simple specialisations of the common base defining the
> ID, number of queues and potentially the config handling.
> 
> I've also added Manos' vhost-user-sound while I was at it.

Dropped due to CI failures. Pls make sure this passes gitlab CI.
Also pls ping me after release to help make sure it does not get lost.
Thanks!

> Changes
> -------
> 
> v6
>   - re-base to current master
>   - make vhost-user-device abstract
>   - mention abstractness in docs
> 
> v5
>   - addressing comments and tags
>   - improved the docs
> 
> v4
>   - dropped the F_TRANSPORT work for another series
>   - added vhost-user-sound
> 
> Alex Bennée (5):
>   virtio: split into vhost-user-base and vhost-user-device
>   hw/virtio: derive vhost-user-rng from vhost-user-base
>   hw/virtio: derive vhost-user-gpio from vhost-user-base
>   hw/virtio: derive vhost-user-i2c from vhost-user-base
>   docs/system: add a basic enumeration of vhost-user devices
> 
> Manos Pitsidianakis (1):
>   hw/virtio: add vhost-user-snd and virtio-snd-pci devices
> 
>  docs/system/devices/vhost-user-rng.rst        |   2 +
>  docs/system/devices/vhost-user.rst            |  65 ++-
>  ...{vhost-user-device.h => vhost-user-base.h} |  21 +-
>  include/hw/virtio/vhost-user-gpio.h           |  23 +-
>  include/hw/virtio/vhost-user-i2c.h            |  14 +-
>  include/hw/virtio/vhost-user-rng.h            |  11 +-
>  include/hw/virtio/vhost-user-snd.h            |  26 ++
>  hw/virtio/vhost-user-base.c                   | 345 +++++++++++++++
>  hw/virtio/vhost-user-device-pci.c             |  10 +-
>  hw/virtio/vhost-user-device.c                 | 337 +--------------
>  hw/virtio/vhost-user-gpio.c                   | 406 +-----------------
>  hw/virtio/vhost-user-i2c.c                    | 272 +-----------
>  hw/virtio/vhost-user-rng.c                    | 278 +-----------
>  hw/virtio/vhost-user-snd-pci.c                |  75 ++++
>  hw/virtio/vhost-user-snd.c                    |  67 +++
>  hw/virtio/Kconfig                             |   5 +
>  hw/virtio/meson.build                         |  23 +-
>  17 files changed, 690 insertions(+), 1290 deletions(-)
>  rename include/hw/virtio/{vhost-user-device.h => vhost-user-base.h} (71%)
>  create mode 100644 include/hw/virtio/vhost-user-snd.h
>  create mode 100644 hw/virtio/vhost-user-base.c
>  create mode 100644 hw/virtio/vhost-user-snd-pci.c
>  create mode 100644 hw/virtio/vhost-user-snd.c
> 
> -- 
> 2.39.2



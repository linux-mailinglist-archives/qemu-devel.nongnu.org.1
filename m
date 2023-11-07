Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 391A67E47F4
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:12:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QYL-0008Bv-UH; Tue, 07 Nov 2023 13:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0QYJ-0007zg-SS
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:11:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0QYG-0002x8-Tc
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699380708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P7hAPpseBnRUOJBjicas994sjMsCUc350pKfgKHGg7o=;
 b=c/MRIocjfuaCFykPbDQAAvPj4rm02VEzo0cxATwhwEpI5sHLOR/nF3Kn8VKIIFuYF5EZgP
 iXSI0zey4+/XFLCUBhH6KBt7kcNFXj+61+5AQ1jGUIe5QgLUhIZeIuRMxOuyF7EMfwLI9d
 vSNQ9h6FRcEYkVGoCqFTHqAeYeGf6VY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-FuaihF8yOoOu6ZYR76lXyA-1; Tue, 07 Nov 2023 13:11:46 -0500
X-MC-Unique: FuaihF8yOoOu6ZYR76lXyA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32fb7de8611so2087933f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:11:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380704; x=1699985504;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P7hAPpseBnRUOJBjicas994sjMsCUc350pKfgKHGg7o=;
 b=GiINt+bFCPKJltG8MDvuXfmkZwf9IlF0ieePRe88c3xIOoNJ3CDcVxoPxDkhyeHaw+
 VBVAvZkRR4B3rlPdqgj4uzi3mQaxpggdh6QqJyl6as1tOkjx60U6XcmvGkM0ylyg+5c+
 OHRV1RyPCV3oR6PgVSTq+SfkSon6pWxycj28/COl6AG9i43JYec5jU/tByeUoHKi5iwF
 aAw0s7SxHrYClwi/8xcjuCexpKeTQfKTBy9WgHFWfmx15rwhxxSvuzG+2ogiOhb/cBL2
 0twExYLj8MCE8gRn8AXuyKVPxAf7+DgL2rrGnJS9EhbmsGg863ErrQmRgM3KXVXxLFaS
 wPdA==
X-Gm-Message-State: AOJu0YzxouuQjNC13jNTctUvApiXBCl9n9AQYMytNtSwV6FUVBFZytdN
 j09QAHqHrIC0+88efvv0IfVxqdmA5F07w1onv/iUuEL8V3niuSFSAEBaa5eQw+zBvP1ZCkhNmHt
 kiVUZMkXmGj9AMgk=
X-Received: by 2002:adf:e0d0:0:b0:32d:81fe:7104 with SMTP id
 m16-20020adfe0d0000000b0032d81fe7104mr22143097wri.63.1699380704340; 
 Tue, 07 Nov 2023 10:11:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+xo1q4iEiWHq+oM0NTfnDo6s+wfw65nApNhsdevVWmvYjqDWj4HLAvcjWkSL5O2Xc3lPeBw==
X-Received: by 2002:adf:e0d0:0:b0:32d:81fe:7104 with SMTP id
 m16-20020adfe0d0000000b0032d81fe7104mr22143062wri.63.1699380703957; 
 Tue, 07 Nov 2023 10:11:43 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f1:373a:140:63a8:a31c:ab2a])
 by smtp.gmail.com with ESMTPSA id
 o15-20020adfcf0f000000b003296b488961sm2968685wrj.31.2023.11.07.10.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:11:43 -0800 (PST)
Date: Tue, 7 Nov 2023 13:11:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, virtio-fs@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v8 0/7] virtio: cleanup vhost-user-generic and reduce c&p
Message-ID: <20231107131107-mutt-send-email-mst@kernel.org>
References: <20231107180752.3458672-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231107180752.3458672-1-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Nov 07, 2023 at 06:07:45PM +0000, Alex Bennée wrote:
> A lot of our vhost-user stubs are large chunks of boilerplate that do
> (mostly) the same thing. This series continues the cleanups by
> splitting the vhost-user-base and vhost-user-generic implementations.
> After adding a new vq_size property the rng, gpio and i2c vhost-user
> devices become simple specialisations of the common base defining the
> ID, number of queues and potentially the config handling.
> 
> I've also added Manos' vhost-user-sound while I was at it.
> 
> Changes
> -------
> 
> v8
>   - scrubbed errant Message-Id

did you pass this by checkpatch btw? there were some warnings on v6.

> v7
>   - various review comments
>   - move to async teardown (fixes CI failure)
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
> Alex Bennée (6):
>   virtio: split into vhost-user-base and vhost-user-device
>   hw/virtio: convert vhost-user-base to async shutdown
>   hw/virtio: derive vhost-user-rng from vhost-user-base
>   hw/virtio: derive vhost-user-gpio from vhost-user-base
>   hw/virtio: derive vhost-user-i2c from vhost-user-base
>   docs/system: add a basic enumeration of vhost-user devices
> 
> Manos Pitsidianakis (1):
>   hw/virtio: add vhost-user-snd and virtio-snd-pci devices
> 
>  MAINTAINERS                                   |  13 +
>  docs/system/devices/vhost-user-rng.rst        |   2 +
>  docs/system/devices/vhost-user.rst            |  70 ++-
>  ...{vhost-user-device.h => vhost-user-base.h} |  21 +-
>  include/hw/virtio/vhost-user-gpio.h           |  25 +-
>  include/hw/virtio/vhost-user-i2c.h            |  14 +-
>  include/hw/virtio/vhost-user-rng.h            |  13 +-
>  include/hw/virtio/vhost-user-snd.h            |  24 ++
>  hw/virtio/vhost-user-base.c                   | 354 +++++++++++++++
>  hw/virtio/vhost-user-device-pci.c             |  13 +-
>  hw/virtio/vhost-user-device.c                 | 338 +--------------
>  hw/virtio/vhost-user-gpio.c                   | 406 +-----------------
>  hw/virtio/vhost-user-i2c.c                    | 272 +-----------
>  hw/virtio/vhost-user-rng.c                    | 278 +-----------
>  hw/virtio/vhost-user-snd-pci.c                |  75 ++++
>  hw/virtio/vhost-user-snd.c                    |  67 +++
>  hw/virtio/Kconfig                             |   5 +
>  hw/virtio/meson.build                         |  23 +-
>  18 files changed, 719 insertions(+), 1294 deletions(-)
>  rename include/hw/virtio/{vhost-user-device.h => vhost-user-base.h} (71%)
>  create mode 100644 include/hw/virtio/vhost-user-snd.h
>  create mode 100644 hw/virtio/vhost-user-base.c
>  create mode 100644 hw/virtio/vhost-user-snd-pci.c
>  create mode 100644 hw/virtio/vhost-user-snd.c
> 
> -- 
> 2.39.2



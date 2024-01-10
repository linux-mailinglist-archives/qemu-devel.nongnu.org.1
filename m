Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B64DB829E48
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 17:14:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNbC5-0005oC-7K; Wed, 10 Jan 2024 11:12:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rNbC4-0005nm-3x
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 11:12:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rNbC2-00086E-HF
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 11:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704903156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NEBxw0HAUx+Yw376hPbAyTeK+8f4xn8fjLHRk88998o=;
 b=TSZjG+NJmxNZxxl8Zrx92462/1qqsu0Gl6NRlJq8TtKPZXJZ+sjGlY4eyq6e+mjh4qGV6K
 Ham+h9pMmIWrUP+CES05fjMDRMbbt3Bajl5fhsEK7hVR/1jw5hC+gOV1KBGcFakrAH2MHg
 w2HnfMENQoWoLCJm3jUlMrspmqRREkg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-dEsvSzyQNuKUjNx6TaPLmw-1; Wed, 10 Jan 2024 11:12:35 -0500
X-MC-Unique: dEsvSzyQNuKUjNx6TaPLmw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33689c90957so2795408f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 08:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704903154; x=1705507954;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NEBxw0HAUx+Yw376hPbAyTeK+8f4xn8fjLHRk88998o=;
 b=HIAjqxMk+ASXz4QIghL5apXiamTxf1M44IgyUWvF7OGqdMSPVr8vLy9L9lQ1lEMItL
 HzzutjemDU3EshwrW15FYuz4SJdi0u73GifzNgyXSwRUIJuDbTvwNyCRS4zBG1fwBEz6
 cPL7/O/+/TbuVX0UvOyycQT389X342hZt38eYDQxHZiTy2oios25rKKmTci2H4rHzPIc
 KBMq3TP7LYwI6gLf+WT4hcZPD0wYDAlIAjpangTD4RFBjKjxQya4j/wcyaVh7FJ5+G9E
 FDopl/KMOiumFh4NVjjHtzyJrt+SFKPDhzytCVoen1Gp/oW1Qyq3ulOSv3bmAq1HDG8A
 I8Mw==
X-Gm-Message-State: AOJu0Yxm6KVa1w1RKVUXbyiX4I0dl98v2ic0LbCkjGamNys3S+THjnkI
 s+ZvXA4iLrM6a921LDpW7hnBkzOSBQcdp1WRKXqJPfsT9We2zR+dD+vbqF9kZbvzQPVGPE4dAlY
 K7/UdAM2qbCw0aueaObgBBSA=
X-Received: by 2002:a05:6000:18c1:b0:336:48fd:3458 with SMTP id
 w1-20020a05600018c100b0033648fd3458mr652205wrq.68.1704903154392; 
 Wed, 10 Jan 2024 08:12:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMZPh8vwCw6ciEGuIHnP5Y3Nz4TA+eqLNHrcUmsmRB/SyvaPhFlVFPx552uWYekmjLkd90Yw==
X-Received: by 2002:a05:6000:18c1:b0:336:48fd:3458 with SMTP id
 w1-20020a05600018c100b0033648fd3458mr652195wrq.68.1704903154033; 
 Wed, 10 Jan 2024 08:12:34 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
 by smtp.gmail.com with ESMTPSA id
 f13-20020adff58d000000b00336d24b4847sm5168068wro.114.2024.01.10.08.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 08:12:33 -0800 (PST)
Date: Wed, 10 Jan 2024 11:12:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jason Wang <jasowang@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, virtio-fs@redhat.com,
 Hanna Reitz <hreitz@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v9 00/11] virtio: cleanup vhost-user-generic and reduce
 c&p + vhost-user-input
Message-ID: <20240110111217-mutt-send-email-mst@kernel.org>
References: <20240104210945.1223134-1-alex.bennee@linaro.org>
 <87zfxdfofk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zfxdfofk.fsf@draig.linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jan 10, 2024 at 10:55:11AM +0000, Alex Bennée wrote:
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
> > A lot of our vhost-user stubs are large chunks of boilerplate that do
> > (mostly) the same thing. This series continues the cleanups by
> > splitting the vhost-user-base and vhost-user-generic implementations.
> > After adding a new vq_size property the rng, gpio and i2c vhost-user
> > devices become simple specialisations of the common base defining the
> > ID, number of queues and potentially the config handling.
> >
> > I've also added Manos' vhost-user-sound and Leo's vhost-user-input
> > stubs which are based on the same base.
> 
> Ping MST,
> 
> Are you waiting for anything else before pulling this into your queue?

Tagged, thanks!

> >
> > Changes
> > -------
> >
> > v9
> >   - re-base and fix conflicts
> >   - add Leo's vhost-user-input series
> >
> > v8
> >   - scrubbed errant Message-Id
> >
> > v7
> >   - various review comments
> >   - move to async teardown (fixes CI failure)
> >
> > v6
> >   - re-base to current master
> >   - make vhost-user-device abstract
> >   - mention abstractness in docs
> >
> > v5
> >   - addressing comments and tags
> >   - improved the docs
> >
> > v4
> >   - dropped the F_TRANSPORT work for another series
> >   - added vhost-user-sound
> >
> > Alex Bennée (6):
> >   virtio: split into vhost-user-base and vhost-user-device
> >   hw/virtio: convert vhost-user-base to async shutdown
> >   hw/virtio: derive vhost-user-rng from vhost-user-base
> >   hw/virtio: derive vhost-user-gpio from vhost-user-base
> >   hw/virtio: derive vhost-user-i2c from vhost-user-base
> >   docs/system: add a basic enumeration of vhost-user devices
> >
> > Leo Yan (4):
> >   hw/virtio: Support set_config() callback in vhost-user-base
> >   docs/system: Add vhost-user-input documentation
> >   hw/virtio: Move vhost-user-input into virtio folder
> >   hw/virtio: derive vhost-user-input from vhost-user-base
> >
> > Manos Pitsidianakis (1):
> >   hw/virtio: add vhost-user-snd and virtio-snd-pci devices
> >
> >  MAINTAINERS                                   |  16 +-
> >  docs/system/device-emulation.rst              |   1 +
> >  docs/system/devices/vhost-user-input.rst      |  45 ++
> >  docs/system/devices/vhost-user-rng.rst        |   2 +
> >  docs/system/devices/vhost-user.rst            |  72 +++-
> >  ...{vhost-user-device.h => vhost-user-base.h} |  21 +-
> >  include/hw/virtio/vhost-user-gpio.h           |  25 +-
> >  include/hw/virtio/vhost-user-i2c.h            |  14 +-
> >  include/hw/virtio/vhost-user-rng.h            |  13 +-
> >  include/hw/virtio/vhost-user-snd.h            |  24 ++
> >  include/hw/virtio/virtio-input.h              |   6 +-
> >  hw/input/vhost-user-input.c                   | 136 ------
> >  hw/virtio/vhost-user-base.c                   | 371 ++++++++++++++++
> >  hw/virtio/vhost-user-device-pci.c             |  13 +-
> >  hw/virtio/vhost-user-device.c                 | 338 +--------------
> >  hw/virtio/vhost-user-gpio.c                   | 407 +-----------------
> >  hw/virtio/vhost-user-i2c.c                    | 272 +-----------
> >  hw/virtio/vhost-user-input-pci.c              |   3 -
> >  hw/virtio/vhost-user-input.c                  |  58 +++
> >  hw/virtio/vhost-user-rng.c                    | 294 +------------
> >  hw/virtio/vhost-user-snd-pci.c                |  75 ++++
> >  hw/virtio/vhost-user-snd.c                    |  67 +++
> >  hw/input/meson.build                          |   1 -
> >  hw/virtio/Kconfig                             |   5 +
> >  hw/virtio/meson.build                         |  27 +-
> >  25 files changed, 850 insertions(+), 1456 deletions(-)
> >  create mode 100644 docs/system/devices/vhost-user-input.rst
> >  rename include/hw/virtio/{vhost-user-device.h => vhost-user-base.h} (71%)
> >  create mode 100644 include/hw/virtio/vhost-user-snd.h
> >  delete mode 100644 hw/input/vhost-user-input.c
> >  create mode 100644 hw/virtio/vhost-user-base.c
> >  create mode 100644 hw/virtio/vhost-user-input.c
> >  create mode 100644 hw/virtio/vhost-user-snd-pci.c
> >  create mode 100644 hw/virtio/vhost-user-snd.c
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro



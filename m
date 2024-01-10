Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6CF82981F
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 11:56:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNWEy-0003wj-EY; Wed, 10 Jan 2024 05:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rNWEu-0003vC-W6
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 05:55:17 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rNWEs-0007g1-QE
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 05:55:16 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e461c1f5cso35555525e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 02:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704884113; x=1705488913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zBS8DGwa7ubhif8WaC2HFR76cqgOEyGOb+UNXZjhz/U=;
 b=ucUHSiqqcW2ffm76eIiS0/0Mr6iPf1dtCEh1KjAbqNuRMOUXDikn5+SvKv+2DRICgR
 fMNbeP60e8grTAsEvmq7zBkqgATWKxdmfFvPwiHAInf6gqzH3VLEyq5GplHOdDQC0LPN
 MZOXcb9nOG3oo4XP7NRpzVZ78V+6XR8DXA0PDyZt2o96qoU+9LKftrn+kzrTuYaGs4it
 s1QHHvgN7fEqv4mT4o1yvPQ88BeIpSo663FNhK2Ro+TO8kb2P12K+73kU9SgWcTAZOXY
 2AV6fMYg5Ft/uBpNGmKTFoTYbiVHr+4JXeW25NilNSbFwoLB0qz6W2Z9od4+PEVaE07J
 7jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704884113; x=1705488913;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zBS8DGwa7ubhif8WaC2HFR76cqgOEyGOb+UNXZjhz/U=;
 b=IL3J4Fn73B89LZwzHNjr5gptuLn8gly+NYcFdLSomgcS3HpvuA8X1THzvBErFTCta7
 vSKI4syywWUDfovO8keqORUG1ALUvdeJ2Een6J2jR1MjWjFCxIOriPZIqDTPp3z2e7cG
 yCAJsrd1q7hoWIcq6p5v3q2+oRF1/QQ5du1r8FGWLXn+dtdljpplr3iTBPL1HGvdQhQy
 UCwF4U8Vh7Esmf6WGDNgEMwl817yq7GE8YmAtsAAaZjA6QnY4UiW1P/FT0jyUMHSvcBu
 4IVsgWapbgWF3NErRBHpWljJHEYnPGLHUysX6NYB50DD0qwDLXO+RJGlJTyDKMcjbVgb
 d6fg==
X-Gm-Message-State: AOJu0Yw9vidHLir0m8N8kVJdpkU3wM5YMwx2oLQA2O8DQLsheXv25jCC
 95gnIt8B1GG7bVhDeFqDFG/lHojZadveGw==
X-Google-Smtp-Source: AGHT+IH9svXkFAveJ3J83yNOtPQaTZ6pHqlD1nDKe2lUtI6FEQ0KPqSOzdwL7/FyV0GK0podoxgo3g==
X-Received: by 2002:a05:600c:310d:b0:40d:6af2:f965 with SMTP id
 g13-20020a05600c310d00b0040d6af2f965mr331710wmo.106.1704884112782; 
 Wed, 10 Jan 2024 02:55:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 iv17-20020a05600c549100b0040e5034d8e0sm1753168wmb.43.2024.01.10.02.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 02:55:12 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EFE3A5F785;
 Wed, 10 Jan 2024 10:55:11 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,  Mathieu Poirier
 <mathieu.poirier@linaro.org>,  Kevin Wolf <kwolf@redhat.com>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Jason Wang
 <jasowang@redhat.com>,  Erik Schilling <erik.schilling@linaro.org>,  Eric
 Blake <eblake@redhat.com>,  Fam Zheng <fam@euphon.net>,  =?utf-8?Q?Marc-A?=
 =?utf-8?Q?ndr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 virtio-fs@redhat.com,  Hanna Reitz <hreitz@redhat.com>,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,  Daniel P. =?utf-8?Q?Berr?=
 =?utf-8?Q?ang=C3=A9?=
 <berrange@redhat.com>,  qemu-block@nongnu.org,  Markus Armbruster
 <armbru@redhat.com>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Raphael Norwitz
 <raphael.norwitz@nutanix.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,  Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: Re: [PATCH v9 00/11] virtio: cleanup vhost-user-generic and reduce
 c&p + vhost-user-input
In-Reply-To: <20240104210945.1223134-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Thu, 4 Jan 2024 21:09:34 +0000")
References: <20240104210945.1223134-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Wed, 10 Jan 2024 10:55:11 +0000
Message-ID: <87zfxdfofk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> A lot of our vhost-user stubs are large chunks of boilerplate that do
> (mostly) the same thing. This series continues the cleanups by
> splitting the vhost-user-base and vhost-user-generic implementations.
> After adding a new vq_size property the rng, gpio and i2c vhost-user
> devices become simple specialisations of the common base defining the
> ID, number of queues and potentially the config handling.
>
> I've also added Manos' vhost-user-sound and Leo's vhost-user-input
> stubs which are based on the same base.

Ping MST,

Are you waiting for anything else before pulling this into your queue?

>
> Changes
> -------
>
> v9
>   - re-base and fix conflicts
>   - add Leo's vhost-user-input series
>
> v8
>   - scrubbed errant Message-Id
>
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
> Alex Benn=C3=A9e (6):
>   virtio: split into vhost-user-base and vhost-user-device
>   hw/virtio: convert vhost-user-base to async shutdown
>   hw/virtio: derive vhost-user-rng from vhost-user-base
>   hw/virtio: derive vhost-user-gpio from vhost-user-base
>   hw/virtio: derive vhost-user-i2c from vhost-user-base
>   docs/system: add a basic enumeration of vhost-user devices
>
> Leo Yan (4):
>   hw/virtio: Support set_config() callback in vhost-user-base
>   docs/system: Add vhost-user-input documentation
>   hw/virtio: Move vhost-user-input into virtio folder
>   hw/virtio: derive vhost-user-input from vhost-user-base
>
> Manos Pitsidianakis (1):
>   hw/virtio: add vhost-user-snd and virtio-snd-pci devices
>
>  MAINTAINERS                                   |  16 +-
>  docs/system/device-emulation.rst              |   1 +
>  docs/system/devices/vhost-user-input.rst      |  45 ++
>  docs/system/devices/vhost-user-rng.rst        |   2 +
>  docs/system/devices/vhost-user.rst            |  72 +++-
>  ...{vhost-user-device.h =3D> vhost-user-base.h} |  21 +-
>  include/hw/virtio/vhost-user-gpio.h           |  25 +-
>  include/hw/virtio/vhost-user-i2c.h            |  14 +-
>  include/hw/virtio/vhost-user-rng.h            |  13 +-
>  include/hw/virtio/vhost-user-snd.h            |  24 ++
>  include/hw/virtio/virtio-input.h              |   6 +-
>  hw/input/vhost-user-input.c                   | 136 ------
>  hw/virtio/vhost-user-base.c                   | 371 ++++++++++++++++
>  hw/virtio/vhost-user-device-pci.c             |  13 +-
>  hw/virtio/vhost-user-device.c                 | 338 +--------------
>  hw/virtio/vhost-user-gpio.c                   | 407 +-----------------
>  hw/virtio/vhost-user-i2c.c                    | 272 +-----------
>  hw/virtio/vhost-user-input-pci.c              |   3 -
>  hw/virtio/vhost-user-input.c                  |  58 +++
>  hw/virtio/vhost-user-rng.c                    | 294 +------------
>  hw/virtio/vhost-user-snd-pci.c                |  75 ++++
>  hw/virtio/vhost-user-snd.c                    |  67 +++
>  hw/input/meson.build                          |   1 -
>  hw/virtio/Kconfig                             |   5 +
>  hw/virtio/meson.build                         |  27 +-
>  25 files changed, 850 insertions(+), 1456 deletions(-)
>  create mode 100644 docs/system/devices/vhost-user-input.rst
>  rename include/hw/virtio/{vhost-user-device.h =3D> vhost-user-base.h} (7=
1%)
>  create mode 100644 include/hw/virtio/vhost-user-snd.h
>  delete mode 100644 hw/input/vhost-user-input.c
>  create mode 100644 hw/virtio/vhost-user-base.c
>  create mode 100644 hw/virtio/vhost-user-input.c
>  create mode 100644 hw/virtio/vhost-user-snd-pci.c
>  create mode 100644 hw/virtio/vhost-user-snd.c

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C12E37E4902
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 20:11:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0RTZ-0001WQ-DH; Tue, 07 Nov 2023 14:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0RT4-0001JU-RC
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 14:10:32 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0RSn-0006F9-FA
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 14:10:30 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4083dbc43cfso37921065e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 11:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699384212; x=1699989012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EsAsWHgoglABS9HuhBM2l6bMb8EQ+b66cuHbxghwiMs=;
 b=qlOx5sE3X0OoMNeAARkHccHAQQKnUsGnpnyVI+EA+Z6tOgksTshxHN91MG3qecUHc8
 eGkD/Z30imi5wxMvetBDftfVKbUk3KroPzd1wiMThEzn+McY6rXGhJ4v86WCzsxBhRz5
 u433pYDDmxUuBQi+h+A5mjpCJYI/mEHdzWGEDO1EZ3EbIMqmq5+DYPfT1q/9fU0+hza4
 bQdJNaw68GxEKle6fGmzTImTYrnai8Oj00PyIMjPZ5R3bQv4ldsx9nZqZNYobblT6uyI
 YPQOsFrqooiTNwmj6dLej4l322U6NUzfBarW2Vhj3JHtnKpzujf7wNc9eEV6v7WciDnX
 zT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699384212; x=1699989012;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EsAsWHgoglABS9HuhBM2l6bMb8EQ+b66cuHbxghwiMs=;
 b=vvivIYZ+p9k4gry4USaDK4NbMKJXorNNBQx1jqT9u2ytwlv67gpUmoqWXXx51neKU4
 2yXgC62JuFFnA5JB5pvt/yA+kLGap7Exsodu8AEQTlHgkXkCtJA01Hq7Z0PIVnsX0vu1
 rrg2yUcUmyXNF9x172j0ff/4dXy6BYDZVUQrd7E6rjydc6nvi/aiECF1qkyHc9Lvtvo2
 tgnCccHvTEG3sZbcAJ0B0VeMu8zgUv987f/alnisHJuq6aXkW8y13hEvfMYUZS5X0SV8
 HMn9rHW/MU2yeePAYWGnCle6N+5SnuzeQM2x4w7pcM5dNAk4pFYWnkUhJkpUp/3HtChq
 C0mA==
X-Gm-Message-State: AOJu0YwJH7lCbwz/UMMVouNm8p6FPNdcOwC0Tf0MH4y+Fke7CTMHOC+b
 kw7Y0YFh4JeSUygaO9K1w0sBbQ==
X-Google-Smtp-Source: AGHT+IGZGAHSdhI5w+svY0snRD1PBdtfN+EO+WQA/mlw028Mhwir+hfQe8GkiZjHBSxVKeJFUn2gzg==
X-Received: by 2002:a05:600c:1c08:b0:401:b6f6:d90c with SMTP id
 j8-20020a05600c1c0800b00401b6f6d90cmr3010703wms.35.1699384211845; 
 Tue, 07 Nov 2023 11:10:11 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q6-20020a05600c2e4600b003feae747ff2sm16178852wmf.35.2023.11.07.11.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 11:10:11 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0DBDF5F790;
 Tue,  7 Nov 2023 19:10:11 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Viresh Kumar
 <viresh.kumar@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Erik Schilling
 <erik.schilling@linaro.org>,  Raphael Norwitz
 <raphael.norwitz@nutanix.com>,  Jason Wang <jasowang@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Markus Armbruster <armbru@redhat.com>,
 virtio-fs@redhat.com,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,  Mathieu Poirier
 <mathieu.poirier@linaro.org>,  Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,  qemu-block@nongnu.org,  "Gonglei
 (Arei)" <arei.gonglei@huawei.com>,  Fam Zheng <fam@euphon.net>,  Kevin
 Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v8 0/7] virtio: cleanup vhost-user-generic and reduce c&p
In-Reply-To: <20231107131107-mutt-send-email-mst@kernel.org> (Michael S.
 Tsirkin's message of "Tue, 7 Nov 2023 13:11:29 -0500 (58 minutes, 13
 seconds ago)")
References: <20231107180752.3458672-1-alex.bennee@linaro.org>
 <20231107131107-mutt-send-email-mst@kernel.org>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Tue, 07 Nov 2023 19:10:11 +0000
Message-ID: <877cmtbcrw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Tue, Nov 07, 2023 at 06:07:45PM +0000, Alex Benn=C3=A9e wrote:
>> A lot of our vhost-user stubs are large chunks of boilerplate that do
>> (mostly) the same thing. This series continues the cleanups by
>> splitting the vhost-user-base and vhost-user-generic implementations.
>> After adding a new vq_size property the rng, gpio and i2c vhost-user
>> devices become simple specialisations of the common base defining the
>> ID, number of queues and potentially the config handling.
>>=20
>> I've also added Manos' vhost-user-sound while I was at it.
>>=20
>> Changes
>> -------
>>=20
>> v8
>>   - scrubbed errant Message-Id
>
> did you pass this by checkpatch btw? there were some warnings on v6.

yes - its checkpatch clean:

  https://gitlab.com/stsquad/qemu/-/jobs/5480800819

>
>> v7
>>   - various review comments
>>   - move to async teardown (fixes CI failure)
>>=20
>> v6
>>   - re-base to current master
>>   - make vhost-user-device abstract
>>   - mention abstractness in docs
>>=20
>> v5
>>   - addressing comments and tags
>>   - improved the docs
>>=20
>> v4
>>   - dropped the F_TRANSPORT work for another series
>>   - added vhost-user-sound
>>=20
>> Alex Benn=C3=A9e (6):
>>   virtio: split into vhost-user-base and vhost-user-device
>>   hw/virtio: convert vhost-user-base to async shutdown
>>   hw/virtio: derive vhost-user-rng from vhost-user-base
>>   hw/virtio: derive vhost-user-gpio from vhost-user-base
>>   hw/virtio: derive vhost-user-i2c from vhost-user-base
>>   docs/system: add a basic enumeration of vhost-user devices
>>=20
>> Manos Pitsidianakis (1):
>>   hw/virtio: add vhost-user-snd and virtio-snd-pci devices
>>=20
>>  MAINTAINERS                                   |  13 +
>>  docs/system/devices/vhost-user-rng.rst        |   2 +
>>  docs/system/devices/vhost-user.rst            |  70 ++-
>>  ...{vhost-user-device.h =3D> vhost-user-base.h} |  21 +-
>>  include/hw/virtio/vhost-user-gpio.h           |  25 +-
>>  include/hw/virtio/vhost-user-i2c.h            |  14 +-
>>  include/hw/virtio/vhost-user-rng.h            |  13 +-
>>  include/hw/virtio/vhost-user-snd.h            |  24 ++
>>  hw/virtio/vhost-user-base.c                   | 354 +++++++++++++++
>>  hw/virtio/vhost-user-device-pci.c             |  13 +-
>>  hw/virtio/vhost-user-device.c                 | 338 +--------------
>>  hw/virtio/vhost-user-gpio.c                   | 406 +-----------------
>>  hw/virtio/vhost-user-i2c.c                    | 272 +-----------
>>  hw/virtio/vhost-user-rng.c                    | 278 +-----------
>>  hw/virtio/vhost-user-snd-pci.c                |  75 ++++
>>  hw/virtio/vhost-user-snd.c                    |  67 +++
>>  hw/virtio/Kconfig                             |   5 +
>>  hw/virtio/meson.build                         |  23 +-
>>  18 files changed, 719 insertions(+), 1294 deletions(-)
>>  rename include/hw/virtio/{vhost-user-device.h =3D> vhost-user-base.h} (=
71%)
>>  create mode 100644 include/hw/virtio/vhost-user-snd.h
>>  create mode 100644 hw/virtio/vhost-user-base.c
>>  create mode 100644 hw/virtio/vhost-user-snd-pci.c
>>  create mode 100644 hw/virtio/vhost-user-snd.c
>>=20
>> --=20
>> 2.39.2

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C687AD8F7
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 15:23:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qklXE-0006Qa-3T; Mon, 25 Sep 2023 09:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qklWx-0006PX-T6; Mon, 25 Sep 2023 09:21:47 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qklWw-0007tG-3M; Mon, 25 Sep 2023 09:21:43 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9ad8bba8125so845491866b.3; 
 Mon, 25 Sep 2023 06:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695648100; x=1696252900; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ysNMILzPVYOhrl9jMt72hsdVVnEZyj7M8ol26jRyUO0=;
 b=Y/iMkYmC4k+hYC9tZrHVFPdEgTzGPcwadi8Hntyk7BiRwMNrg+YRAJAQ2+FdUpgsCm
 hcJsN4l+ci/Mu+xMzbCv8wAEfOAY5wx49zyUMQl5l9wXka5nIJoxtBhxtsklS6V+O7kK
 afzYaDEu2j00URmNa+3yXfZ/dUbwVzlPLSOOq9ww6LxD0ivUq3A4LC5cHYUcgwG1QbtB
 dM2fa58Om3hAjjBxVFT0o0mYz5mCb7+hDOcd5NeCUrr2RHXPNWKzetf/CMgWZMEdE352
 i8he7H0wSz/TW6NwuqmzpakLXdqcFoXLZPCHP6VQ0kxZ6gYzZ77HvR7oMSqMQKQJHRI6
 5ZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695648100; x=1696252900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ysNMILzPVYOhrl9jMt72hsdVVnEZyj7M8ol26jRyUO0=;
 b=qgjXzjBBfe7TUysGh4kYbxxsGibXTYAvzV48PcGiMc8L2MLXTcHFhJHqjY+E0Rg5u7
 3F51ZqmY+0SzrnW22wefAKfSNCAv2P62q3TiyHWZtq1VNX7HWhDhlGf4msHiyxaZNEus
 YX0sFcc371CEJuzKIokGgZreVFqLzzLbHuNVwrimeQB63P+Gci3nzUsCGhNjPCovqkQ0
 IBFX3SUvFu8hdFmzkQPlvjSQe+4b2YCzOIS+vUJW7dbV0uVL5wm3HK7OuWfqFYTs4V9R
 bifQQpMfxny8ZNjj9zftmx8tFO/Uta0WLxG3WnqQuzONu8hnNIFZKWI9pr9NDsdpmIVT
 xKHw==
X-Gm-Message-State: AOJu0YxGGG/8tFLMsCY04AB2plx32sypXZmmEMc0jGsNJsQBgjOF6NyZ
 5RVoLOtQcsHQpR6rSyYHZihhJvLWD/4BkPkCVTo=
X-Google-Smtp-Source: AGHT+IHUOKMxNs8XoVSEK8+b27YRhCkDbjtPeXNTdmXku9UNr/bzPwzK1Yw3qwIkeNq4yKexQ1fnIUBGk0xdqGadriY=
X-Received: by 2002:a05:6402:513:b0:522:31d5:ee8e with SMTP id
 m19-20020a056402051300b0052231d5ee8emr6382298edv.8.1695648098829; Mon, 25 Sep
 2023 06:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230918095313.5492-1-faithilikerun@gmail.com>
 <20230918095313.5492-3-faithilikerun@gmail.com> <87a5tatncj.fsf@pond.sub.org>
In-Reply-To: <87a5tatncj.fsf@pond.sub.org>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 25 Sep 2023 21:21:06 +0800
Message-ID: <CAAAx-8JjXu1QhH40MGUh+TMUwuf+_XU_Zv89_JqFDTHQkk0=-w@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] qcow2: add configurations for zoned format
 extension
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, dmitry.fomichev@wdc.com, 
 Eric Blake <eblake@redhat.com>, dlemoal@kernel.org,
 Hanna Reitz <hreitz@redhat.com>, 
 stefanha@redhat.com, hare@suse.de, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=faithilikerun@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=8825=E6=
=97=A5=E5=91=A8=E4=B8=80 21:05=E5=86=99=E9=81=93=EF=BC=9A
>
> Sam Li <faithilikerun@gmail.com> writes:
>
> > To configure the zoned format feature on the qcow2 driver, it
> > requires settings as: the device size, zone model, zone size,
> > zone capacity, number of conventional zones, limits on zone
> > resources (max append sectors, max open zones, and max_active_zones).
> >
> > To create a qcow2 file with zoned format, use command like this:
> > $ qemu-img create -f qcow2 test.qcow2 -o size=3D768M -o
> > zone_size=3D64M -o zone_capacity=3D64M -o nr_conv_zones=3D0 -o
> > max_append_sectors=3D512 -o max_open_zones=3D0 -o max_active_zones=3D0
> > -o zone_model=3D1
> >
> > Signed-off-by: Sam Li <faithilikerun@gmail.com>
>
> [...]
>
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 2b1d493d6e..2aad82c399 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -5021,6 +5021,27 @@
> >  # @compression-type: The image cluster compression method
> >  #     (default: zlib, since 5.1)
> >  #
> > +# @zone-model: Zoned device model, 1 for host-managed and 0 for
> > +#     non-zoned devices (default: 0, since 8.2)
>
> Shouldn't this be a QAPI enum rather than a number?
>
> > +#
> > +# @zone-size: Total number of logical blocks within zones in bytes
> > +#     (since 8.2)
> > +#
> > +# @zone-capacity: The number of usable logical blocks within zones
> > +#     in bytes.  A zone capacity is always smaller or equal to the
> > +#     zone size. (since 8.2)
> > +#
> > +# @nr-conv-zones: The number of conventional zones of the zoned device
> > +#     (since 8.2)
>
> I still think @conventional-zones would be more obvious.
>
> > +#
> > +# @max-open-zones: The maximal number of open zones (since 8.2)
> > +#
> > +# @max-active-zones: The limit of the zones that have the implicit
> > +#     open, explicit open or closed state (since 8.2)
>
> Maybe "The maximum number of zones in the implicit open, explicit open
> or closed state".
>
> (I'll repeat suggestions until you reject them, just to make sure they
> get ignored by accident)

Thanks for noticing. I will change them (enum, conv, maz) in v5.


>
> > +#
> > +# @max-append-sectors: The maximal number of 512-byte sectors of a zon=
e
> > +#     append request that can be issued to the device. (since 8.2)
> > +#
> >  # Since: 2.12
> >  ##
> >  { 'struct': 'BlockdevCreateOptionsQcow2',
> > @@ -5037,7 +5058,14 @@
> >              '*preallocation':   'PreallocMode',
> >              '*lazy-refcounts':  'bool',
> >              '*refcount-bits':   'int',
> > -            '*compression-type':'Qcow2CompressionType' } }
> > +            '*compression-type':'Qcow2CompressionType',
> > +            '*zone-model':         'uint8',
> > +            '*zone-size':          'size',
> > +            '*zone-capacity':      'size',
> > +            '*nr-conv-zones':      'uint32',
> > +            '*max-open-zones':     'uint32',
> > +            '*max-active-zones':   'uint32',
> > +            '*max-append-sectors': 'uint32' } }
> >
> >  ##
> >  # @BlockdevCreateOptionsQed:
>


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCDF78A878
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 11:07:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaYCX-00049F-Ez; Mon, 28 Aug 2023 05:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qaYCV-00047w-GN; Mon, 28 Aug 2023 05:06:23 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qaYCR-0003Sf-6S; Mon, 28 Aug 2023 05:06:22 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5007f3d3235so4604831e87.2; 
 Mon, 28 Aug 2023 02:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693213573; x=1693818373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lKJj039R/IjaZ/u85a0l/4DgHYZQWYOv8n0mVqv/LQ4=;
 b=r87cYFD9y1rIZbl8CeToGk1aKXAbONn5E2n+k5W9WpQ878qrqxkudt1rwTGTwx1Pwx
 tfmUKNhzXpTplcTrdMZ4OP5mGssuGQiRH9qkqQ6f0tK6w1WmNvZT9usDCCjNTwQW8waA
 y45gn8+nWZJd3Ni3UIAwNZ+j8jU7Cln2MyZ3XcxmexgwDPjlWxdZe/Ol7+wF9XrnSG8p
 cD+UIERHVZjVCrCy4djaPSl3+z5m/MiR8Z12Xtb66HNJxaPLCv9X/kOzMWfPDSTw+oVO
 HWJUt5NpVxWoHMpOG62wrJoPdV5tGB+N5JOSrTsfFBCdgSEgRn8pC5pB651FrqJpld6N
 PX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693213573; x=1693818373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lKJj039R/IjaZ/u85a0l/4DgHYZQWYOv8n0mVqv/LQ4=;
 b=BEEJGcudhlj1lUmc69j6t6HZ0e3OcoKLYOBNmKGekx9gs7PTJLcBrlEzaz/ekrmY3Q
 heIrmjFcqLWJwETdNVmv6s5m1miQXZXRBeSTvTmFQ5ncXrW4gmhoCtdodG+coYY+E2Nf
 cIG/4K/2v3aSMOzwgmSkyXd1LWpUOzVqSagMqRL+yfIvMAF4mtfw6QZxE4YyqPR7wdSs
 Xp3ulgpM02z9fBA1nOBfUavmzT4LcUkVmZDQGaQaXE81Y8MqdA3h5Uq2iZHMr9LB0+fp
 ZzBzw/t5TlVT90yoge0j0WsgesRfgaTc1N7UHCaqHGGOzQ0pwbJ/YtOxhruJSZ8zCac5
 2OQw==
X-Gm-Message-State: AOJu0Yye1n8nM8nGTKCUi5APOli2RjsbyncTcuB3U0i6HF0GOSUnBa4L
 hHomhIAmS5iaJQazPguaVGP9OTf1PXefCfnUC8QdOrZy/iMyMvD/
X-Google-Smtp-Source: AGHT+IENkqVyjw9MGUBvpaQmArZddlbIUkHO6Ora/c93RPvO9tDSh4CGCC+Ya4oN/NcB/XM3CUK+AwKDkjnk0gD8TSM=
X-Received: by 2002:a05:6512:615:b0:4fd:d9dd:7a1a with SMTP id
 b21-20020a056512061500b004fdd9dd7a1amr17222351lfe.31.1693213572056; Mon, 28
 Aug 2023 02:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230814085802.61459-1-faithilikerun@gmail.com>
 <20230814085802.61459-3-faithilikerun@gmail.com> <87wmxobks7.fsf@pond.sub.org>
In-Reply-To: <87wmxobks7.fsf@pond.sub.org>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 28 Aug 2023 17:05:43 +0800
Message-ID: <CAAAx-8KOmqkDJA8Ga9gS4p6hWnwSXSjz8cBrX=vTZkr2psXFVw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] qcow2: add configurations for zoned format
 extension
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, hare@suse.de, Hanna Reitz <hreitz@redhat.com>, 
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Eric Blake <eblake@redhat.com>, stefanha@redhat.com, dlemoal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=faithilikerun@gmail.com; helo=mail-lf1-x130.google.com
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

Markus Armbruster <armbru@redhat.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=B8=80 21:13=E5=86=99=E9=81=93=EF=BC=9A
>
> Sam Li <faithilikerun@gmail.com> writes:
>
> > To configure the zoned format feature on the qcow2 driver, it
> > requires following arguments: the device size, zoned profile,
> > zoned model, zone size, zone capacity, number of conventional
> > zones, limits on zone resources (max append sectors, max open
> > zones, and max_active_zones). The zoned profile option is set
> > to zns when using the qcow2 file as a ZNS drive.
> >
> > To create a qcow2 file with zoned format, use command like this:
> > $ qemu-img create -f qcow2 test.qcow2 -o size=3D768M -o
> > zone_size=3D64M -o zone_capacity=3D64M -o zone_nr_conv=3D0 -o
> > max_append_sectors=3D512 -o max_open_zones=3D0 -o max_active_zones=3D0
> >  -o zoned_profile=3Dzbc/zns
> >
> > Signed-off-by: Sam Li <faithilikerun@gmail.com>
>
> [...]
>
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 2b1d493d6e..0c97ae678b 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -5020,24 +5020,42 @@
> >  #
> >  # @compression-type: The image cluster compression method
> >  #     (default: zlib, since 5.1)
> > +# @zoned-profile: Two zoned device protocol options, zbc or zns
> > +#                 (default: off, since 8.0)
>
> When a 'str' thing accepts a fixed set of (string) values, it most
> likely should be an enum instead.  Have you considered making
> @zoned-profile one?
>
> > +# @zone-size: The size of a zone of the zoned device (since 8.0)
> > +# @zone-capacity: The capacity of a zone of the zoned device (since 8.=
0)
>
> In bytes, I presume?

Yes.

>
> What's the difference between size and capacity?
>

Zone size is the total number of logical blocks within zones in bytes.
Zone capacity is the number of usable logical blocks within zones in
bytes. A zone capacity is always smaller or equal to than zone size.
According to ZBC/ZAC standards, a zone capacity is equal to the zone
size. While in ZNS spec, it can be smaller. I will add the
documentation and below in the next patches.

> > +# @zone-nr-conv: The number of conventional zones of the zoned device
> > +#                (since 8.0)
> > +# @max-open-zones: The maximal allowed open zones (since 8.0)
> > +# @max-active-zones: The limit of the zones that have the implicit ope=
n,
> > +#                    explicit open or closed state (since 8.0)
>
> Naming...  if I understand the comment correctly, then @zone-nr-conv,
> @max-open-zones, and @max-active-zones are all counting zones.  Rename
> @zone-nr-conv to @conventional-zones?
>
> > +# @max-append-sectors: The maximal sectors that is allowed to append w=
rite
>
> I'm not sure I understand the explanation.  Elaborate for me?

The max_append_sector is the maximum data size (in sectors) of a zone
append request that can be successfully issued to the device.  It is a
constraint on the maximum amount of data that can be appended to a
zone in a single request.

>
> > +#                      (since 8.0)
>
> Please format like
>
>    #
>    # @zoned-profile: Two zoned device protocol options, zbc or zns
>    #     (default: off, since 8.0)
>    #
>    # @zone-size: The size of a zone of the zoned device (since 8.0)
>    #
>    # @zone-capacity: The capacity of a zone of the zoned device
>    #     (since 8.0)
>    #
>    # @zone-nr-conv: The number of conventional zones of the zoned device
>    #     (since 8.0)
>    #
>    # @max-open-zones: The maximal allowed open zones (since 8.0)
>    #
>    # @max-active-zones: The limit of the zones that have the implicit
>    #     open, explicit open or closed state (since 8.0)
>    #
>    # @max-append-sectors: The maximal sectors that is allowed to append
>    #     write (since 8.0)
>
> to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
> to conform to current conventions).
>
> >  #
> >  # Since: 2.12
> >  ##
> >  { 'struct': 'BlockdevCreateOptionsQcow2',
> > -  'data': { 'file':             'BlockdevRef',
> > -            '*data-file':       'BlockdevRef',
> > -            '*data-file-raw':   'bool',
> > -            '*extended-l2':     'bool',
> > -            'size':             'size',
> > -            '*version':         'BlockdevQcow2Version',
> > -            '*backing-file':    'str',
> > -            '*backing-fmt':     'BlockdevDriver',
> > -            '*encrypt':         'QCryptoBlockCreateOptions',
> > -            '*cluster-size':    'size',
> > -            '*preallocation':   'PreallocMode',
> > -            '*lazy-refcounts':  'bool',
> > -            '*refcount-bits':   'int',
> > -            '*compression-type':'Qcow2CompressionType' } }
> > +  'data': { 'file':                'BlockdevRef',
> > +            '*data-file':          'BlockdevRef',
> > +            '*data-file-raw':      'bool',
> > +            '*extended-l2':        'bool',
> > +            'size':                'size',
> > +            '*version':            'BlockdevQcow2Version',
> > +            '*backing-file':       'str',
> > +            '*backing-fmt':        'BlockdevDriver',
> > +            '*encrypt':            'QCryptoBlockCreateOptions',
> > +            '*cluster-size':       'size',
> > +            '*preallocation':      'PreallocMode',
> > +            '*lazy-refcounts':     'bool',
> > +            '*refcount-bits':      'int',
> > +            '*compression-type':   'Qcow2CompressionType',
>
> I'd keep the existing lines unchanged.  Not a demand.
>
> > +            '*zoned-profile':      'str',
> > +            '*zone-size':          'size',
> > +            '*zone-capacity':      'size',
> > +            '*zone-nr-conv':       'uint32',
> > +            '*max-open-zones':     'uint32',
> > +            '*max-active-zones':   'uint32',
> > +            '*max-append-sectors': 'uint32'}}
>
> Keep the spaces around the } for consistency.  Yes, they're kind of
> ugly.

Thanks!

>
> >
> >  ##
> >  # @BlockdevCreateOptionsQed:
>


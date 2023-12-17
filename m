Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BD6815CD6
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 01:32:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEf3q-0000L3-3N; Sat, 16 Dec 2023 19:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rEf3n-0000Km-Au; Sat, 16 Dec 2023 19:31:11 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rEf3l-0006o7-AB; Sat, 16 Dec 2023 19:31:10 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40c6a71e88cso23678735e9.0; 
 Sat, 16 Dec 2023 16:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702773028; x=1703377828; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YlK/WE4CmftcJifCxWtg/KO2TCvZZRqHHZWItFqWGEc=;
 b=N31Eo8NeSr0IDX+dRezvz895EgMwnQ7TAtYxFz8V2bAFvyH4efcCUc5iueOzAXkAOU
 mjflhw1hjj6WD9I4mYRjFa26oNnb18NhZyyA/504kqIOlBo7fVTuFXcpX4uWxqSJPHAL
 BFtWfaPKMpaPl+NLqrB4Aoc3wMnp+KY1k5/jvhdBdiY5mv3T4ICr7aw+l4b2SGNh4nXT
 1cif8WOmNHvRN+hl+zd01YM8RSK9Oq7fiJOX9rY2/RjCX5+IDVVRydNFgeLk6F7JPw1u
 YmHARMJdnbQcbCjMijP8aB3/Fs9ZaA6sflbjZiK9lWoYStgIhX6mpKW2b+C68Phw85fG
 0fiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702773028; x=1703377828;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YlK/WE4CmftcJifCxWtg/KO2TCvZZRqHHZWItFqWGEc=;
 b=n4PRgenx3bolgP7tpN0a0Ih37eO6M0//3+QqLd4ym9ATj0U/+hUZBnTLTuMU6N0QdJ
 AgKQWR08iQKwd5WSNa8Twkbv0zrp/N13smVU3TYcHM1Lhy4msWyLrt9jK1iKkq8TQZSm
 QDC0oGGQ+4dZ1G+siGQ2zEzKxH6QvrULJ8024qFr2LiuZEElngVxhCCORBZogfiHZWDf
 LCbEX/iLpZNl14V9DGy/lslZeMvdwvUZZX6AEnlMl+22mT+dNNwdLQJ32S7L+HxURI6T
 KncenMjlr58PurtlLyH0D820YnDs8u67Hnp2Bof6ccdyd/d+HtHOVT0lNDgShV/U2l1S
 EJVA==
X-Gm-Message-State: AOJu0YwB5UcffY9kfE2HSwdwEqomneD1qac5N5iL9Heg2TeX/fJnmd+A
 fsn/MzhEqFKIErsUPq5mlcy9CHKhcn9wXYRR12M=
X-Google-Smtp-Source: AGHT+IEQb0Jq89uDYQbhpDVdSeUQYj0x5Id8QaNB6QCTGK1KjFaItSODGQ9wAwun8+uPymKW/kMuvAzyy2TwlMYqmRk=
X-Received: by 2002:a05:600c:4e0d:b0:40c:3f87:32df with SMTP id
 b13-20020a05600c4e0d00b0040c3f8732dfmr7354716wmq.35.1702773027412; Sat, 16
 Dec 2023 16:30:27 -0800 (PST)
MIME-Version: 1.0
References: <20231127043703.49489-1-faithilikerun@gmail.com>
 <20231127043703.49489-3-faithilikerun@gmail.com> <87bkbbeis6.fsf@pond.sub.org>
In-Reply-To: <87bkbbeis6.fsf@pond.sub.org>
From: Sam Li <faithilikerun@gmail.com>
Date: Sun, 17 Dec 2023 01:30:00 +0100
Message-ID: <CAAAx-8LReW-U5omAzVckymtwNB_sWDMebqJYyDyGm344r9WpcA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] qcow2: add configurations for zoned format
 extension
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, dmitry.fomichev@wdc.com, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, dlemoal@kernel.org, hare@suse.de, 
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com,
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=faithilikerun@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Markus Armbruster <armbru@redhat.com> =E4=BA=8E2023=E5=B9=B411=E6=9C=8830=
=E6=97=A5=E5=91=A8=E5=9B=9B 09:40=E5=86=99=E9=81=93=EF=BC=9A
>
> Sam Li <faithilikerun@gmail.com> writes:
>
> > To configure the zoned format feature on the qcow2 driver, it
> > requires settings as: the device size, zone model, zone size,
> > zone capacity, number of conventional zones, limits on zone
> > resources (max append bytes, max open zones, and max_active_zones).
> >
> > To create a qcow2 image with zoned format feature, use command like
> > this:
> > $path/to/qemu-img create -f qcow2 zbc.qcow2 -o size=3D768M
>
> I'd omit $path/to/
>
> > -o zone.size=3D64M -o zone.capacity=3D64M -o zone.conventional_zones=3D=
0
> > -o zone.max_append_bytes=3D4096 -o zone.max_open_zones=3D10
> > -o zone.max_active_zones=3D12 -o zone.mode=3Dhost-managed
>
> Suggest to add \ like this:
>
>   qemu-img create -f qcow2 zbc.qcow2 -o size=3D768M \
>   -o zone.size=3D64M -o zone.capacity=3D64M -o zone.conventional_zones=3D=
0 \
>   -o zone.max_append_bytes=3D4096 -o zone.max_open_zones=3D10 \
>   -o zone.max_active_zones=3D12 -o zone.mode=3Dhost-managed
>
> >
> > Signed-off-by: Sam Li <faithilikerun@gmail.com>
>
> [...]
>
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index ca390c5700..ef98dc83a0 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -5038,6 +5038,64 @@
> >  { 'enum': 'Qcow2CompressionType',
> >    'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
> >
> > +##
> > +# @Qcow2ZoneModel:
> > +#
> > +# Zoned device model used in qcow2 image file
> > +#
> > +# @host-managed: host-managed model only allows sequential write over =
the
>
> Suggest "the host-managed model ..."
>
> > +#     device zones
> > +#
> > +# Since 8.2
> > +##
> > +{ 'enum': 'Qcow2ZoneModel',
> > +  'data': [ 'host-managed'] }
> > +
> > +##
> > +# @Qcow2ZoneHostManaged:
> > +#
> > +# The host-managed zone model.  It only allows sequential writes.
> > +#
> > +# @size: Total number of bytes within zones
> > +#
> > +# @capacity: The number of usable logical blocks within zones
> > +#     in bytes.  A zone capacity is always smaller or equal to the
> > +#     zone size
> > +#
> > +# @conventional-zones: The number of conventional zones of the
> > +#     zoned device
> > +#
> > +# @max-open-zones: The maximal number of open zones
> > +#
> > +# @max-active-zones: The maximal number of zones in the implicit
> > +#     open, explicit open or closed state
> > +#
> > +# @max-append-bytes: The maximal number of bytes of a zone
> > +#     append request that can be issued to the device.  It must be
> > +#     512-byte aligned
>
> Missing period at the end.
>
> For all the optional members: what's the default?

The default for optional members is 0. When max-open-zones and
max-active-zones are 0, it implies no limit on zone resources.

>
> > +#
> > +# Since 8.2
> > +##
> > +{ 'struct': 'Qcow2ZoneHostManaged',
> > +  'data': { '*size':          'size',
> > +            '*capacity':      'size',
> > +            '*conventional-zones': 'uint32',
> > +            '*max-open-zones':     'uint32',
> > +            '*max-active-zones':   'uint32',
> > +            '*max-append-bytes':   'uint32' } }
>
> Why isn't @max-append-bytes 'size'?  It's a byte count...
>
> > +
> > +##
> > +# @Qcow2ZoneCreateOptions:
> > +#
> > +# The zone device model for the qcow2 image.
> > +#
> > +# Since 8.2
> > +##
> > +{ 'union': 'Qcow2ZoneCreateOptions',
> > +  'base': { 'mode': 'Qcow2ZoneModel' },
> > +  'discriminator': 'mode',
> > +  'data': { 'host-managed': 'Qcow2ZoneHostManaged' } }
> > +
> >  ##
> >  # @BlockdevCreateOptionsQcow2:
> >  #
> > @@ -5080,6 +5138,8 @@
> >  # @compression-type: The image cluster compression method
> >  #     (default: zlib, since 5.1)
> >  #
> > +# @zone: @Qcow2ZoneCreateOptions.  The zone device model modes (since =
8.2)
>
> Don't put the type into the description like that, because it comes out
> like
>
>     "zone": "Qcow2ZoneCreateOptions" (optional)
>        "Qcow2ZoneCreateOptions".  The zone device model modes (since 8.2)
>
> in formatted documentation.
>
> Let's spell out the default: the device is not zoned.
>
> > +#
> >  # Since: 2.12
> >  ##
> >  { 'struct': 'BlockdevCreateOptionsQcow2',
> > @@ -5096,7 +5156,8 @@
> >              '*preallocation':   'PreallocMode',
> >              '*lazy-refcounts':  'bool',
> >              '*refcount-bits':   'int',
> > -            '*compression-type':'Qcow2CompressionType' } }
> > +            '*compression-type':'Qcow2CompressionType',
> > +            '*zone':            'Qcow2ZoneCreateOptions' } }
> >
> >  ##
> >  # @BlockdevCreateOptionsQed:
>


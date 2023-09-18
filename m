Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D2C7A4B55
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:53:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFcS-0001kF-Jf; Mon, 18 Sep 2023 10:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qiFcC-0001hd-Vd; Mon, 18 Sep 2023 10:52:45 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qiFc9-0004nP-Ju; Mon, 18 Sep 2023 10:52:44 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so617301966b.0; 
 Mon, 18 Sep 2023 07:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695048759; x=1695653559; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=laPw1fRYqDkgU80JmAa+Y1RT+CAGTbopP/xitJ/SJi0=;
 b=mLsuxLItUS/6+wx+bFQD2ccDT4WQRthRMsSiR/6EAzcGJots7lkbuwurKfcub5PSD8
 RPec13NzbJosHVlI5x7LgCujfd1JbRuYcOZl6mDQ1WLn0jrsjSNmb9vhG6FEPxyfaQng
 YfD366EtC3ZViPO/s6KQcg+e6pXwFfiwmGXjs38NWIX++2bnxRRIVqkd7CAynRu+0zWa
 fdgL6zAvg35kmb56TO0Dy/Oatx5Apx7psKJFrQIkD9VO/7ME5LaDdhDc0cP/YxJgrckO
 /ooEeeM82gEhmNRkzLIRcyGDonWOfzljNoczDZPO2uAiRe6PNqX/d4rRRLRnSAIE6ryE
 8F1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695048759; x=1695653559;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=laPw1fRYqDkgU80JmAa+Y1RT+CAGTbopP/xitJ/SJi0=;
 b=pupy2VaAsbTtw/Ku8AndBlWIi0BvvmKa9LDuqLpEySPg9lB/wV7moyYtWjZuKrpk3D
 eMSa5+l85wzxb3CZ2dPmwaehpMHv5AVgheDi33OdAWq9qPx9HY9EItHFOPeiJveCEfI7
 uTY40NOIyeaqd1YOV7AZ5RN1CHKrRO1p4LpdBUiSwRWSh9kt8LMLWZ1r8E5qn6oX4P8n
 pY//ERAO+xzhyvoK+8SMqdUZltSdhoz7Utqpap0jCT+C5EQzYw/d4ZS0B5GGxVCGrog1
 poqXN6V2cHYNUFTcPvTCUXEqOuAO34TKT8zOAzgCkqFi4nDZsgIVozyadCrPPXIhAc/v
 r5Hg==
X-Gm-Message-State: AOJu0Yx4IXJc7Y6edQIEJka3wtYuNp8L0jzJZEROdRR4TUwL3X9PUPHN
 WfJ6H5PtlckPj4BJ52foJkOyKJCTFtY+hc0DrgY=
X-Google-Smtp-Source: AGHT+IEixYS+pbTMImfqxsJo4jpi9iskdNfDzmUU7qxZ1t5+c7s+nm45bNmKRPIPmqmFW0ABc4lkYXhc28+9p9xIasw=
X-Received: by 2002:a17:907:7856:b0:9a1:edfd:73b2 with SMTP id
 lb22-20020a170907785600b009a1edfd73b2mr7675802ejc.2.1695048758722; Mon, 18
 Sep 2023 07:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230828150955.3481-1-faithilikerun@gmail.com>
 <20230828150955.3481-3-faithilikerun@gmail.com> <875y4ugnhs.fsf@pond.sub.org>
 <CAAAx-8Lf1FrJ52+=8=t4qKwA2HevYq0PToSQuXtQ9HBsbxbUzA@mail.gmail.com>
 <875y47czdx.fsf@pond.sub.org>
In-Reply-To: <875y47czdx.fsf@pond.sub.org>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 18 Sep 2023 22:52:10 +0800
Message-ID: <CAAAx-8JZctx5_HUOh6Ur-ttPNOBGebBitH=5Zw2iC-e0jw9xbA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] qcow2: add configurations for zoned format
 extension
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 dmitry.fomichev@wdc.com, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>, hare@suse.de, 
 qemu-block@nongnu.org, stefanha@redhat.com, dlemoal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=faithilikerun@gmail.com; helo=mail-ej1-x635.google.com
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

Markus Armbruster <armbru@redhat.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=8818=E6=
=97=A5=E5=91=A8=E4=B8=80 22:46=E5=86=99=E9=81=93=EF=BC=9A
>
> Sam Li <faithilikerun@gmail.com> writes:
>
> > Markus Armbruster <armbru@redhat.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=881=
=E6=97=A5=E5=91=A8=E4=BA=94 19:08=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Sam Li <faithilikerun@gmail.com> writes:
> >>
> >> > To configure the zoned format feature on the qcow2 driver, it
> >> > requires following arguments: the device size, zoned profile,
> >>
> >> "Zoned profile" is gone in v3.
> >>
> >> > zone model, zone size, zone capacity, number of conventional
> >> > zones, limits on zone resources (max append sectors, max open
> >> > zones, and max_active_zones).
> >> >
> >> > To create a qcow2 file with zoned format, use command like this:
> >> > $ qemu-img create -f qcow2 test.qcow2 -o size=3D768M -o
> >> > zone_size=3D64M -o zone_capacity=3D64M -o nr_conv_zones=3D0 -o
> >> > max_append_sectors=3D512 -o max_open_zones=3D0 -o max_active_zones=
=3D0
> >> > -o zone_model=3D1
> >> >
> >> > Signed-off-by: Sam Li <faithilikerun@gmail.com>
> >>
> >> [...]
> >>
> >> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> > index 2b1d493d6e..0d8f9e0a88 100644
> >> > --- a/qapi/block-core.json
> >> > +++ b/qapi/block-core.json
> >> > @@ -5021,6 +5021,27 @@
> >> >  # @compression-type: The image cluster compression method
> >> >  #     (default: zlib, since 5.1)
> >> >  #
> >> > +# @zone-model: Zoned device model, 1 for host-managed and 0 for
> >>
> >> Why is this encoded as a number?
> >>
> >> If it's fundamentally a flag, use bool.
> >>
> >> If more models could appear in the future, make it an enum.
> >>
> >
> > Yes, it is an enum.
> >
> > typedef enum BlockZoneModel {
> >     BLK_Z_NONE =3D 0x0, /* Regular block device */
> >     BLK_Z_HM =3D 0x1, /* Host-managed zoned block device */
> >     BLK_Z_HA =3D 0x2, /* Host-aware zoned block device */
> > } BlockZoneModel;
>
> Please make it an enum in the QAPI schema, too.

I see.

>
> >> > +#     non-zoned devices (default: 0, since 8.0)
> >>
> >> Since 8.2.  More of the same below.
> >>
> >> > +#
> >> > +# @zone-size: Total number of logical blocks within zones in bytes
> >> > +#     (since 8.0)
> >> > +#
> >> > +# @zone-capacity: The number of usable logical blocks within zones
> >> > +#     in bytes. A zone capacity is always smaller or equal to the
> >> > +#     zone size. (since 8.0)
> >>
> >> Two spaces between sentences for consistency, please.
> >>
> >> > +#
> >> > +# @nr-conv-zones: The number of conventional zones of the zoned dev=
ice
> >> > +#     (since 8.0)
> >>
> >> I think @conventional-zones would be more obvious.
> >>
> >> > +#
> >> > +# @max-open-zones: The maximal allowed open zones (since 8.0)
> >>
> >> Maybe "The maximum number of open zones".
> >>
> >> > +#
> >> > +# @max-active-zones: The limit of the zones that have the implicit
> >> > +#     open, explicit open or closed state (since 8.0)
> >>
> >> Maybe "The maximum number of zones in the implicit open, explicit open
> >> or closed state".
> >>
> >> > +#
> >> > +# @max-append-sectors: The maximal data size in sectors of a zone
> >> > +#     append request that can be issued to the device. (since 8.0)
> >>
> >> What's the sector size, and how can the user determine it?  Why can't =
we
> >> use bytes here?
> >
> > The sector size is 512 bytes.
>
> Needs to be documented.
>
> I believe bytes would be easier to document, which makes me suspect
> they'd be the simpler interface.
>
> >                               It's more for conventional use.
>
> I'm afraid I don't understand this part.  Do I have to?

Not necessarily. I adopt the name from zoned storage part of virtio spec.

+If the VIRTIO_BLK_F_ZONED feature is negotiated, then in
+\field{virtio_blk_zoned_characteristics},
+\begin{itemize}
+\item \field{zone_sectors} value is expressed in 512-byte sectors.
+\item \field{max_append_sectors} value is expressed in 512-byte sectors.
+\item \field{write_granularity} value is expressed in bytes.
+\end{itemize}

>
> >> > +#
> >> >  # Since: 2.12
> >> >  ##
> >> >  { 'struct': 'BlockdevCreateOptionsQcow2',
> >> > @@ -5037,7 +5058,14 @@
> >> >              '*preallocation':   'PreallocMode',
> >> >              '*lazy-refcounts':  'bool',
> >> >              '*refcount-bits':   'int',
> >> > -            '*compression-type':'Qcow2CompressionType' } }
> >> > +            '*compression-type':'Qcow2CompressionType',
> >> > +            '*zone-model':         'uint8',
> >> > +            '*zone-size':          'size',
> >> > +            '*zone-capacity':      'size',
> >> > +            '*nr-conv-zones':      'uint32',
> >> > +            '*max-open-zones':     'uint32',
> >> > +            '*max-active-zones':   'uint32',
> >> > +            '*max-append-sectors': 'uint32' } }
> >> >
> >> >  ##
> >> >  # @BlockdevCreateOptionsQed:
> >>
>


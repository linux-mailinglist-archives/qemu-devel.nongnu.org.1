Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C23CD7A4490
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:25:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi9Yx-0003Fi-OX; Mon, 18 Sep 2023 04:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qi9Yv-0003F4-HC; Mon, 18 Sep 2023 04:24:57 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qi9Yt-00032i-TJ; Mon, 18 Sep 2023 04:24:57 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9a9d6b98845so1162767266b.0; 
 Mon, 18 Sep 2023 01:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695025494; x=1695630294; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A0iYT1x7+4uw7wMmK627alEe2xu2ednRdOQ9XUvARb4=;
 b=b4LV6LBduN9PdtH+2vPasPOawGyjtGkqwnV4uJV7RNqN2DRMz9tsgJTyrKypypg5Oh
 kwb3gjmBC6sVr+5ElXqaf+n9BlAiJcEceTJh8EhvnTGEOoNVbMJ5kLJLRZXWCMvMyJpJ
 PYvjed8CHZimE6epeMRcEYMOScptndC03Iu6wYDlI39g0vVrZyTQJcF0C1mGllUJXBxE
 EK4IaEWYqunLKYbHVV/qZG9cnPGuxikB7Ju4wIqMtrvfu0uvma1aAkpJWXz+NWj9JDSP
 lCFk+VBJat77ozp0g6xAoEnORFNb1xFTFWCMp7Rficrslf3k8XtV32/kxY9sg7snVkuz
 ODIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695025494; x=1695630294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A0iYT1x7+4uw7wMmK627alEe2xu2ednRdOQ9XUvARb4=;
 b=WCTCHH9wtqyc6LFpTSbEKf1CoWAdgB0IFgfRuSMOpZQFB1ExD/TXmp4aypOpY6LK5e
 rNt8g40J66FL3GfaFmb8fv32cEh4wHfYriLVZZh0dFEeeriTc1FhFfKjGSZpvJuax5ql
 RdSjCWZIMZ/ZBVbuWp6rjuzWpML3cNfgk7ME30SXgmfksBNsh/I2ur5MTh4RfO0SGNwn
 rstQnuCdyQ9FfE9KU6+/1T/1MkQlC4N+P6Sm3LUTzyUyZ9fOZa9MpiDxeHuSY13OhmGZ
 MwiuQFeYxmAJGFAZsrGX7osKNmT6Bacvz1+vn6QR4MmfKmen/EEzIJehuD+Ij3YcL7K8
 WT5Q==
X-Gm-Message-State: AOJu0YwgSV0zMeqMcyay6itPwarTpg8gGmQ23DSiBT5qaKTkadjwsMXf
 gRMMVMcHFfadeoEAgT4P5lXUUDK3rc3HPfNI0iA=
X-Google-Smtp-Source: AGHT+IHOqqut0PACrpNOwZLCAhaLAemFqWyIf07tHC2Z1nLqiBsYFSSCuNiB+4stIxivYe6UukZnI0LioO7k9nHHJ30=
X-Received: by 2002:a17:906:4fc9:b0:9a5:dc2b:6a5 with SMTP id
 i9-20020a1709064fc900b009a5dc2b06a5mr14319584ejw.35.1695025493174; Mon, 18
 Sep 2023 01:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230828150955.3481-1-faithilikerun@gmail.com>
 <20230828150955.3481-3-faithilikerun@gmail.com> <875y4ugnhs.fsf@pond.sub.org>
In-Reply-To: <875y4ugnhs.fsf@pond.sub.org>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 18 Sep 2023 16:24:26 +0800
Message-ID: <CAAAx-8Lf1FrJ52+=8=t4qKwA2HevYq0PToSQuXtQ9HBsbxbUzA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] qcow2: add configurations for zoned format
 extension
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 dmitry.fomichev@wdc.com, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>, hare@suse.de, 
 qemu-block@nongnu.org, stefanha@redhat.com, dlemoal@kernel.org
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

Markus Armbruster <armbru@redhat.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=881=E6=
=97=A5=E5=91=A8=E4=BA=94 19:08=E5=86=99=E9=81=93=EF=BC=9A
>
> Sam Li <faithilikerun@gmail.com> writes:
>
> > To configure the zoned format feature on the qcow2 driver, it
> > requires following arguments: the device size, zoned profile,
>
> "Zoned profile" is gone in v3.
>
> > zone model, zone size, zone capacity, number of conventional
> > zones, limits on zone resources (max append sectors, max open
> > zones, and max_active_zones).
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
> > index 2b1d493d6e..0d8f9e0a88 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -5021,6 +5021,27 @@
> >  # @compression-type: The image cluster compression method
> >  #     (default: zlib, since 5.1)
> >  #
> > +# @zone-model: Zoned device model, 1 for host-managed and 0 for
>
> Why is this encoded as a number?
>
> If it's fundamentally a flag, use bool.
>
> If more models could appear in the future, make it an enum.
>

Yes, it is an enum.

typedef enum BlockZoneModel {
    BLK_Z_NONE =3D 0x0, /* Regular block device */
    BLK_Z_HM =3D 0x1, /* Host-managed zoned block device */
    BLK_Z_HA =3D 0x2, /* Host-aware zoned block device */
} BlockZoneModel;

> > +#     non-zoned devices (default: 0, since 8.0)
>
> Since 8.2.  More of the same below.
>
> > +#
> > +# @zone-size: Total number of logical blocks within zones in bytes
> > +#     (since 8.0)
> > +#
> > +# @zone-capacity: The number of usable logical blocks within zones
> > +#     in bytes. A zone capacity is always smaller or equal to the
> > +#     zone size. (since 8.0)
>
> Two spaces between sentences for consistency, please.
>
> > +#
> > +# @nr-conv-zones: The number of conventional zones of the zoned device
> > +#     (since 8.0)
>
> I think @conventional-zones would be more obvious.
>
> > +#
> > +# @max-open-zones: The maximal allowed open zones (since 8.0)
>
> Maybe "The maximum number of open zones".
>
> > +#
> > +# @max-active-zones: The limit of the zones that have the implicit
> > +#     open, explicit open or closed state (since 8.0)
>
> Maybe "The maximum number of zones in the implicit open, explicit open
> or closed state".
>
> > +#
> > +# @max-append-sectors: The maximal data size in sectors of a zone
> > +#     append request that can be issued to the device. (since 8.0)
>
> What's the sector size, and how can the user determine it?  Why can't we
> use bytes here?

The sector size is 512 bytes. It's more for conventional use.

>
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


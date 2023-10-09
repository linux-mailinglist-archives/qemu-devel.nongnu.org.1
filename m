Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E077BD694
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:18:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmOz-0006Ns-Nx; Mon, 09 Oct 2023 05:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qpmOk-0006Kp-RA; Mon, 09 Oct 2023 05:18:01 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qpmOi-0000OJ-Ih; Mon, 09 Oct 2023 05:17:58 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9a58dbd5daeso762012866b.2; 
 Mon, 09 Oct 2023 02:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696843074; x=1697447874; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4HPWV+2IdURMdbyeY/LK0hN1/NaVvtkhYWDelGdNu0A=;
 b=Rp8OyMuxoJdQ7SSJXKce5aZ5nfAEEwxnhVzCwLK5tlbGmyzxygt1yliNFLsVLZEic2
 18xbVqiEKYcWY7tFEofLoQU7WY+IKudMNbDlsjcdNP9Ac3328/cKSgWXkVaykcduso5P
 OAo5G1q9HasshiqYGWw66Le7gzokuCgnjQYoz+xRJTVDu2IA4n+vR9b9ZpptzZTltP10
 +geA9+AJwItasyaheVpYDPZd0wn4ocN/gfrqjiIfK/4sVijCcAhdl1AdnfDGWfAgI86U
 5crIPoJGqqGMKglhsxMA6Y60zS2PvIZfNMzQnezG2N4qm3Rcv91PVKku+WGksvr3dX0U
 pcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696843074; x=1697447874;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4HPWV+2IdURMdbyeY/LK0hN1/NaVvtkhYWDelGdNu0A=;
 b=Ld9XmE9+NqSYm5oqDCBmqWjBtxi43J2eFoBChHJZqKSD20Gjsup6DE5lLhxIbVI04m
 DsiYEAWDnmoOmPVVrlU6fVM3mFYIFvs3Ne4hA47wTS0/qWOOpSLv2ajJ0PNSe6BMLJM9
 8v0YdPqHl6ehc5szjNaM0IQuAi9keckzT3OsxIzVq4Frn+z1cAIC5yxRhQehfP5KgCtQ
 XOq7vP5gBKVywwCdTJj9SmTBHE9JjaeAZkuxtKraCUBVVdDiuaHFTBjtb0RBqg1LRzAs
 mHDjr9g2M/Tnx0ha6Q4S0lGTm2JEIKbwIrtleA/RFhPpCBhUejG+jhzpSPSjEu4smWQr
 B4Ww==
X-Gm-Message-State: AOJu0Yxt1jWadL1YZSDbMnhBe5O+rN0vNhkadW3OoPbqKKlvd48neqHQ
 xIsHHU5H/arJFtYyX+45hoJ6pHIOiWsKR6jNd+g=
X-Google-Smtp-Source: AGHT+IGwHmkDssvnPGjnIew8Z2+eT1lQeJA7+sElS8UnbLAQUxhHYJ14Cins9Wl604WDkujUnIMccPCLSAp9j/EsNIE=
X-Received: by 2002:a17:906:2249:b0:9ae:5ba3:9d8f with SMTP id
 9-20020a170906224900b009ae5ba39d8fmr13740735ejr.17.1696843073495; Mon, 09 Oct
 2023 02:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230918095313.5492-1-faithilikerun@gmail.com>
 <20230918095313.5492-3-faithilikerun@gmail.com>
 <b52s4hymg6wkxvbfvhft7xgw3ithcxb3y2a477enenpjcuj43n@vyny33zrkt2w>
In-Reply-To: <b52s4hymg6wkxvbfvhft7xgw3ithcxb3y2a477enenpjcuj43n@vyny33zrkt2w>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 9 Oct 2023 17:17:24 +0800
Message-ID: <CAAAx-8+VnNNoxExTyvmd0f=4dG74s+BSNEoHzAKjXKA6gXqdmA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] qcow2: add configurations for zoned format
 extension
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, dmitry.fomichev@wdc.com, 
 Markus Armbruster <armbru@redhat.com>, dlemoal@kernel.org,
 Hanna Reitz <hreitz@redhat.com>, 
 stefanha@redhat.com, hare@suse.de, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=faithilikerun@gmail.com; helo=mail-ej1-x62c.google.com
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

Hello Eric,

Eric Blake <eblake@redhat.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=8828=E6=97=A5=
=E5=91=A8=E5=9B=9B 23:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Sep 18, 2023 at 05:53:11PM +0800, Sam Li wrote:
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
> > ---
> >  block/qcow2.c                    | 186 ++++++++++++++++++++++++++++++-
> >  block/qcow2.h                    |  28 +++++
> >  docs/interop/qcow2.txt           |  36 ++++++
> >  include/block/block_int-common.h |  13 +++
> >  qapi/block-core.json             |  30 ++++-
> >  5 files changed, 291 insertions(+), 2 deletions(-)
>
> Below, I'll focus only on the spec change, not the implementation:
>
> >
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index b48cd9ce63..521276fc51 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -73,6 +73,7 @@ typedef struct {
> >  #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
> >  #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
> >  #define  QCOW2_EXT_MAGIC_DATA_FILE 0x44415441
> > +#define  QCOW2_EXT_MAGIC_ZONED_FORMAT 0x7a6264
>
> Why not spell it 0x007a6264 with 8 hex digits, like the others?  (I
> get why you choose that constant, though - ascii 'zbd')
>
> > +++ b/docs/interop/qcow2.txt
> > @@ -331,6 +331,42 @@ The fields of the bitmaps extension are:
> >                     Offset into the image file at which the bitmap dire=
ctory
> >                     starts. Must be aligned to a cluster boundary.
> >
> > +=3D=3D Zoned extension =3D=3D
>
> Where is the magic number for this extension called out?  That's
> missing, and MUST be part of the spec.

It's a part of the header extension type in the spec. I will add it.

>
> Back-compatibility constraints: you should consider what happens in
> both of the following cases:
>
> a program that intends to do read-only access to the qcow2 file but
> which does not understand this extension header (for example, an older
> version of 'qemu-img convert' being used to extract data from a newer
> .qcow2 file with this header present - but also the new 'nbdkit
> qcow2dec' decoder plugin just released in nbdkit 1.36).  Is it safe to
> read the data as-is, by basically ignoring zone informations?  Or will
> that ever produce wrong data (for example, if operations on a
> particular zone imply that the guest should read all zeroes after the
> current zone offset within that zone, regardless of whether non-zero
> content was previously stored at those offsets - then not honoring the
> existence of the extension header would require you to add and
> document an incompatible feature bit so that reader apps fail to open
> the file rather than reading wrong data).
>
> a program that intends to edit the qcow2 file but which does not
> understand this extension header (again, consider access by an older
> version of qemu).  Is it safe to just write data anywhere in the disk,
> but where failure to update the zone metadata means that all
> subsequent use of the file MUST behave as if it is now a non-zeoned
> device?  If so, then it is sufficient to document an autoclear feature
> bit: any time a newer qcow2 writer creates a file with a zoned
> extension, it also sets the autoclear feature bit; any time an older
> qcow2 writer edits a file with the autoclear bit, it clears the bit
> (because it has no idea if its edits invalidated the unknown
> extension).  Then when the new qcow2 program again accesses the file,
> it knows that the zone information is no longer reliable, and can fall
> back to forcing the image to behave as flat.

Considering access by an older version of qemu ('old qemu' for abbr.)
with a qcow2 file created with zoned extension ('new file' for abbr.),
reads from a new file on old qemu which does not understand zoned
information are safe. The zoned extension represents necessary zone
states for all zones, which puts constraints to operations on the
zones. For example, writes to offsets that are over the capacity of
that zone are not allowed, where it will be read as zeroes. The old
qemu ignores that and reads the new file as a regular one anyway.

However, what is unsafe is when an old qemu program gets involved in
editing a new file. The new qemu will not see the write pointer
changes of the new file that was done sometime by old qemu programs.
Then the zone information is no longer reliable as you illustrated.

Therefore I will add an autoclear bit for the latter case. It clears
the zoned extension when it is set by old qemu programs.

>
> > +
> > +The zoned extension is an optional header extension. It contains field=
s for
> > +emulating the zoned stroage model (https://zonedstorage.io/).
>
> Assuming that you'll need to add one or two feature bits (most likely
> an autoclear bit, to prevent editing the file without keeping the zone
> information up-to-data, and possibly also an incompatible feature bit,
> if interpreting the file even without editing it is impossible without
> understanding zones), you'll want to mention this header's relation to
> those feature bit(s).
>
> > +
> > +The fields of the zoned extension are:
> > +    Byte        0:  zoned
> > +                    Zoned model, 1 for host-managed and 0 for non-zone=
d devices.
>
> This tells me nothing about what those two models mean.  You'll need
> to describe them better for an independent implementation of a qcow2
> reader (such as 'nbdkit qcow2dec') to be able to properly read such a
> file with either value, even if it doesn't plan on editing it.
>
> If we do add feature bits, what happens when reading a file when the
> feature bits are set but this extension header is missing?

It's not allowed to set the zone model to host-managed type without
other extension header fields like zone size.

>
> > +
> > +            1 - 3:  Reserved, must be zero.
> > +
> > +            4 - 7:  zone_size
> > +                    Total number of logical blocks within the zones in=
 bytes.
>
> This is confusing.  It is a number of blocks, or a number of bytes?  I
> would prefer bytes (will we ever have to worry about a device that can
> have zones larger than 4G - then make this 8 bytes instead of 4, and
> see comments below about alignment), but then word it as:
>
> Total size of each zone, in bytes.
>
> Also, should you require that the zone_size be a multiple of the
> cluster size and/or a power of 2?  (That is, if I have a qcow2 file
> with 2M clusters, does it make sense to permit a zone size of only 1M,
> or should zone size always be at least as large as a cluster?)

In general the zone size must be a power of two. It is not related to
the cluster size.

>
> > +
> > +           8 - 11:  zone_capacity
> > +                    The number of writable logical blocks within the z=
ones in
> > +                    bytes. A zone capacity is always smaller or equal =
to the
> > +                    zone size.
>
> Again, mixing the term blocks and bytes in the same sentence is confusing=
.
>
> > +
> > +          12 - 15:  nr_conv_zones
> > +                    The number of conventional zones.
> > +
> > +          16 - 19:  nr_zones
> > +                    The number of zones.
>
> What's the difference between these two numbers?

nr_zone =3D conventional_zones + sequential_zones.

>
> > +
> > +          20 - 23:  max_active_zones
> > +                    The limit of the zones that have the implicit open=
,
> > +                    explicit open or closed state.
> > +
> > +          24 - 27:  max_open_zones
> > +                    The maximal allowed open zones.
> > +
> > +          28 - 35:  max_append_sectors
> > +                    The maximal number of 512-byte sectors of a zone
> > +                    append request that can be issued to the device.
>
> Is this value in sectors instead of bytes?  I'd prefer bytes, but then
> document that the value must be a multiple of 512.  Also, having a
> 64-bit number not be 64-bit aligned within the extension header is
> unwise.  Please rearrange fields so that all 64-bit fields are 8-byte
> aligned.
>
> This structure as written has implicit tail padding (all extension
> headers must be 8-byte multiples in the end; but the spec already
> documents how that is handled).  Is it worth explicitly calling out
> tail padding up to an 8-byte boundary?

I see. I will rearrange it to 8-byte alignment.

Thanks for your comments!

>
> > +
> >  =3D=3D Full disk encryption header pointer =3D=3D
> >
> >  The full disk encryption header must be present if, and only if, the
> > diff --git a/include/block/block_int-common.h b/include/block/block_int=
-common.h
> > index 85be256c09..d169d15dd6 100644
> > --- a/include/block/block_int-common.h
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
>


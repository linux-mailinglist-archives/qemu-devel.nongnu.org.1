Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC50478AF5A
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 13:57:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaar8-0005V3-KF; Mon, 28 Aug 2023 07:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qaar4-0005Um-PO; Mon, 28 Aug 2023 07:56:27 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qaar2-0000RT-2l; Mon, 28 Aug 2023 07:56:26 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4ff882397ecso4689442e87.3; 
 Mon, 28 Aug 2023 04:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693223782; x=1693828582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CGEeNflkyKEDpdmEc8hMy2V2FxZZTIXkzy4Ny61k+UM=;
 b=TkR5o34b5whqlFW/YN9FKzMMCJmDYbnUi2gsgWojUIC0G5H+8p+X5TX0KWLca8pHA1
 ABJkqXev1/lueRnQrH/PjSBGWRxFos9cfBBylutbP+qB2RSAEKz8cgKUEOPSky1RvJzV
 SxmIllSd1U0GZCZNyCD0QWj8ChQ8Bq3oyIrnYVbLKIA4EnGudmgX1oJfOxjZeq4M2zso
 8l67vJFFYOpjywvTUbrTi8VKgtmFIqBqoMrssju++JGO1BulZLbig8Pr1Aq2uLidDlPv
 SXMQy6QmrGZjMnYmDMNLswprb6m3de2lhx0cWMb3TtCy07SdJZ/Y3x0CsmKTCoPY++y6
 jNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693223782; x=1693828582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CGEeNflkyKEDpdmEc8hMy2V2FxZZTIXkzy4Ny61k+UM=;
 b=SplApLICckPXgW2hQXCTz1bVDEb3sRV5l0IcmbgXuCjwHatGBv8LnEz+rlR4y+GPry
 LTvhPr4NfBmgnRJ6yUraB21EafP8XyXM0IEKJg6xexYTtFpNIEBPuTjRlItGTzTurlFE
 U6YFsgK+BoS98jLBS69lQymgU+Lpini/wbHy0xF8CTeh7KKkuDp5wniUJAaqgFEGXX3x
 alGvjdtbS+UCLo+46VmdlzJQM15D6wHwwCv9ue4PsWZfkNvRF1w8dUOHR0NhWYMl9rMN
 Bfy7eZvuChRjHdb5U76QkPB4sGW6BYvIcfRu7461hhM6NYV3SD4qWJtv7poalo5Ya2ca
 9ftQ==
X-Gm-Message-State: AOJu0YxUBs4fges1VA0yi71F14ZGJYHrYvFHPhNT1h2quiHqkBxOpqVe
 ShwfwcsqVCvcayXiq/bJjzaYRyxjlcz61CKmSjG/Ry8rewLakg==
X-Google-Smtp-Source: AGHT+IFd8Ead/wCh0fOjijUA4/p+FV8lILJVSc3ljXnXgY9wTTI/c+HVwfCsggSsbstjUjXXzGRuQtpLrjulPx1uCG0=
X-Received: by 2002:a05:6512:3084:b0:500:be57:ce53 with SMTP id
 z4-20020a056512308400b00500be57ce53mr543329lfd.42.1693223780967; Mon, 28 Aug
 2023 04:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230814085802.61459-1-faithilikerun@gmail.com>
 <20230814085802.61459-4-faithilikerun@gmail.com>
 <20230822194814.GB37847@fedora>
In-Reply-To: <20230822194814.GB37847@fedora>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 28 Aug 2023 19:55:52 +0800
Message-ID: <CAAAx-8KQOBxt3S+nB0MNtOdG_8SZVg1HOud0hp65A+LXUrL-fw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] qcow2: add zoned emulation capability
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, hare@suse.de, Hanna Reitz <hreitz@redhat.com>, 
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 dlemoal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=faithilikerun@gmail.com; helo=mail-lf1-x136.google.com
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

Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=B8=89 03:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Aug 14, 2023 at 04:58:01PM +0800, Sam Li wrote:
> > By adding zone operations and zoned metadata, the zoned emulation
> > capability enables full emulation support of zoned device using
> > a qcow2 file. The zoned device metadata includes zone type,
> > zoned device state and write pointer of each zone, which is stored
> > to an array of unsigned integers.
> >
> > Each zone of a zoned device makes state transitions following
> > the zone state machine. The zone state machine mainly describes
> > five states, IMPLICIT OPEN, EXPLICIT OPEN, FULL, EMPTY and CLOSED.
> > READ ONLY and OFFLINE states will generally be affected by device
> > internal events. The operations on zones cause corresponding state
> > changing.
> >
> > Zoned devices have a limit on zone resources, which puts constraints on
> > write operations into zones.
> >
> > Signed-off-by: Sam Li <faithilikerun@gmail.com>
> > ---
> >  block/qcow2.c          | 676 ++++++++++++++++++++++++++++++++++++++++-
> >  block/qcow2.h          |   2 +
> >  docs/interop/qcow2.txt |   2 +
> >  3 files changed, 678 insertions(+), 2 deletions(-)
> >
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index c1077c4a4a..5ccf79cbe7 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -194,6 +194,164 @@ qcow2_extract_crypto_opts(QemuOpts *opts, const c=
har *fmt, Error **errp)
> >      return cryptoopts_qdict;
> >  }
> >
> > +#define QCOW2_ZT_IS_CONV(wp)    (wp & 1ULL << 59)
> > +
> > +static inline int qcow2_get_wp(uint64_t wp)
> > +{
> > +    /* clear state and type information */
> > +    return ((wp << 5) >> 5);
> > +}
> > +
> > +static inline int qcow2_get_zs(uint64_t wp)
> > +{
> > +    return (wp >> 60);
> > +}
> > +
> > +static inline void qcow2_set_wp(uint64_t *wp, BlockZoneState zs)
> > +{
> > +    uint64_t addr =3D qcow2_get_wp(*wp);
> > +    addr |=3D ((uint64_t)zs << 60);
> > +    *wp =3D addr;
> > +}
> > +
> > +/*
> > + * File wp tracking: reset zone, finish zone and append zone can
> > + * change the value of write pointer. All zone operations will change
> > + * the state of that/those zone.
> > + * */
> > +static inline void qcow2_wp_tracking_helper(int index, uint64_t wp) {
> > +    /* format: operations, the wp. */
> > +    printf("wps[%d]: 0x%x\n", index, qcow2_get_wp(wp)>>BDRV_SECTOR_BIT=
S);
> > +}
> > +
> > +/*
> > + * Perform a state assignment and a flush operation that writes the ne=
w wp
> > + * value to the dedicated location of the disk file.
> > + */
> > +static int qcow2_write_wp_at(BlockDriverState *bs, uint64_t *wp,
> > +                             uint32_t index, BlockZoneState zs) {
> > +    BDRVQcow2State *s =3D bs->opaque;
> > +    int ret;
> > +
> > +    qcow2_set_wp(wp, zs);
> > +    ret =3D bdrv_pwrite(bs->file, s->zoned_header.zonedmeta_offset
> > +        + sizeof(uint64_t) * index, sizeof(uint64_t), wp, 0);
> > +
> > +    if (ret < 0) {
> > +        goto exit;
>
> Should *wp be restored to its original value to undo the effect of
> qcow2_set_wp()?
>
> > +    }
> > +    qcow2_wp_tracking_helper(index, *wp);
> > +    return ret;
> > +
> > +exit:
> > +    error_report("Failed to write metadata with file");
> > +    return ret;
> > +}
> > +
> > +static int qcow2_check_active(BlockDriverState *bs)
>
> Please rename this to qcow2_check_active_zones() to avoid confusion with
> other uses "active" in qcow2.
>
> > +{
> > +    BDRVQcow2State *s =3D bs->opaque;
> > +
> > +    if (!s->zoned_header.max_active_zones) {
> > +        return 0;
> > +    }
> > +
> > +    if (s->nr_zones_exp_open + s->nr_zones_imp_open + s->nr_zones_clos=
ed
> > +        < s->zoned_header.max_active_zones) {
> > +        return 0;
> > +    }
> > +
> > +    return -1;
> > +}
>
> (This function could return a bool instead of 0/-1 since it doesn't
> really need an int.)
>
> > +
> > +static int qcow2_check_open(BlockDriverState *bs)
>
> qcow2_check_open_zones() or, even better, qcow2_can_open_zone().
>
> > +{
> > +    BDRVQcow2State *s =3D bs->opaque;
> > +    int ret;
> > +
> > +    if (!s->zoned_header.max_open_zones) {
> > +        return 0;
> > +    }
> > +
> > +    if (s->nr_zones_exp_open + s->nr_zones_imp_open
> > +        < s->zoned_header.max_open_zones) {
> > +        return 0;
> > +    }
> > +
> > +    if(s->nr_zones_imp_open) {
> > +        ret =3D qcow2_check_active(bs);
> > +        if (ret =3D=3D 0) {
> > +            /* TODO: it takes O(n) time complexity (n =3D nr_zones).
> > +             * Optimizations required. */
>
> One solution is to keep an implicitly open list. Then this operation is
> O(1).

Yes, I'll add this maybe in the v4.

>
> > +            /* close one implicitly open zones to make it available */
> > +            for (int i =3D s->zoned_header.zone_nr_conv;
> > +            i < bs->bl.nr_zones; ++i) {
> > +                uint64_t *wp =3D &s->wps->wp[i];
> > +                if (qcow2_get_zs(*wp) =3D=3D BLK_ZS_IOPEN) {
> > +                    ret =3D qcow2_write_wp_at(bs, wp, i, BLK_ZS_CLOSED=
);
>
> I'm wondering if it's correct to store the zone state persistently in
> the qcow2 file. If the guest or QEMU crashes, then zones will be left in
> states like EOPEN. Since the guest software will have forgotten about
> explicitly opened zones, the guest would need to recover zone states.
> I'm not sure if existing software is designed to do that.
>
> Damien: Should the zone state be persistent?

Pin?

>
> > +                    if (ret < 0) {
> > +                        return ret;
> > +                    }
> > +                    s->wps->wp[i] =3D *wp;
> > +                    s->nr_zones_imp_open--;
> > +                    s->nr_zones_closed++;
> > +                    break;
> > +                }
> > +            }
> > +            return 0;
>
> This returns 0 if there are no IOPEN zones available. It needs to return
> an error when there are not enough resources available.
>
> > +        }
> > +        return ret;
> > +    }
> > +
> > +    return -1;
>
> This function mixes 0/-1 with -errno return values. -1 is -EPERM, but I
> think that's not what you want.


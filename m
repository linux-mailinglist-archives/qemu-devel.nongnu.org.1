Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D73F735A10
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:51:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBGDh-0004mL-DU; Mon, 19 Jun 2023 10:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qBGDf-0004ln-Cw; Mon, 19 Jun 2023 10:51:03 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qBGDc-0001FX-E8; Mon, 19 Jun 2023 10:51:01 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b46cad2fd9so27193201fa.1; 
 Mon, 19 Jun 2023 07:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687186258; x=1689778258;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QDV7ApOPHWFcz6wrXNMvXo5riBqjJKA3L/ogRmfBxIw=;
 b=ERcX58lf4STgX/7Lw3DX1960P171oHFAA6XNtAkXE6ef97MeQ1cDsOJhG9q2WYLnaP
 UoFFJYQZHaBaMXGD4b7rhn8CbyLFKPzuAZ1qaFtsQNYeqZ3vyIE8TGjgbrZ5EuSgfaI+
 WbnqaYzAJnzjOoJ0g5VnAVui+NYxK+5Ra1COL6vuC3b7MRmAdcfIgrTgyELV0FGetKIY
 dL0HyRFmCaq5+ZIBsBOpkJZUDAEUaHbkh2VdWt/RJ++SwjnZC5EkRfrHOb19Ef7z2zF6
 5cuCVWL0dRPzGGztu05qFexS8LXukkP6ZMnwugd5i5+he+t5SbrkTNqp8FQtyCV8MZgA
 Z7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687186258; x=1689778258;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QDV7ApOPHWFcz6wrXNMvXo5riBqjJKA3L/ogRmfBxIw=;
 b=cRBweptsvtfa4HL8eV5QLK3Z/zCHbO4zNfVc8BH8kY3JuHkKAcybywyvaad04IG/Qv
 WjHy07qUO4rk0i2ueaLKkBg4ABkAugRlE7lhhKIdAnIHBpVPy0ATnzGGP2SbQPh5HPV4
 vLXXCPSbvGbOfFUXKjHb2EYuTzOW2/SVPWtpaP+WHRvdE/iwy2ldIE01UqRIoayvrdBx
 WPZdxhjq5nidkdhB5NUwp818D4hodgboXq/3ZDO2/c6d4JTsyZ0w33h79ZggqGpNHx8m
 GJG6KnZSwXUF7x7ZPw7ktCzRPS4UMgzP+h0VXPIhFYg0L5jX/0jUIFkrbZqIIzMWe2dT
 6D5A==
X-Gm-Message-State: AC+VfDy4OFjmoSTy5cRJuKcv+U8rVUVkoLHp82Ya8ETBOvDZChG0iXVS
 IaWN0xPRvlK0s6mu+wrM0za5Jcvy4oN4uzWAZaQ=
X-Google-Smtp-Source: ACHHUZ6FHegyjElXOL0cnK1qQksos6AnPVIUrOMdOVlGD8ob+v9OJLn0gMVKLwu8z7Gzp+/BFTUA4cs0ZOgnjHd5xEo=
X-Received: by 2002:ac2:4e8a:0:b0:4f3:b61a:a94b with SMTP id
 o10-20020ac24e8a000000b004f3b61aa94bmr5378311lfr.53.1687186257731; Mon, 19
 Jun 2023 07:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230605104108.125270-1-faithilikerun@gmail.com>
 <20230605104108.125270-3-faithilikerun@gmail.com>
 <20230619101031.GC2497337@fedora>
 <CAAAx-8+WmeTGM=PoRxorGmexYqM8uUGyqGeLYyQPLQ0+K6iaUA@mail.gmail.com>
 <20230619144215.GF2497337@fedora>
In-Reply-To: <20230619144215.GF2497337@fedora>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 19 Jun 2023 22:50:31 +0800
Message-ID: <CAAAx-8+Jnpx7AvytRdGCwA00QpuDM9F3=GiWY2UCrZNjWC3czg@mail.gmail.com>
Subject: Re: [RFC 2/4] qcow2: add configurations for zoned format extension
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, dlemoal@kernel.org, dmitry.fomichev@wdc.com, 
 hare@suse.de, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=faithilikerun@gmail.com; helo=mail-lj1-x22b.google.com
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

Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=8819=E6=
=97=A5=E5=91=A8=E4=B8=80 22:42=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jun 19, 2023 at 06:32:52PM +0800, Sam Li wrote:
> > Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=881=
9=E6=97=A5=E5=91=A8=E4=B8=80 18:10=E5=86=99=E9=81=93=EF=BC=9A
> > > On Mon, Jun 05, 2023 at 06:41:06PM +0800, Sam Li wrote:
> > > > diff --git a/block/qcow2.h b/block/qcow2.h
> > > > index 4f67eb912a..fe18dc4d97 100644
> > > > --- a/block/qcow2.h
> > > > +++ b/block/qcow2.h
> > > > @@ -235,6 +235,20 @@ typedef struct Qcow2CryptoHeaderExtension {
> > > >      uint64_t length;
> > > >  } QEMU_PACKED Qcow2CryptoHeaderExtension;
> > > >
> > > > +typedef struct Qcow2ZonedHeaderExtension {
> > > > +    /* Zoned device attributes */
> > > > +    BlockZonedProfile zoned_profile;
> > > > +    BlockZoneModel zoned;
> > > > +    uint32_t zone_size;
> > > > +    uint32_t zone_capacity;
> > > > +    uint32_t nr_zones;
> > > > +    uint32_t zone_nr_conv;
> > > > +    uint32_t max_active_zones;
> > > > +    uint32_t max_open_zones;
> > > > +    uint32_t max_append_sectors;
> > > > +    uint8_t padding[3];
> > >
> > > This looks strange. Why is there 3 bytes of padding at the end? Norma=
lly
> > > padding would align to an even power-of-two number of bytes like 2, 4=
,
> > > 8, etc.
> >
> > It is calculated as 3 if sizeof(zoned+zoned_profile) =3D 8. Else if it'=
s
> > 16, the padding is 2.
>
> I don't understand. Can you explain why there is padding at the end of
> this struct?

The overall size should be aligned with 64 bit, which leaves use one
uint32_t and two fields zoned, zoned_profile. I am not sure the size
of macros here and it used 4 for each. So it makes 3 (*8) + 32 + 8 =3D
64 in the end. If the macro size is wrong, then the padding will
change as well.

Sam


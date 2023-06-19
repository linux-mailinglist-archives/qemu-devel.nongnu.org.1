Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9211B7359E6
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:43:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBG5I-0008HL-Hj; Mon, 19 Jun 2023 10:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qBG5H-0008HB-3S
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:42:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qBG5F-0006f5-O4
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687185741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UV+bBGGy/94oj9kCZL6np4OFys3EWGyo42nWN/vxYCE=;
 b=U0Wz25+jyPmUuPPbwSi481phD1gwmDmngSCmca5SMS+7qRe931Eajg7RK7jK6taoxXntFN
 Z/LU1qqPj2H/nVl24iNg6Y3dHF4vIeUtWmSNOhllOQf/hBSQnZxce2pkxSCqqiMA6Ln25+
 0w/PbspaEiOaMxBKQI+EdoIsRBpuHsg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-lLdv3rn7OQONHx8Mt_HCrA-1; Mon, 19 Jun 2023 10:42:17 -0400
X-MC-Unique: lLdv3rn7OQONHx8Mt_HCrA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C4013C0E203;
 Mon, 19 Jun 2023 14:42:17 +0000 (UTC)
Received: from localhost (unknown [10.39.192.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB3CB492B06;
 Mon, 19 Jun 2023 14:42:16 +0000 (UTC)
Date: Mon, 19 Jun 2023 16:42:15 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, dlemoal@kernel.org, dmitry.fomichev@wdc.com,
 hare@suse.de, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [RFC 2/4] qcow2: add configurations for zoned format extension
Message-ID: <20230619144215.GF2497337@fedora>
References: <20230605104108.125270-1-faithilikerun@gmail.com>
 <20230605104108.125270-3-faithilikerun@gmail.com>
 <20230619101031.GC2497337@fedora>
 <CAAAx-8+WmeTGM=PoRxorGmexYqM8uUGyqGeLYyQPLQ0+K6iaUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cEmZ1wZ11IWSBEr7"
Content-Disposition: inline
In-Reply-To: <CAAAx-8+WmeTGM=PoRxorGmexYqM8uUGyqGeLYyQPLQ0+K6iaUA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--cEmZ1wZ11IWSBEr7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2023 at 06:32:52PM +0800, Sam Li wrote:
> Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=8819=
=E6=97=A5=E5=91=A8=E4=B8=80 18:10=E5=86=99=E9=81=93=EF=BC=9A
> > On Mon, Jun 05, 2023 at 06:41:06PM +0800, Sam Li wrote:
> > > diff --git a/block/qcow2.h b/block/qcow2.h
> > > index 4f67eb912a..fe18dc4d97 100644
> > > --- a/block/qcow2.h
> > > +++ b/block/qcow2.h
> > > @@ -235,6 +235,20 @@ typedef struct Qcow2CryptoHeaderExtension {
> > >      uint64_t length;
> > >  } QEMU_PACKED Qcow2CryptoHeaderExtension;
> > >
> > > +typedef struct Qcow2ZonedHeaderExtension {
> > > +    /* Zoned device attributes */
> > > +    BlockZonedProfile zoned_profile;
> > > +    BlockZoneModel zoned;
> > > +    uint32_t zone_size;
> > > +    uint32_t zone_capacity;
> > > +    uint32_t nr_zones;
> > > +    uint32_t zone_nr_conv;
> > > +    uint32_t max_active_zones;
> > > +    uint32_t max_open_zones;
> > > +    uint32_t max_append_sectors;
> > > +    uint8_t padding[3];
> >
> > This looks strange. Why is there 3 bytes of padding at the end? Normally
> > padding would align to an even power-of-two number of bytes like 2, 4,
> > 8, etc.
>=20
> It is calculated as 3 if sizeof(zoned+zoned_profile) =3D 8. Else if it's
> 16, the padding is 2.

I don't understand. Can you explain why there is padding at the end of
this struct?

--cEmZ1wZ11IWSBEr7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmSQaUcACgkQnKSrs4Gr
c8jg6wf/RBRQltzhhuDVIt+/v2HzKTutC8ybAfWnZ3VZReKVJYvV7u64v5Ca8eLM
jtUq1PleaAsoubT9MKENb90g8BC6vu7qIelVD7hw/ccFBjQOukY4vk8ndOyr/jWG
Ss+3TbRbrrKVS5utSThCJ6qWzhWcvyfFdzBirK3W7dGTeY6pd5Zb1bXZ1GS2csmF
ssST2Dkop/5ASRyecsl+d8Sh4R1w3mdfePkRFwWXPpLqvkJpY1Z+fFqKYBucCtkf
v6WwlAGrSsdLMM7a5BK1+RjBigd/2xiHUlK4uEWwCaTBKxeQMAquiqsGe2/LBHvr
5bC2BwYDRJJjUYANKHAvymqiaK8eSQ==
=s0HE
-----END PGP SIGNATURE-----

--cEmZ1wZ11IWSBEr7--



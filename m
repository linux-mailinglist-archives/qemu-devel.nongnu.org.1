Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B39A2736F0D
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 16:48:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBceW-00087x-Vs; Tue, 20 Jun 2023 10:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qBceQ-0007yx-Fo
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qBceN-0000QK-9Q
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687272486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zVlo4k8cV6a/DCj8k3iVUh9k7PUxoArD6Dx5aKUuvK4=;
 b=WRhvZgWK5R4194tQXAWIE8F4HZ0u6SEp4R1xzc/Cle5xFyia9m8YHroblauCszV9pHJFn7
 clKwFCQjxZwe0lHcEV9FVSXd5EAEMGYswDrdpan4XB0RcaC/fKO8yYGevxPrSOFAydTSxL
 XqGEv9aww4ql2V7fYy4SMjK7m7hDXPA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-ymNa7SYsO32T_W1CJCIUoQ-1; Tue, 20 Jun 2023 10:47:56 -0400
X-MC-Unique: ymNa7SYsO32T_W1CJCIUoQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D710390A93D;
 Tue, 20 Jun 2023 14:44:27 +0000 (UTC)
Received: from localhost (unknown [10.39.194.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55296492B01;
 Tue, 20 Jun 2023 14:44:27 +0000 (UTC)
Date: Tue, 20 Jun 2023 16:44:25 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, dlemoal@kernel.org, dmitry.fomichev@wdc.com,
 hare@suse.de, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [RFC 2/4] qcow2: add configurations for zoned format extension
Message-ID: <20230620144425.GE2625194@fedora>
References: <20230605104108.125270-1-faithilikerun@gmail.com>
 <20230605104108.125270-3-faithilikerun@gmail.com>
 <20230619101031.GC2497337@fedora>
 <CAAAx-8+WmeTGM=PoRxorGmexYqM8uUGyqGeLYyQPLQ0+K6iaUA@mail.gmail.com>
 <20230619144215.GF2497337@fedora>
 <CAAAx-8+Jnpx7AvytRdGCwA00QpuDM9F3=GiWY2UCrZNjWC3czg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="26aNbCK2+7Hi0eke"
Content-Disposition: inline
In-Reply-To: <CAAAx-8+Jnpx7AvytRdGCwA00QpuDM9F3=GiWY2UCrZNjWC3czg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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


--26aNbCK2+7Hi0eke
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2023 at 10:50:31PM +0800, Sam Li wrote:
> Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=8819=
=E6=97=A5=E5=91=A8=E4=B8=80 22:42=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Mon, Jun 19, 2023 at 06:32:52PM +0800, Sam Li wrote:
> > > Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=
=8819=E6=97=A5=E5=91=A8=E4=B8=80 18:10=E5=86=99=E9=81=93=EF=BC=9A
> > > > On Mon, Jun 05, 2023 at 06:41:06PM +0800, Sam Li wrote:
> > > > > diff --git a/block/qcow2.h b/block/qcow2.h
> > > > > index 4f67eb912a..fe18dc4d97 100644
> > > > > --- a/block/qcow2.h
> > > > > +++ b/block/qcow2.h
> > > > > @@ -235,6 +235,20 @@ typedef struct Qcow2CryptoHeaderExtension {
> > > > >      uint64_t length;
> > > > >  } QEMU_PACKED Qcow2CryptoHeaderExtension;
> > > > >
> > > > > +typedef struct Qcow2ZonedHeaderExtension {
> > > > > +    /* Zoned device attributes */
> > > > > +    BlockZonedProfile zoned_profile;
> > > > > +    BlockZoneModel zoned;
> > > > > +    uint32_t zone_size;
> > > > > +    uint32_t zone_capacity;
> > > > > +    uint32_t nr_zones;
> > > > > +    uint32_t zone_nr_conv;
> > > > > +    uint32_t max_active_zones;
> > > > > +    uint32_t max_open_zones;
> > > > > +    uint32_t max_append_sectors;
> > > > > +    uint8_t padding[3];
> > > >
> > > > This looks strange. Why is there 3 bytes of padding at the end? Nor=
mally
> > > > padding would align to an even power-of-two number of bytes like 2,=
 4,
> > > > 8, etc.
> > >
> > > It is calculated as 3 if sizeof(zoned+zoned_profile) =3D 8. Else if i=
t's
> > > 16, the padding is 2.
> >
> > I don't understand. Can you explain why there is padding at the end of
> > this struct?
>=20
> The overall size should be aligned with 64 bit, which leaves use one
> uint32_t and two fields zoned, zoned_profile. I am not sure the size
> of macros here and it used 4 for each. So it makes 3 (*8) + 32 + 8 =3D
> 64 in the end. If the macro size is wrong, then the padding will
> change as well.

The choice of the type (char or int) representing an enum is
implementation-defined according to the C17 standard (see "6.7.2.2
Enumeration specifiers").

Therefore it's not portable to use enums in structs exposed to the
outside world (on-disk formats or network protocols).

Please use uint8_t for the zoned_profile and zoned fields and move them
to the end of the struct so the uint32_t fields are naturally aligned.

I think only 2 bytes of padding will be required to align the struct to
a 64-bit boundary once you've done that.

Stefan

--26aNbCK2+7Hi0eke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmSRu0kACgkQnKSrs4Gr
c8gxGQf/Z379oak5FhzSLlhksiq118/mVd6MjqnEDXMhq2QnvwCpo35uMcEBGtJk
qEs+R7TXXjbwKaeTQTY8PmFj+WVVjh4YnhSFut8yJvars2rJ8wbCznabsoqCIdUu
7Ah/x7ITOSE0wWjoesAIGibpR4QPNfJZS0qGVJz7I3cthgJTSQ6AkOxZVYmkk3p9
saxIxBT9XlK1TN/gFcE7t4SI11ohEO2qyjt0ZSNhKocSRDJJXVzYV0+vM738odJ0
lgtu7RcokW0sGT+GmMm9bgG+ItH3vhhkNoTuyjrWndTq9yAoOPgNknLsE0Fjx0tc
ZMnCGAuy/nrjJG2D58ImIResp/fz+A==
=YswD
-----END PGP SIGNATURE-----

--26aNbCK2+7Hi0eke--



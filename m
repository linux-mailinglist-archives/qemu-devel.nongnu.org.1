Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8D07B33E7
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 15:42:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmDkY-0000pZ-Ht; Fri, 29 Sep 2023 09:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qmDkW-0000pR-Et
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 09:41:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qmDkL-0002w4-Ss
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 09:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695994892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3TSYAPvbGy4zD1Ifsz3buJG7l+qjP5EL33fpkRcuHIg=;
 b=MFu8XeDtd+2TU3P9ayUjQ6AkL1V23mL8dO1m0QNwrQuM7M44PkWgvpgMpfo5kvSakXIu8O
 KpygAkXZ4vXgSptP25ueuHEIBzmt5vhnGPqB+uYoIEbM81dgKozFF4DSFA7DA78MZUkugt
 d//sAr07djCcvQEt62mSAlNKG8v1bhA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-HjW6tK3yPEqEBkwXS2vVpg-1; Fri, 29 Sep 2023 09:41:27 -0400
X-MC-Unique: HjW6tK3yPEqEBkwXS2vVpg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DBB13C025C9
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 13:41:27 +0000 (UTC)
Received: from localhost (unknown [10.45.225.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EDC02156702;
 Fri, 29 Sep 2023 13:41:26 +0000 (UTC)
Date: Fri, 29 Sep 2023 15:41:26 +0200
From: Victor Toso <victortoso@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 5/9] qapi: golang: Generate qapi's union types in Go
Message-ID: <xv5zrswfmkov7lwf2cbnzma3nnl5677uyty3rlkzhoqfzcdkxy@tnw4bo6pkjx2>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-6-victortoso@redhat.com>
 <ZRWMB5qq4E7Xh9ME@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oar7ymv6gboogd3w"
Content-Disposition: inline
In-Reply-To: <ZRWMB5qq4E7Xh9ME@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


--oar7ymv6gboogd3w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 28, 2023 at 03:21:59PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Sep 27, 2023 at 01:25:40PM +0200, Victor Toso wrote:
> > This patch handles QAPI union types and generates the equivalent data
> > structures and methods in Go to handle it.
> >=20
> > The QAPI union type has two types of fields: The @base and the
> > @Variants members. The @base fields can be considered common members
> > for the union while only one field maximum is set for the @Variants.
> >=20
> > In the QAPI specification, it defines a @discriminator field, which is
> > an Enum type. The purpose of the  @discriminator is to identify which
> > @variant type is being used.
> >=20
> > Not that @discriminator's enum might have more values than the union's
> > data struct. This is fine. The union does not need to handle all cases
> > of the enum, but it should accept them without error. For this
> > specific case, we keep the @discriminator field in every union type.
>=20
> I still tend think the @discriminator field should not be
> present in the union structs. It feels like we're just trying
> to directly copy the C code in Go and so smells wrong from a
> Go POV.
>=20
> For most of the unions the @discriminator field will be entirely
> redundant, becasue the commonm case is that a @variant field
> exists for every possible @discriminator value.

You are correct.

> To take one example
>=20
>   type SocketAddress struct {
>         Type SocketAddressType `json:"type"`
>=20
>         // Variants fields
>         Inet  *InetSocketAddress  `json:"-"`
>         Unix  *UnixSocketAddress  `json:"-"`
>         Vsock *VsockSocketAddress `json:"-"`
>         Fd    *String             `json:"-"`
>   }
>=20
> If one was just writing Go code without the pre-existing knowledge
> of the QAPI C code, 'Type' is not something a Go programmer would
> be inclined add IMHO.

You don't need previous knowledge in the QAPI C code to see that
having optional field members and a discriminator field feels
very very suspicious. I wasn't too happy to add it.

> And yet you are right that we need a way to represent a
> @discriminator value that has no corresponding @variant, since
> QAPI allows for that scenario.

Thank Markus for that, really nice catch :)


> To deal with that I would suggest we just use an empty
> interface type. eg
>=20
>   type SocketAddress struct {
>         Type SocketAddressType `json:"type"`
>=20
>         // Variants fields
>         Inet  *InetSocketAddress  `json:"-"`
>         Unix  *UnixSocketAddress  `json:"-"`
>         Vsock *VsockSocketAddress `json:"-"`
>         Fd    *String             `json:"-"`
> 	Fish  *interface{}        `json:"-"`
> 	Food  *interface()        `json:"-"`
>   }
>=20
> the pointer value for 'Fish' and 'Food' fields here merely needs to
> be non-NULL, it doesn't matter what the actual thing assigned is.

I like this idea. What happens if Fish becomes a handled in the
future?

Before:

    type SocketAddress struct {
        // Variants fields
        Inet  *InetSocketAddress  `json:"-"`
        Unix  *UnixSocketAddress  `json:"-"`
        Vsock *VsockSocketAddress `json:"-"`
        Fd    *String             `json:"-"`

        // Unhandled enum branches
        Fish  *interface{}        `json:"-"`
        Food  *interface{}        `json:"-"`
    }

to

    type SocketAddress struct {
        // Variants fields
        Inet  *InetSocketAddress  `json:"-"`
        Unix  *UnixSocketAddress  `json:"-"`
        Vsock *VsockSocketAddress `json:"-"`
        Fd    *String             `json:"-"`
        Fish  *FishSocketAddress  `json:"-"`

        // Unhandled enum branches
        Food  *interface{}        `json:"-"`
    }

An application that hat s.Fish =3D &something, will now error on
compile due something type not being FishSocketAddress. I think
this is acceptable. Very corner case scenario and the user
probably want to use the right struct now.

If you agree with above, I'd instead like to try a boolean
instead of *interface{}. s.Fish =3D true seems better and false is
simply ignored.

Cheers,
Victor

--oar7ymv6gboogd3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmUW1AUACgkQl9kSPeN6
SE8oXRAArJ3GNQ5kuDRiAPBQuE1G+cZQgQzLduSRvK2EA98sAnAAYr9usGE9xO+F
312miFfGN22/PP5kPpI6VBxppST6HnLXVNIsh3u95UNV3TtOZtVXXLmDJ+kPYXeM
EzYMcdEBSISIMnWwRlOu2lpPrEp8IOJEqFwTIOSavs2FCyrYL0O+TC5KHOGWpPz5
pmgZphWC97rw1NmTsIqGl4jYWyOWxvMOOkml+bOjIXXA7QTBBDwjoYvdBOdKYf53
iRQk7P91PTwW83xyqFTkpdQHbI1QHotxs9xYPHWcN+gF5Ja5H3NGFYBJZQElN2LM
IY52usbfV2lqc41BOpHlsRFhYOROM7Zq1JVyzpNcDDvam3ejcQakd7+zdEtLXdqN
ghDEqnOKpte6eZV0n0Fvov4vJsxUEjderr/gL6zp7buLpivG5e6QGyyPIbQxQ8T7
zK23/WQwA2QTkDPSzg0m3iOzWk6EYdSbYcGei9sqBdpM3K+nk0hZEJTMhkdt++Bd
WtRkd/w/BSIKJg80ZzMoMUBita5dxg4ijhhiOb2ga+dokgdXl/2MJ80FDHi60kTW
5lZIfmpxVmXvxcTKDXoTsi293X+TaezVt4HkMVeTNvg28gLsSoehEmsJGIM+gKxL
2YOQztaQSBwmjMSP/14snvD4XXj8Z8HCzFmzggBrwfE12aN0h8I=
=15y8
-----END PGP SIGNATURE-----

--oar7ymv6gboogd3w--



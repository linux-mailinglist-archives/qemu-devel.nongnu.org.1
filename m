Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 628B07C556F
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:28:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZG0-00046F-Md; Wed, 11 Oct 2023 09:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qqZFx-00045n-PU
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:28:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qqZFw-0005lp-1L
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697030886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PD3DbiJCUC1W3xeYFfS5PKzrtfvJ2UxsoCFNyY1mzXE=;
 b=EIs8u3iDSLagleG8BzJWoDiofgZQ6b5Kqyo5f8w8KTFvtdAvR4hMF7mYHYzWJzty+pKd9T
 cj1IsYfOz0TREo8mt3FiVl8SWmErFy+jFkNjNWTzEmhVukgbMItA5+n8dO49Fu6B9VfVC+
 ZbxwhJtnyuX0ZBSX3cQdDZlhUWas5Mg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-CjCjOFinPmulHWvu9RlMPA-1; Wed, 11 Oct 2023 09:27:49 -0400
X-MC-Unique: CjCjOFinPmulHWvu9RlMPA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1DC5811E86
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 13:27:48 +0000 (UTC)
Received: from localhost (unknown [10.45.226.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8050D158;
 Wed, 11 Oct 2023 13:27:48 +0000 (UTC)
Date: Wed, 11 Oct 2023 15:27:47 +0200
From: Victor Toso <victortoso@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 5/9] qapi: golang: Generate qapi's union types in Go
Message-ID: <u53pq2wpwdcyhortjzlsm5avdrjgoklmi64bb7d5k5mta7ivyw@q2il67ol6m2r>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-6-victortoso@redhat.com>
 <ZRWMB5qq4E7Xh9ME@redhat.com>
 <xv5zrswfmkov7lwf2cbnzma3nnl5677uyty3rlkzhoqfzcdkxy@tnw4bo6pkjx2>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rcfqe3bbnsw5ch6g"
Content-Disposition: inline
In-Reply-To: <xv5zrswfmkov7lwf2cbnzma3nnl5677uyty3rlkzhoqfzcdkxy@tnw4bo6pkjx2>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--rcfqe3bbnsw5ch6g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 29, 2023 at 03:41:27PM +0200, Victor Toso wrote:
> Hi,
>=20
> On Thu, Sep 28, 2023 at 03:21:59PM +0100, Daniel P. Berrang=E9 wrote:
> > On Wed, Sep 27, 2023 at 01:25:40PM +0200, Victor Toso wrote:
> > > This patch handles QAPI union types and generates the equivalent data
> > > structures and methods in Go to handle it.
> > >=20
> > > The QAPI union type has two types of fields: The @base and the
> > > @Variants members. The @base fields can be considered common members
> > > for the union while only one field maximum is set for the @Variants.
> > >=20
> > > In the QAPI specification, it defines a @discriminator field, which is
> > > an Enum type. The purpose of the  @discriminator is to identify which
> > > @variant type is being used.
> > >=20
> > > Not that @discriminator's enum might have more values than the union's
> > > data struct. This is fine. The union does not need to handle all cases
> > > of the enum, but it should accept them without error. For this
> > > specific case, we keep the @discriminator field in every union type.
> >=20
> > I still tend think the @discriminator field should not be
> > present in the union structs. It feels like we're just trying
> > to directly copy the C code in Go and so smells wrong from a
> > Go POV.
> >=20
> > For most of the unions the @discriminator field will be entirely
> > redundant, becasue the commonm case is that a @variant field
> > exists for every possible @discriminator value.
>=20
> You are correct.
>=20
> > To take one example
> >=20
> >   type SocketAddress struct {
> >         Type SocketAddressType `json:"type"`
> >=20
> >         // Variants fields
> >         Inet  *InetSocketAddress  `json:"-"`
> >         Unix  *UnixSocketAddress  `json:"-"`
> >         Vsock *VsockSocketAddress `json:"-"`
> >         Fd    *String             `json:"-"`
> >   }
> >=20
> > If one was just writing Go code without the pre-existing knowledge
> > of the QAPI C code, 'Type' is not something a Go programmer would
> > be inclined add IMHO.
>=20
> You don't need previous knowledge in the QAPI C code to see that
> having optional field members and a discriminator field feels
> very very suspicious. I wasn't too happy to add it.
>=20
> > And yet you are right that we need a way to represent a
> > @discriminator value that has no corresponding @variant, since
> > QAPI allows for that scenario.
>=20
> Thank Markus for that, really nice catch :)
>=20
>=20
> > To deal with that I would suggest we just use an empty
> > interface type. eg
> >=20
> >   type SocketAddress struct {
> >         Type SocketAddressType `json:"type"`
> >=20
> >         // Variants fields
> >         Inet  *InetSocketAddress  `json:"-"`
> >         Unix  *UnixSocketAddress  `json:"-"`
> >         Vsock *VsockSocketAddress `json:"-"`
> >         Fd    *String             `json:"-"`
> > 	Fish  *interface{}        `json:"-"`
> > 	Food  *interface()        `json:"-"`
> >   }
> >=20
> > the pointer value for 'Fish' and 'Food' fields here merely needs to
> > be non-NULL, it doesn't matter what the actual thing assigned is.
>=20
> I like this idea. What happens if Fish becomes a handled in the
> future?
>=20
> Before:
>=20
>     type SocketAddress struct {
>         // Variants fields
>         Inet  *InetSocketAddress  `json:"-"`
>         Unix  *UnixSocketAddress  `json:"-"`
>         Vsock *VsockSocketAddress `json:"-"`
>         Fd    *String             `json:"-"`
>=20
>         // Unhandled enum branches
>         Fish  *interface{}        `json:"-"`
>         Food  *interface{}        `json:"-"`
>     }
>=20
> to
>=20
>     type SocketAddress struct {
>         // Variants fields
>         Inet  *InetSocketAddress  `json:"-"`
>         Unix  *UnixSocketAddress  `json:"-"`
>         Vsock *VsockSocketAddress `json:"-"`
>         Fd    *String             `json:"-"`
>         Fish  *FishSocketAddress  `json:"-"`
>=20
>         // Unhandled enum branches
>         Food  *interface{}        `json:"-"`
>     }
>=20
> An application that hat s.Fish =3D &something, will now error on
> compile due something type not being FishSocketAddress. I think
> this is acceptable. Very corner case scenario and the user
> probably want to use the right struct now.
>=20
> If you agree with above, I'd instead like to try a boolean
> instead of *interface{}. s.Fish =3D true seems better and false is
> simply ignored.

I was just double checking that the Union's value for each enum
branch needs to be a Struct. So I think it is fine to use boolean
for unhandled enum branches. I'll be doing that in the next
iteration.

docs/devel/qapi-code-gen.rst: 350
    The BRANCH's value defines the branch's properties, in particular its
    type.  The type must a struct type.  The form TYPE-REF_ is shorthand
    for :code:`{ 'type': TYPE-REF }`.

Cheers,
Victor

--rcfqe3bbnsw5ch6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmUmotMACgkQl9kSPeN6
SE89sA/6A76CQUlglK+3n5cAEWEsrDeaJ84C/kJFpsApMkW1gs9RPHDfv2fRP7PZ
4pyfpeflYCrfVzpcYAdipae97V76fFY0yEm7ahYtLIqxgDCTJOHLu/fhnKZwnWea
mMgKcmMvxMfC9o1n7dwbmadtyoUmht2RpfoghZAovN/YFP9ahDgj4sfWXL07GqqX
U2uGCvVz4TGBDIw0zhgBJEut1piWNUxHaGIBhaIU1tvtuqkDpp7eXhpvhz3a/Ahr
NLGalOgXint5RHjJTD7OEpF8XZmzxWpqyyCGE6AYmGi3vRK92HOOkOM8N9GidfF6
ITf+RYf9JHW2rsJcKqRERlrl/4Bym2yyOCQe3t5o7HUBNZLeqvNknY9Ab3XXIEgS
C5VzqmGZkpZyMyhMee1NIAvxaslO2Qcdk4pcj9sB7AFzEhAGPyIu6OdJ7gIW3DAs
Lvnz8E27I0l79g/GXBXb8W/lj92HMuAo0ZbFrYP+W83qh4QZ3v3Vdt7xQQ3xW8j9
2mg82Ig4k4RTn8+c/dXhdR9NLd//owmLXUB2t1D5E3eqtzulzGxmFLH7N973czMI
21ZeeBRjbGjNOzP7waBDKZzb3qSP0PK7KO7Mx6G41zr70gacdPImXPtqlhZYShCu
0c/69g50Xa5xJCp9w87L1LwSjYBCUkdjXAK9AIwvF98DLvf3RTE=
=tXAx
-----END PGP SIGNATURE-----

--rcfqe3bbnsw5ch6g--



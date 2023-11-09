Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E257E719A
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 19:36:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r19sA-0006pC-As; Thu, 09 Nov 2023 13:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1r19s7-0006mp-6u
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:35:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1r19s5-0000l1-GO
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699554914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xmx37nET/gNVZ6D6QCg+V+SDqm+VhDvvBPhSMDgE2UQ=;
 b=YiUonxMWrFdi+Mf+/8XWrowT3YsEduDRdP1CUl8sChedLq409HhZquMhdijfqeh28rInx0
 7sw76xk7A0xUg2kX20ilJ0WP7kgeeWS7mQFe0/NXSezduiWkfY+jqDL54pYJ8A0nZ3qqzF
 27zXOZIpiBzyafzN4l+55Q5hVf0Y6EE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-vQdb9oxuPnaSZDxFdzD2pg-1; Thu, 09 Nov 2023 13:35:07 -0500
X-MC-Unique: vQdb9oxuPnaSZDxFdzD2pg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B95C0101A53B
 for <qemu-devel@nongnu.org>; Thu,  9 Nov 2023 18:35:05 +0000 (UTC)
Received: from localhost (unknown [10.45.226.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53C085032;
 Thu,  9 Nov 2023 18:35:05 +0000 (UTC)
Date: Thu, 9 Nov 2023 19:35:04 +0100
From: Victor Toso <victortoso@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 07/11] qapi: golang: Generate qapi's union types in Go
Message-ID: <s2ev3hammcfpjbkrk7zxisge4a2cqr2gyomt2htir66vinfyhe@tupvidmxywzv>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-8-victortoso@redhat.com>
 <CABJz62PFopBRaMBc8Smtse9DJEy+0Qii7DtiTZGQdks3dXOdUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="itbdth2fvf4eeddw"
Content-Disposition: inline
In-Reply-To: <CABJz62PFopBRaMBc8Smtse9DJEy+0Qii7DtiTZGQdks3dXOdUw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--itbdth2fvf4eeddw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 09, 2023 at 09:29:28AM -0800, Andrea Bolognani wrote:
> On Mon, Oct 16, 2023 at 05:27:00PM +0200, Victor Toso wrote:
> > This patch handles QAPI union types and generates the equivalent data
> > structures and methods in Go to handle it.
> >
> > The QAPI union type has two types of fields: The @base and the
> > @Variants members. The @base fields can be considered common members
> > for the union while only one field maximum is set for the @Variants.
> >
> > In the QAPI specification, it defines a @discriminator field, which is
> > an Enum type. The purpose of the  @discriminator is to identify which
> > @variant type is being used.
> >
> > For the @discriminator's enum that are not handled by the QAPI Union,
> > we add in the Go struct a separate block as "Unbranched enum fields".
> > The rationale for this extra block is to allow the user to pass that
> > enum value under the discriminator, without extra payload.
> >
> > The union types implement the Marshaler and Unmarshaler interfaces to
> > seamless decode from JSON objects to Golang structs and vice versa.
> >
> > qapi:
> >  | { 'union': 'SetPasswordOptions',
> >  |   'base': { 'protocol': 'DisplayProtocol',
> >  |             'password': 'str',
> >  |             '*connected': 'SetPasswordAction' },
> >  |   'discriminator': 'protocol',
> >  |   'data': { 'vnc': 'SetPasswordOptionsVnc' } }
> >
> > go:
> >  | type SetPasswordOptions struct {
> >  | 	Password  string             `json:"password"`
> >  | 	Connected *SetPasswordAction `json:"connected,omitempty"`
> >  | 	// Variants fields
> >  | 	Vnc *SetPasswordOptionsVnc `json:"-"`
> >  | 	// Unbranched enum fields
> >  | 	Spice bool `json:"-"`
> >  | }
>=20
> Instead of using bool for these, can we denote a special type? For
> example
>=20
>   type Empty struct{}
>=20
> We could then do
>=20
>   u :=3D SetPasswordOptions{
>     Password: "...",
>     Spice: &Empty{},
>   }
>=20
> The benefit I have in mind is that you'd be able to check which
> variant field is set consistently:
>=20
>   if u.Vnc !=3D nil {
>     ...
>   }
>   if u.Spice !=3D nil {
>     ...
>   }
>=20
> Additionally, this would allow client code that *looks* at the
> union to keep working even if actual data is later added to the
> branch; client code that *creates* the union would need to be
> updated, of course, but that would be the case regardless.

I think it is better to not have code that is working to keep
working in this case where Spice is implemented.

Implementing Spice here would mean that a struct type
SetPasswordOptionsSpice was created but because the code handling
it before was using struct type Empty, it will not handle the new
struct, leading to possible runtime errors (e.g: not handling
username/password)

A bool would be simpler, triggering compile time errors.

Note that I'm working with the mindset that each version of the
module talks well with a version of QEMU. We should consider next
if we want to implement logic for QAPI versioning promises, which
is for more than one QEMU version. Markus had an email about it
last year. Daniel also suggested more version promises than what
QAPI currently does.

Anyway, that's my rationale for bool here.

Cheers,
Victor

--itbdth2fvf4eeddw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmVNJlcACgkQl9kSPeN6
SE9Nxw//b8H0nDL26FZ0mLT2ABbSxNbHy+NyvfcUCqMAWVO9JYiuAvGz6op5AKFb
veYs2c8CH7EC0gJqQRvSxYYX7P7enyBEebSwqzywL60Wj5HGagDqw/ynhKth1WuL
qrrp35y0BSU3/LT9DmWrEyVSluS3VnXGJoDoNBbFCoG3M7HdASYHPsSOi4g0aAeG
CTkF8Pb5poSWLsr7Fz2GgGesK1hO0c9J3mWg3LCyYggQzytiuS5HcaYIJJeSsGfJ
SovXqyWS9fxxiqy7anXxoV6wrhyJ7vg47GZ0MHHQbolx7VnmU2UvR8zfztT0Qman
9jISeX6l3B/53I3GNTRopceBDci4/grhy6gkAcp09dbCEj5NraQvWAFbMYzyRJsR
VDsR5mFLMnAGQHzR9gRi76ftzcOwz6xHeuZNWQQHOHmAtEE4InTfOw/fbs4/YtFl
EXkeCbKMeThPgtXTnMkDubFrX6O+xk3Mjkc+n1KuJ3jvUlOfabCK4NlT4llTPTX4
UpSmyZcMc35rd4awnTSAWJ10W7VYIpAJkfgYzvST+P69lHkLO47L9sL/26INKcV3
lK5M/3NkLqlPgWfil+4xa6cRo/v0iFSQtJGzSbBRbqvdjwFCDm5sB8XjVU7smll3
5DrNNWjLpNJRCWKofbMzJ/oWpm7wihnRR6WawuB9iiVkK+aeXMg=
=tTkO
-----END PGP SIGNATURE-----

--itbdth2fvf4eeddw--



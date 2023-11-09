Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0881D7E71DC
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:03:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1AI5-0004Dv-CE; Thu, 09 Nov 2023 14:02:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1r1AHu-0004DW-1p
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:01:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1r1AHq-0007t3-4b
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699556512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=flACq5x9IqQlyX48bPgeAaeRxy2Ag7Grja/2KE2LxMo=;
 b=Qe6uQRhEJllsx7WHZP8ur4uP7biMNYP4ycnbtpWnwMt0Msq9zvGxMGJ2vG3wGjAfEHqizF
 VtR9hn2E8Vw4uX0Yv/FRYta3EKleumN4mttqPZ9ijbOCu9o07+o/wDndSckKKKZEu30elO
 Bj7gnht7A2o2502Zj628g/BJaMmY13I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-40L27TUBOZqqE9OL9VRcug-1; Thu,
 09 Nov 2023 14:01:50 -0500
X-MC-Unique: 40L27TUBOZqqE9OL9VRcug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61D6E1C0651C
 for <qemu-devel@nongnu.org>; Thu,  9 Nov 2023 19:01:50 +0000 (UTC)
Received: from localhost (unknown [10.45.226.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD531502A;
 Thu,  9 Nov 2023 19:01:49 +0000 (UTC)
Date: Thu, 9 Nov 2023 20:01:48 +0100
From: Victor Toso <victortoso@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 04/11] qapi: golang: Generate qapi's alternate types
 in Go
Message-ID: <gcsvqv4zxbe2ujyexzfc2fgh5vo2vxlmgcelbcin7u2zecemox@4erxiqf7jg7y>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-5-victortoso@redhat.com>
 <CABJz62NbJAkLRS7t3JN8T-=1mkZ9BX68Jgd+VPr0tYwQPZNKag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="q43mecrkye7zaowx"
Content-Disposition: inline
In-Reply-To: <CABJz62NbJAkLRS7t3JN8T-=1mkZ9BX68Jgd+VPr0tYwQPZNKag@mail.gmail.com>
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


--q43mecrkye7zaowx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 09, 2023 at 09:34:56AM -0800, Andrea Bolognani wrote:
> On Mon, Oct 16, 2023 at 05:26:57PM +0200, Victor Toso wrote:
> > [*] The exception for optional fields as default is to Types that can
> > accept JSON Null as a value. For this case, we translate NULL to a
> > member type called IsNull, which is boolean in Go.  This will be
> > explained better in the documentation patch of this series but the
> > main rationale is around Marshaling to and from JSON and Go data
> > structures.
> >
> > Example:
> >
> > qapi:
> >  | { 'alternate': 'StrOrNull',
> >  |   'data': { 's': 'str',
> >  |             'n': 'null' } }
> >
> > go:
> >  | type StrOrNull struct {
> >  |     S      *string
> >  |     IsNull bool
> >  | }
>=20
> We should call this Null instead of IsNull, and also make it a
> pointer similarly to what I just suggested for union branches
> that don't have additional data attached to them.

I don't have a strong argument here against what you suggest, I
just think that the usage of bool is simpler.

The test I have here [0] would have code changing to something
like:

When is null:

  - val :=3D &StrOrNull{IsNull: true}
  + myNull :=3D JSONNull{}
  + val :=3D &StrOrNull{Null: &myNull}

So you need a instance to get a pointer.

When is absent (no fields set), no changes as both bool defaults
to false and pointer to nil.

The code handling this would change from:

  - if u.IsNull {
  + if u.Null !=3D nil {
        ...
    }

We don't have the same issues as Union, under the hood we Marshal
to/Unmarshal from "null" and that would not change.

[0] https://gitlab.com/victortoso/qapi-go/-/blob/main/test/type_or_null_tes=
t.go

I can change this in the next iteration.

Cheers,
Victor

--q43mecrkye7zaowx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmVNLJwACgkQl9kSPeN6
SE+xGw/+IkIRZDu3ai1tYI6JbT1UT1Z2TqoggGbLNWPHO4zuA3ygaohJ46WI4TdN
kSFdcCjjdb8ssXUE7cb+QRmV9zZMavKGl9gEUTvJ5yvwyVblSsuFF/aKjA7cSsr9
iQ+ljtau6KzSSDxPsEgvahjKWLl3fTbLeR/+0+JEUUoGiiEDg/FS9ZUsZZyBbAlY
SJTmwh3l1U52pjh76M8AHmomKZ1gT7vUBYHV1ZWKKDK+Rh98+CDgixMus9G8LDdB
hfvGJXcxuWXxcO8HnG1yzdDUJPxOsx6sescn/v/rJaIwDZaE551SD3RRJzmY9ug1
DFl/UZRgk4dScQuV8uwiTO0b98YYPf5U8dd3RQinBLviWnpM0L8AWcGx+r51TA7/
/gjzdioYY4eGYLBEH5CaOZHaAeaaMKh+G3870RKky6oE01HKH02vYMVpJe1nq7E1
B8Qt+U87yLISA4FBfNFkfMV5hOT4iCD6d8hd+1st7OY8A92bgh4Iq/Vt6Lfl5Lsa
klzRpS8afK0pfIAFvYn5o4VyJzdmoUqkRP3S82QeiCo422tuZV9ovIxHaea1Lx9E
lb9Udaywe/HIGwxHOlvpQxKCohmAeSZyrEshWuWO0trNI+LJAj4wO7GYJ2LEqVAh
LIjEPIHk60aqOxRqhsul8yMdajZhOrlEDdQeFeOBEJ/+IN8nZ1Q=
=BN2D
-----END PGP SIGNATURE-----

--q43mecrkye7zaowx--



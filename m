Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAC47E7D7F
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 16:45:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Tg0-00029Z-Nf; Fri, 10 Nov 2023 10:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1r1Tfz-00029P-NU
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 10:44:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1r1Tfw-0005rc-A6
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 10:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699631034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TzsA8CIJbbLQ8RgvO+KlTdLwp2u4R3p9cQTooHurvLQ=;
 b=TdHJgoihm/XW2eUYWF02lV/+N3xT3xaP/vMrFJW96L07Aa3Jy1XhtdypPiLOQthCH71haN
 Y/KCP7SWFH+NfGXTWsAJJR789TflMgkuQjJiT14N1e2vGiJaZwC3wVQUFGkgLzNs+Usjnv
 Q7VHfb1mXL+QXIMvDi4jO37CvfpBsmk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-8REG2RpDN6es1QVL6eE6_g-1; Fri, 10 Nov 2023 10:43:52 -0500
X-MC-Unique: 8REG2RpDN6es1QVL6eE6_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A90F101A52D
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 15:43:52 +0000 (UTC)
Received: from localhost (unknown [10.45.225.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AAB082166B29;
 Fri, 10 Nov 2023 15:43:51 +0000 (UTC)
Date: Fri, 10 Nov 2023 16:43:50 +0100
From: Victor Toso <victortoso@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 04/11] qapi: golang: Generate qapi's alternate types
 in Go
Message-ID: <ct2me4r6kge4iq2b45btswbrakgyvbd4uxcdesfo56x4v7qj67@7dworgnzfevx>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-5-victortoso@redhat.com>
 <CABJz62NbJAkLRS7t3JN8T-=1mkZ9BX68Jgd+VPr0tYwQPZNKag@mail.gmail.com>
 <gcsvqv4zxbe2ujyexzfc2fgh5vo2vxlmgcelbcin7u2zecemox@4erxiqf7jg7y>
 <CABJz62OLy=JThQLwDPXBpdrsa5kLijegk=c34isBa=ABygVK-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="w3fuih4w7uutmvcr"
Content-Disposition: inline
In-Reply-To: <CABJz62OLy=JThQLwDPXBpdrsa5kLijegk=c34isBa=ABygVK-w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--w3fuih4w7uutmvcr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 10, 2023 at 01:58:20AM -0800, Andrea Bolognani wrote:
> On Thu, Nov 09, 2023 at 08:01:48PM +0100, Victor Toso wrote:
> > On Thu, Nov 09, 2023 at 09:34:56AM -0800, Andrea Bolognani wrote:
> > > We should call this Null instead of IsNull, and also make it a
> > > pointer similarly to what I just suggested for union branches
> > > that don't have additional data attached to them.
> >
> > I don't have a strong argument here against what you suggest, I
> > just think that the usage of bool is simpler.
> >
> > The test I have here [0] would have code changing to something
> > like:
> >
> > When is null:
> >
> >   - val :=3D &StrOrNull{IsNull: true}
> >   + myNull :=3D JSONNull{}
> >   + val :=3D &StrOrNull{Null: &myNull}
> >
> > So you need a instance to get a pointer.
> >
> > When is absent (no fields set), no changes as both bool defaults
> > to false and pointer to nil.
> >
> > The code handling this would change from:
> >
> >   - if u.IsNull {
> >   + if u.Null !=3D nil {
> >         ...
> >     }
> >
> > We don't have the same issues as Union, under the hood we Marshal
> > to/Unmarshal from "null" and that would not change.
> >
> > [0] https://gitlab.com/victortoso/qapi-go/-/blob/main/test/type_or_null=
_test.go
> >
> > I can change this in the next iteration.
>=20
> No, leave the type alone. But I still think the name should probably
> be Null instead of IsNull.

Ok, keeping bool, rename to Null. Deal.

Cheers,
Victor

--w3fuih4w7uutmvcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmVOT7UACgkQl9kSPeN6
SE85JxAAuQShnxVItZ6KfkSb/qFpFsbKgwj+9B1AibU+s8XlfnFmljaLqcZijvpX
fKnBLG34ngl//tkvUvV/AxSC5YtuqCm9MAKuBaB9d/SmNYuQh1cI8UKsCsRsMH0D
pwbLqcVurCStdSF4aL6Ojcn1g24gCPA/MDiMCzlN1196Z2nLFJ3nqfMxXkWXAbMI
5VetTfnIJmdhaP4MiOx6RtBbonyFxHQjyjXM0XI5UNSAAtehyK1AHX2R4eGpajq/
wEjr6RUV6tx8Pp7hf9x1wsK9Cj7DJVglG7TPxbC+1/Je9kJrtgVOM4qFkumpgK9T
jBKHfX/h3lnkC3K9vroEZ4Nu3gTa9pPY+qHfX0a/foI+LQ54eWfYGYWJuqnHNBee
2gnHiwRABICy7r9eMua/N07QOHv/oX8jpMrXCYi3BBxt+IfOXDL7KsPEGiS8f4YJ
qJ2gYkEzyrPiEvaqxQGRwpeIDXVz7C6tFS5T0f5/4U2afnPPhVuWP3qt3M0btgWT
6hTTeDYKteKaKqroUyzsa6Y/zHTT1gvUhIeY8abJlwiGH7GV7Z2k8/3WmqqIYgEG
I9N+nZz91ebRIfHV8HrW4zWxeUOIh8eHYb8xLOwDcnGQ+5GTWf3nepQgmW33BVY1
zL5mGRXOt/QsuZ6rq7f8kpDH5XFaO3yyaBL+sKEuoktQk6yjd78=
=eEEk
-----END PGP SIGNATURE-----

--w3fuih4w7uutmvcr--



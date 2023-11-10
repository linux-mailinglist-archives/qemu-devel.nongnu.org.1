Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E40D47E7D7E
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 16:45:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Th9-0002ip-83; Fri, 10 Nov 2023 10:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1r1Th6-0002iI-Gt
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 10:45:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1r1Th5-0006Iw-2D
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 10:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699631114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pmYXyvYMVFlVc8jrvy6i4Gk3OAF3NHa7DN7cShN1Q6M=;
 b=WPXiqdgTaI8A3QZ3mJYlJ1b408vKS9nuOLeMEXaiX/9DW3lUHs7mhc0+PF5Qln6S6MgL9F
 uUaX91/Ly5HYZoxdLAh/1YiMXVhMrmdMhPwfuCwU4M2oKD9m982RGATxHqDllhYb9L3Yty
 vP3nML7bDd6zwJIuJtXbwd98+APns7Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-xQa7iWOJO2ePdRXyBoBlxg-1; Fri, 10 Nov 2023 10:45:09 -0500
X-MC-Unique: xQa7iWOJO2ePdRXyBoBlxg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05C1F85D213
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 15:45:08 +0000 (UTC)
Received: from localhost (unknown [10.45.225.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 850C47AC6;
 Fri, 10 Nov 2023 15:45:07 +0000 (UTC)
Date: Fri, 10 Nov 2023 16:45:05 +0100
From: Victor Toso <victortoso@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 07/11] qapi: golang: Generate qapi's union types in Go
Message-ID: <hu2ifbi4bkf3pipb6kzec2usplj7yvry7hvwstk2ohusp7gifb@m54ctahvm6tt>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-8-victortoso@redhat.com>
 <CABJz62PFopBRaMBc8Smtse9DJEy+0Qii7DtiTZGQdks3dXOdUw@mail.gmail.com>
 <s2ev3hammcfpjbkrk7zxisge4a2cqr2gyomt2htir66vinfyhe@tupvidmxywzv>
 <CABJz62Ncr+r7iHrbv+kAjjuNB8cGAdRyAS0Q7yj2On7XzGkyZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="irbpktuzq7ontt2w"
Content-Disposition: inline
In-Reply-To: <CABJz62Ncr+r7iHrbv+kAjjuNB8cGAdRyAS0Q7yj2On7XzGkyZw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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


--irbpktuzq7ontt2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 10, 2023 at 01:54:50AM -0800, Andrea Bolognani wrote:
> On Thu, Nov 09, 2023 at 07:35:04PM +0100, Victor Toso wrote:
> > On Thu, Nov 09, 2023 at 09:29:28AM -0800, Andrea Bolognani wrote:
> > > Additionally, this would allow client code that *looks* at the
> > > union to keep working even if actual data is later added to the
> > > branch; client code that *creates* the union would need to be
> > > updated, of course, but that would be the case regardless.
> >
> > I think it is better to not have code that is working to keep
> > working in this case where Spice is implemented.
> >
> > Implementing Spice here would mean that a struct type
> > SetPasswordOptionsSpice was created but because the code handling
> > it before was using struct type Empty, it will not handle the new
> > struct, leading to possible runtime errors (e.g: not handling
> > username/password)
> >
> > A bool would be simpler, triggering compile time errors.
>=20
> You've convinced me :) Let's leave it like this for now. Once
> we start seriously thinking about compatibility across versions
> then we might have to reconsider this, but it's going to be
> part of a much bigger, much more fun conversation ;)

Yes! I'm looking forward to a 'unstable' version where we can
agree on building things on top.

Thanks,
Victor

--irbpktuzq7ontt2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmVOUAEACgkQl9kSPeN6
SE9V6RAAnEsozjC3k0FsDtTpH9qGDet9iEkDgJs7POjyu1kah3DZGWjfwfCjgl2D
Z2FGdY7UR5olcm45I8FefbrTtsHom2VVV7GtlXY09l6cmDv56heLLwiZgh/7kMoF
Y4uRvtXjKMrUF+7we4x+oZANEkwG56TtHP8u0f/am2wuB39rogU4jQBMsdzr7Rrq
4O6Xe7PPdnB6VaOczTKJYfsZ1B/sp/TQ3JYcTlavvWHP/z2nDsUEh8hvsBBQielw
NNraio5JCCGkPc/jBEE6yCriR8f2RiASZwt3WF8jM4B3HPZevWBmRigB/cgCMPNV
yuh1SVWcj/OH0chTEWsShott6UkA3p914Z7evngfgbBJAQc2Dr8jvXRQEIBeVHMJ
rhArSC8Mdk0CWw7BidGSphUvRV7b6fIbNex7mht6Hbmj59MipyNcF2jMXB2F+zEj
CeCk4SruBVkZoG8H6kPNwjtNgqAFdvhzMClXhu/HAJqJPSTNq328BIP8ftzdDgyu
A47RQpFGg5HvtXz5chokdXIbpxwOlvOvKv3HZBwn9tqSRmXiJxwvNQXiwZR4AwX0
TMP4lQ/kEuqHcPvgOAhOFxiFNlEQu/b2t0QA99WMxmGz0ySDwnfPwJpF1D4AWZEs
3Co4FDCuwgiBSEsk3NG4OeUCnMMCnyeEoXoRbAiSOxPHYOOnrZk=
=I+wD
-----END PGP SIGNATURE-----

--irbpktuzq7ontt2w--



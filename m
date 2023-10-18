Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1B37CE122
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:24:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8Oi-0007sq-RK; Wed, 18 Oct 2023 11:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qt8Of-0007sc-CL
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:23:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qt8Od-0001Ea-My
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697642621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0dcLn6WWYbwsPIye+Ya6vBDS1pJC2lAX+gLK6QQOt04=;
 b=PiZ3W395Srmmd92hA5AScKLpv8IOb78UsiODKP+HELsTPkB8GNunvlSfTKxgUG6dgM86XV
 DyvfrTb5zeWQiBS1bteG/P0j9Bdxu3yHln12zOfvFQn1WzgsGv2FYOUKugDCSgkZPZUdCg
 VlJ256pIAShWMan6J2M7xG2dHu3TbRM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-asXjOdxVP1iBmcGE3wqbuw-1; Wed, 18 Oct 2023 11:23:29 -0400
X-MC-Unique: asXjOdxVP1iBmcGE3wqbuw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BFE188B779
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:23:29 +0000 (UTC)
Received: from localhost (unknown [10.45.225.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E810AC15BB8;
 Wed, 18 Oct 2023 15:23:28 +0000 (UTC)
Date: Wed, 18 Oct 2023 17:23:27 +0200
From: Victor Toso <victortoso@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v2 02/11] scripts: qapi: black format main.py
Message-ID: <iwlndli3c4waxnjgtvyo6bi52vc4nundupqkrjeufwilua22s2@rh4j2jk26htq>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-3-victortoso@redhat.com>
 <87pm1crya0.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vpo2z7bxt3vwej3c"
Content-Disposition: inline
In-Reply-To: <87pm1crya0.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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


--vpo2z7bxt3vwej3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 01:00:07PM +0200, Markus Armbruster wrote:
> Victor Toso <victortoso@redhat.com> writes:
>=20
> > flake8 complained:
> >     ./main.py:60:1: E302 expected 2 blank lines, found 1
> >
> > Which is simple enough. My vim has black [0] enabled by default, so it
> > did some extra formatting. I'm proposing to follow it.
> >
> > [0] https://black.readthedocs.io/en/stable/
> >
> > Signed-off-by: Victor Toso <victortoso@redhat.com>
> > ---
> >  scripts/qapi/main.py | 76 ++++++++++++++++++++++++++++----------------
> >  1 file changed, 48 insertions(+), 28 deletions(-)
>=20
> Is this all black hates about scripts/qapi/?

No, just scripts/qapi/main.py.

> Did you configure it in any way, and if yes, how?

Only to reduce line length to 79.

I can do a separate series for this, if the idea is accepted.

Cheers,
Victor

--vpo2z7bxt3vwej3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmUv+G4ACgkQl9kSPeN6
SE8wCg/9F33/w9SwSXglqRe8H0dtO4wQZlOXe6mzIL+omf373IJJVSRoTbES+yP5
cVW8vN5XEe+KTrA5DFNpEtEZqj20UgVxlhe4i1uccA6GAPLbw1jzZwtIDlRQEokK
Zzst9jf8In78w3MmCpWpmPP128lHDdM6xvylULPHsVBGBA7frq6v147NQ1y0DQNj
ov6VmvDh9HyENrG5/2bjf3ez1g4xfvb+tVsuDX4a00KZiE9qdSfF8wOBfJ8Dw4wu
zNosDy9p6HXP3Zn3i6C6935eaMLySnrz8qXFXOdTMmOsrFlu8gzu8GSBegzO7o4+
q3AAWu1c1jZtBAdLsEn+bl0m8LgOOAPye7Lbqtw8LYVZEIM/2dmxjc5+Lv4LdgAw
G5RT3kbk+gD9+cUoqjMEURR9/PqaOHhRr01Uq9gCwKE3DQCZeYBnvNnn3/ewAkCZ
YXZDY8NSyCrSWbbM+rykvpkp399Dw3IeFjWi6QfAGqKJb7KOSdIrR0weSIuPCWnd
SoIG/ffCJS3haDkDHwGHc3sXREIXQm5jiJGMSSOHa3FCOotsjmGpmWNwECylPwQQ
1RVy0Hvc+RAP3WxYCep4KQP71MXxkf2hEy635D56WmkOPd9SuL9EmxBMhBkxQFsc
4qToPEKsi2nob4ROozyJWpghkC0HmiwQqela7MEH6GhV37C4Hec=
=wOGI
-----END PGP SIGNATURE-----

--vpo2z7bxt3vwej3c--



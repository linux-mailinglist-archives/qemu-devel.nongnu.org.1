Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BADC7E209E
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 13:01:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzyHw-0008Ie-3k; Mon, 06 Nov 2023 07:01:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qzyHk-00088K-8g
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 07:00:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qzyHh-00087z-6f
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 07:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699272047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IbieIwyWzLirg/Hvt1WTxU/mrvv7xLivYl1QUrbmPxU=;
 b=BFE8LDky/bBR9M/5SO3ZI7KOmmi5x7nPs07h4y37DId5nPXNW1GgNaleK+PFUPFrjGmP4y
 Lrybb/3umszHt79K7pWXsaUM2DET/Rr6GZ9ZY4LPt54xDA4z7ECDG+jyu4AJA9By38QyWu
 A//wbI6LPz6FBK2u2ujC0ELq0POk/BA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-NisguugwMEaanM55aMXLxQ-1; Mon, 06 Nov 2023 07:00:26 -0500
X-MC-Unique: NisguugwMEaanM55aMXLxQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5321D185A782
 for <qemu-devel@nongnu.org>; Mon,  6 Nov 2023 12:00:26 +0000 (UTC)
Received: from localhost (unknown [10.45.226.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E36E2C1596F;
 Mon,  6 Nov 2023 12:00:25 +0000 (UTC)
Date: Mon, 6 Nov 2023 13:00:24 +0100
From: Victor Toso <victortoso@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 00/11] qapi-go: add generator for Golang interface
Message-ID: <sqe4yeak64kqw5njznkojw4t24i3nj6luqi3mlrzshvnic3njh@24vb4dminwyr>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <5drfnt5rr5jmjl7xv65355squ2zzjra23mdrk5q3avnbue4kqx@7pmoj2zwfggx>
 <CABJz62PV8s=Dmh9cpa-3cRaLdNmUnW5zo4MYUA3=6kDdW8QbcA@mail.gmail.com>
 <CABJz62MQ6oYMiPicbERYoV-DYozciDXB9p5mT11P4bsajYy+KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4tetgfd5jqsx6fzb"
Content-Disposition: inline
In-Reply-To: <CABJz62MQ6oYMiPicbERYoV-DYozciDXB9p5mT11P4bsajYy+KA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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


--4tetgfd5jqsx6fzb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 03, 2023 at 11:34:18AM -0700, Andrea Bolognani wrote:
> On Tue, Oct 31, 2023 at 09:42:10AM -0700, Andrea Bolognani wrote:
> > On Fri, Oct 27, 2023 at 07:33:30PM +0200, Victor Toso wrote:
> > > Hi,
> > >
> > > Daniel & Andrea, it would be great to have your take on the Go
> > > side of this series. If we can agree with an acceptable
> > > 'unstable' version of Go modules, we can start building on top of
> > > this:
> > >  - libraries/tools in Go to interact with QEMU
> > >  - qapi specs to fix limitations (e.g: Data type names)
> > >  - scripts/qapi library wrt to generating interfaces in other
> > >    languages other than C
> > >
> > > I would love to have this prior to 8.2 feature freeze if the
> > > idea and current code meet your expectations.
> >
> > Apologies for not providing any feedback so far. I'll do my best to
> > get around to it by the end of the week.
>=20
> Layering apologies on top of apologies: I started looking into this,
> but I have since realized that I need some more time to page all the
> months-old context back in and digest the whole thing. I'll continue
> next week.
>=20
> As an appetizer, one thing that I've noticed: you seem to ignore it
> when gen:false is included in a command definition, so we get
>=20
>   type DeviceAddCommand struct {
>       MessageId string  `json:"-"`
>       Driver    string  `json:"driver"`
>       Bus       *string `json:"bus,omitempty"`
>       Id        *string `json:"id,omitempty"`
>   }
>=20
> which I don't think will work as it can't handle even the example
> used to document the command
>=20
>   { "execute": "device_add",
>     "arguments": { "driver": "e1000", "id": "net1",
>                    "bus": "pci.0",
>                    "mac": "52:54:00:12:34:56" } }
>=20
> This command will probably require an ad-hoc implementation.

Indeed, thanks for catching this.

Cheers,
Victor

--4tetgfd5jqsx6fzb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmVI1VcACgkQl9kSPeN6
SE8Hug/+OyCrXkUn2E7PdtjFpoNTbcw4tknpIHlmrB/cYRdDUpYswBe0GUCr7I4g
VYpRUlp6Jcw/Q3cG7/IGSAN6PN4sOVHcZNlyz+bpxc9eP1DREsvGM1xpPApY/xNM
faodCwuFaFjhNgNCWKt5LRsXo7J2ehMt9VY0DVMgmp1TvauNYr3OolXYlvrj8uIq
qyXUkrvNzW9j4m9xJbUH+Q1k2IygrsFIpZcn4A2GeqYtqL28CB43AqP5LCGz8Lu0
ETLocmmOytOVfYGc6B9DRCEQgAMhZ07qwQDWWQUwZ6QcTHfscwrSpiF2W5MRd0ET
2jIx7mCvcwpBZ74Ro9dnH+DYy6C9QgHpFhAZJeURulerfVlAgzaAfoXxIQp2LCGu
o/hi9xnebeYSxEONUVbbUy5D2Jjsl9CQvu6H+SsHiIeru5piey+EunqL0BdpxFu/
fzaQvtz18t0Z96LAGIaTJ+UkB1IGUBzmLguX0LY2z7RyHO/laiNDzgXbocfR8HCs
8petRdoMOD9P8v2j58YZPHNl9oBvf4UoRqzy7XoCyRrfHFc9+WD6kRzTN/V9Z+L1
uikPeh43GO5YmDcnEJxWB4nJORQtY1bgjW6yXi4wYIcmxGPY/PZGvaSFJOYEmNyE
vlMcGwO2KKbvZ4V16BQ/MFP+1DmfocJPKljT+5gdTlDAiQMM9sQ=
=zOBr
-----END PGP SIGNATURE-----

--4tetgfd5jqsx6fzb--



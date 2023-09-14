Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4AA7A06C7
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 16:02:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgmv8-000855-07; Thu, 14 Sep 2023 10:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qgmv0-00082V-Mv
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qgmuy-0001CQ-A0
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694700119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ClWqYeGKH10tyfrD2P4bOHORDIlL8Eusc56eN8hEfh8=;
 b=UyVSC1LUyPhzgfnBR1/yAxPvjK/TW6kB6dCf/nvkIpwHd0vyJFgJJsP0RlYz365EHstS3I
 GJMC8dBFR/KUkIO4gvt4SRwI/sorNETV6+M2OHDxnVOkPK5u9CVHV4nRTvEKSeEMJSl6sr
 L/V+f8as55V6glAUPPqB+F/FyruhQGs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-mpUmI4rPO3-MjV5uWv-NNA-1; Thu, 14 Sep 2023 10:01:57 -0400
X-MC-Unique: mpUmI4rPO3-MjV5uWv-NNA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BBAC80159F
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 14:01:57 +0000 (UTC)
Received: from localhost (unknown [10.45.224.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8CF440C6EC0;
 Thu, 14 Sep 2023 14:01:56 +0000 (UTC)
Date: Thu, 14 Sep 2023 16:01:55 +0200
From: Victor Toso <victortoso@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 07/11] qapi: fix example of query-rocker-of-dpa-flows
 command
Message-ID: <rfoxcr5ki2g7p42mny2ycw4fo6is6n262c7byujqw7gauqketa@zsiljvb3akc3>
References: <20230911104017.65397-1-victortoso@redhat.com>
 <20230911104017.65397-8-victortoso@redhat.com>
 <87ttrwn9sw.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="v7ebvm4ezqdco5jb"
Content-Disposition: inline
In-Reply-To: <87ttrwn9sw.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--v7ebvm4ezqdco5jb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 14, 2023 at 03:50:23PM +0200, Markus Armbruster wrote:
> Victor Toso <victortoso@redhat.com> writes:
>=20
> > Example output has a comment embedded in the array. Remove it.
> > The end result is a list of size 1.
> >
> > Signed-off-by: Victor Toso <victortoso@redhat.com>
> > ---
> >  qapi/rocker.json | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/qapi/rocker.json b/qapi/rocker.json
> > index 31ce0b36f6..858e4f4a45 100644
> > --- a/qapi/rocker.json
> > +++ b/qapi/rocker.json
> > @@ -249,8 +249,7 @@
> >  #                   "cookie": 0,
> >  #                   "action": {"goto-tbl": 10},
> >  #                   "mask": {"in-pport": 4294901760}
> > -#                  },
> > -#                  {...more...},
> > +#                  }
> >  #    ]}
> >  ##
> >  { 'command': 'query-rocker-of-dpa-flows',
>=20
> The schema patches in this series fix typos, except for this patch and
> the next one, which drop "more of the same omitted for brevity" text.  I
> believe you drop the text because it doesn't parse as JSON.

That's correct.

> Fine if the example still make sense afterwards.  Do they?

It depends what you mean by making sense. I did not setup rocker
to do this query and copied a real example. I think the real
example would have a list of size more than one.

So, if you think about real examples, it might not make sense. If
we talk about clarifying they API, I think it is reasonable.
=20
> Shortening examples is a reasonable thing to do.  Perhaps we
> should adopt a conventional way to do it, and teach the
> proposed generator to cope with it.  What do you think?

Yep, I like it. In reality, I did not do this change in v1 but it
was suggested by Daniel that the end result of introducing this
generator would be to have it run without errors, so I shortened
as a simple way to fix it.

So, should we instead move forward with another convention for
comments inside the examples? This way we could still have a list
size 1 with this patch but it would be clear that the expectation
is a bigger list.

Cheers,
Victor

--v7ebvm4ezqdco5jb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmUDElMACgkQl9kSPeN6
SE9PPQ//YnyARnBJMGOv44scgLFahqgH7le+7O0UiGZ04h0eSpmAFiBEMDiTpV2T
8V0G61UUiIIICqVXsjFBuebvljU+7HxICXrsjVXneKSsPhAJFsJ6j85W93VgOzTf
dkWQNzzSOqIeEZn1i0uSh0MBGCWRzfVGYgmp35rMRzXgVJbuwgQnEIjbAnk1mEDN
Lotg/bttJJbPd4JgzSEzcB27fB4NZ8CWJt2llkvsUDJI8r/po8FQs2mKFvlkSDSj
os/jJcfkmd5b+MoJ5JhJjTtTUm1MpuXG6r5O6/ZZ44e7Ay0SVf/OwdmJLfYj+JTi
ZUwBuyAFkMba2YZ93KVEvUaORDT9Vli13mk3JWMKobaVcfLxnDJZRLas2Yb3GSIq
3fTvpAD0F/V7MYhVwam7ESDqE4JgyhRrY/P1hJ1GWE1usyxu3CiYGPOPvOL/qgyJ
oAt+4UFiRLK0MpucePl1PdKbyy5HGj3SdXVk5M8ZLLFHudJ6efJ1VTbuPbapxtp2
8kB+ig/qMCZd+gnBE55OM6CbMiQ9zDEH7KHWB+q5GSfrAdkDVRkYiGWz9AgtftcA
eA1sDyoKGYS4xERwbNoxyMir/5bCIsRCOESz7Zvd/XjDhL7qYJH37I5jhKTIoiSC
RBaQfcwe9U1DCMv2xjkAr4gquN4HhE3o+ipfSLn46IoyGofQJaA=
=EgwH
-----END PGP SIGNATURE-----

--v7ebvm4ezqdco5jb--



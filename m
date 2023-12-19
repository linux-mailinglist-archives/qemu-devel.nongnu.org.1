Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01563818BDB
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 17:09:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFceV-0004Iz-3v; Tue, 19 Dec 2023 11:09:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rFceS-0004Ht-Nw
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 11:09:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rFceH-0002t4-0g
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 11:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703002128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nehSg1qUG4FPwQIICtA8a7u9BTZLf4UhxolRehZbvbc=;
 b=Ng6K6Q4jaqbxFvq4rusKTnei+/VzmkiX2ZxBqx0rAxLYmsAnoKh4rLVwCuBMwtuccdmlNG
 /a1mKNL6jeOv9LhPFjAH6HIQvEse2AIJBOwLctW3qqmqIiw6xRXYXVo2eu92f+h10y+pXw
 8rj5YF1zFm06U9QU4WVT0dmg+j7U4KE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-OT2NU8FwNk-5Eb8LC-2Wuw-1; Tue,
 19 Dec 2023 11:08:44 -0500
X-MC-Unique: OT2NU8FwNk-5Eb8LC-2Wuw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACD7D280BC41;
 Tue, 19 Dec 2023 16:08:43 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CD40492BC6;
 Tue, 19 Dec 2023 16:08:41 +0000 (UTC)
Date: Tue, 19 Dec 2023 17:08:40 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Michal Privoznik <mprivozn@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 1/2] qdev: add IOThreadVirtQueueMappingList property
 type
Message-ID: <ZYHACN3AEV_TW0iZ@redhat.com>
References: <20230918161604.1400051-1-stefanha@redhat.com>
 <20230918161604.1400051-2-stefanha@redhat.com>
 <877cnpsll9.fsf@pond.sub.org> <20231219151328.GA219161@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uKF9U+XoWI36t1e7"
Content-Disposition: inline
In-Reply-To: <20231219151328.GA219161@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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


--uKF9U+XoWI36t1e7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 19.12.2023 um 16:13 hat Stefan Hajnoczi geschrieben:
> On Sat, Oct 14, 2023 at 09:35:14AM +0200, Markus Armbruster wrote:
> > Stefan Hajnoczi <stefanha@redhat.com> writes:
> > > +##
> > > +# @IOThreadVirtQueueMappings:
> > > +#
> > > +# IOThreadVirtQueueMapping list. This struct is not actually used bu=
t the
> > > +# IOThreadVirtQueueMappingList type it generates is!
> >=20
> > Two spaces between sentences for consistency, please.
> >=20
> > Doc comments are QMP reference documentation for users.  Does this
> > paragraph belong there?
>=20
> Someone might wonder why a type exists that is never used, so I think
> including this in the documentation is acceptable.

I seem to remember that we had a similar remark elsewhere, but maybe it
doesn't exist any more today?

> My comment is mostly intended to stop someone from removing this
> "unused" type from the schema though. If there is a better way to do
> that I can do that instead.

Won't the QAPI generator or the compiler stop them soon enough?

Kevin

--uKF9U+XoWI36t1e7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmWBwAgACgkQfwmycsiP
L9YrWg/+L+1dhk2MFsIBSwIdCIY4bIbVpHzZwPCuPppfIlUTvIMUiUo5QIChD2vM
dZozKKk+Qp8XfRyyv1ffTqpnzMhXqhSCNgsnsD5iNNrHH8poNWW54SsyDbueVT7r
I2SIwjlye2I7rjX9E3+ZHhjcjch6bXY0/ul73cazc9fdYTdb40sKdqUPr7sh05tM
ZStRKXIIN0y0hn8ukN05f8AXcFXutNS79DPnEiuyKOSAQf8qALtdh5CPGb7+acgD
qGOGwfPYM3pfNnEBXs5Paw6rtwBU1MPKPnk3sFUzzDR+T6X25jDad3YCO1bXn72R
Yrx72s9psslcGCwqp9oq2x72hSO6CenHJFj6Ne+HzK4CbQZL8Yn0239KDQYW2faK
SbAXCEQl4JfF0VbOKqRyOEx1hCCFAX/r9B3WQ6kbjIOYB/nsrbkQZp2xfUTKB0KA
eLOdtjPNTIvCjbv8lZZZCyP+YzGKfoYTUcPOHh3dpppb6Rhhv9mNX2YVhLvWuAND
Lj5WBmnClgyuONjNY7qNWXmW4b8nbrzHdcjdifwnsc1jFXM6PWoDEZ5gloRy4TV5
LJsnsFak1Vsm3WdPWABRbnjRXJvp+IdWgg9FWYWS+Eo7IkHbYax6joiYlzOF9uaV
StUd3PbFC7WpOgFFkhZLweVJnAdPbZO8wu60Hj4LTwalDfFr38Y=
=2IzM
-----END PGP SIGNATURE-----

--uKF9U+XoWI36t1e7--



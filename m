Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5364480EE19
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 14:50:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD38v-0004he-W6; Tue, 12 Dec 2023 08:49:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rD38u-0004hQ-9E
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 08:49:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rD38p-0005hR-10
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 08:49:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702388981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gXQzA515/lspRULG6L8c0GMYQwgsdNxCdjP77r2n1Kw=;
 b=ED/jl5G5WNeTL1/h+Yah3GcgVj7By+ERvnuwy81t4LYCvUaq+vABBTnzZ5JYDS+JTHwXra
 YWsfr5Fs+siwaJQVkSRNJ7ki11lZNtWyzHnMw2Ma826D6PJG1CKpC9rtit3VAJTpWYdepD
 LNKdJsnMgzCbxgM/BtcZhYzkk+Hnd74=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-z1AsqB81P7Sv-K5vlD2rWw-1; Tue, 12 Dec 2023 08:49:39 -0500
X-MC-Unique: z1AsqB81P7Sv-K5vlD2rWw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 884658493EB;
 Tue, 12 Dec 2023 13:49:39 +0000 (UTC)
Received: from localhost (unknown [10.39.193.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E26E7492BC6;
 Tue, 12 Dec 2023 13:49:38 +0000 (UTC)
Date: Mon, 11 Dec 2023 16:15:02 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Michal Privoznik <mprivozn@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, aliang@redhat.com, qinwang@redhat.com
Subject: Re: [PATCH v2 1/2] qdev: add IOThreadVirtQueueMappingList property
 type
Message-ID: <20231211211502.GA431872@fedora>
References: <20230918161604.1400051-1-stefanha@redhat.com>
 <20230918161604.1400051-2-stefanha@redhat.com>
 <ZXcVCMU7hYZ6jhp3@redhat.com> <87msugah6x.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5vgVYxTV9Z6+lxNa"
Content-Disposition: inline
In-Reply-To: <87msugah6x.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--5vgVYxTV9Z6+lxNa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 04:32:06PM +0100, Markus Armbruster wrote:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > Am 18.09.2023 um 18:16 hat Stefan Hajnoczi geschrieben:
> >> virtio-blk and virtio-scsi devices will need a way to specify the
> >> mapping between IOThreads and virtqueues. At the moment all virtqueues
> >> are assigned to a single IOThread or the main loop. This single thread
> >> can be a CPU bottleneck, so it is necessary to allow finer-grained
> >> assignment to spread the load.
> >>=20
> >> Introduce DEFINE_PROP_IOTHREAD_VQ_MAPPING_LIST() so devices can take a
> >> parameter that maps virtqueues to IOThreads. The command-line syntax f=
or
> >> this new property is as follows:
> >>=20
> >>   --device '{"driver":"foo","iothread-vq-mapping":[{"iothread":"iothre=
ad0","vqs":[0,1,2]},...]}'
> >>=20
> >> IOThreads are specified by name and virtqueues are specified by 0-based
> >> index.
> >>=20
> >> It will be common to simply assign virtqueues round-robin across a set
> >> of IOThreads. A convenient syntax that does not require specifying
> >> individual virtqueue indices is available:
> >>=20
> >>   --device '{"driver":"foo","iothread-vq-mapping":[{"iothread":"iothre=
ad0"},{"iothread":"iothread1"},...]}'
> >>=20
> >> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >
> > When testing this, Qing Wang noticed that "info qtree" crashes. This is
> > because the string output visitor doesn't support structs. I suppose
> > IOThreadVirtQueueMapping is the first struct type that is used in a qdev
> > property type.
> >
> > So we'll probably have to add some kind of struct support to the string
> > output visitor before we can apply this. Even if it's as stupid as just
> > printing "<struct IOThreadVirtQueueMapping>" without actually displaying
> > the value.
>=20
> The string visitors have been nothing but trouble.
>=20
> For input, we can now use keyval_parse() and the QObject input visitor
> instead.  Comes with restrictions, but I'd argue it's a more solid base
> than the string input visitor.
>=20
> Perhaps we can do something similar for output: create a suitable
> formatter for use it with the QObject output visitor, replacing the
> string output visitor.

I sent an initial patch that just shows "<omitted>" but would like to
work on a proper solution with your input.

=46rom what I've seen StringOutputVisitor is used in several places in
QEMU. "info qtree" calls it through object_property_print() to print
individual qdev properties. I don't understand the requirements of the
other callers, but object_property_print() wants to return a single
string without newlines.

QObjectOutputVisitor produces a QObject. That could be formatted as
JSON using qobject_to_json_pretty()?

The pretty JSON would contain newlines and existing callers such as
"info qtree" may need to scan the output and insert indentation.

The goal would be to keep the output unchanged as far as possible and to
emit JSON for structs and lists.

What do you think about this approach?

Stefan

--5vgVYxTV9Z6+lxNa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmV3e9YACgkQnKSrs4Gr
c8iEgQgAqdMZNbIZoxYmo1DK0XamXGtRdlNZ/oqRNaXdwhAFuZ9/XO8YDjBVgejL
S8TRSrg6Sghqsj+lls2yLvlCWAbtmS8g2tnm1TZLq8V1nMGV0mN5wOfxyBRikX/i
qZOUg6HSOpoFoR8d6cNmjuQQGhnNyvoi7aF9M9BeLwArz+WENBAmpidzwsFrt21x
o3cJh4DWK0W4IfV+lDP/lgkmhk1hkRqTbw4qZZsG7164E9wVlsTBvJ99lzi5H62d
VBHdx3hqkh5jvAoqJpO1tNYF3WE1Upa/pz4l+Lyt7pCw1NZVxZy7gdXzXX2bucB3
ui4gj9wRpCOpnDn3MrJ/+hH/YRGisw==
=Iacv
-----END PGP SIGNATURE-----

--5vgVYxTV9Z6+lxNa--



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D45DE818AEC
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 16:14:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFbmv-0004lL-GL; Tue, 19 Dec 2023 10:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFbms-0004ka-SC
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 10:13:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFbmq-0001iv-VF
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 10:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702998816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qt6aiXIlWZeBjGRRJ5Kln35GChvQ+CJfMkLg7OBk/a0=;
 b=DzlSTTTCgCWryo2cEecUvEfCaslUXm+YraoAn9+tiJxg4VbkgsrIfyZzL52plkL0I0Rlku
 a3m0P9N+QbjH8HQUExYPffOLibBV0YDZyyvc/hAtkmJMxA3czjKAqbeHhKDO3SuTx00WXo
 8WkLCQQyubAs5lJuCZeClZIrNzF9HnQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-W6TPrZ3eM4ukodP6kFPx-A-1; Tue, 19 Dec 2023 10:13:31 -0500
X-MC-Unique: W6TPrZ3eM4ukodP6kFPx-A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73D6485A58F;
 Tue, 19 Dec 2023 15:13:31 +0000 (UTC)
Received: from localhost (unknown [10.39.194.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CFBA0C15968;
 Tue, 19 Dec 2023 15:13:30 +0000 (UTC)
Date: Tue, 19 Dec 2023 10:13:28 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michal Privoznik <mprivozn@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 1/2] qdev: add IOThreadVirtQueueMappingList property
 type
Message-ID: <20231219151328.GA219161@fedora>
References: <20230918161604.1400051-1-stefanha@redhat.com>
 <20230918161604.1400051-2-stefanha@redhat.com>
 <877cnpsll9.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JR126xj/yojkJDSb"
Content-Disposition: inline
In-Reply-To: <877cnpsll9.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--JR126xj/yojkJDSb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 14, 2023 at 09:35:14AM +0200, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
> > +##
> > +# @IOThreadVirtQueueMappings:
> > +#
> > +# IOThreadVirtQueueMapping list. This struct is not actually used but =
the
> > +# IOThreadVirtQueueMappingList type it generates is!
>=20
> Two spaces between sentences for consistency, please.
>=20
> Doc comments are QMP reference documentation for users.  Does this
> paragraph belong there?

Someone might wonder why a type exists that is never used, so I think
including this in the documentation is acceptable.

My comment is mostly intended to stop someone from removing this
"unused" type from the schema though. If there is a better way to do
that I can do that instead.

Stefan

--JR126xj/yojkJDSb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWBsxgACgkQnKSrs4Gr
c8gDBwf+JMClRwbswttxbtv7AtOxjJsHZe2/bwK7SepaTOIpZ6NC1GhJlijonQH4
AUzwJw4EvoLDXgcJo0m0RC0crwtKGSr3rvOeBlbNX/Iej6Qwujf2qTWsH+0uH/NG
bWGNht1JBCBQwYjezTOyZASy7Em5cshm/MzRTvm4gS1A7JfQpOyZ44cSXy/EE2MQ
Jup6EWTTy9pr4zk6u4vundtMp2vO8ayXgzgWDb4uVMZcaLkaEPzspH81kGwUpfJ8
Z4DyiOCFmcq0RKKlXQxKjZUYXkpqlF0IIFUPPNF0keXzd2pT94zGyFg4WYLbEl0v
+ECBxazTyWGac5ywme4g5HoVHmOpUA==
=XD2/
-----END PGP SIGNATURE-----

--JR126xj/yojkJDSb--



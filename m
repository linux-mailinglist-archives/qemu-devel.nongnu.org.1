Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 235F88320E2
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 22:29:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQZvo-00065a-27; Thu, 18 Jan 2024 16:28:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQZvm-00065J-Vv
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 16:28:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQZvl-0003Lv-Bk
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 16:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705613288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y44KFrYN+AF/9IEcr8SLr2eUKJgQ3JUUbJx8Hr1AVs4=;
 b=cBkWAimq2SmLA4bjI9fEvuPpHlc/cCm/XI6aEEDhv1yXdQjxUUI/uzZvqbkaZxb3oujgMF
 yfRlTWhe0BCYuIrnWe3FmSsU5Htsi87IaXMansfgDKtPl8aI6j1b9yOa2CQLGeyKFpNoUe
 9S75b1boXlV1SgchZP3xxkFBLIEtJdM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-F1elYDwgN7O1NgZCX6_W2A-1; Thu, 18 Jan 2024 16:28:03 -0500
X-MC-Unique: F1elYDwgN7O1NgZCX6_W2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAFAA83B9CA;
 Thu, 18 Jan 2024 21:28:02 +0000 (UTC)
Received: from localhost (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E389B2166B33;
 Thu, 18 Jan 2024 21:28:01 +0000 (UTC)
Date: Thu, 18 Jan 2024 16:28:00 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Michal Privoznik <mprivozn@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 4/4] virtio-blk: add iothread-vq-mapping parameter
Message-ID: <20240118212800.GA51691@fedora>
References: <20231220134755.814917-1-stefanha@redhat.com>
 <20231220134755.814917-5-stefanha@redhat.com>
 <ZYQ5PM8Hak2xDpIj@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="M1I4PXX5nZeDFc0R"
Content-Disposition: inline
In-Reply-To: <ZYQ5PM8Hak2xDpIj@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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


--M1I4PXX5nZeDFc0R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 02:10:20PM +0100, Kevin Wolf wrote:
> Am 20.12.2023 um 14:47 hat Stefan Hajnoczi geschrieben:
> > Add the iothread-vq-mapping parameter to assign virtqueues to IOThreads.
> > Store the vq:AioContext mapping in the new struct
> > VirtIOBlockDataPlane->vq_aio_context[] field and refactor the code to
> > use the per-vq AioContext instead of the BlockDriverState's AioContext.
> >=20
> > Reimplement --device virtio-blk-pci,iothread=3D and non-IOThread mode by
> > assigning all virtqueues to the IOThread and main loop's AioContext in
> > vq_aio_context[], respectively.
> >=20
> > The comment in struct VirtIOBlockDataPlane about EventNotifiers is
> > stale. Remove it.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> I'm looking at virtio_blk_dma_restart_cb/bh(). It seems to run all
> queued requests in the iothread of the first vq, but when the requests
> complete, they will push the result to their original vq.
>=20
> Do we know that the dataplane isn't started and won't be started until
> the requests complete? (I wouldn't expect so, because then moving to the
> AioContext of the BlockBackend wouldn't have been necessary either.) Or
> is there another reason why this is safe?

You are right. I overlooked this. I'll send a patch to make s->rq
multi-queue safe.

Stefan

--M1I4PXX5nZeDFc0R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWpl+AACgkQnKSrs4Gr
c8jRAwgAo1eQaQ2LJwamvxvQhuXa1mmF/tv1xEGuaiE4CGyv6vqAbLxrRDvB1tZZ
iuzwB5S1ByGQTpSvN6PLO7y3rGMjWMJ+JdDsmgnVnumSCCKW19EhTzJKG0pp51eI
5DXThDTiDajArizLceafIdSkjiHFB5iCYOsOJOkiFQbAJuh+vHfDFzNuJDfQaD6n
MWTmuuTglnKhE5X7U3wI35QrDc13zJYLcIpcD56KqxasRsbLD0pKwX6iQF2eFUp8
3gtDpPdQmxYnpmz/LB+HsjZl7TydPWO1QieIvdXrNWpI4qraL2tFTpJAktM86qKO
nA/Ntkj/neMUtcFUo7eydhFZfYaoNQ==
=IaNR
-----END PGP SIGNATURE-----

--M1I4PXX5nZeDFc0R--



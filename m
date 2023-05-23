Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA6670E0E0
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:48:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1UEv-0006cK-2S; Tue, 23 May 2023 11:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1UEs-0006RP-2c
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:47:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1UEq-00067Z-EZ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684856866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rm9mITxOyG5cxYYxQZ7UqEX4fWrCe1vU4eCgXL+WHCA=;
 b=LvlGxMphQ4CVhzZ5TzXZ9lolvBGHKbH5eRdxkGdYf/lsY11YM4oNgPso9PfwA8OgGaoDwu
 cbaLtIG9pr44u+9GWW+1ANFfywAl1F7PKvnX8G3mECZSxCNlx4m976eonh6GKOZz3qggDc
 2P3ERBFjpKRy/DdUQHljMRLTWsIBE5Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-h1xXJyOoMk6r5QUJju6_Wg-1; Tue, 23 May 2023 11:47:41 -0400
X-MC-Unique: h1xXJyOoMk6r5QUJju6_Wg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B00423C0C889;
 Tue, 23 May 2023 15:47:40 +0000 (UTC)
Received: from localhost (unknown [10.39.195.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 160DE492B0B;
 Tue, 23 May 2023 15:47:39 +0000 (UTC)
Date: Tue, 23 May 2023 11:47:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org,
 Julia Suvorova <jusual@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Anthony Perard <anthony.perard@citrix.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 1/6] block: add blk_io_plug_call() API
Message-ID: <20230523154738.GD96478@fedora>
References: <20230517221022.325091-1-stefanha@redhat.com>
 <20230517221022.325091-2-stefanha@redhat.com>
 <7bsmwvpfmf6kelaxv32p6nhqcx2f2um2vqhvhu6uw5cooztrhe@oijddrxc2ysx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/bz85OT1GdNsEeu4"
Content-Disposition: inline
In-Reply-To: <7bsmwvpfmf6kelaxv32p6nhqcx2f2um2vqhvhu6uw5cooztrhe@oijddrxc2ysx>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--/bz85OT1GdNsEeu4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 07:04:52PM -0500, Eric Blake wrote:
> On Wed, May 17, 2023 at 06:10:17PM -0400, Stefan Hajnoczi wrote:
> > Introduce a new API for thread-local blk_io_plug() that does not
> > traverse the block graph. The goal is to make blk_io_plug() multi-queue
> > friendly.
> >=20
> > Instead of having block drivers track whether or not we're in a plugged
> > section, provide an API that allows them to defer a function call until
> > we're unplugged: blk_io_plug_call(fn, opaque). If blk_io_plug_call() is
> > called multiple times with the same fn/opaque pair, then fn() is only
> > called once at the end of the function - resulting in batching.
> >=20
> > This patch introduces the API and changes blk_io_plug()/blk_io_unplug().
> > blk_io_plug()/blk_io_unplug() no longer require a BlockBackend argument
> > because the plug state is now thread-local.
> >=20
> > Later patches convert block drivers to blk_io_plug_call() and then we
> > can finally remove .bdrv_co_io_plug() once all block drivers have been
> > converted.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
>=20
> > +++ b/block/plug.c
> > +
> > +/**
> > + * blk_io_plug_call:
> > + * @fn: a function pointer to be invoked
> > + * @opaque: a user-defined argument to @fn()
> > + *
> > + * Call @fn(@opaque) immediately if not within a blk_io_plug()/blk_io_=
unplug()
> > + * section.
> > + *
> > + * Otherwise defer the call until the end of the outermost
> > + * blk_io_plug()/blk_io_unplug() section in this thread. If the same
> > + * @fn/@opaque pair has already been deferred, it will only be called =
once upon
> > + * blk_io_unplug() so that accumulated calls are batched into a single=
 call.
> > + *
> > + * The caller must ensure that @opaque is not be freed before @fn() is=
 invoked.
>=20
> s/be //

Will fix, thanks!

Stefan

--/bz85OT1GdNsEeu4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRs4BoACgkQnKSrs4Gr
c8g/3Qf8DjCIpK9YEJBH+iKEtbVAQHcEC/7bPX1ycHXFuHAraWci8xbeeGhnjLvP
qVo0xbXOZE53Ain3joyIK+OL8L+CEEkQU/uAD+VQpJB26yeEZ/edMdLb2qZekQaa
7rzckl1MWg7YXVg4nOybLVIT2tD2CbXTKYxh2ohMsM1cHEOQqXyoUW43g1VOVx1E
N+q1UH2VHWfDoHtPDu8R2Fdq+IOMf/Kl35rxKH5w79OfZGTI3tOCjWHY6JNO5H9K
uGSSWdR0Ty4DAUIG/i4l/+wigqaR1TuJ4+QojpGad9AkjESBSIuFEDtCkscVcFeU
PJUiGF+ARlcOl/9tR1Xdq/fKTOm5tw==
=NIAu
-----END PGP SIGNATURE-----

--/bz85OT1GdNsEeu4--



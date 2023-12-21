Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DC981B563
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 12:56:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGHfM-0000wk-PT; Thu, 21 Dec 2023 06:56:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rGHf3-0000kj-IN
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 06:56:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rGHez-0000F8-Hp
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 06:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703159776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IxgDrtkuBD3kbWVyFWeuiGkTn/+hcIuj77sfxXIAB0o=;
 b=TCyKoScZcNXDMwGSdUp30vAkR50ueo38F2AWUPovwc8la7IUCbYl5AhFVpm0gPicCGRImn
 5a8pElMGQKA0SzfN584QUybTzA8e7A3c8PsNfKMekUkNOvLEMw2qClMpBm4HzU5tIG92vu
 CTLR0BnTOEITDiRGitYzzlvNOGIUWmk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-efjxJOdpN-KItxGeZzTR3A-1; Thu, 21 Dec 2023 06:56:14 -0500
X-MC-Unique: efjxJOdpN-KItxGeZzTR3A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4306E8F5DA0;
 Thu, 21 Dec 2023 11:56:14 +0000 (UTC)
Received: from localhost (unknown [10.39.194.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 839292166B33;
 Thu, 21 Dec 2023 11:56:13 +0000 (UTC)
Date: Thu, 21 Dec 2023 06:56:11 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 6/6] nbd/server: introduce NBDClient->lock to protect
 fields
Message-ID: <20231221115611.GA1578764@fedora>
References: <20231221014903.1537962-1-stefanha@redhat.com>
 <20231221014903.1537962-7-stefanha@redhat.com>
 <da5f4630-b09b-49d0-9457-4fc71d43a682@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xcBAHf+FqD7GuuEI"
Content-Disposition: inline
In-Reply-To: <da5f4630-b09b-49d0-9457-4fc71d43a682@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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


--xcBAHf+FqD7GuuEI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 08:26:58AM +0100, Paolo Bonzini wrote:
> On 12/21/23 02:49, Stefan Hajnoczi wrote:
> >       nbd_client_receive_next_request(client);
> > +
> > +    qemu_mutex_unlock(&client->lock);
> > +
> >       if (ret =3D=3D -EIO) {
> >           goto disconnect;
> >       }
>=20
> I think I slightly prefer if disconnect is reached with lock taken, for
> consistency with the "done" label.  It does not complicate the code,
> because you can just move qio_channel_set_cork() and replace:

Yes, that makes the code easier to follow. Will fix in v2.

Stefan

--xcBAHf+FqD7GuuEI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWEJ9sACgkQnKSrs4Gr
c8iIhAf/UtX+Oh1/ofZ8w6kMpFIrrT/FFOOc2+P1R/aIY2Mz/b5JXwMpew4Xpett
r3Xxtb/c5ob7dDGaq0xvl1ArPGLDyVhACKdFnUbMFMkZxZ9NYPIfa5qB76Izv0Mh
bbrtvG0FT33qzsbM3B06eEhX5VuFnlpkFsCUjjmxyZCXvt7KeVlIORjf/rtxnXeY
qm1f+G5yak4pETmCkvxQ9z2F7rDJjoPpFP9/o/rzE6/xh7H4d22E/lcVu1H2wqls
1IfiK7bxuixMRr2Ub/XWfZKYNG7o3/sT8iVZBeZgI4NA4OqJeEHjCZEBRY1ec8lC
yZKFmc7P+AKXeXkRhPMtkfdoA1hvsQ==
=qZRA
-----END PGP SIGNATURE-----

--xcBAHf+FqD7GuuEI--



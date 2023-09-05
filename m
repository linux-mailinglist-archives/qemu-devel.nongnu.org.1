Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E8679308E
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 22:58:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdd6d-0007X1-1Z; Tue, 05 Sep 2023 16:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qdd6Z-0007UB-T7
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 16:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qdd6W-0003YV-8H
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 16:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693947415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p6uWxtrd0Sm4ALEe53o8K0Jz8iI/O2mZ3aD1ylmLS+8=;
 b=bReLHQPSvFRal+SUb9uQp26PMfqQWz0pogO1tNW0gWrKQLw34zS1PeTUoGKjGgWAgwP7jh
 PzBMSgg9PAoblGj5AxLh5+nz7vfHp43dkgvlMprm3ynq/745otNgNAyk2ou6+UVRbW0rql
 5vjFHn+hRu5TIFeslAk3kUUEuzELRtM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-8D-Xcu2zPSq-bj5_vIoP3g-1; Tue, 05 Sep 2023 16:56:52 -0400
X-MC-Unique: 8D-Xcu2zPSq-bj5_vIoP3g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C38FF1C05137;
 Tue,  5 Sep 2023 20:56:51 +0000 (UTC)
Received: from localhost (unknown [10.39.192.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 366BF568FF;
 Tue,  5 Sep 2023 20:56:51 +0000 (UTC)
Date: Tue, 5 Sep 2023 16:56:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3] iothread: Set the GSource "name" field
Message-ID: <20230905205649.GA530281@fedora>
References: <20230905180359.14083-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LWorslbDKTjL64yk"
Content-Disposition: inline
In-Reply-To: <20230905180359.14083-1-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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


--LWorslbDKTjL64yk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2023 at 03:03:59PM -0300, Fabiano Rosas wrote:
> Having a name in the source helps with debugging core dumps when one
> might not have access to TLS data to cross-reference AioContexts with
> their addresses.
>=20
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> v3:
> used const
> v2:
> used g_autofree where appropriate
> ---
>  iothread.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Thanks, applied to my monitor-drain_call_rcu tree:
https://gitlab.com/stefanha/qemu/commits/monitor-drain_call_rcu

Stefan

--LWorslbDKTjL64yk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT3lhAACgkQnKSrs4Gr
c8hmhQf+PgAHa0/ItvHsoofQjjvDuKlq6YfhbnssL0x64PbIoKc28jNUAjCWnrKR
kZc3kpzSIq8eQ3YBGcRi+AKiBDWQLjN+8+cpqvLzZ3NyvKIxM78URzFSumoGY1tL
L/DLH4C5mBhUxJEVNdqDWjH1ZSG20YXMBQY4l0E3p+WhhNO66eamW49JmUung4km
3UQYGYR5lL9N8yims18Orsh5ZI0Br+D0PDVAVunuS2PKyVf1lJf9Ysj0IXb0E00a
7bgQJqY6zNzWtcHrmGtD+4SBh+yKVHZqq/uHTisrRLLWideSvFBkiy0aN6RWv8vA
VDjW+TbewIH1cm99rt8JtYuwQXjbZQ==
=fa7B
-----END PGP SIGNATURE-----

--LWorslbDKTjL64yk--



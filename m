Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F20727CACDF
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 17:05:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsP8Y-0001Vn-0B; Mon, 16 Oct 2023 11:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qsP8T-0001V6-5Q
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:04:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qsP8O-0006Xo-R5
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697468636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l0Mn7+jp2EbdD6tMqOyTqclAZc6aqDVz3lwJBfwAZ0A=;
 b=OINcFwUzuvJf2n7Dy1maNkyMwoATRh7erY/JwrJ4wfDJDxJGVai69EyBQxJrHy7cx50G/R
 blHDvqKkB3denZzVK4vjnOHh2qFkx4NK5ZkU3p2pou25qEfkdph+RDjUIo6mXj+mkfw/sc
 fTBnMgiULYliEfBPUMIFGrMOYlWxQqA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-696-pwojv5P4Of6YjUITQ9dqRA-1; Mon, 16 Oct 2023 11:03:40 -0400
X-MC-Unique: pwojv5P4Of6YjUITQ9dqRA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB5D23C0E45D;
 Mon, 16 Oct 2023 15:03:37 +0000 (UTC)
Received: from localhost (unknown [10.39.195.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09D361C060AE;
 Mon, 16 Oct 2023 15:03:36 +0000 (UTC)
Date: Mon, 16 Oct 2023 11:03:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>,
 Jeff Cody <codyprime@gmail.com>,
 "open list:Block Jobs" <qemu-block@nongnu.org>
Subject: Re: [RFC PATCH v3 02/78] block: add fallthrough pseudo-keyword
Message-ID: <20231016150333.GC119987@fedora>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
 <e54aa70630d6d524886d7950b84d5bda39c3d605.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oYTzAa64K7383oip"
Content-Disposition: inline
In-Reply-To: <e54aa70630d6d524886d7950b84d5bda39c3d605.1697186560.git.manos.pitsidianakis@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--oYTzAa64K7383oip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 11:45:30AM +0300, Emmanouil Pitsidianakis wrote:
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
>=20
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  block/block-copy.c    |  1 +
>  block/file-posix.c    |  1 +
>  block/io.c            |  1 +
>  block/iscsi.c         |  1 +
>  block/qcow2-cluster.c |  5 ++++-
>  block/vhdx.c          | 17 +++++++++++++----
>  6 files changed, 21 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--oYTzAa64K7383oip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUtUMUACgkQnKSrs4Gr
c8igkwgAu8zFELOZAKZevXpo1F+zkmES23N25nqjzRUkGLpe4SQSoWQNA0kAx9+X
CuwZAAkeQFwOFLiWtNOMH7ydTRpWeFThTLcLaqu0A0hzyzPnbtoodt3/9wpYyp8t
cNODmvSGOv9AIsye2nRc0n0TKY3ZLkvSWG/S0Lo6RPTXHzJBw3srWApxqrqMvdmt
37LnURP1WF5Iadd1rXAvClaSR1z8mkKh3V0zEoYMRfbE6BIBTJzo1mWFTlEKz3YK
DdnAqMvzUdd88iurB28ndL4aC2fP5zifv0t78ZKwanzygt96fAjLvfokHXxTMA/N
PWfSQk0FLnvwusCzHI5Sq4ZQEq7IEw==
=j3RB
-----END PGP SIGNATURE-----

--oYTzAa64K7383oip--



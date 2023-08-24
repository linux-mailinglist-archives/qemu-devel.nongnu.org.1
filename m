Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 077407871C2
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 16:37:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZBOQ-0007ND-Kn; Thu, 24 Aug 2023 10:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZBOO-000756-DF
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 10:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZBOL-00017A-QN
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 10:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692887576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nMqbmSc7Os29AGJmbrJcftmBaqb+V8gGiz1hXukt4Zs=;
 b=g8cq7/wLnRxY0kHyY6TM+ukR2ZoVvWzna2UuUsMRu2kIadgsQvwFvNnyDljjlJOaTpi8l3
 HkpoOPHzCcePuDMpZ41Xsc0Fc+1AekVM9ndLU0UX9wZpNXKd22Iy2k867KS1eCAz6oVnB+
 X33grYduwI+fomnEMFzxXZrxRz8dGQ0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-lm_cOiBnOVqx37MeFUrdZw-1; Thu, 24 Aug 2023 10:32:53 -0400
X-MC-Unique: lm_cOiBnOVqx37MeFUrdZw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79AF91C0CCB2;
 Thu, 24 Aug 2023 14:32:50 +0000 (UTC)
Received: from localhost (unknown [10.39.194.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB9B54A9004;
 Thu, 24 Aug 2023 14:32:49 +0000 (UTC)
Date: Thu, 24 Aug 2023 10:32:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, vsementsov@yandex-team.ru, eblake@redhat.com,
 den@openvz.org, fam@euphon.net
Subject: Re: [PATCH v2 0/3] block: align CoR requests to subclusters
Message-ID: <20230824143247.GB1412804@fedora>
References: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
 <c49fd209-9a6a-9e0d-752f-30a5178d855b@virtuozzo.com>
 <85e0a9bb-8e8f-e414-70ad-528e45a803e4@virtuozzo.com>
 <60354ae2-d394-49b8-8289-787b4e02e2a6@virtuozzo.com>
 <577e81f0-1479-41b2-9e97-ad6678cf7216@virtuozzo.com>
 <CAFn=p-bz35mcXgG81Dk70u4u8A8cqERot2=fJjYAcweThE0fVQ@mail.gmail.com>
 <3ea51ea2-0138-4a0e-92f0-175d8ad7540e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JRwA8EvR7o0BlQQd"
Content-Disposition: inline
In-Reply-To: <3ea51ea2-0138-4a0e-92f0-175d8ad7540e@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--JRwA8EvR7o0BlQQd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 03:50:55PM +0300, Andrey Drobyshev wrote:
> On 8/22/23 22:58, John Snow wrote:
> > On Tue, Aug 22, 2023 at 1:33=E2=80=AFPM Andrey Drobyshev
> > <andrey.drobyshev@virtuozzo.com> wrote:
> >>
> >> On 8/16/23 12:22, Andrey Drobyshev wrote:
> >>> On 7/31/23 17:51, Andrey Drobyshev wrote:
> >>>> On 7/24/23 16:11, Andrey Drobyshev wrote:
> >>>>> On 7/11/23 20:25, Andrey Drobyshev wrote:
> >>>>>> v1 --> v2:
> >>>>>>  * Fixed line indentation;
> >>>>>>  * Fixed wording in a comment;
> >>>>>>  * Added R-b.
> >>>>>>
> >>>>>> v1: https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg00=
606.html
> >>>>>>
> >>>>>> Andrey Drobyshev (3):
> >>>>>>   block: add subcluster_size field to BlockDriverInfo
> >>>>>>   block/io: align requests to subcluster_size
> >>>>>>   tests/qemu-iotests/197: add testcase for CoR with subclusters
> >>>>>>
> >>>>>>  block.c                      |  7 +++++
> >>>>>>  block/io.c                   | 50 ++++++++++++++++++-------------=
-----
> >>>>>>  block/mirror.c               |  8 +++---
> >>>>>>  block/qcow2.c                |  1 +
> >>>>>>  include/block/block-common.h |  5 ++++
> >>>>>>  include/block/block-io.h     |  8 +++---
> >>>>>>  tests/qemu-iotests/197       | 29 +++++++++++++++++++++
> >>>>>>  tests/qemu-iotests/197.out   | 24 +++++++++++++++++
> >>>>>>  8 files changed, 99 insertions(+), 33 deletions(-)
> >>>>>>
> >>>>>
> >>>>> Ping
> >>>>
> >>>> Another ping
> >>>
> >>> Yet another friendly ping
> >>
> >> One more friendly ping
> >=20
> > Looks like Stefan gave you an R-B for the series; do we just need an
> > ACK by the block maintainers at this point or is there someone
> > specific you're hoping will review this?
> >=20
> > --js
> >=20
>=20
> Hi John,
>=20
> I figure a maintainer's R-b doesn't imply the patches being merged into
> the tree.  Hence I'm waiting for the notice that they actually are merged.
>=20
> Please let me know if the process should be different.

Hi Andrey,
Kevin is away right now but seemed happy enough when I mentioned this
series to him, so I have merged this into my own tree:

  https://gitlab.com/stefanha/qemu block

Sorry that your patch series have not been merged in a timely manner.

Stefan

--JRwA8EvR7o0BlQQd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTnag4ACgkQnKSrs4Gr
c8g74Qf/Y4IluNq0ki7mzT+OGaxf/cyyNgHyP70chYlQzFHy+0fU3tcGLG+nbQsr
nIooAWTcQ7le4Ytt2ymXi8bzKnmunxhZQAu5FHwX/MSIazSgCv1yloWv5Bgh8mQH
goVfH3kKADJXrsrKptdRNTChTJW3UDPDhg/uF+y2/Y6AnEMuuBuToUbZmdx2RDp3
64L9IKaWpr3T2yhRZOpXeAy2jjuM4f/ba0tYUkkBgQopZHGw0j+h80xjIU5Ta1Vx
EQaD3Bj7B5NScXsmIOTr06R3zZP8qrqlooM0nIKXVNGQbldtwWHgLx8QbL2Q0P3W
pobnPa83tmlnX4c01bX48E6bVfy5LA==
=iZT4
-----END PGP SIGNATURE-----

--JRwA8EvR7o0BlQQd--



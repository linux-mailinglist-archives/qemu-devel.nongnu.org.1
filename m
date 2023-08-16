Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A85AE77E313
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 15:53:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWGxQ-0006Ct-MB; Wed, 16 Aug 2023 09:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qWGxK-00062Y-QB
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 09:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qWGxH-0004eH-Oz
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 09:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692193979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=blE/aYKpysKoZu+DnzhSSmm9E+7zD8+IP8115IHHpEc=;
 b=JBqjJH/cUBeoV7RZdfT8DRlxxYr/+Z11OEJg11PRyazxJTwVoW1xDRWaQVOybKCW3Z0Kaw
 2R17Ew+4pKhblmCFgRv9dA6TfofWHxdtyQy3enRpv65qgO2COJmTk9hh5tC8Bw4pvcBi8S
 2Vue7k2ggyBqZtBnxsNY/mHgLuae/rQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-696--ypWdAj_MPm3y3kTOhVWug-1; Wed, 16 Aug 2023 09:52:55 -0400
X-MC-Unique: -ypWdAj_MPm3y3kTOhVWug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 167633C14AA8;
 Wed, 16 Aug 2023 13:52:55 +0000 (UTC)
Received: from localhost (unknown [10.39.193.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7082F2166B2D;
 Wed, 16 Aug 2023 13:52:54 +0000 (UTC)
Date: Wed, 16 Aug 2023 09:52:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 kwolf@redhat.com, hreitz@redhat.com, vsementsov@yandex-team.ru,
 eblake@redhat.com, den@openvz.org,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: Re: [PATCH v2 0/3] block: align CoR requests to subclusters
Message-ID: <20230816135253.GA3432536@fedora>
References: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vL4+WIDC3lQlJGjy"
Content-Disposition: inline
In-Reply-To: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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


--vL4+WIDC3lQlJGjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 08:25:50PM +0300, Andrey Drobyshev via wrote:
> v1 --> v2:
>  * Fixed line indentation;
>  * Fixed wording in a comment;
>  * Added R-b.
>=20
> v1: https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg00606.html
>=20
> Andrey Drobyshev (3):
>   block: add subcluster_size field to BlockDriverInfo
>   block/io: align requests to subcluster_size
>   tests/qemu-iotests/197: add testcase for CoR with subclusters
>=20
>  block.c                      |  7 +++++
>  block/io.c                   | 50 ++++++++++++++++++------------------
>  block/mirror.c               |  8 +++---
>  block/qcow2.c                |  1 +
>  include/block/block-common.h |  5 ++++
>  include/block/block-io.h     |  8 +++---
>  tests/qemu-iotests/197       | 29 +++++++++++++++++++++
>  tests/qemu-iotests/197.out   | 24 +++++++++++++++++
>  8 files changed, 99 insertions(+), 33 deletions(-)
>=20
> --=20
> 2.39.3
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--vL4+WIDC3lQlJGjy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTc1LQACgkQnKSrs4Gr
c8jQsgf/SEcJkCuBlHwi49sun91Z3kTON9tGzjrV4JOZWKhdd0HM2uVA+I97d2ge
EGJTc1c4ZRg//mTAWjUrLBBui/56kw4iNj2Xws8REel9xy0M8wFDbqtI2D+BmHAo
z/oa8wCUsMtT47YmrFB7+BbP7GTn7oVl3IHTc+eC+iVzQqKd+hnJkv8m39XhPKaz
4pCfZHsd5piAy2wXBZpif0rfNsQd028jd557R8IFizpIbNZYPmT3Pq8OdG9GRgRn
eJ2AMTiUj3l1LcVMsgE+6OU/dUiuVhQL+iwNw0QhCFVOKPobjzmHRly9GzUWc4tc
644DYrCOh9IughcjGvCgfnEQi39R8Q==
=dH9F
-----END PGP SIGNATURE-----

--vL4+WIDC3lQlJGjy--



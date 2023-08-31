Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5862B78F346
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 21:25:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbnHx-0002r9-9z; Thu, 31 Aug 2023 15:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbnHs-0002qb-3T
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 15:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbnHq-0003Rv-1w
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 15:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693509901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aCX7Roe7lgAeuJ04Wd+aBj3yNRL+/6WAn3/NsVYv67o=;
 b=QQd/JVvL8PSJJklBoRjMRjFrO1ELsVbTgwVoxTtswlDSri06RvShDi3imfct5MkEYttBKJ
 gxFGF0gjKKjHw21uP1wiAAJEhflJQLG/959GJ+R1mBJ5VT6mb0HHwBYxeY5+cnW2/9rMsm
 wIeJ+WUGdAs5KuM24KP8FaE3ynm+ZCc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-3z7pV_keMIyc36zB9mNkRA-1; Thu, 31 Aug 2023 15:24:54 -0400
X-MC-Unique: 3z7pV_keMIyc36zB9mNkRA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BA39299E742;
 Thu, 31 Aug 2023 19:24:53 +0000 (UTC)
Received: from localhost (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C68240C2063;
 Thu, 31 Aug 2023 19:24:51 +0000 (UTC)
Date: Thu, 31 Aug 2023 15:24:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 idryomov@gmail.com, pl@kamp.de, sw@weilnetz.de,
 sstabellini@kernel.org, anthony.perard@citrix.com, paul@xen.org,
 pbonzini@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, thuth@redhat.com, philmd@linaro.org,
 fam@euphon.net, quintela@redhat.com, peterx@redhat.com,
 leobras@redhat.com, kraxel@redhat.com, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH 6/7] block: Clean up local variable shadowing
Message-ID: <20230831192450.GB532982@fedora>
References: <20230831132546.3525721-1-armbru@redhat.com>
 <20230831132546.3525721-7-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="V8X+bYL3C2bPPQtN"
Content-Disposition: inline
In-Reply-To: <20230831132546.3525721-7-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--V8X+bYL3C2bPPQtN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 03:25:45PM +0200, Markus Armbruster wrote:
> Local variables shadowing other local variables or parameters make the
> code needlessly hard to understand.  Tracked down with -Wshadow=3Dlocal.
> Clean up: delete inner declarations when they are actually redundant,
> else rename variables.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block.c              |  7 ++++---
>  block/rbd.c          |  2 +-
>  block/stream.c       |  1 -
>  block/vvfat.c        | 34 +++++++++++++++++-----------------
>  hw/block/xen-block.c |  6 +++---
>  5 files changed, 25 insertions(+), 25 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--V8X+bYL3C2bPPQtN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTw6QIACgkQnKSrs4Gr
c8jv+wgAp6Bn3IdAxQ34Kzvg5ACHF4Zw7LSLIBoSZ7iindUoJORMnR9rAszp98Xd
YLGEToT0e5nBhrzISbSOj2i4dSGQvdqDx0KhhKApn4VwPMzk2EAN43j2Ek0eMIoe
/zABxa3splVjeZ1OygB7xLXB0DozqvTT4g9nxmTi+CLw/bUsqY0vys9LPlXHsvmS
YzQNXX+0/dyK29KRdYouoWJO7NOhUgW/uI5uND3B3272/tQH8PA4qin9n3jIKTiN
RS4bCzd2dAf/Jmj8f4t8JvnS3lod3mmOv8ofbFjdZrtHxiMhtLn5lJGTNEI5wtIr
hUDMx/dmvONyEsCY6ZHUqfDH3EDE5w==
=NToX
-----END PGP SIGNATURE-----

--V8X+bYL3C2bPPQtN--



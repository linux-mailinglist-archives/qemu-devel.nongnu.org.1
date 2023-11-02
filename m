Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 349EE7DEB22
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 04:08:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyO3H-0004Bx-EQ; Wed, 01 Nov 2023 23:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qyO3G-0004Ba-1n
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 23:07:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qyO3E-0003Ib-I5
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 23:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698894438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HVB0dcKplVKjilgJJqQV5PdobAnqGYOBw8/ST0QMoZU=;
 b=VtqXNWuZ8/yWCoPebw2E89Jp3PuaPBgTD1sTfwAL3bbKBICuH0EvvL2A8zQ8ntqnZKRorp
 Qq5dBwTEMFe0TQ5Zs/4WIM0O1silxDzsogvXdeNaQsyVv5XzatlnQLpa5477iDTYmJ/hYb
 WQt0gbRFl8gU+WZQ7lIQx/7678hksMY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-xeKWZX8JMYSk0CFgZ3P_Pg-1; Wed,
 01 Nov 2023 23:07:14 -0400
X-MC-Unique: xeKWZX8JMYSk0CFgZ3P_Pg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BFAE3816C93;
 Thu,  2 Nov 2023 03:07:13 +0000 (UTC)
Received: from localhost (unknown [10.39.192.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3A952026D6E;
 Thu,  2 Nov 2023 03:07:12 +0000 (UTC)
Date: Thu, 2 Nov 2023 11:07:10 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Naohiro Aota <nao.aota@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Sam Li <faithilikerun@gmail.com>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] file-posix: fix over-writing of returning zone_append
 offset
Message-ID: <20231102030710.GA705642@fedora>
References: <20231030073853.2601162-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="acrXJBGfg3iMLRLi"
Content-Disposition: inline
In-Reply-To: <20231030073853.2601162-1-naohiro.aota@wdc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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


--acrXJBGfg3iMLRLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 04:38:53PM +0900, Naohiro Aota wrote:
> raw_co_zone_append() sets "s->offset" where "BDRVRawState *s". This point=
er
> is used later at raw_co_prw() to save the block address where the data is
> written.
>=20
> When multiple IOs are on-going at the same time, a later IO's
> raw_co_zone_append() call over-writes a former IO's offset address before
> raw_co_prw() completes. As a result, the former zone append IO returns the
> initial value (=3D the start address of the writing zone), instead of the
> proper address.
>=20
> Fix the issue by passing the offset pointer to raw_co_prw() instead of
> passing it through s->offset. Also, remove "offset" from BDRVRawState as
> there is no usage anymore.
>=20
> Fixes: 4751d09adcc3 ("block: introduce zone append write for zoned device=
s")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  block/file-posix.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--acrXJBGfg3iMLRLi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVDEl0ACgkQnKSrs4Gr
c8guEQgAjuBybyO8/xov1K2OmDjlGYJBL6A6Sjs5NfzGYz3RfMBGRQ2BMQKLcjCA
zIY4+02Z6s/ncJ+3yE5EmXRH9Av4sp5Hdj4sMdlCYzzwY90swRuMQUtQpb3CCu/b
XIYE43u9ed3slnitHqmntUgdZjs+bxovB102OTC9KkqFjsoQS3lvm9Lmq/i3gS15
/y2KjAX3b9fJcFGbVoJsJjTHf8mWhF/x83Vcmrpt2BdszYm5xG2eWK8Fr6NKCRkr
AiWR225qKd0ux7dqcbLFs4OFiODZAbovnmlVxEHtnW4QGmNn7/Aluz4RcoB87AT7
oWWMF45Z8MAXXhLycWEwWLKGpTcX0w==
=ntsM
-----END PGP SIGNATURE-----

--acrXJBGfg3iMLRLi--



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F1476EE22
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 17:29:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRaG6-0001bf-3Q; Thu, 03 Aug 2023 11:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qRaG3-0001ax-Qs
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:28:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qRaG2-0001nG-Dr
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691076537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uf0fG7S12anuO5EOgbS7soM6aDtcJOQMQj73C66CZ/Q=;
 b=N13csNCimdMlnA1jipWhyLbWjzVNVaHn0hMUFdFOsyTJY1wU+SaGUccdPCdmQfKx1E36Fp
 G5eY1R9r4P/WIW4BYXA8aAkMN/7u5NyAcDbl6p0KQkhKkQYNPqTmYcN8Yscb4XrfmWo/Yf
 TVXKiqsqvL4vTpIT99k7INfmWNKbFSQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-cBdutjZuM7iLELkGyFdlzg-1; Thu, 03 Aug 2023 11:28:54 -0400
X-MC-Unique: cBdutjZuM7iLELkGyFdlzg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DA753C025AD;
 Thu,  3 Aug 2023 15:28:54 +0000 (UTC)
Received: from localhost (unknown [10.39.194.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CED5C477F63;
 Thu,  3 Aug 2023 15:28:53 +0000 (UTC)
Date: Thu, 3 Aug 2023 11:28:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 0/2] block/blkio: fix fd leak and add more comments
 for the fd passing
Message-ID: <20230803152852.GB2336534@fedora>
References: <20230803082825.25293-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gBEb6PydFY2VB5N6"
Content-Disposition: inline
In-Reply-To: <20230803082825.25293-1-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--gBEb6PydFY2VB5N6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 10:28:23AM +0200, Stefano Garzarella wrote:
> Hanna discovered an fd leak in the error path, and a few comments to
> improve in the code.
>=20
> v2:
>   - avoid to use `fd_supported` to track a valid fd [Hanna]
>=20
> v1: https://lore.kernel.org/qemu-devel/20230801160332.122564-1-sgarzare@r=
edhat.com/
>=20
> Stefano Garzarella (2):
>   block/blkio: close the fd when blkio_connect() fails
>   block/blkio: add more comments on the fd passing handling
>=20
>  block/blkio.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
>=20
> --=20
> 2.41.0
>=20

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--gBEb6PydFY2VB5N6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTLx7QACgkQnKSrs4Gr
c8jVUwf9GXNvq9DI4L5vrxeeyoGZ2iDBd+o6nvDikbLI4HiLbqJtGKrRuhGkPSni
gK2WlaFrfhj+AdzmEbirlRTFag27nruc3Lb8WCdU0Rvi2AcXKyZT5BpEz4Nl3z4k
QjVh2QVQqgvqVfiym0npvYCvbB1VXSusa7aHwQgaUsL/piTBnxSybVvOQQ3PFpB/
93sPpfUbnQOoZj3El0Ldo2s00CGqdTscDWw0+8JGfMyNgMpq+t9aVCziJke1ts6J
KZLY+dbHVV7uoV806aJDvyJNr5/9fI421c7ggGr9gSefq3CXOaFSb5SrKCGjJERk
db+AQrE2g75y5Goh4DQcOGX+KwpMXA==
=W/HS
-----END PGP SIGNATURE-----

--gBEb6PydFY2VB5N6--



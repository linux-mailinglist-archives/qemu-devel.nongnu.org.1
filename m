Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B193D78D797
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 18:23:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNyc-0007zR-RJ; Wed, 30 Aug 2023 12:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbNya-0007wc-6C
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:23:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbNyX-00062r-Mq
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693412603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7EuHn1ASKrJfSuy2uNbj4uRIotgAhs3ITkUctuSMyn8=;
 b=LnICeG92NYOjyW3ZcuOpvSDoABT5In1TKNG8CXpxqUb1X/PEHQ5Dc2MW6FH3tZetobeZ10
 IBFBXNeD3gwI4m9b3LmlZCfDahPMycQYW3wclVsRwGkh+Sf1py4Lq+7B/J8EQEqF+hyc6G
 PLPX6LabwuFDPQPtJXWjfq45w0+8A+0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-PoExXC4oMASkm8sshFI3oA-1; Wed, 30 Aug 2023 12:23:21 -0400
X-MC-Unique: PoExXC4oMASkm8sshFI3oA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BEAE9101A528;
 Wed, 30 Aug 2023 16:23:20 +0000 (UTC)
Received: from localhost (unknown [10.39.193.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4E1E492C14;
 Wed, 30 Aug 2023 16:23:19 +0000 (UTC)
Date: Wed, 30 Aug 2023 12:23:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Jeuk Kim <jeuk20.kim@samsung.com>, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PULL v3 0/5] Block patches
Message-ID: <20230830162318.GA474789@fedora>
References: <20230830114942.449060-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0OchaymyIa0j6mC7"
Content-Disposition: inline
In-Reply-To: <20230830114942.449060-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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


--0OchaymyIa0j6mC7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--0OchaymyIa0j6mC7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTvbPYACgkQnKSrs4Gr
c8h0egf/dnWu+lwiiBA4tO305utm0U8vbUUvzk7HAFdeFdhGvyedyRUrPcJ1iBpi
iPAtfhLAHDcP9qrShI0QTdBKAjK5JzXIRp2PlkIV+i4l2wX7oI75ugPBV6d8PpmG
MnXLWxKlCL9FUVv5ZpgzCJ1fxJoO0Owzj2RCztstIafUMlx7KFSfWqjyiVeCnu4w
5QWY+5Zy2I9m+EnKEiDrhXsX8OEuvPMijwo7/lvFBnmAeQLZQZ9mj88U5TOG4cPo
bZiJvb9F62Qb9Fh9DRZRQRv7pzDnDZOlHzeTkAYkelNKEHdH+1yDYzewyRlqMlC9
t+rbKBgsZMHk8iwuylSP25sUIz4YOg==
=scsa
-----END PGP SIGNATURE-----

--0OchaymyIa0j6mC7--



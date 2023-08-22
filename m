Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6990784AA0
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:43:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYXFQ-0001UT-60; Tue, 22 Aug 2023 15:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYXFO-0001Tw-KT
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYXFL-0006cX-0Y
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692733256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=br2wln4ONcOSHVrSNZHrzANY2w61bzWjpZg8kCKn/J0=;
 b=Q4X657uEvi8Vyo/8V3fRmbuJYtbwrfNN0GzJILS4XzinS41ucpwee8vHhcRpD40oEMgBV6
 JCAyc0k6DPjAvrB7jTbEr/8QMEcC9OU4yEjCiLI/5qhhUf8YZhTMUbjZQJWQuKiW0JB0O6
 lcwxl+dsr/vK13McflaJdyRSEWqfmTg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-tc11BpOoOkCY-8sjKM66YQ-1; Tue, 22 Aug 2023 15:40:52 -0400
X-MC-Unique: tc11BpOoOkCY-8sjKM66YQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 149563814942;
 Tue, 22 Aug 2023 19:40:52 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F7E9C15BAE;
 Tue, 22 Aug 2023 19:40:51 +0000 (UTC)
Date: Tue, 22 Aug 2023 15:40:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 21/21] block: Mark bdrv_add/del_child() and caller
 GRAPH_WRLOCK
Message-ID: <20230822194050.GX727224@fedora>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-22-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hZGHJ1x/UUL0hQTZ"
Content-Disposition: inline
In-Reply-To: <20230817125020.208339-22-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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


--hZGHJ1x/UUL0hQTZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 02:50:20PM +0200, Kevin Wolf wrote:
> The functions read the parents list in the generic block layer, so we
> need to hold the graph lock already there. The BlockDriver
> implementations actually modify the graph, so it has to be a writer
> lock.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block-global-state.h |  8 +++++---
>  include/block/block_int-common.h   |  9 +++++----
>  block/quorum.c                     | 23 ++++++-----------------
>  blockdev.c                         | 17 +++++++++++------
>  4 files changed, 27 insertions(+), 30 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--hZGHJ1x/UUL0hQTZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTlD0IACgkQnKSrs4Gr
c8i+rAgAo05Op9FsLS9Ypq3uWdKk7CCyRFQb1jBdmMwpo9Xl0GW7cMg4Gv8vjn1N
Eb+QPb8eDqEERxmKfAN2GOz5sPUrsch9+wQzqpVDV0dQE/pBXwmrPKq+drbkEhfd
UapTpg0yQAuHK6E6q68HTCN3z5/37BNlSybupdekKPQG97gsgW+KqdG9rlKMZSD+
wteolDlqDpV+V3nYqgyTOUD+BYJDGsBon89/f7nJOYXxfad11dVBWu0TyFuXAZjS
63hL7NkvvbYsW6zQvIAqPJgVbLqwZOC8+7Fk9oc7tF+Ed7B7nCd6QnCG+7rg84gy
Qu0FXqT0eN83FbYtXpokV27+EK225Q==
=5+fB
-----END PGP SIGNATURE-----

--hZGHJ1x/UUL0hQTZ--



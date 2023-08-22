Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E445A784A6F
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:29:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYX3T-0007Vb-Ol; Tue, 22 Aug 2023 15:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYX3R-0007VO-IR
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYX3P-0003CK-Ej
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692732518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GCYSDw2ozJ6861oijCSFiUlAGaI4S76kmR9BBpMAMGE=;
 b=SXJMb+gC+VWvRhmcSWIn5cytGdOMkUsPbroongbCa1wYrlYVj/FnSr3LYpugw4sbo1JBzb
 MdjiVZQSD9RLMwwedLvNWwaXzRg4yGMA1U6fZWrnD11Z/OKeIMA4QUXXxb7kzZ6ge/bn+H
 ubchhDJyhfr4PdN80jFGtyYJvU8U+Ow=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-qpkTb8wMO1-ZmC6fMYqVSQ-1; Tue, 22 Aug 2023 15:28:36 -0400
X-MC-Unique: qpkTb8wMO1-ZmC6fMYqVSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D540785CBED;
 Tue, 22 Aug 2023 19:28:35 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A6EC140E96E;
 Tue, 22 Aug 2023 19:28:34 +0000 (UTC)
Date: Tue, 22 Aug 2023 15:28:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 14/21] block: Mark bdrv_get_cumulative_perm() and callers
 GRAPH_RDLOCK
Message-ID: <20230822192833.GR727224@fedora>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-15-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OI7APtwTwurdIlpC"
Content-Disposition: inline
In-Reply-To: <20230817125020.208339-15-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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


--OI7APtwTwurdIlpC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 02:50:13PM +0200, Kevin Wolf wrote:
> The function reads the parents list, so it needs to hold the graph lock.
>=20
> This happens to result in BlockDriver.bdrv_set_perm() to be called with
> the graph lock held. For consistency, make it the same for all of the
> BlockDriver callbacks for updating permissions and annotate the function
> pointers with GRAPH_RDLOCK_PTR.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block_int-common.h       |  9 ++++---
>  include/block/block_int-global-state.h |  4 +--
>  block.c                                | 35 ++++++++++++++++++++------
>  blockdev.c                             |  6 +++++
>  4 files changed, 40 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--OI7APtwTwurdIlpC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTlDGEACgkQnKSrs4Gr
c8jQ5gf/blrJPq/A8gLSJg/Dky4vsnJGIat7ADBr3cpoOOXasEVpKhOeGMTmIosD
0ihH5Tc+7OYmpiVHS4LuSnUw9ep4PNdK49cuHktbm+oxWQo/Gdbp3QFzeynaccdl
Eye5osEkiklChAz+CsABXp9FC0p5jl06NLYhrDmMlTx/jH8jzKo6y5z8/CqG+fFI
3dlTmRvVsJnEQkXZb13wd+dAsJc4qDjfU38wyGLqPFSHq61JjVr0DQTG99Je+H9j
UcirP/ub4TjXAIrj/x0zwNPruiiO2SITVaihK0IUuve5flT2raES3oXTnKjcWI9B
7qMmW0elauSDBCmunJKZiiJtQMxtTQ==
=fAnX
-----END PGP SIGNATURE-----

--OI7APtwTwurdIlpC--



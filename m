Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAA8711375
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:17:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FW3-0000f8-Av; Thu, 25 May 2023 14:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2FVm-0000ZC-6K
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:16:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2FVk-0007gK-Re
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685038588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ye2Zoa3by9989JCLGqQMTFd0M0unviRO5bGkXL9ipqU=;
 b=GqYKTXcwcUOJZbk8bYhhE/I+ULQhnSaFdFTgPhMleDQ+j3KF13J0C8sqAf/Jb+sKYSimPF
 3UV8eAqHDi3L/549P0vY+o4XDT4Q4V3T+QAwZ45Ao2/5NSNO3b4mAoVsSo6SBbgyTegDq2
 6qA1A1Q9MCXGjlohRv0+ocvoYbJ7QTQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-JmPYmkxENj-SFL9WPMH67Q-1; Thu, 25 May 2023 14:16:26 -0400
X-MC-Unique: JmPYmkxENj-SFL9WPMH67Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFFF685A5A8;
 Thu, 25 May 2023 18:16:25 +0000 (UTC)
Received: from localhost (unknown [10.39.192.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C32D48205E;
 Thu, 25 May 2023 18:16:25 +0000 (UTC)
Date: Thu, 25 May 2023 14:16:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 02/12] block: Clarify locking rules for
 bdrv_open(_inherit)()
Message-ID: <20230525181623.GD132697@fedora>
References: <20230525124713.401149-1-kwolf@redhat.com>
 <20230525124713.401149-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ojg3I3GlZPBtT3gS"
Content-Disposition: inline
In-Reply-To: <20230525124713.401149-3-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--Ojg3I3GlZPBtT3gS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 02:47:03PM +0200, Kevin Wolf wrote:
> These functions specify that the caller must hold the "@filename
> AioContext lock". This doesn't make sense, file names don't have an
> AioContext. New BlockDriverStates always start in the main AioContext,
> so this is what we really need here.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Ojg3I3GlZPBtT3gS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRvpfcACgkQnKSrs4Gr
c8iubgf/YxzV25/y1u12U8qXVoSyYiZMIkXJeR/BPRasZ7S6wcZKoTz5ToUgsPYc
Ru23tFQuN7N/S75qNf840FS0nxTHaeTQgA/lxz/BMds7MjEFJ966J1300VysjKxF
N4TlrHx+GkZvoGCLXQNvtELY/lFp1/LVy1DtWPIITSZSMxVdXsveMkz7iCwgfRzK
xuKekn9z+z2kcPovNiMkG1kTlgPQz1WbW/9SGsE1Hd28my66rTkhrsHO3B5DY7OB
vTFfqoWggiAl/sX9AhdMYvL0JkDiaz6Dm4j1FV6XJF8mNCQlNoFOWudz6u+x9+yZ
N6ktct3p/ONkDxe5+4CwLFLG6yQJsg==
=0DBC
-----END PGP SIGNATURE-----

--Ojg3I3GlZPBtT3gS--



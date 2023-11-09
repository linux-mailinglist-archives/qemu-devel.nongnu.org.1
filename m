Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3107E626E
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 03:51:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0v7r-0007WY-56; Wed, 08 Nov 2023 21:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0v7g-0007UZ-0Y
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 21:50:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0v7e-0005ky-Jj
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 21:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699498222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N4TLDMplG8DOSZuvqlzJiEHT4BME73/zBa1KDIDZy24=;
 b=DueqYODm2BN4ocjyiztGlsoqXXZY32Vok25PKdeY9bah2z/PEh2b3SrQJGKTQzE48/20RB
 N/2gZsDja8D0ODuT8wRglD13Ujv7FVB3EZC/8DVFROVRJnzlIB+/PX4/Y21JSpWe1WIW7q
 fDNB034466hNZBu1SbS7+d3HLTwQtxE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-MWtUh4zePQ6lXwnzDeIhbQ-1; Wed, 08 Nov 2023 21:50:17 -0500
X-MC-Unique: MWtUh4zePQ6lXwnzDeIhbQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D1B5101A529;
 Thu,  9 Nov 2023 02:50:17 +0000 (UTC)
Received: from localhost (unknown [10.39.192.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 881F51121306;
 Thu,  9 Nov 2023 02:50:16 +0000 (UTC)
Date: Thu, 9 Nov 2023 10:50:13 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL v2 00/23] Final test, gdbstub, plugin and gitdm updates
 for 8.2
Message-ID: <20231109025013.GA7926@fedora>
References: <20231108151743.3834165-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nFNyzUj1+y6HTqKi"
Content-Disposition: inline
In-Reply-To: <20231108151743.3834165-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--nFNyzUj1+y6HTqKi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--nFNyzUj1+y6HTqKi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVMSOQACgkQnKSrs4Gr
c8jgPQf/TBLmCOI1TQP1X7UqcdD1yOFRLr3Y7jmTxlSDJln5Sr5jEGRwoKNQ/Xpg
9g+NjL+KwoI/jA5TAneg4VfmGMhsSuFAG1f93Yh9lPb4pM2O1UbqfMOaNVn4qpxV
T7ZPjsrfhgKczBbtsuyJq650i/tAKapOBICxhJ2v0A8R9zvFB12cnBb3UX+kXIY6
n+VHm1glzBeG9argvfI/g4/UQSkde7HzWfOGb+FOn73Cnawd9pAbZTcTy1dXNjxG
+MgmtGLlljGNH5EqEZU8KJf1vs5WIYeQvkyvQV5vdTccOOvevvlwALTRLcC5GWmb
byOzPgWUmzS/FJu9djgIOE//iVCUdQ==
=hPuX
-----END PGP SIGNATURE-----

--nFNyzUj1+y6HTqKi--



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A8B7A6B40
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 21:14:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qig9r-00027Z-1h; Tue, 19 Sep 2023 15:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qig9p-00027J-H0
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 15:13:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qig9o-0007KH-5d
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 15:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695150791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u5sa5AHmSj/bfBGirsBFps+MsKV3vAgrsKCM4oEDXJs=;
 b=FmGvmGakqkobIoe+Q2JLkr2AUlVHzKHZ51+8JvX82hSSE7E0Du1jj5/QdFyY2fH69Jq7ss
 Z1HvznLFtcDcekvGElJokOomkX9iAlmh16j33Nme+w+hIANE9ybb2b3fy1gqjOT6e8VcmJ
 DlYPz+ERP5Tmj+UXG4KCzm4w/4niuy8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-qnHJzzKiObyRo7o8DPyfGw-1; Tue, 19 Sep 2023 15:13:07 -0400
X-MC-Unique: qnHJzzKiObyRo7o8DPyfGw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09321185A79C;
 Tue, 19 Sep 2023 19:13:06 +0000 (UTC)
Received: from localhost (unknown [10.39.192.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 890431C646;
 Tue, 19 Sep 2023 19:13:05 +0000 (UTC)
Date: Tue, 19 Sep 2023 15:13:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, danielhb413@gmail.com,
 peter.maydell@linaro.org, clg@kaod.org
Subject: Re: [PULL 0/3] ppc queue
Message-ID: <20230919191304.GA1843284@fedora>
References: <20230918132912.291204-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HHvX9+n9oplR6HBr"
Content-Disposition: inline
In-Reply-To: <20230918132912.291204-1-danielhb413@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--HHvX9+n9oplR6HBr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--HHvX9+n9oplR6HBr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUJ8sAACgkQnKSrs4Gr
c8hRtgf+J+NSUREFnG/uOFotlbZac6KZxNmxTR6w2hGsIhCxmmosV/3kHLmRMPVL
J8fbqEmor7JPO50UReoNyoIRXEq+ZMiMKIqYkZlXrIeLCC9BKhu3l39y4u0Jrjbc
cxu9bN7zL2FlfgFARBzMBPz1XmvTWdReHcQLoIPcajygl2S8CqYLeZsTL41VNmJM
QJRoMknYij/awgCU+WYVdAGTaGKaQwCMzuhoyAaMVkZw3DDUocvg0DqfUt2Yh3xy
R3IWKS4cxx1XCf+RCvY31RtV6r1pbcvwW7skHJhMIthYYQNVVO/aoP0LgYY+8byI
RcUCR6r1sxTOjzTM5THnrBazr0HSQw==
=rBfZ
-----END PGP SIGNATURE-----

--HHvX9+n9oplR6HBr--



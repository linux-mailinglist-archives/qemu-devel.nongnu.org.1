Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5657DD96B
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 01:02:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxyfD-0003VQ-8O; Tue, 31 Oct 2023 20:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qxyf0-0003Uy-AU
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 20:00:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qxyey-0007rf-Ln
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 20:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698796835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bbpBfTX9CQwJJN492b5VtITUAz4AwvZ8UVhRoWPXu9w=;
 b=OI2/Q8InPSD7ohXVK6FCZnYzkbI1RklMi3w9RZQCDkZMuN0KYLWNxxlNyeni/7+irfed5D
 JcBPcDLZ6wdikziPm1PymVusR4C6yTsi1vcr0r0I/1ENXvPFH17I6GlRqoNxdR1ICcAX03
 V2hhIhMFIuSG6ta3FIfo/vByOdIRXbs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-gPszYfJoNIWAM2She7TpJQ-1; Tue,
 31 Oct 2023 20:00:34 -0400
X-MC-Unique: gPszYfJoNIWAM2She7TpJQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B92543857B67;
 Wed,  1 Nov 2023 00:00:33 +0000 (UTC)
Received: from localhost (unknown [10.39.192.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0635A10F57;
 Wed,  1 Nov 2023 00:00:32 +0000 (UTC)
Date: Wed, 1 Nov 2023 08:31:50 +0900
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PULL 00/27] Block layer patches
Message-ID: <20231031233150.GA674004@fedora>
References: <20231031185918.346940-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a8A7xJL/C+kXY7sW"
Content-Disposition: inline
In-Reply-To: <20231031185918.346940-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--a8A7xJL/C+kXY7sW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--a8A7xJL/C+kXY7sW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVBjmYACgkQnKSrs4Gr
c8i1rQgAjlBxCsJw06M1K0dMu1oVOU70aLPgFSZyc4bJqrLrPVRXPS/0zf7HiUXu
Pl1+8bMEAvtQMG5/pMLR/gLas6WMSAQOzu5rnXZuMpAeXWxb1P+/GaDZTCwPfq34
9FMnqtJBA/5T8m48OpJZDj6ai6PEM/IZkih8pejfhiMc7lm9T/46HrxCpZij2BEP
kqu1H/KQeKBOMQ+gXd2dFNZsaOWmzcHW93RssmCcBU+N0ao3TDNb/gcwEEdOW3gR
eZKR2AGRh5xHsYItuFN63t9yxhdPNTg33rCBhqkbH7Nugsrl3uUD8ytCcXj1sEgy
Ta5cGHIkDLALW/TnQo0AbkvW1nX6UQ==
=xjnR
-----END PGP SIGNATURE-----

--a8A7xJL/C+kXY7sW--



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8747A0F93
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 23:10:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtbG-0006Tg-LB; Thu, 14 Sep 2023 17:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgtbE-0006TO-GT
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 17:10:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgtbC-0005wZ-1C
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 17:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694725804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Y8DMaE6R8GR3qMnXClWRS5c0bg39NmyBFXHePRoxsU=;
 b=Pw4wWagwPJcwSsL5O80Fc7cNc/tlAOCquzSXK8So7fkJO6lYsO1kkTECoCeXc23pfzhPuF
 mK/G/WNy1y4kXNl2CcAOJkzeStwJ6e9DFFHPACe7gPfZiJuTzQAc2RU1CK3OJWa1JV1HzP
 EYZEq6CE8TTBnJGuhKXm8Wa/B2hc22g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-2RNWq2w1OFeVl0H0MReBEQ-1; Thu, 14 Sep 2023 17:10:01 -0400
X-MC-Unique: 2RNWq2w1OFeVl0H0MReBEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F77181B08C;
 Thu, 14 Sep 2023 21:10:01 +0000 (UTC)
Received: from localhost (unknown [10.39.194.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 058F628FB;
 Thu, 14 Sep 2023 21:10:00 +0000 (UTC)
Date: Thu, 14 Sep 2023 17:09:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>
Subject: Re: [PATCH v4 02/14] simpletrace: annotate magic constants from QEMU
 code
Message-ID: <20230914210959.GB1094271@fedora>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-3-mads@ynddal.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="v9ZCkB3DQKxfvaoy"
Content-Disposition: inline
In-Reply-To: <20230823085429.20519-3-mads@ynddal.dk>
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


--v9ZCkB3DQKxfvaoy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:54:17AM +0200, Mads Ynddal wrote:
> From: Mads Ynddal <m.ynddal@samsung.com>
>=20
> It wasn't clear where the constants and structs came from, so I added
> comments to help.
>=20
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
> ---
>  scripts/simpletrace.py | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--v9ZCkB3DQKxfvaoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUDdqcACgkQnKSrs4Gr
c8hC/wf9E7DG1YZisoUm0o62YiKhLNPTrnI+wT3o40KWdqaOaaoHyVll979aqqjc
l7xa+RXTDs+UFEC/5UXB8Bj1SMIAvp4HeF1q0sSl2aZYU7nIp3MYgPlAtzV0fNlG
Pgk44/5CsL83Pe886+AXIMwVm7c5Xmv5d/r4+U5By1hQ/RSsyajdIOfnmwCEu3Cl
tAhlWy2rsIK7kAZyZ7jJBhzzwgkf7w7G8R1pispTjjCXYnuX7q/wkzvXQHsu6faH
/ZUg+iFWfyEi7hp8G6shm9CI9mUUUd+axGEgXD3y04sbzPJm3GSmBOCZZm86iJI7
FmsIY8Zngft0JICppMZ1jz8tP+OEgw==
=97Ov
-----END PGP SIGNATURE-----

--v9ZCkB3DQKxfvaoy--



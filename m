Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF757A8D97
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 22:12:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj3YB-0006aR-3Q; Wed, 20 Sep 2023 16:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3Y5-0006Va-7o
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:11:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3Y3-0004nO-6X
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695240706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SoQ58lV/Wkq/Jt+wAn5s9R3z+AmbTBlUFz8lHItBxvI=;
 b=W1U3ai+ByR7MrQJaqUHFmAurTrFH5R1t5CpiaNwSwAiiSoFUOi/qwXIPS37Wmmp+nJuDLp
 qkq/eDt8EA5AYx14Qo2DtUqfFfWIjJzbLr7JhsRyzjUoDFsdPFBXFLTb3szfAkv6SyVV8y
 zRWe/vw2DRq5+fhGn1XTtrEd0d3ykuk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-HQ5_xK04OjOlfbbbRTdyNw-1; Wed, 20 Sep 2023 16:11:42 -0400
X-MC-Unique: HQ5_xK04OjOlfbbbRTdyNw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3037811E7B;
 Wed, 20 Sep 2023 20:11:41 +0000 (UTC)
Received: from localhost (unknown [10.39.193.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69F4D51E3;
 Wed, 20 Sep 2023 20:11:41 +0000 (UTC)
Date: Wed, 20 Sep 2023 16:11:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>
Subject: Re: [PATCH v4 08/14] simpletrace: made Analyzer into context-manager
Message-ID: <20230920201139.GG1094271@fedora>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-9-mads@ynddal.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Z6hZsQNvqiKoZk+V"
Content-Disposition: inline
In-Reply-To: <20230823085429.20519-9-mads@ynddal.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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


--Z6hZsQNvqiKoZk+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:54:23AM +0200, Mads Ynddal wrote:
> From: Mads Ynddal <m.ynddal@samsung.com>
>=20
> Instead of explicitly calling `begin` and `end`, we can change the class
> to use the context-manager paradigm. This is mostly a styling choice,
> used in modern Python code. But it also allows for more advanced analyzers
> to handle exceptions gracefully in the `__exit__` method (not
> demonstrated here).
>=20
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
> ---
>  scripts/simpletrace.py | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Z6hZsQNvqiKoZk+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmULUfsACgkQnKSrs4Gr
c8jrGgf9FtWbh20dhRWmmHT/GK/yGaKgRmdReJGcaTAQxtYWwsJuMSlFdfltlRkm
XMzjgUz8o3dhB382BIK6yN8WbWC13/3T0hIdyHVA1Zrgu9AsQPYEuLcZKssGPQB+
Fms1XUIDU0bgt6HhCcSc3mzvlyhHgXX9tepf1DiJmHH+2QvSVNZRLCEpb4Ir5AEX
td3BpCCJGQ5w7Dspin8atX2b2kWE9t/SaBJ64RXNNpGpGDaK5mubGbraNyVTWL4d
iAboY3VBpIli4pW1kCXZeLoP2tDPJxu5bVhn93NYfW9jetQSUupXpJ1ROLZXWb/k
PqoDjzXzkPrt8dBRDQH+dzWgcNP2MA==
=lfHZ
-----END PGP SIGNATURE-----

--Z6hZsQNvqiKoZk+V--



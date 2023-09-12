Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8275E79D6BE
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 18:50:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg6aE-0001dm-8b; Tue, 12 Sep 2023 12:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qg6aC-0001cE-GS
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qg6aA-0008J1-Fh
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694537385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HAU8bha7olwl5iZP0eLr4ienFJLMR0UGmf1cYbJieOw=;
 b=BGOXUaYapk3bXeOafYtcaed+OMSniLzyR8JcnSvEagMOaqoSk3QxHQBNNehvK3/T0pbwU6
 2Z+bcO6pofeiY2dzYvkk+19iwijkUumXtYCAADRExbMksjWYQ+URB28f7WasjIOl64oeAj
 1uqowFqnD2D1zmvBSd9Y0afneC0nyl4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-8sOjZRvVOgmleDUzY85K1w-1; Tue, 12 Sep 2023 12:49:42 -0400
X-MC-Unique: 8sOjZRvVOgmleDUzY85K1w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B685129AB435;
 Tue, 12 Sep 2023 16:49:41 +0000 (UTC)
Received: from localhost (unknown [10.39.193.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F7042026D4B;
 Tue, 12 Sep 2023 16:49:41 +0000 (UTC)
Date: Tue, 12 Sep 2023 12:49:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 18/21] block: Take graph rdlock in
 bdrv_change_aio_context()
Message-ID: <20230912164934.GE72318@fedora>
References: <20230911094620.45040-1-kwolf@redhat.com>
 <20230911094620.45040-19-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ORdsk9lV7d1XexRB"
Content-Disposition: inline
In-Reply-To: <20230911094620.45040-19-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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


--ORdsk9lV7d1XexRB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 11:46:17AM +0200, Kevin Wolf wrote:
> The function reads the parents list, so it needs to hold the graph lock.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> ---
>  block.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ORdsk9lV7d1XexRB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUAlp4ACgkQnKSrs4Gr
c8hr9wf/WYDSiGkSOEZE3tuJrvvqsmtDPtHndgWD4HRS5vVmL9XGGmra/w23bsmL
UEDy6rXSfRN3hPWdPljvZqOVykODblOD8NdEut8s9IqW5bxmhnfI2r7FjqfyWln+
kMGjVHk95Y9EiNIdQvhW38M+8oaDAUfeiEoAP13l8cF0eEIU0uR3okhxw3eAKYmJ
T33m/Wfnv/YFvms7mTEULBxyv5KOe+TK6oNuPOGU5rBP32DOg0vpxZlvwef4nhwL
SuOBtwf+nxvD0edAAYaVSaqi86N7BCZY7hAKSuPTvNxPgup75OKliPRjamxjJTD+
btZlHf2vpzTxJyG0Y/xukmUnJXqfgQ==
=lkkA
-----END PGP SIGNATURE-----

--ORdsk9lV7d1XexRB--



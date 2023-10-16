Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB727CB344
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 21:20:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsT8g-0006Ja-Rw; Mon, 16 Oct 2023 15:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qsT8a-0006Dj-JE
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 15:20:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qsT8Y-0005Tf-9P
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 15:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697484021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z/MHWRmqkzg34S5YxIZx27M+Gh3FnucGfZDpDdOzPac=;
 b=B0ngESn2vEfz6+0OANqMtt8GMvJWZZdVIj6yr5TfFxXrw8NL7+osPbHZZKIRDrhn8m+IpM
 Pz3wcOpXvu7V5se6BHPBCXAMLtaNvmdG1VEyK3tOrvAg0LwbL8koEDKIiLcT0/AoFXFRFp
 TKtebXF4rqTqiigV0U+lAoJzGhpYWS8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-WEcl0B7uO4yDBpiemzVaEg-1; Mon, 16 Oct 2023 15:20:04 -0400
X-MC-Unique: WEcl0B7uO4yDBpiemzVaEg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 996808E8C63
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 19:20:04 +0000 (UTC)
Received: from localhost (unknown [10.39.195.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D55F1C060AE;
 Mon, 16 Oct 2023 19:20:03 +0000 (UTC)
Date: Mon, 16 Oct 2023 15:20:03 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 0/5] -Wshadow=local patches for 2023-10-12
Message-ID: <20231016192003.GA161174@fedora>
References: <20231012145721.77039-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zvvTRwCs30HJRfFN"
Content-Disposition: inline
In-Reply-To: <20231012145721.77039-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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


--zvvTRwCs30HJRfFN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--zvvTRwCs30HJRfFN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUtjOIACgkQnKSrs4Gr
c8jWWQgAnUMVxM3mQU7aO9dfQ7dawN+RDGac8G/3wj/P/4tL75Kf7ilygAgIZE+c
FiXMlapTbOUe1lV9pLOKG0z+RhSfFlNi+H2jqGZFTKflq53vN5VOON0Pm8oEGK3O
vmmaSFm47ycIkQJQsKDo4HYGAyH1/PCGJPGwCEmvzkr3kgSuDyp3XhyuKznrWy0z
Q27vVL4K799EDJ+aseiIDjz7vnFCFZHq47svlmOPz+9L5p+PURCcXnn7VF6IddRH
2O+J/0jY2+fMOymgukLH+RXLewOgap2SuMCDATTjs2vZJtZCN/ulaEUxs3vCfL29
SICzRqOUgtCWQQMENF7pzqcsHn5qvQ==
=7V6S
-----END PGP SIGNATURE-----

--zvvTRwCs30HJRfFN--



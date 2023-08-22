Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49208784963
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 20:26:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYW51-0006Rk-JS; Tue, 22 Aug 2023 14:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYW4x-0006R6-NA
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 14:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYW4v-0003uQ-M5
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 14:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692728769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s6XwWIniZcVlF0tL4UhRyjr5Cytmb5mHztOSGEp4uzQ=;
 b=MgMolsM9/EI0+ymYcU8U2eIWizbEkjyAg/K/3sHLA6nYIjhzbHmBKZZDehDgHeGdAFrcIJ
 qd/cqVgk+BHljTuxf/7Ow3nt57jzM/+DIIPZePIZEUfCF5Y2pLYffgdT6hlakAHG2EU7p/
 jCoP9sFx+3jCsmqqkIHC9cxM2s1futk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-lvR5uNlNNoqnlKTUaoYWJg-1; Tue, 22 Aug 2023 14:26:04 -0400
X-MC-Unique: lvR5uNlNNoqnlKTUaoYWJg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3D58185A791;
 Tue, 22 Aug 2023 18:26:03 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 47EB140D2844;
 Tue, 22 Aug 2023 18:26:03 +0000 (UTC)
Date: Tue, 22 Aug 2023 14:26:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 02/21] preallocate: Factor out
 preallocate_truncate_to_real_size()
Message-ID: <20230822182602.GE727224@fedora>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JSTAsHUKAh5xpVcN"
Content-Disposition: inline
In-Reply-To: <20230817125020.208339-3-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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


--JSTAsHUKAh5xpVcN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 02:50:01PM +0200, Kevin Wolf wrote:
> It's essentially the same code in preallocate_check_perm() and
> preallocate_close(), except that the latter ignores errors.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/preallocate.c | 48 +++++++++++++++++++++------------------------
>  1 file changed, 22 insertions(+), 26 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--JSTAsHUKAh5xpVcN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTk/boACgkQnKSrs4Gr
c8iG2gf9EeOB20+bjoXIljKdfF1zhPZgRDI+NBOJK7Ou1AgT1mN6IKDfGQO41XJd
VORBevLcMUozeZfwTgjEywxnSWLsOW/XlZCe29O42C034YfNZRLZYLP7fEaRTCIP
FVaIJbJnjIkv9PgWK+8sno1BLxoxulzcTpFCJloxfDL0T1/kicjM+s99VTKe7VLM
dwtIQXt4Xpt9B5XyUdr9V6KAzcCFm3kMIV4FiNyqVB0quI2h7ehoUQc8qCsGWB+3
z+Qll/9//q7UkPmhlCDzl9p+hywaBr16Z9kWU0Aa7Q9MNFG/6/smtUyhJKXRhSCI
reisQfn/LzzD7zEBpIYqnRpQD+wMHg==
=Amqi
-----END PGP SIGNATURE-----

--JSTAsHUKAh5xpVcN--



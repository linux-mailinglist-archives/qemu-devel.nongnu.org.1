Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C7478D798
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 18:23:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNyS-0007Yw-Bi; Wed, 30 Aug 2023 12:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbNyN-0007JD-2i
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbNyI-000619-7o
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693412589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=URHZcZYVZG7vpxZ4kf+hvGWiehZFmbmQ0LkuYfKSn8M=;
 b=Gdac6itRMTdF713wRsvIWJy7+SLznpuSC8Uco4Au/yxN4zLcoyHE96dCKHSlcC//8Te5ge
 x44WTx+wG88VGA7vzbobNuSvc8FlbchK50etM1Wqr4xoueSwklwqrWLi5g5OyLZBOYt1/b
 Y4gEO0dsgxJzlJ0jK6ldIImCqmdi3ws=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-ccTP_rlDOL6Ymrhwxpn4SQ-1; Wed, 30 Aug 2023 12:23:07 -0400
X-MC-Unique: ccTP_rlDOL6Ymrhwxpn4SQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50EE4101A53C;
 Wed, 30 Aug 2023 16:23:07 +0000 (UTC)
Received: from localhost (unknown [10.39.193.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF720492C13;
 Wed, 30 Aug 2023 16:23:06 +0000 (UTC)
Date: Wed, 30 Aug 2023 12:23:05 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/5] tcg patch queue
Message-ID: <20230830162305.GA474731@fedora>
References: <20230829185458.861690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qZ/ixvdxHfZKeBPj"
Content-Disposition: inline
In-Reply-To: <20230829185458.861690-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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


--qZ/ixvdxHfZKeBPj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--qZ/ixvdxHfZKeBPj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTvbOkACgkQnKSrs4Gr
c8gWnAgArSk50mhRkibXV8KR9P4EvS+9xPRx0gnvSmP1oy6ByJ+FGeauOQn4iy0H
7VoPxsxbSUizWiu0p+z91cSPWBB0xgxaIERqV7YLlL9A+kQIMns9Bn0Q0I8xCT2e
belzm6zz90rHTUlfZTYizaQ3Lwj3moJ3uljI7i7/8DrAeyCc+dyz5hFtLiF9wuT0
OPLUMyhnehWZ5RaxWlQHyWccnpuFc+vKBbqFoEc2na6XA5p0xxoRwcKwDYVc9Wsm
okfJQH5G1fqe7STxUC0grfkSNVj9h3hifB2kLpPSZlD/tBIJZ0/BlrHATBmsjo6j
qbiXhY80hUhjONRmK8lVWAMndaikxA==
=E5oI
-----END PGP SIGNATURE-----

--qZ/ixvdxHfZKeBPj--



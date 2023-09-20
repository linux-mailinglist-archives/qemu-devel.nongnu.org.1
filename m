Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 838F87A8D77
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 22:06:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj3Sd-0003rI-N1; Wed, 20 Sep 2023 16:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3Sa-0003qn-Pt
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:06:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3SY-0003Kt-K1
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695240365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WKgGoLIZGAp6Mcte2htctcSnKOnyZgZSog9+l26sWz8=;
 b=HRe52rVKCj6qM4ATAYqFa27uKW7yrOfGuQvHYVQkkC9wbLeWW1ntqrFKe60ciunXVctaTz
 UKYtELx9OKAG5dgDsL3p9uSpNYCiJ/d85zpLjetZFSeWJ5s1vnZUjW8ezlEJBc7CRjkIH8
 tOcuAHLXqXpZvY4kWSjr/mMmepUVVGI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-iI6bGZA2MiCvMQmp_cUs7w-1; Wed, 20 Sep 2023 16:06:02 -0400
X-MC-Unique: iI6bGZA2MiCvMQmp_cUs7w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D0D9802D38;
 Wed, 20 Sep 2023 20:06:01 +0000 (UTC)
Received: from localhost (unknown [10.39.193.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD72440C2064;
 Wed, 20 Sep 2023 20:06:00 +0000 (UTC)
Date: Wed, 20 Sep 2023 16:05:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: deller@kernel.org
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PULL v2 0/8] Hppa btlb patches
Message-ID: <20230920200558.GA2587607@fedora>
References: <20230919191757.98889-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IEMzwBzAAcw/5WyJ"
Content-Disposition: inline
In-Reply-To: <20230919191757.98889-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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


--IEMzwBzAAcw/5WyJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--IEMzwBzAAcw/5WyJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmULUKYACgkQnKSrs4Gr
c8jKegf/ZZVkosvv2yoCxb6dQDk7vtIYZGfvSw4trAdWwzCNbLowH8kthrwWQw7c
uRmKFUtcFw2q0/1PM5q0mmT/Y9jMg46+tmz5o5BcAQ0Bxy/l1AwpQoLO+sHn+v7V
S0TETZuUlTJVubtopz4yWI3v41pd30bF8ihKXa8D/X46UmkTjHnhE8NaXLv7zFdS
GZmz6/duoyyiceqS+Z6W37kIOq4yQ/PwNXgf809WM98ozJuncOaxIlt721l9AFR4
R2Ix886s7foH/LUUYd0aCV4uVS1SNtt2Ew82hI5SDTMjfwACGmAAcI6//bpDsgDg
hOx2RfVXzpRew0zROaDQgCXJog5NUA==
=w1QZ
-----END PGP SIGNATURE-----

--IEMzwBzAAcw/5WyJ--



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D867FCAA1
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 00:15:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r87Hn-0001eg-RZ; Tue, 28 Nov 2023 18:14:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r87Hl-0001dm-21
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 18:14:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r87Hj-0006P2-43
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 18:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701213269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JOhZJUiHIx9vek3JrVo6kHC7HAezrI08fuvCLYq6yfI=;
 b=J3+nWp30+tcV+9Jcq8CycTmux01JKPc6pOaurH/iAQPqESgtkKiVl3p6ywi5ZsBz5JN798
 u6RA3fwKY4UJpQGDCBq5sSlgvhajWttUb95yu6iuf13u72qW96NfNzthgFEaS4UTJub/jE
 ZqW3n6A62iicZrr+1Gk5G44z98wJRyc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-4TWQxJw1OsSaH3FOvw3xRA-1; Tue, 28 Nov 2023 18:14:26 -0500
X-MC-Unique: 4TWQxJw1OsSaH3FOvw3xRA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0D8988CDC0;
 Tue, 28 Nov 2023 23:14:25 +0000 (UTC)
Received: from localhost (unknown [10.39.195.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB0592166B27;
 Tue, 28 Nov 2023 23:14:24 +0000 (UTC)
Date: Tue, 28 Nov 2023 18:14:23 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 0/7] Misc fixes for 2023-11-28
Message-ID: <20231128231423.GA741888@fedora>
References: <20231128133740.64525-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="atunKu3JQV9ozszU"
Content-Disposition: inline
In-Reply-To: <20231128133740.64525-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--atunKu3JQV9ozszU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--atunKu3JQV9ozszU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVmdE8ACgkQnKSrs4Gr
c8jLJgf/XeF5wnPjk6sjvy3WB6EtyvU/9AoUL96ejivzuGhwEI+2GnYz4Yu4U+Q1
RGax4w2RzQ+4lSmzdc9F49V4Dz+7WpjxQIaC4Qg8OAFkjbAvhcuVWUXgG2FIMWRT
PWBIIMgyfYh3v0WaqrNn6N3UgCOYxJPu/nngnowa+cDodRbAuG5W/x1JnrV7eDEe
KjsGER9KGZRhsQVU/IaN5CnK485QD67nLAUlKA0mNYHnYudkggvYes2vRkh5tsHn
0eScGnWtZJFePZOokufb8VBw7/hKfe5xiJstGiRhWYMqkm4VKu6Tyw00TOsbNwJm
VyDjOw7CMtt5h+NHFzGpvZoY6u3d2g==
=gvwi
-----END PGP SIGNATURE-----

--atunKu3JQV9ozszU--



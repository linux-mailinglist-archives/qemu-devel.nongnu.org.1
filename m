Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ED9758535
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 20:57:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLpsF-00053C-G3; Tue, 18 Jul 2023 14:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLpsC-00052V-Uf
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 14:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLpsB-0004gP-DE
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 14:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689706594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=15+AVKOPp5LnZGDRq8j15lEJGYl4g+SvsnGxjVYPNco=;
 b=ZmqiAVdcclEg/1TAzi4/up/R9vCKEfVXAZIcChP4Cz9s7e+0gBEBAq7eJgt1vaVAuXRujV
 NSq3bUQJDbJZpkUBXy4elkZl4vz4thptMCoXWZR+FpijCTftFfC60ivScnlpX75TjMG8D8
 092ir+1cBgL51DJ+D57r+L3aeoDbTws=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-16aZI6zxMESrHVtl55Q8ug-1; Tue, 18 Jul 2023 14:56:30 -0400
X-MC-Unique: 16aZI6zxMESrHVtl55Q8ug-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A012629A9D3C;
 Tue, 18 Jul 2023 18:56:29 +0000 (UTC)
Received: from localhost (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF23F1454142;
 Tue, 18 Jul 2023 18:56:28 +0000 (UTC)
Date: Tue, 18 Jul 2023 14:56:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, hreitz@redhat.com,
 k.jensen@samsung.com, kwolf@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 mst@redhat.com, philmd@linaro.org, thuth@redhat.com
Subject: Re: PING: [PATCH v4 0/3] hw/ufs: Add Universal Flash Storage (UFS)
 support
Message-ID: <20230718185626.GA68526@fedora>
References: <cover.1688459061.git.jeuk20.kim@gmail.com>
 <0e1a269c-0834-7255-1ded-0d37bddd1976@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9JeuaV9tHH5HBxCZ"
Content-Disposition: inline
In-Reply-To: <0e1a269c-0834-7255-1ded-0d37bddd1976@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--9JeuaV9tHH5HBxCZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 07:31:02PM +0900, Jeuk Kim wrote:
> Hi,
> Any more reviews...?
>=20
> Dear Stefan
> If you don't mind, Could you give it "reviewed-by"?
> And is there anything else I should do...?

Sorry for the late reply. I was on vacation and am working my way
through pending code review and bug reports.

I have started reviewing this series and should be finish on Wednesday
or Thursday.

Stefan

--9JeuaV9tHH5HBxCZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS24FoACgkQnKSrs4Gr
c8hmTQf9HuEHYR+BROG2xci1qYVu9NtXQp/sOEvjbp72aP9l+tqXax+LtIlqaEYA
UdJ/hcKqCTN2yFH2pvr+WVwkoPd3qvLc8cLh8soD5iMAmlozsH0cQPkx0sS0kAfr
Pf4ozoT7sbYWcr5HolfyJ1U5dLMv3YodXhkhS04EscD+zcObsC7tjqm9GBpxrweP
Fhu4nr2rLTROzzlAVkyrAJl1wEur9hXlP1dpSJJ4lcIwqCPQCpHh3H7ulYjiAsJv
Pyw/tEEIivJbQ68eDddZYlDmKLu3drSyKvkTTqNsoIF7ROXs2HMiEfoZNxr667uo
elfw52pS4DS3xeMx7h8LRaxlODVtWg==
=ZY4e
-----END PGP SIGNATURE-----

--9JeuaV9tHH5HBxCZ--



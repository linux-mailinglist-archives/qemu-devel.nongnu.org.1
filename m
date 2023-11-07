Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E34877E336B
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:03:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CNC-0004BQ-88; Mon, 06 Nov 2023 22:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0CN9-0003zp-Uy
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:03:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0CN2-0000LY-KU
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:03:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699326196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mgfGOTc/97wvPQl9RxSSEn4Bldqs7W0wtVwzs15gRfc=;
 b=NYcQcuBd1w+98O+8xzPXCwctIe3l4VDbd+z7Oi79Xyg0m9qB7bV4aT3YRW4GzXKIa7X2zj
 W5unAbz3nfZdcAvfiAw7NPOlPjpaJPGS9B5fRl6ggc4js3D3/Yzb06UdcXPzNPHT79ZDg3
 3XfKbpyx9k8iK+Mcd9Ez7Y0xMY9CF+0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-gELDjhaMMSuq0A3UvvhxVg-1; Mon, 06 Nov 2023 22:03:12 -0500
X-MC-Unique: gELDjhaMMSuq0A3UvvhxVg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 186C5821944;
 Tue,  7 Nov 2023 03:03:12 +0000 (UTC)
Received: from localhost (unknown [10.39.192.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 534DA492BFA;
 Tue,  7 Nov 2023 03:03:10 +0000 (UTC)
Date: Tue, 7 Nov 2023 11:03:09 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [PULL 0/3] Block patches
Message-ID: <20231107030309.GA952903@fedora>
References: <20231106171031.1084277-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3daZpUw0HjrUMzjY"
Content-Disposition: inline
In-Reply-To: <20231106171031.1084277-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--3daZpUw0HjrUMzjY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--3daZpUw0HjrUMzjY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVJqOwACgkQnKSrs4Gr
c8jnxAf+LrNf/7vwMG4Ey57+dtVhi7MFldBERPEHze6FhdDJoQImivJlcGHKTiWE
NHBlIkxxeqKnhpXqwc09/HFN4kD3RoyGhrLy8Y4VqdhngJAdxcghAELoqJq7a0JE
RvQuuWgwgk5phgoNl4SofWn1gw1P8cIP11z0jmjw29ZwTI7Sx6ESOsLOwhtkv5gv
BEVU8gZctXk2Y+OiL8TNWBSiHKCuq1em2U+uz15BYMD3sDbskzlF1l03ET3+8/rC
KEkfeSWbDsrBnyWU7EfJAQVWu/5R9xqCfTc5ewVri2qtc6bAxwMz1nAEfFAIEu2G
A7AhlJjo2rnRhRgOiHdTPdQNRnGquQ==
=JcKn
-----END PGP SIGNATURE-----

--3daZpUw0HjrUMzjY--



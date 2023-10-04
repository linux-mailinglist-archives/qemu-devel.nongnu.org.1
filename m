Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 799CC7B9D14
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 14:54:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoNqk-00029V-KI; Thu, 05 Oct 2023 08:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoNqj-00028e-2G
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:53:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoNqh-0005hJ-JQ
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696510383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pJyNp8Hn/vHqWdjoFA8oe3/g8wL6ZMH2ct6JpQ0i7Ew=;
 b=hV2LS9Z7lLxt2Z2A/C/rHrgKrk4Cg8RuG5mpAxcJGepqxPAgQ3Fc0gSyIQTbjvn5BuAsqL
 mfkonH5Aa6Rj9KdzI2IaP+K66FojTdzCUdIjrxi8zToN8A6H1F3q49SewUXnEfrslwUdp6
 +mTLYMW4uyKyAOqinhom/Z/f7v8dHwQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-yUjejyQqMtGyZLuIS263bQ-1; Thu, 05 Oct 2023 08:52:51 -0400
X-MC-Unique: yUjejyQqMtGyZLuIS263bQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F350C280FEC8;
 Thu,  5 Oct 2023 12:52:50 +0000 (UTC)
Received: from localhost (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 823A940C6EA8;
 Thu,  5 Oct 2023 12:52:50 +0000 (UTC)
Date: Wed, 4 Oct 2023 14:33:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 0/1] Block patches
Message-ID: <20231004183353.GA1287883@fedora>
References: <20231004135317.1254548-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bsgpBePtHuV7fTtj"
Content-Disposition: inline
In-Reply-To: <20231004135317.1254548-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--bsgpBePtHuV7fTtj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--bsgpBePtHuV7fTtj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUdsBEACgkQnKSrs4Gr
c8gvpAgAhVUGsic4If7zrrIQ50CdwweKN5hF08wx35W4ctC6poIPHMRN38h2eSkA
kVX4G6Hmj7NOVeFuakq5wy+jTTsrZy3N70Q5K2HuL9yrLESWyQxmhfeNXagyFbte
xJ3DoOfkhVWHv0h198Hv+n21+EXh/eZIh1L4PZsk0D302s5i+szIM/vTHvQoSgua
4m1BVj6p4Le2InI381gRBK31AFM0IpFxWJw0978tA0zhpsYCdpWwka77iB4XaP8Z
d1SIdepYJUEGOdT4jaXRHB8isD7FbQvbAJ3FWJnHj923Yff5sSZyf4ook+pg5x9D
4SlbrDXeDks08QWFXmw0sKbcQf1X8Q==
=8dnW
-----END PGP SIGNATURE-----

--bsgpBePtHuV7fTtj--



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DADBF92E2FF
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jul 2024 11:03:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRpiK-0003bn-2t; Thu, 11 Jul 2024 05:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRpiF-0003OC-N6
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 05:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRpiE-0003Gy-C2
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 05:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720688617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9KG/5sRzeSrQq4JhhLlLVy8iS+K8PaW5eDsd19p51qE=;
 b=Gw+XwfMj7ZqH6MkuW+gqBxwCIFgnTKt3RR7ALkKrI7K6AOrjQN3PndG68G1NmSnCRXVuHP
 cdLhqX2m3ffdwP57Agtz61V4hegy+a914dTQ3YkpVB03u4dnjeuZmFg7VnAF3dyQ2sw0VI
 Xet+5n+1iIichGv2/GPFJOqROZ00uMA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-R3wkvt12Pq2cv3Egv7jidA-1; Thu,
 11 Jul 2024 05:03:32 -0400
X-MC-Unique: R3wkvt12Pq2cv3Egv7jidA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B08E91955F67; Thu, 11 Jul 2024 09:03:31 +0000 (UTC)
Received: from localhost (unknown [10.39.192.113])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B81D01955E85; Thu, 11 Jul 2024 09:03:30 +0000 (UTC)
Date: Thu, 11 Jul 2024 11:03:29 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v3 1/2] qemu-iotest/245: Add missing discard=unmap
Message-ID: <20240711090329.GI563880@dynamic-pd01.res.v6.highway.a1.net>
References: <20240628202058.1964986-1-nsoffer@redhat.com>
 <20240628202058.1964986-2-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aRHlT1XYc6pmLQf5"
Content-Disposition: inline
In-Reply-To: <20240628202058.1964986-2-nsoffer@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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


--aRHlT1XYc6pmLQf5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 28, 2024 at 11:20:57PM +0300, Nir Soffer wrote:
> The test works since we punch holes by default even when opening the
> image without discard=on or discard=unmap. Fix the test to enable
> discard.
> ---
>  tests/qemu-iotests/245 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--aRHlT1XYc6pmLQf5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaPn+EACgkQnKSrs4Gr
c8gZ2ggAlqoGdG/ix5slvt3ibaGnTS2za/N+oqSMedExoF5RyzKvDab5KZfw5ZKX
5KyxiRNfMCXAXVNt7lTJ5Jn/cCmceMXKufyW3NR1q9PxexV3Y+MXzeNT45bnMWzB
c1k2QV71WLvacdwViYlCcukNT4Jlng+EK11kAZSX1Wr5ZPZlkIl0znY7R/7bQ9uF
3fEzeJY+sDl0NCPWJSqTKUhhWctzzr2we9a/Cu3fuEjL09t35igvefU+lN22xce0
ZQ7NV3VTYNfxV5/uzed4HmWq5UQyCKiH25vQcrumZmRxQ6+fAHE8xv21D13zWjA0
RNPGPpviyZEl33Mx6QKcGeAuCSdGjA==
=kult
-----END PGP SIGNATURE-----

--aRHlT1XYc6pmLQf5--



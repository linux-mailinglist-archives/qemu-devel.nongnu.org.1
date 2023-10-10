Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D5D7BF048
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 03:30:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq1Z7-0006t2-Oe; Mon, 09 Oct 2023 21:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qq1Z4-0006sc-Gm
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 21:29:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qq1Z2-0001pJ-U0
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 21:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696901375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/yZAZdhmHhjzGO8a6pII+15Bgi+KnIB97hPy8d2jGgE=;
 b=JJhSEGnO/jzZGWhRpNuTTO165yG0obhzFT2VLxNAKHpxOTOfOOlkpW19mFWQSbJ5qZjQsp
 BEatEA/Ntjo92fYvwtcfGtoeqZUza6PdsaeRZ3EJfsAZlQlqaPQ47SIespcQKWR469uq3A
 gqZs7jsCTm0Ab6R/88gdzpjAbef5idc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-v3FNVYf_PaGYELelvuDvlw-1; Mon, 09 Oct 2023 21:29:33 -0400
X-MC-Unique: v3FNVYf_PaGYELelvuDvlw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59BBD1C05154
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 01:29:33 +0000 (UTC)
Received: from localhost (unknown [10.39.192.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBE172027045;
 Tue, 10 Oct 2023 01:29:32 +0000 (UTC)
Date: Mon, 9 Oct 2023 21:29:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL v2 0/6] vfio queue
Message-ID: <20231010012931.GA1674691@fedora>
References: <20231009064900.1465361-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KcJjRe35Vo9Im9Ul"
Content-Disposition: inline
In-Reply-To: <20231009064900.1465361-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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


--KcJjRe35Vo9Im9Ul
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--KcJjRe35Vo9Im9Ul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUkqPsACgkQnKSrs4Gr
c8iHyQgAgNdhY7CghqXl4nYOdkJ00hTii3czagKdnTuDUPrKarwwuFz4gh2JOgGO
tT00ctcR0gpXxNOOO7lk1N0+Kdriv6ZZ42aKqX1diV9oSYSDqARJG0IXc6oLhdTY
0VqNVs1qD1bpvidNUXqfWSV7eO4uX5i2rVWTmHQpNdzGwqR/1m12FPpy7LxOrl0W
qxiqYBdBlkUVplbq2ByKCF+vFTjfgEH96yp+u6O2h4QlRq8YWeBgpEyl5sU55Zh6
neqBqb9LNpp9xeLzJmnq6QDDr+Ow7s5J0q6+jeVjPAOpHELNfZE/QqZa0pthgMUi
dm44f/oBxJzTjj/7vaWyVaydMa6OzA==
=xKmr
-----END PGP SIGNATURE-----

--KcJjRe35Vo9Im9Ul--



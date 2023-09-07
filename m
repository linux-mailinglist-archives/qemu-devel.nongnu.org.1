Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CCE7974EF
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 17:45:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeHAQ-0004L1-C9; Thu, 07 Sep 2023 11:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeHAO-0004KW-U5
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 11:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeHAK-0003Mq-Oz
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 11:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694101411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uiiz/PaONkCp9h7zmv/wp525+hIIms/kqTfTN9kg6Xs=;
 b=ZVZlBMLCQDXxzjiCfdk0GCJhlwDQIRf4PuqYqieYziBn+QbjbIRT/n9Y/l1il9O/LIGDFW
 I/Tc4O1aMEBzeUemuy43Rn48FS/erJuKruas5Nqy2HdzZcdIQneBTwgoqQ924RTcFbSYL+
 AInNgCZfeLUxmLDqfpkh/Gs2HZ0EE9E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-K1IsZIhZOrS9XMfgTDpRdQ-1; Thu, 07 Sep 2023 11:43:28 -0400
X-MC-Unique: K1IsZIhZOrS9XMfgTDpRdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E34E929AA3B1;
 Thu,  7 Sep 2023 15:43:27 +0000 (UTC)
Received: from localhost (unknown [10.39.193.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A7D01460FE5;
 Thu,  7 Sep 2023 15:43:27 +0000 (UTC)
Date: Thu, 7 Sep 2023 11:43:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PULL v2 00/35] ppc queue
Message-ID: <20230907154326.GA1550586@fedora>
References: <20230906143653.54709-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1Ps1bXh3mLFUAaMd"
Content-Disposition: inline
In-Reply-To: <20230906143653.54709-1-clg@kaod.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--1Ps1bXh3mLFUAaMd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--1Ps1bXh3mLFUAaMd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT5750ACgkQnKSrs4Gr
c8j4fwgAqrtE0TjLnli25DrP18wW9nYhcjBUYebOKTjgmxyDQTJPIDXVg/WvjVI5
EEAK9SU2ddHYP497S9nAXegYjcK1kOr8YQXNhtg9SVL2g0m+mR7kfLJNwNukSidJ
NwQXkDS02OKRqbq0Z/nmQtPeC/L1QBAMJZaEbWicoGrCss6d+H0HeHqoSFOR245L
mao8X353aOy4YZAtbW9kvAiut5JSACnQK10iFhCfp2om0i9MDqthR6WwWHM8iF8L
+oJPdZ+mIDncB4WY6yuD5rNiVYGiZWiCGnqI9bjMewR+9qEHX/yn1yyRYY1viYeD
MtmakRZLVQJ411r1WobVJOlqyyTKpQ==
=zCGr
-----END PGP SIGNATURE-----

--1Ps1bXh3mLFUAaMd--



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A887E71E3
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:04:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1AJY-0005wn-4u; Thu, 09 Nov 2023 14:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1r1AJV-0005wV-UA
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:03:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1r1AJT-0008D5-5C
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:03:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699556614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pjeQm7qRqWEfxXpBNyqBZ4DSrudxcdLoPP1hEwG4vj0=;
 b=ixMyTTuQwEflvODr5PccGvVaPAqbF51gWHwgHY4OnW+EpySkWiN5PIEvtvcqoN+0+vNtnf
 fY4ZKvpPLvrFGD4Z80II4NfyxgSkgb+2NLznwdBHtJbmsmczlEjw46BibsM7Rn4tprDA1Q
 /YKN1RAsmHFSVgK7KtkNG63GnMiNaxo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-9juMXwn-PJ2UiF9YMIWRQw-1; Thu,
 09 Nov 2023 14:03:32 -0500
X-MC-Unique: 9juMXwn-PJ2UiF9YMIWRQw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6546F28AC1E4
 for <qemu-devel@nongnu.org>; Thu,  9 Nov 2023 19:03:32 +0000 (UTC)
Received: from localhost (unknown [10.45.226.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00F91492BFA;
 Thu,  9 Nov 2023 19:03:31 +0000 (UTC)
Date: Thu, 9 Nov 2023 20:03:31 +0100
From: Victor Toso <victortoso@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 00/11] qapi-go: add generator for Golang interface
Message-ID: <dlkhli4djkalmf3usmjche6pwq2kjp4epkj6h54oibq424tmgb@65scjnbd6aqe>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <CABJz62M1QnjdutHvPi9dyEueEU+BEfqK+xXeHw5GXeJaR+PcAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gpynhqjk44vgm3sh"
Content-Disposition: inline
In-Reply-To: <CABJz62M1QnjdutHvPi9dyEueEU+BEfqK+xXeHw5GXeJaR+PcAA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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


--gpynhqjk44vgm3sh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 09, 2023 at 10:35:07AM -0800, Andrea Bolognani wrote:
> On Mon, Oct 16, 2023 at 05:26:53PM +0200, Victor Toso wrote:
> > This patch series intent is to introduce a generator that produces a Go
> > module for Go applications to interact over QMP with QEMU.
> >
> > This is the second iteration:
> >  v1: https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg06734.html
> >
> > I've pushed this series in my gitlab fork:
> > https://gitlab.com/victortoso/qemu/-/tree/qapi-golang-v2
> >
> > I've also generated the qapi-go module over QEMU tags: v7.0.0, v7.1.0,
> > v7.2.6, v8.0.0 and v8.1.0, see the commits history here:
> > https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v2-by-tags
> >
> > I've also generated the qapi-go module over each commit of this series,
> > see the commits history here (using previous refered qapi-golang-v2)
> > https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v2-by-patch
>=20
> I've provided feedback on the various facets of the API in response
> to the corresponding patch. Note that I've only addressed concerns
> about the consumer-facing API: I have some notes about the
> implementation as well, but that's something that we should be able
> to easily change transparently so I didn't give it priority.

Sure thing.
=20
> Overall, I think that the current API is quite close to being a
> solid PoC that can be used as a starting point for further
> development.

Happy o hear it. Many thanks for the review, I really appreciate
it.

Cheers,
Victor

--gpynhqjk44vgm3sh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmVNLQIACgkQl9kSPeN6
SE+ckA//XlQrM+EOGXskv+WHFIBpHMFBzuKrmGL+YB493e3bM6ouGXpcYfIJIStG
6vHPx51MDjuin4qFgxgeGfFvMSObausPbFu8tlP/xxZ9bINS8l8n31NRmMr7zEgP
W6t/ULO1EdsxrIAsLcU1miyH2kAQqVOa0FDeuJPE8dN+1J6W2b3Ubo9whqDNwjfj
8K95KdhzzHNR6/6iNwGS76Yf43oB7l5JvvQ6WW4KIlrXYzVJHO90cHNYjz51r75y
SoPKm+jENyf+6lzyGRO0rXaUSQWs8GH2h+W9n5wunPJLMFuomICaR6Bt4ueXddS4
2D8PkcquKMUeY1HT4x6NKMG4BcrjrL98tcRAZUN7wQc4JDPDYN11fyDqG2Ltd8VE
0edlQYzrfaIm5q+5T+GBYaXL/zjFdi8NErJqdvKNqFn9q32acGhrly2mAuOeeyP2
zxvFUc8kZJf1jUrNuQv+Y9iZKUXUOIfvna2Fe4nI6itcSl46qmv1dYOsmgAtAxtf
Drfrp/MIjyUw8XoqwYpO01HE1ypK+O4hcOYwYOYEhC3LGzVlvZZapa7u+ZHbnDOa
UwP0PkxBY0jNo7uBNJC9Y/jL0bufAFdxnVkXUEDMSKwnEfGeiteMzwtRPYTaS6No
rZ4SZZMZ/gdeO2KZ08gzxGMF1wLFeeI51wruHDM5zj7/Og6L4Wg=
=DF5o
-----END PGP SIGNATURE-----

--gpynhqjk44vgm3sh--



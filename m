Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D81975B655
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 20:15:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMYB9-0004C1-O5; Thu, 20 Jul 2023 14:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMYB6-0004An-4N
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMYB4-00034L-OZ
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689876902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6aji4AUo/q3xcVp5i8vFfPFEaMhEyNTec2z203O2Wh8=;
 b=IOJqlBW01r2MEkQxNgAkbgWEarErsi45x6KZtW/LsHZfazgVRGwQ47AZv15n77fFpo4ljf
 StsTpdtYyHw6RJw/OwtyylM0LmnsHhfd1jBm5uH+2ggaF/EqrKDKZLPGB8rFA6ydDAImaE
 XIyoHYTjTXRiMxhWLg0OK6feu8K1yjA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-138-mrhjCRWMOdeiNFrB4Pw43w-1; Thu, 20 Jul 2023 14:14:56 -0400
X-MC-Unique: mrhjCRWMOdeiNFrB4Pw43w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A2CD858EED;
 Thu, 20 Jul 2023 18:14:56 +0000 (UTC)
Received: from localhost (unknown [10.39.194.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63280C57969;
 Thu, 20 Jul 2023 18:14:55 +0000 (UTC)
Date: Thu, 20 Jul 2023 14:14:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: qemu-devel@nongnu.org, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, john.levon@nutanix.com
Subject: Re: [PATCH 1/3] softmmu: Support concurrent bounce buffers
Message-ID: <20230720181453.GC210977@fedora>
References: <20230704080628.852525-1-mnissler@rivosinc.com>
 <20230704080628.852525-2-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="G6F2Gdz6QWgAblRO"
Content-Disposition: inline
In-Reply-To: <20230704080628.852525-2-mnissler@rivosinc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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


--G6F2Gdz6QWgAblRO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 04, 2023 at 01:06:25AM -0700, Mattias Nissler wrote:
> +        if (qatomic_dec_fetch(&bounce_buffers_in_use) == 1) {
> +            cpu_notify_map_clients();
>          }

About my comment regarding removing this API: I see the next patch does
that.

Stefan

--G6F2Gdz6QWgAblRO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS5eZ0ACgkQnKSrs4Gr
c8jNewf/dKmABPNzhBZEA7NaT1/DFNP2kqEAy5g8VW0D3S8BHGbroDToxSQMzmXz
JSdnEW7dnusFBGFc3UCtk7ZPqWCYYWg4pVb1VmnOfN1Wx0BgcVu2HvbJ5EAvlh2N
Nm90Y3pVxFUb6B9ht69k6mSCAzmtEtyMyb0XWEMrrbYTcZX298hl04FFIZs0jFmd
SNz49R1N9Popxjgj0OhpznRUDksVh85SEknprCey5oA6FFb3dGBxXoSEbbmLfdrr
pR0Ttb1VlLMMe52P9IIbTRnU7aucmoXh8ZOgIUxyhaaeDHm0GZhhMMbnXNRbUhUh
1R3/M30ctAhCV1toavX+ZV/t4XG0nA==
=aYr3
-----END PGP SIGNATURE-----

--G6F2Gdz6QWgAblRO--



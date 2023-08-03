Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D1076EED3
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 17:58:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRai2-0001kQ-Qj; Thu, 03 Aug 2023 11:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qRai0-0001Zv-Rw
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qRahz-0005R4-BB
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691078270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ao3MBoJl72eX41QiSRmPuHDbSurQm2qlLvvU+8UzEHk=;
 b=U5ICoFr4BgecQoPpoRe6h2T4/DqYS1ctg6gQyHRm/TLonuCNrFW9BoyWtlUOgozpx2es9j
 T85pSGJoAqITWsa3hFYu+SRayuGitiYZonaM6POjZIGXGHeZnw9xXzxg2kDPs44b2d29Ao
 2CfYPKo80tGldwDkMeNBmF4yFRkylTI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-sv9jnVgANKCS16_bagKcuA-1; Thu, 03 Aug 2023 11:57:48 -0400
X-MC-Unique: sv9jnVgANKCS16_bagKcuA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CAB0800159;
 Thu,  3 Aug 2023 15:57:47 +0000 (UTC)
Received: from localhost (unknown [10.39.194.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76EC8200A7CA;
 Thu,  3 Aug 2023 15:57:46 +0000 (UTC)
Date: Thu, 3 Aug 2023 11:57:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, hreitz@redhat.com,
 k.jensen@samsung.com, kwolf@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 mst@redhat.com, philmd@linaro.org, thuth@redhat.com,
 lvivier@redhat.com, jeuk20.kim@samsung.com
Subject: Re: [PATCH v9 0/4] hw/ufs: Add Universal Flash Storage (UFS) support
Message-ID: <20230803155744.GA2350274@fedora>
References: <cover.1691062912.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+2EtOBS8wD5jZSVN"
Content-Disposition: inline
In-Reply-To: <cover.1691062912.git.jeuk20.kim@samsung.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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


--+2EtOBS8wD5jZSVN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 03, 2023 at 08:48:22PM +0900, Jeuk Kim wrote:
> Dear Stefan,
> I'm really sorry, but could you please put this patch series
> instead of v8, which was previously merged into block-next?
> The fixes from v8 are below.
> Please let me know if you have any comments or issues.

I hope you have time to solve the remaining endianness issues, but that
can be done as a separate series.

Thanks, applied to my block-next tree:
https://gitlab.com/stefanha/qemu/commits/block-next

Stefan

--+2EtOBS8wD5jZSVN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTLzngACgkQnKSrs4Gr
c8jHDwf/dG763/UJyzYttau6kq9e5VL1mD8s1x2407iEFZkuakzpPDpL+VQNCZXR
qfpqZbPRkK2yFlAwyhfakdmSOesEcNeLgqjItEbXCsZU+IRdk/UXAu4ypTCA857Z
GXqJ8+A9Xu9cH+LTNUejknvT+bAHaE1qmUdTQooTjmKHISjlKUSZfuWO5SbfwZGf
wlvxNaL3JYEOxugVuPySGOU8eYqouOwbLzPuN1FUnGexYJbiQh1lw6fUfwzhNEUC
Lmvl7mGQaXGRNTi+hW8yeVqzaX62ujGM6PTa2+lOmZsYMgXhJecCUgZdmdolve5K
7TyWY18e+gozYmHoLyvxSiL0KbjI8Q==
=DUya
-----END PGP SIGNATURE-----

--+2EtOBS8wD5jZSVN--



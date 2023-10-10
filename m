Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 738F77BF047
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 03:30:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq1Yj-0006pn-0x; Mon, 09 Oct 2023 21:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qq1Yg-0006pK-Uw
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 21:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qq1Ye-0001lh-Ex
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 21:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696901350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HJwSG4mydfi+JXLRlkhOXhGn23+1pc2lXVkFyt1WNMU=;
 b=FKeOaGyd/T6HskZY1i5Q/nj2gjYKl1f/lq8iChoCmE+fHqmWivWGyl4fP0mMXOxa22CYGc
 KhcLYuLGwr2SeDAdL635hNULSBbifWGEa5U7Bux0JznH4xEUjZvmy2B6l3L2M/bCFeX4xd
 Ufo6T1idFePzKGyYf7N20d/s4R4iuq8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-2c7GuOfROYGyrWP-H-iDiw-1; Mon, 09 Oct 2023 21:29:08 -0400
X-MC-Unique: 2c7GuOfROYGyrWP-H-iDiw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 653A1101A5C5;
 Tue, 10 Oct 2023 01:29:08 +0000 (UTC)
Received: from localhost (unknown [10.39.192.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F233C40C6EA8;
 Tue, 10 Oct 2023 01:29:07 +0000 (UTC)
Date: Mon, 9 Oct 2023 21:29:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PULL 00/20] Q800 for 8.2 patches
Message-ID: <20231010012906.GA1674588@fedora>
References: <20231008062349.2733552-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BBtJILf9hsTeC1Ds"
Content-Disposition: inline
In-Reply-To: <20231008062349.2733552-1-laurent@vivier.eu>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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


--BBtJILf9hsTeC1Ds
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--BBtJILf9hsTeC1Ds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUkqOIACgkQnKSrs4Gr
c8iZ3Qf/StF8/urTyUdLLt9KI3VdHyV15R0Ab4p/+gsnM8pBBBiZkx9im4HvoELE
28wywwV6U6PFr1UBAvcsJwi5vi/XFLKVy64r4zpusox0WhZFe/bfuTdYrA2xIg0t
ACnw58sK/LUxSwCgnIE3O5pxDsaLp4SKFcOjX8/b17FrASlyoBrtnJ2LgR0il7k6
ipU+vyercuqS6f5r6vpT6TvMQISBy/rBlFKg5u4HYjU+V5N8+HimCa0UkF5lVFOr
Woc0YVylyv8nZnGSvUCZBb4DQEqrjmN1J2ij1/hUOg1YRyUKmX5xfevMhjRviTRd
lZXtgLYY8PTv2XHIMXqyEiZyZG/d+A==
=XhYG
-----END PGP SIGNATURE-----

--BBtJILf9hsTeC1Ds--



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 273E57CB349
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 21:21:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsT90-00078q-DY; Mon, 16 Oct 2023 15:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qsT8y-000759-UI
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 15:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qsT8x-0005Zs-EM
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 15:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697484046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O9JxGTlnrwjTbg04r7ebzr5iBzLwaQDHTk56qZ8XRyk=;
 b=M/GRlfpVEKsoF5ZYsHgzQP2DBOUE5xtreNcjuCg2j+D86HdT1J09UaYpljFTQUz0gKxneJ
 0VRaxr5SiGBB2GUor/c2cgSXfwREPZzACxo9XkKZy+jBS7qpofGF/22UnU6kjLn8NyS8tu
 G5SIjA/TMkJRm0mcqbQi40B2fl7WJXE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-6Pg7mQ3VM4GHloX_qioQxA-1; Mon, 16 Oct 2023 15:20:43 -0400
X-MC-Unique: 6Pg7mQ3VM4GHloX_qioQxA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 056178E8C64;
 Mon, 16 Oct 2023 19:20:40 +0000 (UTC)
Received: from localhost (unknown [10.39.195.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F772C15BB8;
 Mon, 16 Oct 2023 19:20:39 +0000 (UTC)
Date: Mon, 16 Oct 2023 15:20:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 qemu-block@nongnu.org, jeuk20.kim@samsung.com, bmeng.cn@gmail.com
Subject: Re: [PULL v2 0/2] hw/ufs: fixes
Message-ID: <20231016192038.GA161309@fedora>
References: <cover.1697173209.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VCxyur0gQ2nnfKt3"
Content-Disposition: inline
In-Reply-To: <cover.1697173209.git.jeuk20.kim@samsung.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--VCxyur0gQ2nnfKt3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--VCxyur0gQ2nnfKt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUtjQYACgkQnKSrs4Gr
c8hSdggAqZz2CAtOO6Ar8aYM7QkVKxK/XjHKNA50Xcu5SusBniXFt0iXSlFBuYn3
4/4h3fDku6DohjKFxy2LSDg+gCqhB4VBIxNbsdvb2UqyHiH9p4qx523yyRiUUF9q
Y1FTSY7sfjRXow9GNZWXVPfULZg6Dzkq0hPukwVjA/xir2EMEdgTOg1vs1mxgR24
OPYhyFGxOc9ZOMv+dZl0EbcJiq3toV4wZfCl095QzFQwsia3k2B/pxasXcTsTBT5
NKZ/ZijhYerkM4RRBUVkAXT8nPSV1/0UV7Csebrh+Qjnb1Z0hCE7CJ8MmKq8X8L8
xdO4zyu/HWduB9FrgfWn+Zs75eLtcQ==
=2aF0
-----END PGP SIGNATURE-----

--VCxyur0gQ2nnfKt3--



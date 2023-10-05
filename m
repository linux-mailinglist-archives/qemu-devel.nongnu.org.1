Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F577BA38A
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 17:58:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoQir-0001XC-GR; Thu, 05 Oct 2023 11:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoQio-0001WF-R8
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoQin-0006Kq-0V
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696521424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3XnY9QHTWJ26IFwNgUJQblFKg3jtwUnr6etwSGp9N5k=;
 b=eiSOoYVHtGzYAo7QaJqERkGOMW/q1cr3RqipOuGcA1AV9v4YhCwqkSjp7Ja7QIutco/F04
 GbFdZbI/dIzRJCOXhb+huiigvVJGyhA4NcfNe6KQbCfFowNIU9iDjpbMf39e5sthBKMl8f
 8pChR55iQyUX8ugDxHGuoJRsAFdk4aU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-VkogY-8iPNqZJ1UlJcJIaw-1; Thu, 05 Oct 2023 11:56:52 -0400
X-MC-Unique: VkogY-8iPNqZJ1UlJcJIaw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81057185A79C;
 Thu,  5 Oct 2023 15:56:52 +0000 (UTC)
Received: from localhost (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1AD742156711;
 Thu,  5 Oct 2023 15:56:51 +0000 (UTC)
Date: Thu, 5 Oct 2023 11:56:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v2 00/53] virtio,pci: features, cleanups
Message-ID: <20231005155650.GA1344739@fedora>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/qQ/b5tlZC1mgwpC"
Content-Disposition: inline
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--/qQ/b5tlZC1mgwpC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--/qQ/b5tlZC1mgwpC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUe3MIACgkQnKSrs4Gr
c8gh0QgAj8Uvq/xLKWBmvBXM/4gN+sSLFlnt755JNug8FmCbkarHfbMM92M6wDPZ
jq9Xm3SoBnsYxzp4PDzspco1Znub95qQS7zB7PwTswgrpShR/dTNOau5YcjIfluh
AK1u1XJ5bPz9b6eA3HEz3rzElgLmG9RzV+UEy4S0y7vX78HN5IXib3yy3b9VXcbO
Z0tqO+xwPqJ2WkrSyoh12xCrj8M5EhvFkFaImJdqaG7cyTyROVQxNd6BjADBAVTq
FtYitWkFNAoa+pOumymcPL8a1EMDLpqTDNB31AIDsG9HbYIdKMTSvmDt0leR9MNL
wDV7r5iRYwAU2XbwRYoQs2BdVEZR4Q==
=9uly
-----END PGP SIGNATURE-----

--/qQ/b5tlZC1mgwpC--



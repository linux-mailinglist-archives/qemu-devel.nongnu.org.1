Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 653037AF571
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:42:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlEsN-0007u0-F9; Tue, 26 Sep 2023 16:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlEsL-0007th-R3
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:41:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlEsJ-00030K-Sz
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695760903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i/biLNNzqaH6G/kJm5JZ0C6gIrsItYoU4jKbt/w5d4o=;
 b=PXcmX9+KiNo9q8NA/6j+BlqhBfkSVcSYDJnwYtxfPVmzfVm8K2Qjv0DI0gIV3ZOwIlW992
 l18rp689AkNcrsHVw7PetMyv8kUfca61EClBnnUcQQ2xYCUpd9PL4D2fU9kxVH1kTEth0k
 bwPeu0OP9n7qxfwaunTzie4FBrL4sac=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-O-Fn9wkDMiWyJ85e4If5yg-1; Tue, 26 Sep 2023 16:41:39 -0400
X-MC-Unique: O-Fn9wkDMiWyJ85e4If5yg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B9BC800045;
 Tue, 26 Sep 2023 20:41:38 +0000 (UTC)
Received: from localhost (unknown [10.39.192.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64F0B2156702;
 Tue, 26 Sep 2023 20:41:37 +0000 (UTC)
Date: Tue, 26 Sep 2023 16:41:35 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 yc-core@yandex-team.ru, davydov-max@yandex-team.ru,
 alex.chen@huawei.com, euler.robot@huawei.com, Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:NVMe Block Driver" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 6/8] block/nvme: nvme_process_completion() fix bound
 for cid
Message-ID: <20230926204135.GA409047@fedora>
References: <20230926201532.221152-1-vsementsov@yandex-team.ru>
 <20230926201532.221152-7-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QfvlyoqgmMJ8pnDb"
Content-Disposition: inline
In-Reply-To: <20230926201532.221152-7-vsementsov@yandex-team.ru>
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


--QfvlyoqgmMJ8pnDb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 11:15:30PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> NVMeQueuePair::reqs has length NVME_NUM_REQS, which less than
> NVME_QUEUE_SIZE by 1.
>=20
> Fixes: 1086e95da17050 ("block/nvme: switch to a NVMeRequest freelist")
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>=20
> Cc: stefanha@redhat.com
> Cc: alex.chen@huawei.com
> Cc: euler.robot@huawei.com
>=20
> Note, that there was similar patch in the past:
>  https://patchew.org/QEMU/20201208144452.91172-1-alex.chen@huawei.com/
> I still think, that using NVME_NUM_REQS is better here.
>=20
>  block/nvme.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--QfvlyoqgmMJ8pnDb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUTQf8ACgkQnKSrs4Gr
c8j2cAf+PYfCemokwzt6n5htZfTyaN1FQxRz5augYhQv/LQ2mV0oERr1h6xe/unh
rmBj5KrPq1ufYJ3IE+UdXG7dlRaOwZV+kx/Cpg7NHWIsmR914IrsExGThTNC/M6I
VfWhz0dj92MLbLEU1myYjG2KXmwBubSRQpHsyVXIBn6wV4b9dicV6af807sHiKCS
g03lk19KLdRby4jdighwuQjn7qH3+cujvwH46EuEOo0qstcXqXL1dW4dIIcO0Hff
Zv82D17/2gtDvSKVlcctxJSqeRh2x6hiO928yjQliWsMsQx4s5nFuLZXWB6HoDYA
5ZOXdZYxusbk1zfFjuAJtjDoeKoxcw==
=9xhI
-----END PGP SIGNATURE-----

--QfvlyoqgmMJ8pnDb--



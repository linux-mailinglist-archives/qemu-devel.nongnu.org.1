Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E6F75B723
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 20:51:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMYiQ-0003J2-Hz; Thu, 20 Jul 2023 14:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMYiP-0003It-0i
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:49:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMYiN-00049w-Lf
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689878966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aB8N1dMLa8zLid3ZsBA53ajjLGj+wtqc5DP+c735854=;
 b=US3S3qYB8zDgwhaan0YT+DGFD2kOjyO5cIjDfPPffTRUpdsTbxnvIf4HUynCg1TR4KRgQy
 x/jqr1ioenSLCm2Y0OJjbQbtUkeem5efcvFN9A0kwp6vme8mqPWhAgfJzl2ZlioxB1y7Z/
 +U/RVyg7cyEE05vGjy/ZanKjUbKzMFo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-H4noul90O_O_w8Fa8lfUzQ-1; Thu, 20 Jul 2023 14:49:22 -0400
X-MC-Unique: H4noul90O_O_w8Fa8lfUzQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43E39858EED;
 Thu, 20 Jul 2023 18:49:22 +0000 (UTC)
Received: from localhost (unknown [10.39.194.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D8711401C2E;
 Thu, 20 Jul 2023 18:49:21 +0000 (UTC)
Date: Thu, 20 Jul 2023 14:49:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, hreitz@redhat.com,
 k.jensen@samsung.com, kwolf@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 mst@redhat.com, philmd@linaro.org, thuth@redhat.com
Subject: Re: [PATCH v5 0/3] hw/ufs: Add Universal Flash Storage (UFS) support
Message-ID: <20230720184919.GF210977@fedora>
References: <cover.1689731819.git.jeuk20.kim@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ldd7pPgEUkVAhGO2"
Content-Disposition: inline
In-Reply-To: <cover.1689731819.git.jeuk20.kim@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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


--Ldd7pPgEUkVAhGO2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
I'm ready to merge this but encountered a bug when testing:

  $ qemu-system-x86_64 --device ufs --device ufs-lu
  Segmentation fault (core dumped)

Please ensure there is an error message like with SCSI disks:

  $ qemu-system-x86_64 --device virtio-scsi-pci --device scsi-hd
  qemu-system-x86_64: --device scsi-hd: drive property not set

Thanks,
Stefan

--Ldd7pPgEUkVAhGO2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS5ga8ACgkQnKSrs4Gr
c8hQbgf/dAqk9vUQZIUBPbRBPuvN7EP3FVSaC0ECgMHY4QpYJp8UKpsunaKcM1ON
QtSpkGq+r1hIlvux73vkgEhJQUw/Mslt0p8qUwekHvlx2jfrfPe1knSiISkV1n4F
Ka7FEHrWRm+Pufe0aCnhJpkwai5gGyJhzzF5bC0XTonQrYWeuxHA4TwgBx2Y2I8F
g3hva+1kURdrVcj/Z4wxCwcZfUy84Tb+ckTKUI7DfQhM5g4WXSKRsooy0m08aQ3d
p+KAqeR61JKYsPqo99B37328tCxPgy/sM9hHPSJa2yk2xh5wR08XKhcVDMeEoUTv
ybZ016v726nj5GAWHapYfLaZwfXHMg==
=VECj
-----END PGP SIGNATURE-----

--Ldd7pPgEUkVAhGO2--



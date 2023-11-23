Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 325F27F67ED
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 20:59:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Fq0-0001EH-O4; Thu, 23 Nov 2023 14:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r6Fpy-0001E5-2E
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 14:58:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r6Fpw-0002RT-MJ
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 14:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700769485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FatwkguduZZYkL2Jy8YhWHxqF/8vEf/NOunmbxwSSVE=;
 b=RUeBwWLYKrIdDXZHliuikonSvvk6xZJIQThDU/UG2YtExFEw7uLbB7Hbr3JBxbK/T3zgnQ
 C+PxKMgWjuXbVLXtVfjY8yN3NrFnsM6adH8qVIsPwzG6fV7GU+Ym4CNj3oXrm7N3kyd29N
 5XjBGDjlFuqjK63vase2RPjOgvVlfIU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-9FFFpyMjNsKJmwWKE1sUcA-1; Thu,
 23 Nov 2023 14:58:02 -0500
X-MC-Unique: 9FFFpyMjNsKJmwWKE1sUcA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 725E53C025BE;
 Thu, 23 Nov 2023 19:57:59 +0000 (UTC)
Received: from localhost (unknown [10.39.192.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CAFC62166B26;
 Thu, 23 Nov 2023 19:57:58 +0000 (UTC)
Date: Thu, 23 Nov 2023 14:57:57 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, kwolf@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH 0/4] scsi: eliminate AioContext lock
Message-ID: <20231123195757.GA172762@fedora>
References: <20231123194931.171598-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Nl1csQn1DUwa0RrI"
Content-Disposition: inline
In-Reply-To: <20231123194931.171598-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--Nl1csQn1DUwa0RrI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 02:49:27PM -0500, Stefan Hajnoczi wrote:
> The SCSI subsystem uses the AioContext lock to protect internal state. Th=
is is
> necessary because the main loop and the IOThread can access SCSI state in
> parallel. This inter-thread access happens during scsi_device_purge_reque=
sts()
> and scsi_dma_restart_cb().
>=20
> This patch series modifies the code so SCSI state is only accessed from t=
he
> IOThread that is executing requests. Once this has been achieved the AioC=
ontext
> lock is no longer necessary.
>=20
> Note that a few aio_context_acquire()/aio_context_release() calls still r=
emain
> after this series. They surround API calls that invoke AIO_WAIT_WHILE() a=
nd
> therefore still rely on the AioContext lock for now.
>=20
> Stefan Hajnoczi (4):
>   scsi: only access SCSIDevice->requests from one thread
>   virtio-scsi: don't lock AioContext around
>     virtio_queue_aio_attach_host_notifier()
>   scsi: don't lock AioContext in I/O code path
>   dma-helpers: don't lock AioContext in dma_blk_cb()
>=20
>  include/hw/scsi/scsi.h          |   7 +-
>  hw/scsi/scsi-bus.c              | 174 ++++++++++++++++++++++----------
>  hw/scsi/scsi-disk.c             |  23 -----
>  hw/scsi/scsi-generic.c          |  20 +---
>  hw/scsi/virtio-scsi-dataplane.c |   8 +-
>  system/dma-helpers.c            |   7 +-
>  6 files changed, 130 insertions(+), 109 deletions(-)

CCing Kevin and qemu-block

>=20
> --=20
> 2.42.0
>=20

--Nl1csQn1DUwa0RrI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVfrsUACgkQnKSrs4Gr
c8jVHwf+MjcfMQfJhyhnGyCd3zDL0Wx1lCypqOyy/D52CkWtKUzUYpQqOZM++7+W
J7U0/NeoW1ZoRWG10pqBqgsjmEd85KiwwyHEwWddyse6IjQ2lRP1uwToDXs9EbdB
Xkfmqxq7hDcCVEQPSncKaC4hVwSjTRjYHM6cabK3ITa7PG/tsmurYep1cE2DW4/L
I4BlIjYjMlVCy7BAsOsmAJBBY9uJYBHo6RlmnLDMog5aEZ838aj9sLiixbjlwkEd
kTWeIIkYwlSb+DHsjzOYFR9S/hflHbN/+DTD27eSpmqjdB6OnWHXivJmEd0KdRJ1
WUDu23/+yZDjHZm96iIO6zW3r6KgEg==
=yGVD
-----END PGP SIGNATURE-----

--Nl1csQn1DUwa0RrI--



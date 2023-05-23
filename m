Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8D170E6B4
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 22:41:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Yo8-00063o-ML; Tue, 23 May 2023 16:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1Yo7-00063g-6o
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1Yo4-0006cE-Tq
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684874431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=STnLOevOlG/6PL4mH3cOiooNHmiasnIbSTtH6HIdst4=;
 b=F5kU3asOIioYivbkEmfh4/QmEIUk4x2Ueo2Si3ZSQftVq2RX8qO9kP5dOVrYFh29VQa5vk
 ZHFFttp3xsVn32VlmNYyOb8M7KKyvTESw9OOFyljEqbJP823EQWFLZmYVHgXqyKLUlkmWp
 JJvsGLoWaHGnIi6nxDyunVfrNkfw6/8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-qPV6zhYmM1a_IqIo78x24w-1; Tue, 23 May 2023 16:40:28 -0400
X-MC-Unique: qPV6zhYmM1a_IqIo78x24w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 514F93C11A1A;
 Tue, 23 May 2023 20:40:27 +0000 (UTC)
Received: from localhost (unknown [10.39.192.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78055140E95D;
 Tue, 23 May 2023 20:40:26 +0000 (UTC)
Date: Tue, 23 May 2023 16:40:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Markus Armbruster <armbru@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, virtio-fs@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 04/13] include/hw/virtio: document virtio_notify_config
Message-ID: <20230523204024.GC140337@fedora>
References: <20230418162140.373219-1-alex.bennee@linaro.org>
 <20230418162140.373219-5-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="n+4RkN+DFQIpOtH2"
Content-Disposition: inline
In-Reply-To: <20230418162140.373219-5-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--n+4RkN+DFQIpOtH2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2023 at 05:21:31PM +0100, Alex Benn=E9e wrote:
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  include/hw/virtio/virtio.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index f236e94ca6..22ec098462 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -274,6 +274,13 @@ extern const VMStateInfo virtio_vmstate_info;
> =20
>  int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id);
> =20
> +/**
> + * virtio_notify_config() - signal a change to device config
> + * @vdev: the virtio device

The spec calls this sending a Configuration Change Notification
(https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.htm=
l#x1-1110001).
I suggest using VIRTIO specification terminology, otherwise every person
paraphrases the spec and you have to guess how QEMU code/comments map to
the spec.

--n+4RkN+DFQIpOtH2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRtJLgACgkQnKSrs4Gr
c8j5gAgAk2asKwBxr19D07pYrcggJWhzcY1bdjNYAYyKLHQxAS7Z3iRW+5gI3MHj
6jF4OwmDC+SGaxCmHFiJ01nipfnEF8lksQlupqxmABr9Ql+Hg+HCl1ph8PP4YaCg
6twnx6ohKPZAM1A4od6ZhSa1rGEENJ+c/PY/KUY0nJ5bDx7wDbSLNyoHqZ4107R5
FXR4fthY9FuEb/3vVkXcvX4bKQj3qSa/09BXCcuJbX9HJaGbI0rP2/Pf1AvK+RDK
9VBzpMPjRFO7bdcyalohC32A/9FjXh+gyw8wY32WE5qWm5QVCJCldSnVczeAlMUe
lGS2dqmSrs0YR+J4MNzSP5dw9L5MvA==
=bKZx
-----END PGP SIGNATURE-----

--n+4RkN+DFQIpOtH2--



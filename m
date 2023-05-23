Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9793970E6B3
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 22:41:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Yom-0008La-Gx; Tue, 23 May 2023 16:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1Yok-00085K-3e
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:41:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1Yoi-0006my-N3
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684874471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PLASUw7a2U/r/ncne6F9gHdKgyHt/K5cMVTZYim/UzY=;
 b=X9ulXcNbsF/b77/UwA7/mm23bGlkyzPFwpi0gGoaOEfsQWv18borOY+xK+EShNKgKytoNw
 U09BxtTpRX96/CnEUIKcKHHfF1FBnZZYCHfC0RP66MZW3JQz9mkxiYiSNZVXX2pYsZ6nZ5
 3p3pkQTKD9fOiJwr3T7JAuHllD7HCLw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-qx0JYLrBNCeP9nmsZPhCBg-1; Tue, 23 May 2023 16:41:06 -0400
X-MC-Unique: qx0JYLrBNCeP9nmsZPhCBg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AFE2858285;
 Tue, 23 May 2023 20:41:05 +0000 (UTC)
Received: from localhost (unknown [10.39.192.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFDABC1ED99;
 Tue, 23 May 2023 20:41:03 +0000 (UTC)
Date: Tue, 23 May 2023 16:41:02 -0400
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
Subject: Re: [PATCH v2 05/13] include/hw/virtio: add kerneldoc for virtio_init
Message-ID: <20230523204102.GD140337@fedora>
References: <20230418162140.373219-1-alex.bennee@linaro.org>
 <20230418162140.373219-6-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dvQrJ4C/KXaEeudq"
Content-Disposition: inline
In-Reply-To: <20230418162140.373219-6-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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


--dvQrJ4C/KXaEeudq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2023 at 05:21:32PM +0100, Alex Benn=E9e wrote:
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  include/hw/virtio/virtio.h | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dvQrJ4C/KXaEeudq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRtJN4ACgkQnKSrs4Gr
c8gGugf+ItsPLi8OQgzdZdQriVkXhH1Qo9Sitp/W3Vux1IB7WJcBEQqUaA3q2Chd
1FlP4aVXRC8dqzk+pf8IhN4pwHZAFij5W6jMZ5xVjpSW9j309+wdGCruufPj9FSn
oiCIJfOVLBTBXB1VeJHP1ZxPGCrwD2bHfS1PYCdZBB+kZjF1p8TOHx6ysCsIUcub
dZm6kQQeZkza5BW7vzUV0gNEnzqkWs8b99E7RMUDlw/giIVwZMUEFqlW4SF6mcyN
2KyQWO+d0Ed9hxgt5OS6Oy7MDMhEQ3mWLxvGstLLENRINE0eslqCRSac2G8TQIRX
HsgrJsjdIEJPLgeRf+FmkfTf0ejTww==
=5l3r
-----END PGP SIGNATURE-----

--dvQrJ4C/KXaEeudq--



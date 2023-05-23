Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADCE70E6DF
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 22:54:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Yzn-0006tU-Gk; Tue, 23 May 2023 16:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1Yzm-0006tC-1W
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:52:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1Yzk-0000wB-J1
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684875153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jpfxhZe73n6bQX1TX9kE0D0tE8B/rP44DikI5+6cGR4=;
 b=bDNHGxpgWnoyBt1eRAWwYOGfbk4y4U1TYG1gh097cDGSA39BAZSjIEN+3EeznElXqTJXfS
 FvbMNZZsCYdaeD8CSM+5csLXdS+tRzLggcal1ukTX7aoS5gUDnAxv8QaNU1a32VaF74PqH
 NM7fX/iFDRJndPP5jr3+WFI1BTYIgO0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-3WeMiFhgOViuFurm9zoqNg-1; Tue, 23 May 2023 16:52:29 -0400
X-MC-Unique: 3WeMiFhgOViuFurm9zoqNg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59E66811E78;
 Tue, 23 May 2023 20:52:29 +0000 (UTC)
Received: from localhost (unknown [10.39.192.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B0BD140E961;
 Tue, 23 May 2023 20:52:28 +0000 (UTC)
Date: Tue, 23 May 2023 16:52:26 -0400
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
Subject: Re: [PATCH v2 06/13] include/hw/virtio: document some more usage of
 notifiers
Message-ID: <20230523205226.GE140337@fedora>
References: <20230418162140.373219-1-alex.bennee@linaro.org>
 <20230418162140.373219-7-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pEofnJd+Ev51ey3k"
Content-Disposition: inline
In-Reply-To: <20230418162140.373219-7-alex.bennee@linaro.org>
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


--pEofnJd+Ev51ey3k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2023 at 05:21:33PM +0100, Alex Benn=E9e wrote:
> Lets document some more of the core VirtIODevice structure.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  include/hw/virtio/virtio.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 1ba7a9dd74..ef77e9ef0e 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -150,10 +150,18 @@ struct VirtIODevice
>      VMChangeStateEntry *vmstate;
>      char *bus_name;
>      uint8_t device_endian;
> +    /**
> +     * @user_guest_notifier_mask: gate usage of ->guest_notifier_mask() =
callback.

s/user_/use_/

> +     * This is used to suppress the masking of guest updates for
> +     * vhost-user devices which are asynchronous by design.

What is the exact reason why masking is not supported by vhost-user?

Only vhost-user-net and vhost-user-crypto set use_guest_notifier_mask to
false. Do the other vhost-user devices need to set it to false too?

> +     */
>      bool use_guest_notifier_mask;
>      AddressSpace *dma_as;
>      QLIST_HEAD(, VirtQueue) *vector_queues;
>      QTAILQ_ENTRY(VirtIODevice) next;
> +    /**
> +     * @config_notifier: the event notifier that handles config events

Using VIRTIO spec terminology:
"the event notifier that sends Configuration Change Notifications"

> +     */
>      EventNotifier config_notifier;
>  };
> =20
> --=20
> 2.39.2
>=20

--pEofnJd+Ev51ey3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRtJ4oACgkQnKSrs4Gr
c8g59wgAyC/aLNruLTM1w0JWagBD1NcaOr44bvzMZQWgxcTGmewWz4H9iXRBwKjo
qZwOLXLJep5/XbgaCokCYOjBJVOG6WS1Ied43h0wQf3rNmkszL4BJlwsp31JCgyC
9/UXz18J9PxTu0tjINL9UIWYcoZsLlPO308q4ArZ0Pvy7vUAaD7F2ged044SCA2H
z0Vv2cY/Fc6woEwLULeztv3dWwl8gpMkgufSan+YLkfXlOfiAERrYvpRjubFEvIQ
sxYIM04R/jn2F4fFxpp6vgCKXp4TQ3ILoJ7a9zPv15bFM+2kVy0yb/zNQ6xBBxhi
R0+dyZCccrtD9nmW1zfkLFDfhAC/rA==
=BgtP
-----END PGP SIGNATURE-----

--pEofnJd+Ev51ey3k--



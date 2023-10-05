Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8CF7BA85E
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 19:47:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoSQi-0006Ym-IC; Thu, 05 Oct 2023 13:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoSQd-0006YA-36
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoSQb-0005aS-MG
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696527985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RjCL+hkdyjqzcINXooArm8wGFV87J3hI+46yN8d26lU=;
 b=JyrlgoMaJ5cYgpioFX97U9yPPZS+hifyFcthgidM+ATDHoGwpC7IRnnDeD85LkCoQjNa8I
 mHiVbk55erFdLm76i4fQOvVqgDBtmox1VVcqi5bBDOxFfDH7rrwWGfylvGpf7T/PBolmNe
 k+/xFUUADqqRIhS5TnxQpFbfg39nx54=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-Rs0LfZuWPwyMtqmwkGfAxw-1; Thu, 05 Oct 2023 13:46:10 -0400
X-MC-Unique: Rs0LfZuWPwyMtqmwkGfAxw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAE202812948;
 Thu,  5 Oct 2023 17:46:09 +0000 (UTC)
Received: from localhost (unknown [10.39.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AA3C47AD4A;
 Thu,  5 Oct 2023 17:46:09 +0000 (UTC)
Date: Thu, 5 Oct 2023 13:46:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>
Subject: Re: [PATCH v4 5/8] vhost-user.rst: Migrating back-end-internal state
Message-ID: <20231005174608.GF1342722@fedora>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-6-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jDuzzalqjlJwX7Gx"
Content-Disposition: inline
In-Reply-To: <20231004125904.110781-6-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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


--jDuzzalqjlJwX7Gx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 02:59:01PM +0200, Hanna Czenczek wrote:
> For vhost-user devices, qemu can migrate the virtio state, but not the
> back-end's internal state.  To do so, we need to be able to transfer
> this internal state between front-end (qemu) and back-end.
>=20
> At this point, this new feature is added for the purpose of virtio-fs
> migration.  Because virtiofsd's internal state will not be too large, we
> believe it is best to transfer it as a single binary blob after the
> streaming phase.
>=20
> These are the additions to the protocol:
> - New vhost-user protocol feature VHOST_USER_PROTOCOL_F_DEVICE_STATE
> - SET_DEVICE_STATE_FD function: Front-end and back-end negotiate a file
>   descriptor over which to transfer the state.
> - CHECK_DEVICE_STATE: After the state has been transferred through the
>   file descriptor, the front-end invokes this function to verify
>   success.  There is no in-band way (through the file descriptor) to
>   indicate failure, so we need to check explicitly.
>=20
> Once the transfer FD has been established via SET_DEVICE_STATE_FD
> (which includes establishing the direction of transfer and migration
> phase), the sending side writes its data into it, and the reading side
> reads it until it sees an EOF.  Then, the front-end will check for
> success via CHECK_DEVICE_STATE, which on the destination side includes
> checking for integrity (i.e. errors during deserialization).
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 172 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 172 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jDuzzalqjlJwX7Gx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUe9mAACgkQnKSrs4Gr
c8j0pggAg8UjrOpW1KQrqs75pbu8eO2gSx9HQGModw59J4CVl1GHySIhKzi7VFQO
Cyvq1wm3vbBJbDwvdeT1al791zvbu1yZgz6nFJZfzJnQ3p9OVYZY9gVSNN4S1gNK
0C71HUGh7Z+9Kf/IeGipgZHkr8VEgFNLZ1VdtvzLzadROBn4fQ71Pp5V54bnkSej
WYOr05CvcUhZKXiudbRVHgddIK+/E1ghxAy1ITi9d2jGOFpHnKX7uKtalAiTLW81
lPTPl+YNJh5ks9IJ06u1NKnOXJMD37SqN6jv47WYtwRQRSsjZQ+ryxWQB2lCjnoc
TAYgRoiG+6pBUPTkGkGKpEDpqM2l8A==
=B0Ah
-----END PGP SIGNATURE-----

--jDuzzalqjlJwX7Gx--



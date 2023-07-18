Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C047581CD
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 18:13:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLnKB-0002l8-Sx; Tue, 18 Jul 2023 12:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLnK6-0002jF-Th
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 12:13:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLnK5-0005dT-GI
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 12:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689696791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b6dgQ39RTjTw4j64wAPn8MJqDBJ0ZJyRZqFRq3S+C3g=;
 b=jPrVXibuhfhPl6qz+J+QqTBqpEUeOQ1HGY8d47wxzJtryJfgzTzmSyTivjeNucwFRi6wL3
 SMxm3IIqz84avL6M+omMmuDLwkoA28DRUpdDuQuRZiXgzxMT0mH+jRJLZLCfECscU7Thuh
 K9Unjd+g9moK0bTfmneQRseX0Fpw94o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-FwIPlmRYNa2XdFZ_BsrUgA-1; Tue, 18 Jul 2023 12:13:09 -0400
X-MC-Unique: FwIPlmRYNa2XdFZ_BsrUgA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3691A936D2E
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 16:13:09 +0000 (UTC)
Received: from localhost (unknown [10.39.193.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F0F24CD0F5;
 Tue, 18 Jul 2023 16:12:57 +0000 (UTC)
Date: Tue, 18 Jul 2023 12:12:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v2 1/4] vhost-user.rst: Migrating back-end-internal state
Message-ID: <20230718161256.GK44841@fedora>
References: <20230712111703.28031-1-hreitz@redhat.com>
 <20230712111703.28031-2-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BwtCgPh9YPz5qIap"
Content-Disposition: inline
In-Reply-To: <20230712111703.28031-2-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--BwtCgPh9YPz5qIap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 01:16:59PM +0200, Hanna Czenczek wrote:
> @@ -1471,6 +1511,53 @@ Front-end message types
>    before.  The back-end must again begin processing rings that are not
>    stopped, and it may resume background operations.
> =20
> +``VHOST_USER_SET_DEVICE_STATE_FD``
> +  :id: 43
> +  :equivalent ioctl: N/A
> +  :request payload: device state transfer parameters

Where are these defined?

--BwtCgPh9YPz5qIap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS2ugcACgkQnKSrs4Gr
c8jU9wgAshYvAU9ZweVQwO2k4C2yAujjDZVLSrcViz/ewOrYM/+tWMRoQZwq4Z77
edpbdLcgGvcQglIwUfYdUXX1EA071YprhLx1SMQM/52u53c/eenzV31WQi5q6+LF
DcyHIv5wTo0Ei5GE6hjZCZC3ejdQCraN9MOxmuhGeWrFPK+jYuhaqOg8TY03M46o
1rMYDoV7/Ukb/lVV3YsL3HbEwM0EfEkB9uNZeQwW7XmRJue4105clF627Yd9J1ZF
Dw2KE7uLrO/SBYbO6kBge4loMJkQh88JBx4nM9DGp5tfkf6lDJdylVF+OHpbmGlZ
2irLnLsqD5SQ9a147SuUNqRCAh2ryQ==
=qMQA
-----END PGP SIGNATURE-----

--BwtCgPh9YPz5qIap--



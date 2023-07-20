Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C8675B810
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 21:34:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMZPs-0002XC-30; Thu, 20 Jul 2023 15:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMZPm-0002UB-MN
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 15:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMZPl-00071P-AE
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 15:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689881656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eG6jlyoUZ5qzdNUtskdrDodZ/+VJIJ2pNFORLB3W/5U=;
 b=BJEDJsf11M9DQllge+Zl+40oeFqRLW65HzZq4RbU6kngMkq6UkC9NOhAs00dpixRPwh5VE
 iTRXoMF+vAaQC3HQHWdk3yNXpf6JUH9/0rvh6gh8b6AsSDGd62d6OgLi4JqChA6GFiE3J8
 O57R2S1EtDHkSpeJp0WYLU+lt3HG2ok=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-3m7NbuOyMTm3RYJBjmG3XQ-1; Thu, 20 Jul 2023 15:34:09 -0400
X-MC-Unique: 3m7NbuOyMTm3RYJBjmG3XQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC757185A791;
 Thu, 20 Jul 2023 19:34:07 +0000 (UTC)
Received: from localhost (unknown [10.39.194.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FFC140C2070;
 Thu, 20 Jul 2023 19:34:06 +0000 (UTC)
Date: Thu, 20 Jul 2023 15:34:05 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, slp@redhat.com,
 mst@redhat.com, marcandre.lureau@redhat.com,
 viresh.kumar@linaro.org, sgarzare@redhat.com,
 takahiro.akashi@linaro.org, erik.schilling@linaro.org,
 manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Subject: Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature for
 vhost-user
Message-ID: <20230720193405.GH210977@fedora>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="j9wh8nmrelTh7uLo"
Content-Disposition: inline
In-Reply-To: <20230704123600.1808604-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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


--j9wh8nmrelTh7uLo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Benn=E9e wrote:
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index c4e0cbd702..28b021d5d3 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -202,6 +202,13 @@ typedef struct VhostUserInflight {
>      uint16_t queue_size;
>  } VhostUserInflight;
> =20
> +typedef struct VhostUserBackendSpecs {
> +    uint32_t device_id;
> +    uint32_t config_size;
> +    uint32_t min_vqs;

You already answered my question about min_vqs in another sub-thread.
I'll continue there. Please ignore my question.

Stefan

--j9wh8nmrelTh7uLo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS5jC0ACgkQnKSrs4Gr
c8iN6AgAxdqz+9Xcn0x06RFaLDFhDZZIKyQMS5xX2hORkjyy4/elj76lqsL3LWp3
hg2YULCGZR2aKklkTi0ru6GZ+sHCHgK5b5Jc4mIZv+J9bxxKvPipRfuxaAbax8zp
32swpPC5FMIl+LtM7YT4+DaJo8xggwqXlDMtQ1jIKZI68hqE7gM8DXQBg/XKHNcI
Cb0BFC+up8UgVEE5NhdZKZiHU18ibcTs7B0VilMIrB6E6ca7qZyX0LS6rWAV7QyT
Wfi8eeNpzKnY6ol08simZf+6aSyVLu7cO9MK5PlbpMQMtUUofe8pz55GaBK9Odme
rDiX1BP4ycHowZZ3/W1ItQK2iT1urA==
=zdi6
-----END PGP SIGNATURE-----

--j9wh8nmrelTh7uLo--



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 373DF7CB34A
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 21:21:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsT8e-0006BG-Lm; Mon, 16 Oct 2023 15:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qsT8Y-00064v-VM
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 15:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qsT8X-0005TV-Ec
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 15:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697484020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mNxoHIEbh7QiDPugAhSSBQuNL877gWnzDB5xpvXAI9E=;
 b=dK5/wDAoLMM9RA4UW2vmfpCCkQo2cuYzgEJNHV9xfVKT1PgNRgNTj9D8RwMaWwfABVvqd+
 WQWNWC6QRcbNXKutagz4Oe9zfEKYNhEXU9YFxN8KJawS8/vrNAqX+ZsV1dgwwqnxGhyFo7
 5X6TBU31jo6WcRq8zPkl1TEaIZchB80=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-RorWwk77PqGaSnmu3X_5SA-1; Mon, 16 Oct 2023 15:20:17 -0400
X-MC-Unique: RorWwk77PqGaSnmu3X_5SA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD8681029F43;
 Mon, 16 Oct 2023 19:20:16 +0000 (UTC)
Received: from localhost (unknown [10.39.195.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77DD4C15BB8;
 Mon, 16 Oct 2023 19:20:16 +0000 (UTC)
Date: Mon, 16 Oct 2023 15:20:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PULL 00/26] Block layer patches
Message-ID: <20231016192015.GA161231@fedora>
References: <20231012162224.240535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Bm6SNscwVJcVAcJj"
Content-Disposition: inline
In-Reply-To: <20231012162224.240535-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--Bm6SNscwVJcVAcJj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--Bm6SNscwVJcVAcJj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUtjO8ACgkQnKSrs4Gr
c8jgkQf/alzysV84E8WZgXNnF/HkAvyHtCtLQgz/H7sgrY3z9OQYwEWIDd/n0aKe
8MMlvysecUfUaCdPwrKzIYOAk+xVHf6bPEYbbhumboujpy6o2fwtrLeVIbYPVr5Z
OBzoSK/aDl3JKvcVlINDVQcPFKOKQjk0A4FkvHuNpbbCPTNmDChNT+iYYrhoCdpn
8g5bgfiRj3Z0kt+IFVr0n4ibS0BmimuvEhdeD5hDN0DMJrRZZMk93TAG9MSajvYa
peIcZBazFUSoIJWB0LWqcHJ/QFw/7NRS4XiJcB/442eo27W+zgjgmiX7+/qQSyG3
Di0KQw3kJGiL3BogDS5T/DXp66Rqlg==
=ulIo
-----END PGP SIGNATURE-----

--Bm6SNscwVJcVAcJj--



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFADBB07630
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Jul 2025 14:51:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc1WO-0001Kt-V4; Wed, 16 Jul 2025 08:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uc1RG-0006G5-Jn
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uc1R8-00009G-94
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752669636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KDwqM8lNUKyGu32ZJxHcnGWz3PruMHg/KjDSaFQ7hfU=;
 b=R/WhCUVRYgsnAKbhARA9DzI8fNMPXzXBafnuqtbAEivZ7fYvpZcXFDd3LczYu3W3Z+n1CU
 qglQhcZk3OfBHyxz+y+qRZQsqRjPZMxpsVrr0CVRUJoeiFdV2qBWN+fobl9tGeCsoNOxQj
 1jAoy4icLNt6WTDRF8ZAuwuTEo+Afic=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-cge1GSjUOhqMZhYf5ptcyw-1; Wed,
 16 Jul 2025 08:40:34 -0400
X-MC-Unique: cge1GSjUOhqMZhYf5ptcyw-1
X-Mimecast-MFC-AGG-ID: cge1GSjUOhqMZhYf5ptcyw_1752669634
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8A41195608C
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 12:40:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.35])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D22A30001A2; Wed, 16 Jul 2025 12:40:32 +0000 (UTC)
Date: Wed, 16 Jul 2025 08:40:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL v2 00/13] Ui patches
Message-ID: <20250716124031.GA328177@fedora>
References: <20250715063301.145191-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z1FA1lzYaWqWX9pf"
Content-Disposition: inline
In-Reply-To: <20250715063301.145191-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--Z1FA1lzYaWqWX9pf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--Z1FA1lzYaWqWX9pf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh3nb8ACgkQnKSrs4Gr
c8h28gf/co8zu9IUOof65IYVxbTw5Yp9Toeg+eOTHqU1FrKQ8EMBqx3MK0jrFtYg
h0u/i+kWlA1qecp11nbOY4zOUcshDe/b0DP3V/s3ogGL6uBSEdE5BL/f8XhC5SsR
hcEl3nZNqzcpwo9mR3UzBcnSTdCQeRnTlyN1i6p2TyQAEZogBMS1a+HIRbkv/Tjv
GEZQoSq4mAVjHHOglmAb4ZFNofBJ0tsIk8kQkhkhRIHSuslyih6IVp4LYy5MR3vd
2BlRQNzU+LHytSWdz31sx24L7GTx1524NUGysLsNXB0T5dl+ygS226z08UlS46tM
YMEDmkHwxpC9sInw+LoaSkU8+DH5lg==
=JhGd
-----END PGP SIGNATURE-----

--Z1FA1lzYaWqWX9pf--



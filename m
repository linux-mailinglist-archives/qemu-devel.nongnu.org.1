Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D33B78F104
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 18:16:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbkKX-0003sV-Jw; Thu, 31 Aug 2023 12:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbkK2-0003pF-Iz
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:15:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbkK0-0002Pb-0j
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693498502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZtTij15NZHDno/aWE4MBCidya7ycH8kLao4Fm4JJhkU=;
 b=b7WevdKzTKSigV+hOeGEoMfHmBNLJnt6GrtmIsDXFp9ZBrdRRjZsXRMj3YoGl2GS2kSZC1
 2DEeoEmaOlAO0OjUmwoXMC0kq4pU+FhEsUZbNgHwFcC6ZaijlClPEsJljKlNIVXVkKfNZ/
 nugmrqMwJE+a+wEzP4yyRLGZnH146c8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-ZGh9OBvNM86JWk3hfsU0_Q-1; Thu, 31 Aug 2023 12:14:59 -0400
X-MC-Unique: ZGh9OBvNM86JWk3hfsU0_Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B72293803908;
 Thu, 31 Aug 2023 16:14:58 +0000 (UTC)
Received: from localhost (unknown [10.39.192.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4ED86413709;
 Thu, 31 Aug 2023 16:14:58 +0000 (UTC)
Date: Thu, 31 Aug 2023 12:14:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: peter.maydell@linaro.org, sstabellini@kernel.org,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, vikram.garhwal@amd.com
Subject: Re: [PULL v2 0/2] xen-virtio-2-tag
Message-ID: <20230831161457.GA541246@fedora>
References: <alpine.DEB.2.22.394.2308301824340.6458@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4GsRsZ32fHGNv7q1"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2308301824340.6458@ubuntu-linux-20-04-desktop>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--4GsRsZ32fHGNv7q1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--4GsRsZ32fHGNv7q1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTwvIEACgkQnKSrs4Gr
c8is1Af/dbHuVgmaNxD6pufpvyWnZ39Efto9IDDjI+dJsynPTfyqWT2lhIC/VpsV
JMXNjZX2IKLwh6Aj++VZymO9OlSZ3MKipKoI7EbCSshaDmdsplE8zt2KXXH8hxlA
3k7Uyf4bovO+kpJMBXY9608wbxr2PLwYG3ECxnG7SX3Of8cBWG+qtWGlxjUX3hmO
07SDFxVO+tWpvM+spnfc2v1OrIUaliHJBVIf1tHcgwCOK0aNEq4NrX1bNiqoiKDD
929atI/7ozujwdPKei3IaEWuPYqf2Jewte9GZlhoY7W81j45yXvZ9X8qBWQ3NHYL
5C5yV1qkNxylAwtbkLmLyP2wjiJM0w==
=Kdub
-----END PGP SIGNATURE-----

--4GsRsZ32fHGNv7q1--



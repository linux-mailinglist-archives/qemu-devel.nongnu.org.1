Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFF37A6B3F
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 21:14:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qigAM-0002Pb-JZ; Tue, 19 Sep 2023 15:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qigAF-0002JN-Da
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 15:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qigAE-0007M7-2B
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 15:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695150817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fWulAHWOBLRhq2ViZgmjssADNaqeK2xF4AZzkuUa8mI=;
 b=TlzH5e6V1w9a8Pf/zJ3/43OGTfEfVU7s9h/jolAgeegCziQ/tIvT2I5rzn+FH3vmR4sTJ7
 2gRjX68LPZ4Q0ieOGVHRfuBwASROojCYhdx4nmW8DZ4AtVtbDU8iJY5VPxTqQ0+J3Rz4cq
 vk40BDg0MFPAmUrTYu0hViTDq8ubl50=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-rKo2UMMqOW-HK7otuvF-sw-1; Tue, 19 Sep 2023 15:13:35 -0400
X-MC-Unique: rKo2UMMqOW-HK7otuvF-sw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C1621C06347
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 19:13:35 +0000 (UTC)
Received: from localhost (unknown [10.39.192.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3D17492B16;
 Tue, 19 Sep 2023 19:13:34 +0000 (UTC)
Date: Tue, 19 Sep 2023 15:13:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Subject: Re: [GIT PULL 00/12] Host Memory Backends and Memory devices queue
 2023-09-19
Message-ID: <20230919191333.GA1843393@fedora>
References: <20230919103029.235736-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="K449nZ0atFr+k4UI"
Content-Disposition: inline
In-Reply-To: <20230919103029.235736-1-david@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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


--K449nZ0atFr+k4UI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--K449nZ0atFr+k4UI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUJ8t0ACgkQnKSrs4Gr
c8hz5Qf/RvBfvAmTda3x/l9d/zqGBMs8WAjlIeSMHj4ccCwVgWy30Co5ipBCcRYd
yqAJY1E1VCOix4ZJ2kv8ttFIe+0OtrrHJbPNRFE7zrR339NNpoGFtMjbMuoG4sTY
KAemoWF8LBcOTTCwiZpMLn5hNCczTkYFha0F/HHH9JsXWlq8IsrJdr44kblHpdzU
zoojPXOtBD87ZFMCT/sqtWb648D8Ygfr/fsmOQeCy06ZWmnM0oO7HlLChb122tM8
CqZmaOMXr8X3jcGcgB9qGYa8+70ARF8pzGqk2wY9OsRdKCpBPueHMSQHhwYrYLXA
D4c9+ebj4yJJAU+hWih25KbQJKVNHg==
=Rul5
-----END PGP SIGNATURE-----

--K449nZ0atFr+k4UI--



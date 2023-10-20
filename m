Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFB27D13AE
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 18:08:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qts1w-0006pn-27; Fri, 20 Oct 2023 12:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qts1t-0006nw-Ro
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qts1s-0001a1-Ex
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697818035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M5jUhmxfA6feUUiyMRgQyezTB1l5fcY0jBRGDTSTlag=;
 b=gGHCRIY7xt6C3645z2bS5U3iWKUcI8vWz6S2TFbujlq8w/yFF1vApskKd7rLc5Of9keC95
 sykvgz+0pgg7PKgOLbpOQSeYPtVVRILznJlt8VB0PEsTSIA90Q0D9Uq04D/oRz2gFAIfM/
 CXHePKqeNTWfuQ/i3Lri3WYYzA0FPek=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-Bme8E-ZqOv-UcdXxmG34Ag-1; Fri, 20 Oct 2023 12:07:13 -0400
X-MC-Unique: Bme8E-ZqOv-UcdXxmG34Ag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD23C87AA02;
 Fri, 20 Oct 2023 16:07:12 +0000 (UTC)
Received: from localhost (unknown [10.39.192.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17A4B503C;
 Fri, 20 Oct 2023 16:07:11 +0000 (UTC)
Date: Fri, 20 Oct 2023 09:07:10 -0700
From: Stefan Hajnoczi <stefanha@redhat.com>
To: deller@kernel.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PULL 00/11] C3700 patches
Message-ID: <20231020160710.GA472129@fedora>
References: <20231019225257.383071-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="T1/fPxNXIMFlA+Yu"
Content-Disposition: inline
In-Reply-To: <20231019225257.383071-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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


--T1/fPxNXIMFlA+Yu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--T1/fPxNXIMFlA+Yu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUypa4ACgkQnKSrs4Gr
c8jj3Af+KQLO826sECvOhi1RApHwctoWTv4lEko1tjkeJW+ATTWRw+Qibs6Nc1hO
iBShmpLitDHUrUbCteXWGOdctuCOgvpW8/xun5n0O43OPR52yB5qfubAQxsmnhzA
hsv/EAowFxtO9GOTPBPcaLOKSV+Zp/TSZdZ7Xv8IBE4UWQTloOWtRvE0+mQiZLpp
iXO6VSKqLMvOXgtcDFEoibFwpSrCDKhBY6AOxg6VxFGA9tr12DCAd0ttl7sQ+jMk
FPScGOtBLWAy8pfwu4vIuFK6WTnEAJSgsoWC+zuuqI+fe2yagziLIEQp8ga5jT5A
koFYuVpuw+7IlQ/v7Mb4V9Dgy0NjMg==
=Dw7J
-----END PGP SIGNATURE-----

--T1/fPxNXIMFlA+Yu--



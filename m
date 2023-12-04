Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD6A803763
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 15:47:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAACu-0004ld-21; Mon, 04 Dec 2023 09:46:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAACr-0004l9-6o
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:45:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAACp-0003vG-Pn
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701701154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/DXL/p/4OkrzyOLSuzaTGpmKmLJHDZ3U23vrAbbX4b0=;
 b=TyS6ZQB9GOyN0HU+BZG2iPBaGSyoMjWxSMG8gUBoWFdngn6vhkF9BuqASF7WPIz88ujmjg
 mIO4CoWbRnKEr2xnUapT+rjs9AIuNuXlJ67zPnrt1wSQsXnyLW1PPb0lXF3zEoZtO0PKoF
 EW2jrswtYhleCGbFF4PDpMTqiiNHe48=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-xrPzogxROmS58xdhYZAZEA-1; Mon, 04 Dec 2023 09:45:52 -0500
X-MC-Unique: xrPzogxROmS58xdhYZAZEA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90B07185A78A;
 Mon,  4 Dec 2023 14:45:52 +0000 (UTC)
Received: from localhost (unknown [10.39.192.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B5B22026D4C;
 Mon,  4 Dec 2023 14:45:51 +0000 (UTC)
Date: Mon, 4 Dec 2023 09:45:50 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/15] virtio,pc,pci: fixes
Message-ID: <20231204144550.GA1491640@fedora>
References: <cover.1701450838.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZhUMwszIWEdyhuFD"
Content-Disposition: inline
In-Reply-To: <cover.1701450838.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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


--ZhUMwszIWEdyhuFD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--ZhUMwszIWEdyhuFD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVt5h4ACgkQnKSrs4Gr
c8go0wf+MlShNFExONZBfSphWXiIFI3BHbEMC3tprJh9AIh8f/kGpprid5m/NAaq
Q3QZhVJvo647MLSCu318JKtk6lWH0GgBdS+3c9O9Zs+Cx9Nxz4ax5ZAm8Ht10TvK
s+6nYE35xyw8vGJmZBIYy7lepn6bVRMK/2hNybWP4/+8ksaBShpKI2GkqGcBnQGv
uORPAlA9EzIeTJTdUcItb9GFlCH/o04JUyqUpiPdeA25Cun7W89MCvBKNXyCaa9K
v3dz+o2sHGpFQTsZjkJzjFj5MBA31I3BjUGB2yX/+/QXXiadCPJju45V4scN/RHw
dpghqwpXbfnMmAHMzRqxTxdqCGRljw==
=KGSX
-----END PGP SIGNATURE-----

--ZhUMwszIWEdyhuFD--



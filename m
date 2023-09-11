Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0349079A98B
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:20:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfihi-0001vP-E1; Mon, 11 Sep 2023 11:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qfihg-0001sL-Ko
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:19:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qfihe-0007Hv-B4
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694445593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7hcuxHlYcLPJIeat6lrS7c26bNrvAwYUHWzqv2c2eJI=;
 b=XVwUJrf7TSS0TcdF2yj7S85VRR2aNKIzzf0BnvgeIetEjTFSA3D+ferc89kA6PG3V6H6zf
 0Q4aNJbO/qiAQ7IMvtBIp5U2jnFvyMDSBs+FI10TETgSkrtaoxhpIG7oAnVu2C4yA86Oa1
 KbS4DxzY473oZVtjX0911TFtzEgAWTM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-t5gwskP5P4i2-eltWRRQwQ-1; Mon, 11 Sep 2023 11:19:51 -0400
X-MC-Unique: t5gwskP5P4i2-eltWRRQwQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C2053815F72
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 15:19:51 +0000 (UTC)
Received: from localhost (unknown [10.39.195.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25551215670B;
 Mon, 11 Sep 2023 15:19:50 +0000 (UTC)
Date: Mon, 11 Sep 2023 11:19:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/13] vfio queue
Message-ID: <20230911151949.GA4101538@fedora>
References: <20230911075008.462712-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="i/zxVtV6FlBmMtW8"
Content-Disposition: inline
In-Reply-To: <20230911075008.462712-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--i/zxVtV6FlBmMtW8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--i/zxVtV6FlBmMtW8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT/MBUACgkQnKSrs4Gr
c8ipPgf9Hfm3PTW0QNZJVMFuO01IJTZ21WAT+aAj7npU3iGil9Hl20IO7v+268t5
UygfAxrWl9NNY5YcHssmy+qwaps1dV2BUptq8VlyYXOyQR60h0UsKA6C0T8CGjaf
qbanMTPtcwppg3sO3uS/pbJSIWvsVbAPwb+3CtmA1uVD/v5oFODOaAu08Mibdpvu
Cr27OuzIBCptbM3bi/ELR/94bPD/5lB7hn2nHSn5jIAVYIUdZQ7eEsNe8IyDVTF4
oe9+TVrB/0f/DnDWSqxaTnYuMZmtUKvygQksAhkxMwTf2feyW2h7pchU9GN6c26Z
noigGHwQZKakc4Q2toBtAIx1WKinpQ==
=U5hv
-----END PGP SIGNATURE-----

--i/zxVtV6FlBmMtW8--



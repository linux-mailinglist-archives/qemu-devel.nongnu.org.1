Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D46AC26B3
	for <lists+qemu-devel@lfdr.de>; Fri, 23 May 2025 17:46:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIUaV-0006U6-Nv; Fri, 23 May 2025 11:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uIUaQ-0006SY-6t
 for qemu-devel@nongnu.org; Fri, 23 May 2025 11:45:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uIUaO-0000r5-Cc
 for qemu-devel@nongnu.org; Fri, 23 May 2025 11:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748015127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q/56R77gfOvpg/GaFRp+S98sqx/xuTgbxb/zD/VQ7J4=;
 b=J1y+Er6gkQEzOkYB8EpzoMV7h8+90j6MkDVm2McUJR9dSYrp1jVzMzWmUcmW1btuZBEG9p
 bpCk8zVbIN4l+GfJPJQRltI7SNxnNmaP0yqO+hEufL+xlgp2f4U6sz0gEjjrT0kQUAy1Ln
 OKUn9atjVaKCqAEIxev+HDKOo2ycRaw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-tZfemcMFPXSLif6IjJ5WSw-1; Fri,
 23 May 2025 11:45:23 -0400
X-MC-Unique: tZfemcMFPXSLif6IjJ5WSw-1
X-Mimecast-MFC-AGG-ID: tZfemcMFPXSLif6IjJ5WSw_1748015122
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5275F1800361; Fri, 23 May 2025 15:45:22 +0000 (UTC)
Received: from localhost (unknown [10.2.16.119])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A590730001A1; Fri, 23 May 2025 15:45:21 +0000 (UTC)
Date: Fri, 23 May 2025 11:45:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PULL 0/5] Block layer patches
Message-ID: <20250523154520.GA23031@fedora>
References: <20250522183115.246746-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0ymyhVehze+O2DLR"
Content-Disposition: inline
In-Reply-To: <20250522183115.246746-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--0ymyhVehze+O2DLR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--0ymyhVehze+O2DLR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgwmBAACgkQnKSrs4Gr
c8jmagf9HoqWeanMxWEJnyYROY7lg9aDhlPmTMDQGbzafk+rUicpRSh+OKaNcsfW
XvMZpd+/4vBP3BqeZjcXsLzMK6YklwuotK6quGVHiFluHi5rhV9Oqxwumeh/83Pz
JcmOIWk+PrCDwGUcQ7Jq5GNPHVEv+jlpb5Qx/H5qadSzZryG3B/xrKWQYPwVnqJD
sROTHjPhZ8v5INwv9E1E3GDlg0BbZ0/qiQblsAHpZEzSQsVBmRyNwmUQEyfuoYrN
jXrjPbeWzUwjmQ8PApn28JPW1Cl/FK+3zJcMSUY8bWqZmeN97Wdc6eurr7UdSx5H
S4Es4vO615M+cZxa8yezJbF7t/iUyA==
=7jvf
-----END PGP SIGNATURE-----

--0ymyhVehze+O2DLR--



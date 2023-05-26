Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA2971222B
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:28:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2SnD-0004R9-3b; Fri, 26 May 2023 04:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2SnA-0004QX-Bf
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2Sn8-0000Oe-UU
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685089637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pXBFooYwxDxEQfNe8R0h4FyXwkykt1j0a7D+jBdCofU=;
 b=MNfsAEZT7BbJKvKmwuDtD5YOqZ6p1J5dDMtmZHvnESY5tPdPqjJHciUBj5vsobwx0Wfj+L
 JDd4qtItcRvxxfPZ7xuwf3jHn/HiJWgJrrm8IZap01LiQHf/7NeQmCHAz3Zrt4pq2U8IWt
 3W/PzQjdbJvdNnq2JjMwaoTa8o0I3Lo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-VqUsxsWmP06_kOnON5t3Vg-1; Fri, 26 May 2023 04:27:15 -0400
X-MC-Unique: VqUsxsWmP06_kOnON5t3Vg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 788D11C05EB2;
 Fri, 26 May 2023 08:27:15 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E894400E13A;
 Fri, 26 May 2023 08:27:14 +0000 (UTC)
Date: Fri, 26 May 2023 10:27:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 03/12] block: Take main AioContext lock when calling
 bdrv_open()
Message-ID: <ZHBtYd4Hfl308hpJ@redhat.com>
References: <20230525124713.401149-1-kwolf@redhat.com>
 <20230525124713.401149-4-kwolf@redhat.com>
 <20230525182032.GE132697@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="I/wmsoRCGB/wJ9NH"
Content-Disposition: inline
In-Reply-To: <20230525182032.GE132697@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--I/wmsoRCGB/wJ9NH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 25.05.2023 um 20:20 hat Stefan Hajnoczi geschrieben:
> On Thu, May 25, 2023 at 02:47:04PM +0200, Kevin Wolf wrote:
> > The function documentation already says that all callers must hold the
> > main AioContext lock, but not all of them do. This can cause assertion
> > failures when functions called by bdrv_open() try to drop the lock. Fix
> > a few more callers to take the lock before calling bdrv_open().
>=20
> Did you audit the code to check that there are no cases where
> aio_context_acquire() is now called twice, leading to aio_poll() hangs?

Yes, I did go through (hopefully) all callers, so I should have caught
all of them.

I'm pretty sure that at this point in the series there are some callers
that call it while locking the wrong AioContext, but by the end of the
series they should have disappeared. This is where I couldn't find any
patch order that keeps things fully working in all intermediate steps,
but having a single giant patch felt even worse.

The good thing is that locking the main context multiple times is
harmless because we're running in the main thread, so nested event loops
can make progress even if it's still locked. (This patch, and some
others in the series, rely on this.)

Kevin

--I/wmsoRCGB/wJ9NH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmRwbWEACgkQfwmycsiP
L9bELRAApWebV7ZvuhYnma/txtnaPYDiC3qeZMP86JXvymKpOxU/RPBgIXVmHcD+
QG8portciRoglD+k0KHGmkBXhVKW44kIiOqoficMdpt+GYZFg1gKihT+8UNw/tld
iJzf6tBCL6NigDzm82CHDKakTbzynwTxZHUdfoXS0sgqgZ3VB/cdHErVEmhiGKNI
kh5ZHMUXEzkoMmtUGddwGels6DzymvO8+Zr+NkbmeA21aa8Ix4EAxanlM3DWzYhk
xiq+e5NU+E0OxbPeT/AsIXr1d5zkUEIXs3YUCRYDvaz8N8+E2KEtRMS+xo+aTfyg
L5v9xaPy4GevvE1P1Ga9BXGBjUohjzLyiVTwvfMGpg452grhhq48cZ+xpXa0UpS4
uFv8xbbnFYrwavo2slDe8711OgSRKeSvB+pEDj2cW2w4AJKrtxove+y1Lgcz0XvT
zlPzwfBsbUsBk6t1d2sIlJDK3OZeTSex6n5f+DAzUpCqs/557WVxri+X/ZCDFzV3
o7CdLVT8eP5B36xVoZku/y0o3hDdCOfCeMZ56uv1TcQIoKgPlh1rbDOeB7pq3I2G
Wy6fZ7L40e4nXqi/LZsXYU3sdvtAzKCkvWSFzkiixcJVbO4zKJw1NfqjiCyQoKIc
gB4HJtBxC08fQOrUH0gbvDJcnCZr96lt/vK8W19imyY0vGe0r74=
=hKmH
-----END PGP SIGNATURE-----

--I/wmsoRCGB/wJ9NH--



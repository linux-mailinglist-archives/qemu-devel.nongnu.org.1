Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DBBA73508
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Mar 2025 15:54:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txod0-0006Sl-GE; Thu, 27 Mar 2025 10:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txocl-0006Ok-88
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txoci-0000Kw-58
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743087263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8YROHxUhss530lk40/uQJh0ibroK9/GWh/HWuMHxR78=;
 b=RNKD8GblLMlDtoQhMioWnsawng7rG9ODNLIkLCtB+WHLpvuotT1fLx+lx31jcJvDPIlcJU
 7c4y70udUL0p9pZm/F92LCQG2vpm/mvgWa5lBIbba46TcalmErzCUQE0lHFyx31Eeyfqap
 rogh/LlijhqIUQOsXu40836o299bqgM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-o2CU2HcqPom16z_YOI0IVA-1; Thu,
 27 Mar 2025 10:54:20 -0400
X-MC-Unique: o2CU2HcqPom16z_YOI0IVA-1
X-Mimecast-MFC-AGG-ID: o2CU2HcqPom16z_YOI0IVA_1743087258
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF4941828BB2; Thu, 27 Mar 2025 14:54:09 +0000 (UTC)
Received: from localhost (unknown [10.2.16.93])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 51C341800944; Thu, 27 Mar 2025 14:54:09 +0000 (UTC)
Date: Thu, 27 Mar 2025 10:54:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 04/15] fuse: Explicitly set inode ID to 1
Message-ID: <20250327145408.GD37458@fedora>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-3-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MNu4IfoYVsdqrEoA"
Content-Disposition: inline
In-Reply-To: <20250325160655.119407-3-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--MNu4IfoYVsdqrEoA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 05:06:44PM +0100, Hanna Czenczek wrote:
> Setting .st_ino to the FUSE inode ID is kind of arbitrary.  While in
> practice it is going to be fixed (to FUSE_ROOT_ID, which is 1) because
> we only have the root inode, that is not obvious in fuse_getattr().
>=20
> Just explicitly set it to 1 (i.e. no functional change).
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--MNu4IfoYVsdqrEoA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmflZpAACgkQnKSrs4Gr
c8jSuwgAnm2UapDE+BmqeuMJJ2wTHAC8kC3vBATn0G1bz6+d5S+uTjebr2daHp19
iZPTfIxdd97XYl89xKTHtV+6wZh8O0x6zpog0xpNBS5s0g2HIJFDKbdCaulhbstJ
rYJqmqsS6pQraHz+X9PRhZngJyYQZWkAPCa/vI4a5aP/wzG8xSKswSx64FusRN+e
aybCur65+Cs6Kp4a3YXtsZu1bFDUdUaoJxxxSaeGGLk5wJQZP1chQGBeAa1mt/pF
uQpjtJAkvr6yXoIQcu9WPjt2MOq/FSF5vStF5KdEZXK3CyU24tWKDqafc0C8TanP
AJ/ugiAM71USiwQMMoeB/1yDgyyOKw==
=OLQI
-----END PGP SIGNATURE-----

--MNu4IfoYVsdqrEoA--



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F1EAB24FB
	for <lists+qemu-devel@lfdr.de>; Sat, 10 May 2025 20:38:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDp52-00036C-Vw; Sat, 10 May 2025 14:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uDp4l-0002uj-OR
 for qemu-devel@nongnu.org; Sat, 10 May 2025 14:37:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uDp4j-0007dz-ON
 for qemu-devel@nongnu.org; Sat, 10 May 2025 14:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746902249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ccFQEtnTbbhoawL8wBSIFMLaXJPj2gRj7L3IJV7tiYw=;
 b=cuFesgXGvVY0zOTYmzkh05mbs62ZlVckv0ckDZ4o841wjpGlcoIX1cDfqtZ0p+3dW1GhQZ
 fmBfcgqlMHa5BCkEcuzAZg+QeLVVPJDGuACg9Cvb6nu2EvHDVMglfIllKNclYTA52cRxGJ
 lamSW9PKc68xtwFzeIIXlqF5wR1ejYI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-mZDrUWiSPJKciG-Uy7jy8Q-1; Sat,
 10 May 2025 14:37:27 -0400
X-MC-Unique: mZDrUWiSPJKciG-Uy7jy8Q-1
X-Mimecast-MFC-AGG-ID: mZDrUWiSPJKciG-Uy7jy8Q_1746902246
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 611AD19560AF; Sat, 10 May 2025 18:37:26 +0000 (UTC)
Received: from localhost (unknown [10.2.16.39])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B95BA180049D; Sat, 10 May 2025 18:37:25 +0000 (UTC)
Date: Sat, 10 May 2025 14:35:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 00/19] Misc HW patches for 2025-05-08
Message-ID: <20250510183552.GA116934@fedora>
References: <20250508122522.73786-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="czSoGKEsuIqjv5Y0"
Content-Disposition: inline
In-Reply-To: <20250508122522.73786-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--czSoGKEsuIqjv5Y0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--czSoGKEsuIqjv5Y0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgfnIgACgkQnKSrs4Gr
c8g/Cgf/fkIYaMlLCowLOTMHV8Yul0dEbSbrLKZT3LwCpamXnEMJy1ZA5oE2HtP8
lCkcIMHFp441yQEqla2ubvAx/4hih622GlXN6d5Fzdrr/c0bgCkax6cVfzYiSDXa
NjZEhIWUTs2KLFZ7SlV/4fbWdyTqom0cTr9C9/B5j7xiR8lx7sYbfkug2X5Z/jJ2
GqYd0CCFKoYDHm0XDjM+455G58Xil5THCn4gN1FRIcehCQro1bBa7Xee1vPjPtqW
ztyruAKlw/2hy/Cx8bJSBaQtHO94ftTqXq7PxTs2cEUD6C3Fifo9WXDtpyWTmhaQ
LVQhl33JcziV/Aj2JmscYPH+8uLyVQ==
=E2X2
-----END PGP SIGNATURE-----

--czSoGKEsuIqjv5Y0--



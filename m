Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 824C991997C
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jun 2024 22:54:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMZdt-00042i-HX; Wed, 26 Jun 2024 16:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sMZdq-00041r-Uf
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 16:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sMZdo-00066e-3O
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 16:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719435198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d6SO/uToUOZkYi6H3vJE+RwjJb3OHqcwkanwQiXCKGQ=;
 b=Xiwe6FYZILISgAVtmzbwFmxomHM/yBptIEq1gxfAHuRQLeMx22lA9YKA2L1ZEPfz2Ovkur
 veCIKrlL+bUG0xax+GlaO+rsH19OUEreGDs+QeMyVCmFLrVMC/dLjryD0VfKW1ObsmCxKs
 pOfD/IS+JYqgJMHKXO/4npHfAgPoHLk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-pLYldK_cMVO9FgCk9RkACg-1; Wed,
 26 Jun 2024 16:53:13 -0400
X-MC-Unique: pLYldK_cMVO9FgCk9RkACg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50E21195608F; Wed, 26 Jun 2024 20:53:11 +0000 (UTC)
Received: from localhost (unknown [10.39.192.29])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4977519560B2; Wed, 26 Jun 2024 20:53:08 +0000 (UTC)
Date: Wed, 26 Jun 2024 16:53:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v6 03/10] scsi/constant: add persistent reservation
 in/out protocol constants
Message-ID: <20240626205307.GC2529519@fedora.redhat.com>
References: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
 <20240613071327.2498953-4-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qkYnx11X4C0Ab7HG"
Content-Disposition: inline
In-Reply-To: <20240613071327.2498953-4-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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


--qkYnx11X4C0Ab7HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 03:13:20PM +0800, Changqi Lu wrote:
> Add constants for the persistent reservation in/out protocol
> in the scsi/constant module. The constants include the persistent
> reservation command, type, and scope values defined in sections
> 6.13 and 6.14 of the SCSI Primary Commands-4 (SPC-4) specification.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  include/scsi/constants.h | 52 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)

These new constants are not copied from Linux include/scsi/scsi_proto.h
like the rest of the file, but it's okay because constants.h is not
kept in sync with the Linux headers.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--qkYnx11X4C0Ab7HG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZ8f7MACgkQnKSrs4Gr
c8gERwf/ShPDoilMyPFjBKseK7mJPtgKH93UWNmIZJ9VMpEdp+tyetRjbedAXBJM
Be0S9pbeuFEgCa11H8Iei3dyxdkupi2CinweVgd0JK+n+c51fC0zDjY53A/UJUAd
DSe8redknEabQHZP4g1AtM8cXABGNAX1fzR6YcA0gRubjr/RUQyeTKWb6zCzD2Jj
aeK30fmLU//g4qTShLpMVvlcZBHSi8WsdUQpVe+BdYB41hTGMpx/wVk/QcJMB6f6
5yrS1LKBpAZ1YXHkzm4VDiXainscR2/XnSTIV2bKyKZpA+8aCa3as+CI4eJ3yWcS
GXz9VKcepFS62mBrVhOrRnRUVl6Esw==
=ebS8
-----END PGP SIGNATURE-----

--qkYnx11X4C0Ab7HG--



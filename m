Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F05437B0D99
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 22:51:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlbU8-0003gl-Ak; Wed, 27 Sep 2023 16:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlbU0-0003ft-UV
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 16:50:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlbTy-0006lm-JU
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 16:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695847804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AB5xPLtIiZBNsk3NA2U3Rw/gwoLE2QVHx938v/DzJ88=;
 b=gge2bsxMkRxOTJj7wEQp30nTBno+xOoUBvKHDn+zm1NG3rgGzAHvjmZC6Y5vWly9EN7W24
 SSAZkEs3YegjBQNuaNuJe8T3MNCTlXIt1Ain03SoSqFkdz9ax0cfNVS+S0b8g3pEgE+SiD
 I7m0oPTX/sadDBwyXHI2A3lDRBvDm3E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-rutZHJ8PMm-9JnrH152Kdw-1; Wed, 27 Sep 2023 16:49:36 -0400
X-MC-Unique: rutZHJ8PMm-9JnrH152Kdw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 813F83800C56;
 Wed, 27 Sep 2023 20:48:52 +0000 (UTC)
Received: from localhost (unknown [10.39.193.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE5C740C2064;
 Wed, 27 Sep 2023 20:48:51 +0000 (UTC)
Date: Wed, 27 Sep 2023 16:48:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, dmitry.fomichev@wdc.com,
 Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, dlemoal@kernel.org,
 Hanna Reitz <hreitz@redhat.com>, hare@suse.de,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v4 1/4] docs/qcow2: add the zoned format feature
Message-ID: <20230927204850.GC529043@fedora>
References: <20230918095313.5492-1-faithilikerun@gmail.com>
 <20230918095313.5492-2-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lI0uk4XABGnvMEjM"
Content-Disposition: inline
In-Reply-To: <20230918095313.5492-2-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--lI0uk4XABGnvMEjM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 05:53:10PM +0800, Sam Li wrote:
> Add the specs for the zoned format feature of the qcow2 driver.
> The qcow2 file can be taken as zoned device and passed through by
> virtio-blk device or NVMe ZNS device to the guest given zoned
> information.
>=20
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  docs/system/qemu-block-drivers.rst.inc | 33 ++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--lI0uk4XABGnvMEjM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUUlTIACgkQnKSrs4Gr
c8hLuggAyUEi5hp0Ev+hxgtBPGgjwti3tAjnqw64zGPwdkOtXSUsZ+NSC9dZNV3o
ur8Bl0ANHy/edNiKlgRvls4knK+StAUQq1TmMrrS2T47s5LCIXxMaWUgR79Fpa6g
qUqZ+mbQiSr8ttxTNSe4sv7lYlTk0m95OuYz1jeL7KQS9FRNDskVg5FLO1oMFXdI
2749LHHQnSPvhHV448WSyVWAsNpVq8FqrH83PH8ssRnETo8J7HAVXroU1SwGumpO
ER23Fh3PrZrsL5xWVOhhbiq/RSnkHuLZp2oOmAlGGfWHwoQ3Xyp37d0dEm2cmOs0
BJTCUVKcypPKWRioNwco5YKSHrM0VA==
=pBol
-----END PGP SIGNATURE-----

--lI0uk4XABGnvMEjM--



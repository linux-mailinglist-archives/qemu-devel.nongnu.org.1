Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AA57655FE
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 16:30:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP1KG-0007gW-5R; Thu, 27 Jul 2023 09:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP1KB-0007fP-Ni
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 09:46:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP1KA-0002fl-Br
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 09:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690465597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XP82NJ0PAn1yarrEv0Ujbxk3AAxIUTsONunvdgYuTEg=;
 b=YbAtlmKZZFxHzy4lMQEHw1eEMTzQk0mBcRHtuXacZXgPUNkwKQhO0bgQRVZVOtN6GeXFVR
 WCEqctUkYCgYtfXboQVW0vXv86ya+AzMRWSnBxJJ470am6rNsjHjZWWCvcvtV3lBvo3NNs
 eL3NlkWMxvy9C1mnZo7uwCsDGG0cxM0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-2DiN40u_PpyNnLp9k6sUsA-1; Thu, 27 Jul 2023 09:46:33 -0400
X-MC-Unique: 2DiN40u_PpyNnLp9k6sUsA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D65F01C29AEF;
 Thu, 27 Jul 2023 13:46:32 +0000 (UTC)
Received: from localhost (unknown [10.39.193.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04BA6140E949;
 Thu, 27 Jul 2023 13:46:31 +0000 (UTC)
Date: Thu, 27 Jul 2023 09:46:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, qemu-devel@nongnu.org, hare@suse.de,
 mjrosato@linux.ibm.com, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com,
 Kevin Wolf <kwolf@redhat.com>, dlemoal@kernel.org
Subject: Re: [PATCH v2] block/file-posix: fix g_file_get_contents return path
Message-ID: <20230727134630.GB868174@fedora>
References: <20230727115844.8480-1-faithilikerun@gmail.com>
 <ZMJf5JwIAeR0G52G@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="j3cTX/J+5HKXgACC"
Content-Disposition: inline
In-Reply-To: <ZMJf5JwIAeR0G52G@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--j3cTX/J+5HKXgACC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 01:15:32PM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Jul 27, 2023 at 07:58:44PM +0800, Sam Li wrote:
> > The g_file_get_contents() function returns a g_boolean. If it fails, the
> > returned value will be 0 instead of -1. Solve the issue by skipping
> > assigning ret value.
> >=20
> > This issue was found by Matthew Rosato using virtio-blk-{pci,ccw} backed
> > by an NVMe partition e.g. /dev/nvme0n1p1 on s390x.
> >=20
> > Signed-off-by: Sam Li <faithilikerun@gmail.com>
> > Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  block/file-posix.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
>=20
> We should put this in 8.1 rc2 IMHO

Agreed, I will send a block pull request for 8.1.

Stefan

--j3cTX/J+5HKXgACC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTCdTYACgkQnKSrs4Gr
c8jViQf/ea725+jZw3GIKLjB42r9fRwzI7Y0zA1lszmvUA9VoL1/6ZFPl5Alxj6l
zrA2vCqcRk//+QysCKfL4DHulEYdxp5xVCyyWzknfkF46oeOY7meFPZQaYn7agRG
2DjRZVH76UeuZ7kqBXpEMTOqhXOXd/BVO+JeA4Q7n5mbqenegqINPn270RAHshaW
dV339wtHQhdnbLJ3x2GkD0PwyUEP8O2cDJoA41jUwk79zToXBQ8omRHMrl4/mLII
osc2MMtBQ0mE0WGtNl5/ZIAY87ie34iNfB8tmGYYz5RuIOkqLOr1zAN48h1Mz8ns
1wzk4LrkTLk9S75sizF2OcClMGF/BQ==
=aGWO
-----END PGP SIGNATURE-----

--j3cTX/J+5HKXgACC--



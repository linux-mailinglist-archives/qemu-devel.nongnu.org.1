Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 402B47A0F0C
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:34:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgt1O-0005RR-L9; Thu, 14 Sep 2023 16:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgt1M-0005Qk-5V
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:33:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgt1K-0003a0-P6
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694723581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QbcHbohncSUgHsfr8JHw3fe0I9frPbrX/z7vDcww3y4=;
 b=MMN2svQXTLFe4xm1EQY7Q4rKx5iEaoZvUUvB/quJkNM0e1iy+ggWP97vGM9mZVdxVNuiuv
 sT9R56QCxalNIifVDUtS1aUfIC2wazZXIvFdkVXwQgkK4uwZB4bgQueIQe+E+Xr85t1HtQ
 zrG3RVIgquMiZjtYPr1NfAZ8H3zNHDk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-puQc1DvmMSaXMvKv_eG7JA-1; Thu, 14 Sep 2023 16:32:55 -0400
X-MC-Unique: puQc1DvmMSaXMvKv_eG7JA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07302857A9C;
 Thu, 14 Sep 2023 20:32:55 +0000 (UTC)
Received: from localhost (unknown [10.39.194.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7402940C2070;
 Thu, 14 Sep 2023 20:32:54 +0000 (UTC)
Date: Thu, 14 Sep 2023 16:32:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: qemu-devel@nongnu.org, john.levon@nutanix.com,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 5/5] vfio-user: Fix config space access byte order
Message-ID: <20230914203252.GA1098343@fedora>
References: <20230907130410.498935-1-mnissler@rivosinc.com>
 <20230907130410.498935-6-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1SskSS2+6QHN77oN"
Content-Disposition: inline
In-Reply-To: <20230907130410.498935-6-mnissler@rivosinc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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


--1SskSS2+6QHN77oN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2023 at 06:04:10AM -0700, Mattias Nissler wrote:
> PCI config space is little-endian, so on a big-endian host we need to
> perform byte swaps for values as they are passed to and received from
> the generic PCI config space access machinery.
>=20
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> ---
>  hw/remote/vfio-user-obj.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

After some discussion about PCI Configuration Space endianness on IRC
with aw, mcayland, and f4bug I am now happy with this patch:

1. Configuration space can only be accessed in 1-, 2-, or 4-byte
   accesses.
2. If it's a 2- or 4-byte access then your patch adds the missing
   little-endian conversion.
3. If it's a 1-byte access then there is (effectively) no byteswap in
   the code path and the pci_dev->config[] array is already
   little-endian.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--1SskSS2+6QHN77oN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUDbfQACgkQnKSrs4Gr
c8jlrwf9E+Pz4mEmDNHccAjkq5Dxocs/4ErHaKJrZHLA+VGhqdzoK49fPV8CKheZ
XvAP15UolRWt0zw3fAbFBzxbKddVW0t20mszmjqqo9KD7viKBEN6r8+HFGpuBcIB
Dfr5XiTyK0ALC1Bsq1BW/fxP+SJvxkRE3HXqJiiERb29MKDFT0Ctj2jm+1eVukOG
Wuor343YDSQ5QD8crp0IFepTVTIvumGkezKTIOovCFkp4mT5BydLEjFQ2dAEF4bl
KsteT3W6XxnSq1pdgErY7CnviI5++ts+1rCd2g0QjdC08bbaA/RVPvXalZx/X2uT
BeZ/T+9dZvrGQbaiJ+ogCszHCcJRUw==
=bfXD
-----END PGP SIGNATURE-----

--1SskSS2+6QHN77oN--



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E88487A0E69
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 21:36:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgs6t-00073r-5z; Thu, 14 Sep 2023 15:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgs6r-00073V-7Y
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 15:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgs6p-0001OV-IP
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 15:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694720077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dyQgtSS2sDlsPzeXyPR/i4txkO22/a60POyvmeZdcs8=;
 b=CTetHf27oxIEp7nTsA2BT2iY3IICREGAvAMyv22xBWRQXvFO0kTA3e4VS0Ar46yU5PEs84
 O9O6dYn3XqbmyIiw13dkeoz0noH3QtQX5+jpy9124G2AUGZkGahk+3i797dTuXFaBY+xAj
 Q9ZtEpO8HjfJwBWt/iC3R2GzKnrVmx4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-tTnpCYSYN3miy1tNbokf7Q-1; Thu, 14 Sep 2023 15:34:32 -0400
X-MC-Unique: tTnpCYSYN3miy1tNbokf7Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C06C101B456;
 Thu, 14 Sep 2023 19:34:32 +0000 (UTC)
Received: from localhost (unknown [10.39.194.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9A191054FC0;
 Thu, 14 Sep 2023 19:34:31 +0000 (UTC)
Date: Thu, 14 Sep 2023 15:34:30 -0400
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
Message-ID: <20230914193430.GD1066211@fedora>
References: <20230907130410.498935-1-mnissler@rivosinc.com>
 <20230907130410.498935-6-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MXBt3DPGoq7m1tgY"
Content-Disposition: inline
In-Reply-To: <20230907130410.498935-6-mnissler@rivosinc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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


--MXBt3DPGoq7m1tgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2023 at 06:04:10AM -0700, Mattias Nissler wrote:
> PCI config space is little-endian, so on a big-endian host we need to
> perform byte swaps for values as they are passed to and received from
> the generic PCI config space access machinery.

Byteswapping only works when registers are accessed with their natural
size, even with this patch.

If there is something like a PCI Capability structure, then it needs to
be read one register at a time to get back valid data. It cannot simply
be copied in a single multi-DWORD access.

I'm not sure if this fix is sufficient. Maybe pci_host_*() needs to be
extended to support little-endian accesses instead?

>=20
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> ---
>  hw/remote/vfio-user-obj.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index cee5e615a9..d38b4700f3 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -281,7 +281,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_c=
tx, char * const buf,
>      while (bytes > 0) {
>          len =3D (bytes > pci_access_width) ? pci_access_width : bytes;
>          if (is_write) {
> -            memcpy(&val, ptr, len);
> +            val =3D ldn_le_p(ptr, len);
>              pci_host_config_write_common(o->pci_dev, offset,
>                                           pci_config_size(o->pci_dev),
>                                           val, len);
> @@ -289,7 +289,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_c=
tx, char * const buf,
>          } else {
>              val =3D pci_host_config_read_common(o->pci_dev, offset,
>                                                pci_config_size(o->pci_dev=
), len);
> -            memcpy(ptr, &val, len);
> +            stn_le_p(ptr, len, val);
>              trace_vfu_cfg_read(offset, val);
>          }
>          offset +=3D len;
> --=20
> 2.34.1
>=20

--MXBt3DPGoq7m1tgY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUDYEYACgkQnKSrs4Gr
c8jNEggAgjVfyDQ5d5bmRSdvdX5oUNXPFyDpLesIy2n5lb9N6TbyJ5so+OTYYWqO
1DQCsgzLQbrSUIQgqFuUs5v12wRuvRWgHqGbuWCg2dSLtmv7sQsehPsg6GgxRJNP
la2O78M18dA38Paps0FwwihQgQ1DDmgozM/3VBOhOcOQOUEZ3PZFUPyf2VL6L8DZ
203+Y5oRQKYTPCqexiW05nIQuTUMMoL8gOpSDRZdviYyEMeSW+hRk/BrumAO0M8d
2br0FSS20dK7ysFTY73jiYscCrv2FG0/UG1i6OYK8eFFQfrh7PFl1kECJTDxMQdG
ejaAdcDdwmENjX8FC4om5NKS1SU75A==
=pTCm
-----END PGP SIGNATURE-----

--MXBt3DPGoq7m1tgY--



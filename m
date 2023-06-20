Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1090E737457
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 20:34:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBg9w-0004ZL-K3; Tue, 20 Jun 2023 14:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qBg9g-0004Y5-RS
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 14:32:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qBg9f-0000nx-F8
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 14:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687285958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x11f5g11vdxrx0fJe129Gy7Hy7yhV926S3geMwzS4Vo=;
 b=fLLznuHaC+6z4K2m8pbPQsogXyTZw4/Gd4Ub5pcpXMKGvHu9cCRHlnR98vdliztzLNYMCD
 eQzPRlBepZxPASOBHcSJY5MMU73HSsUzTgJPBY/91ok56CJNZzZk23UzRcJrL3DnTAFJfW
 +j+tSol4mT+5Xrr8RXD0Xk4cwFucyn0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-TD-aCi_1PXOqe0ivHOYN2w-1; Tue, 20 Jun 2023 14:32:33 -0400
X-MC-Unique: TD-aCi_1PXOqe0ivHOYN2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2FE81C08965;
 Tue, 20 Jun 2023 18:32:29 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A2529E9C;
 Tue, 20 Jun 2023 18:32:28 +0000 (UTC)
Date: Tue, 20 Jun 2023 20:32:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 05/12] hw/virtio: Add support for apple virtio-blk
Message-ID: <ZJHwu+YWmNKCtpfa@redhat.com>
References: <20230614224038.86148-1-graf>
 <20230614225626.97734-1-graf@amazon.com>
 <20230620143537.GD2625194@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TzgUut/zgvatE2El"
Content-Disposition: inline
In-Reply-To: <20230620143537.GD2625194@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--TzgUut/zgvatE2El
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 20.06.2023 um 16:35 hat Stefan Hajnoczi geschrieben:
> On Wed, Jun 14, 2023 at 10:56:22PM +0000, Alexander Graf wrote:
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index 39e7f23fab..76b85bb3cb 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -1120,6 +1120,20 @@ static int virtio_blk_handle_request(VirtIOBlock=
Req *req, MultiReqBuffer *mrb)
> > =20
> >          break;
> >      }
> > +    case VIRTIO_BLK_T_APPLE1:
> > +    {
> > +        if (s->conf.x_apple_type) {
> > +            /* Only valid on Apple Virtio */
> > +            char buf[iov_size(in_iov, in_num)];
>=20
> I'm concerned that a variable-sized stack buffer could be abused by a
> malicious guest. Even if it's harmless in the Apple use case, someone
> else might copy this approach and use it where it creates a security
> problem. Please either implement iov_memset() or allocate the temporary
> buffer using bdrv_blockalign() (and free it with qemu_vfree()).
>=20
> > +            memset(buf, 0, sizeof(buf));
> > +            iov_from_buf(in_iov, in_num, 0, buf, sizeof(buf));
> > +            virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);

Good point, even more so when iov_memset() should do the job with
simpler code.

Kevin

--TzgUut/zgvatE2El
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmSR8LoACgkQfwmycsiP
L9aIng//QRDMiPXkpxaA5mcUxnG1DuPIXXjBXRbxu2EU2R67sjNsUX9BYbK13152
t/y7e7zAg+nzfrUc/PG3fd/FS1MkMOeoJOLM3sVVKf3NXEPomNFOnCy/hcdjQ1so
B/l08Ma98moNs00G/JXyXO39YtxbmMMmaqR/aWYVht0VJ2CR6X5894/J20vyUyAZ
TTFJi8IHV3hIknW6E7eCzQ0m3RFf8HNzzOtvIxxuzxkZh5h+W6HxAeysnKhcy8xj
QzG5gPYAjU+1kd1+vDfLmPLbqUdh2WG3+9pEFw5PElHLh+4UkAkCFOS7uiKRBf/g
2U9Xbc+VV5sMVcOt0wBFtIRYQSjHQJJemNQdRg5GL30OTeb4LHjYi02lyoJZu4Wa
bY/2YlHEy1gL9AAa9Uw3xM06e/bnE22BnaBawHxtLqTTf5S3ZeTcTR1BKYnrrYO/
RXLeDWTM+bb2XtLN7mMhcDXlxDtvMc9InMmWOsOnIB+M7qe8MRbhNrECiZ9Fp5br
LjRScZn7qfuYN2f26Fm7SO4W0xkN7uRdV90qfUXuEpDAamH+AkS5ejVUAUhwc634
R4hSTAPN630CbT1RU69VWJH2VbN84c427AGGKA3pO1zg9VNfFyxpJYVjOldsMZeE
oc99QXRmcij1GWmfwn5m0OdhqgzIteAwrnVN1s+U5IRC+ZhYEB8=
=ZyLf
-----END PGP SIGNATURE-----

--TzgUut/zgvatE2El--



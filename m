Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE73F812091
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 22:19:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDWdt-0000NL-Tr; Wed, 13 Dec 2023 16:19:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDWdi-0000MV-Am
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 16:19:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDWdg-00075a-Qh
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 16:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702502371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l0i/cnUa92G7edkpsOhfGpbmCDze0Op1afLYP08/qcM=;
 b=B5mEqLflyzKu/BTpgmL4tYf7fObYXz0Cz45K7QQhTc/zW1ChmF+9pOUDuM+hTYEise+kCh
 ZdrzR0mMIcag/YjJbtVmTIFyK+NtB3s0Tik/BP2Iiglu1ZL+5VR83P3AUcCR8DK5CKAhIJ
 uARTM9cC6UidKBjyWn0+dSwyNBhmN3c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-Zw2sKnTyN96Sek_VdIXT-A-1; Wed,
 13 Dec 2023 16:19:28 -0500
X-MC-Unique: Zw2sKnTyN96Sek_VdIXT-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E7771C0512B;
 Wed, 13 Dec 2023 21:19:27 +0000 (UTC)
Received: from localhost (unknown [10.39.195.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 068351121306;
 Wed, 13 Dec 2023 21:19:26 +0000 (UTC)
Date: Wed, 13 Dec 2023 16:19:25 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Thomas Lamprecht <t.lamprecht@proxmox.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PULL 29/32] virtio-blk: implement BlockDevOps->drained_begin()
Message-ID: <20231213211925.GA1597699@fedora>
References: <20230530163239.576632-1-kwolf@redhat.com>
 <20230530163239.576632-30-kwolf@redhat.com>
 <ee6374dc-c644-449f-b5d1-788695e1a83e@proxmox.com>
 <c3e115ff-c143-4d1b-901c-6b386d012eac@proxmox.com>
 <ZXLUuoOawqQpyodD@redhat.com>
 <a736f5be-b1f9-4ee6-b9f1-a8271566a9e4@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VwJX82GWxvCYx28r"
Content-Disposition: inline
In-Reply-To: <a736f5be-b1f9-4ee6-b9f1-a8271566a9e4@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--VwJX82GWxvCYx28r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 11:48:05AM +0100, Fiona Ebner wrote:
> Am 08.12.23 um 09:32 schrieb Kevin Wolf:
> >=20
> > I'm not involved in it myself, but the kind of theme reminds me of this
> > downstream bug that Hanna analysed recently:
> >=20
> > https://issues.redhat.com/browse/RHEL-3934
> >=20
> > Does it look like the same root cause to you?
> >=20
>=20
> Thank you for the reference! Yes, that does sound like the same root
> cause. And the workaround I ended up with is also very similar, but it
> was missing kicking the virt queue.

Hi Fiona,
I sent an RFC series that calls io_poll_end() from the AioContext's home
thread:
https://lore.kernel.org/qemu-devel/20231213211544.1601971-1-stefanha@redhat=
=2Ecom/T/#t

If you get a chance to test if it fixes the bug that would be great. It
is based on my AioContext lock removal patch series:
https://lore.kernel.org/qemu-devel/20231205182011.1976568-1-stefanha@redhat=
=2Ecom/

Thanks,
Stefan

--VwJX82GWxvCYx28r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmV6H90ACgkQnKSrs4Gr
c8hwsgf/UvGXrQ3505Tv6MjOHvd5f5wDkJPd8s2j58SfeneCbV7zpzGDZ/HoqBzM
YNe7zWgqwiamCEqVSOIWhNKjGStVaZZwAPcAFhiX7cVY0uEX/Vo/YYZg4/xH99PV
ow3mJ6SIQDEVdJ9q8S5IcL2HuUFTfeMXdcvnvdiWAotbuB6ewsOJPqv68dpWWWzc
aDzpkBUy1wYtNtIJP0pvidGCa9Xzmzb55B+douU0qX1JSzwDqZEtU7hh1KPQqGRx
+jB+tHGq7/UePaqN/odapILy770sQ1ygmDv1pzprqD9FE/McE2edobe80fzXWbXC
SgtqJJBPeEbhepW5YtPBU1DowknGzQ==
=U4K+
-----END PGP SIGNATURE-----

--VwJX82GWxvCYx28r--



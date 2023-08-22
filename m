Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AAF784A62
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:26:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYX0l-0006eQ-6P; Tue, 22 Aug 2023 15:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYX0f-0006c2-Ug
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYX0d-0002ht-OG
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692732347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lc6AI7UfNBzaCjSJnQNnKtafUOpom1hWPVUetM3ONdM=;
 b=ft72bU1s2bbOmS28FGK/+6XU+P7xVzDKK9BkpoQwrZ2Jmm2yOLMSOznM5qA25O/xUb3zMs
 XeP4fz7vXQceLP+2syE6bbtnruSaRphIj5+TXK+wJC9HDMtQDWUL9Hs8DUgmoFF9FpoJYt
 EG1AZuhdkPfPvg3XrHmQtcO9zRZOPLM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-Ww-bm2_eOyWCWPuLPbjS1A-1; Tue, 22 Aug 2023 15:25:41 -0400
X-MC-Unique: Ww-bm2_eOyWCWPuLPbjS1A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D20C85C6F4;
 Tue, 22 Aug 2023 19:25:41 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 795F16B2AD;
 Tue, 22 Aug 2023 19:25:40 +0000 (UTC)
Date: Tue, 22 Aug 2023 15:25:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Thiner Logoer <logoerthiner1@163.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 1/9] nvdimm: Reject writing label data to ROM instead
 of crashing QEMU
Message-ID: <20230822192539.GQ727224@fedora>
References: <20230822114504.239505-1-david@redhat.com>
 <20230822114504.239505-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="M8WIBXyRbKTDxuLq"
Content-Disposition: inline
In-Reply-To: <20230822114504.239505-2-david@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--M8WIBXyRbKTDxuLq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 01:44:49PM +0200, David Hildenbrand wrote:
> Currently, when using a true R/O NVDIMM (ROM memory backend) with a label
> area, the VM can easily crash QEMU by trying to write to the label area,
> because the ROM memory is mmap'ed without PROT_WRITE.
>=20
>     [root@vm-0 ~]# ndctl disable-region region0
>     disabled 1 region
>     [root@vm-0 ~]# ndctl zero-labels nmem0
>     -> QEMU segfaults
>=20
> Let's remember whether we have a ROM memory backend and properly
> reject the write request:
>=20
>     [root@vm-0 ~]# ndctl disable-region region0
>     disabled 1 region
>     [root@vm-0 ~]# ndctl zero-labels nmem0
>     zeroed 0 nmem
>=20
> In comparison, on a system with a R/W NVDIMM:
>=20
>     [root@vm-0 ~]# ndctl disable-region region0
>     disabled 1 region
>     [root@vm-0 ~]# ndctl zero-labels nmem0
>     zeroed 1 nmem
>=20
> For ACPI, just return "unsupported", like if no label exists. For spapr,
> return "H_P2", similar to when no label area exists.
>=20
> Could we rely on the "unarmed" property? Maybe, but it looks cleaner to
> only disallow what certainly cannot work.
>=20
> After all "unarmed=3Don" primarily means: cannot accept persistent writes=
=2E In
> theory, there might be setups where devices with "unarmed=3Don" set could
> be used to host non-persistent data (temporary files, system RAM, ...); f=
or
> example, in Linux, admins can overwrite the "readonly" setting and still
> write to the device -- which will work as long as we're not using ROM.
> Allowing writing label data in such configurations can make sense.
>=20
> Fixes: dbd730e85987 ("nvdimm: check -object memory-backend-file, readonly=
=3Don option")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/acpi/nvdimm.c        | 11 ++++++++---
>  hw/mem/nvdimm.c         | 10 +++++++---
>  hw/ppc/spapr_nvdimm.c   |  3 ++-
>  include/hw/mem/nvdimm.h |  6 ++++++
>  4 files changed, 23 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--M8WIBXyRbKTDxuLq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTlC7IACgkQnKSrs4Gr
c8gjvAf/TNdp42RIHSwGsRfntN+3wJs2Q8zCTqwpakKZeWDlJKBrUE9r+yVKiguF
aSAlgp0aKNdAchjkEkGsHG08xrqynGQV97xdIXjbWtFQutph4Co6HhV0E14pi6JS
N/7TZnYjwGyVr39Ob7kr9XZKYaFK/08c8DocDo3g0FfZFlsIiTpyNA1cOYNVUwfB
w6JO7DgOtSKHmLgxLRisdi/xsQmZk00DuiPQ6YsvDe4aS0e5ER3E/nwwWUq77+Y9
3dUUNVxKdCaoz7tdTaeIE3N6FI8l9Qw9NhmMvNnB2bJHEkvcKYIwMBI8fahrAd9i
IHDC70wZF5yOWxjMk1xV8sHrGoTKnQ==
=EAIM
-----END PGP SIGNATURE-----

--M8WIBXyRbKTDxuLq--



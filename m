Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 648527E4036
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:41:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0MK4-0005ZV-Qq; Tue, 07 Nov 2023 08:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0MK2-0005YZ-U9
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:40:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0MK0-0005Y0-Vj
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699364448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NHuO1OojHY7F9rWwEFTdZTm7zhHRCPLRzfq8vCij62c=;
 b=ioWZukLsTXjaQSOi+Pw08zZybXD3IMgIdw88LWyqWih3lGA4bvR3NiXKte1fagOEmkKpdB
 aRu+0w7Yp+05fL8ctrTlXbWgDlCNiZJ74KzQcxCkCiDIjdvQzNe263xScTQekcbtYUGQYL
 yytpxwJc0wflOA7rlBlKrdQ82WwPugE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-OXJe754lPCaTuJ2nvsmUSQ-1; Tue, 07 Nov 2023 08:40:45 -0500
X-MC-Unique: OXJe754lPCaTuJ2nvsmUSQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 381BD8556E9;
 Tue,  7 Nov 2023 13:40:44 +0000 (UTC)
Received: from localhost (unknown [10.39.194.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46AA72026D66;
 Tue,  7 Nov 2023 13:40:42 +0000 (UTC)
Date: Tue, 7 Nov 2023 21:40:40 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Subject: Re: [PULL 00/15] xenfv.for-upstream queue
Message-ID: <20231107134040.GA1010741@fedora>
References: <20231107092149.404842-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GSuJ/hBc0Lx51aih"
Content-Disposition: inline
In-Reply-To: <20231107092149.404842-1-dwmw2@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--GSuJ/hBc0Lx51aih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--GSuJ/hBc0Lx51aih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVKPlgACgkQnKSrs4Gr
c8go6QgAldelY+trwwwNMAllr73WkdwjqbENy+zeBaBa2FAdn9YSw3bke+1Xwo/M
i5mzyJahOWqCBm6B8JS3r7ERxhaln3x4jVxxkSBCcLKLh31WAaaPFRLb0WVr6Wqe
hWQ7dTmOu7V/J2xmpi+FTB4AP4ng5259uWKqsZgsfJvPU+tOsKxscm7ERerOO21A
IoH+7v+IK8uhN94hWcOXcsJlRY8HxMmigsDRTGjex/NuWuQkOW+iMJqhgyANnr+e
h1FMvC18NFzynfvr3Gd750fTps7SLhf0eDQUNpIZvPX6P1Trz9KD9DTQcJ9QZpra
V3L/gTy+FrrDaEEFB8KGtSwyYqSicg==
=TuL5
-----END PGP SIGNATURE-----

--GSuJ/hBc0Lx51aih--



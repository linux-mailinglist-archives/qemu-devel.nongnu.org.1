Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C207E34C1
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 06:01:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0EC0-00025P-CS; Tue, 07 Nov 2023 00:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0EBx-00025E-Ct
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 23:59:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0EBv-0004Hj-QC
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 23:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699333194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ktD//8OHK7gieiSem3d7wEZJxcM/hxK5fNmN/eD4FBM=;
 b=KHHBGDTgacfKh1WWBUE+o5SDWB4XBEQ7zYyoT+3Jzy7G/lPBrDObnlk8pxD0e679+lYnFt
 8lNxFcNSbCPPWZqXmEt/ZJ5Nsn+6kMGoy9rJLRgP6spLzZxkkJ6+9t3ZbgWaskBfmn7VlL
 ah5AOmtbMtId3VPEFui/qtNVa2A5qoA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-vWIUvUg6NbqFB2obQqbTCg-1; Mon, 06 Nov 2023 23:59:50 -0500
X-MC-Unique: vWIUvUg6NbqFB2obQqbTCg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EA28811E7D;
 Tue,  7 Nov 2023 04:59:34 +0000 (UTC)
Received: from localhost (unknown [10.39.192.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56F05492BE0;
 Tue,  7 Nov 2023 04:59:32 +0000 (UTC)
Date: Tue, 7 Nov 2023 12:59:30 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PULL 00/49] riscv-to-apply queue
Message-ID: <20231107045930.GA963879@fedora>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ShITSTa+w7tf5XFu"
Content-Disposition: inline
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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


--ShITSTa+w7tf5XFu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--ShITSTa+w7tf5XFu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVJxDIACgkQnKSrs4Gr
c8ibuQf9GkYlbyXVmgOVw44G41BHSMVgK6jMtvF5CKrAAcO2l8QuMBMHWL8W17E1
d4ksxVIAqimnaUVIGQZzGH0x72b15smmu6kQEaMQIl7VqPmuAdmHdnXbqp+pOSN9
P9cwDZTpTMIfRc3DBAxhJijnVeqnkwdbA8nwQ9cCDKNyrhazJDtuOR6e9GXtnQJP
WfDZDX1DZ4PAbrFuPW/wGtrkuYKrYgAjLc0cYf2Kjh6RiPE+hfozDd2VIqFVn7wi
4xMlCYDSaGHPjYDtQa/lPGaFnyjIxOPJ3eQQgPLpwZ3eRmeC8gxxDG2I68UeTD2t
8m5nfJLr8iwJWyXvIBRUGitEGfzEAw==
=kux0
-----END PGP SIGNATURE-----

--ShITSTa+w7tf5XFu--



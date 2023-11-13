Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2C37EA3C0
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 20:29:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2cbz-0006Xb-Q5; Mon, 13 Nov 2023 14:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r2cbu-0006WZ-Hc
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:28:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r2cbr-0004GK-4S
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699903714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VNRbbohd3iCo4reptqG+ytme9L/4nNGVYkkWWDJJfUs=;
 b=hvOV/7hHoqE/C8E//33wBlnPieDJktwlF7XIeZDiB/Z//QGT6OlVH2CW4VGc/EJgC0+TNj
 HvMBfl2QYuhMcPShHvmkSk4oWmrXFs0CTNaxu3xEZjYSR71s9gUDetk+Mz8G1j6yluz1fZ
 sdrpAmL3Ckeh40smXSytGUyREDd629g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-53bNpbOaNAquApJ5L-YpBw-1; Mon, 13 Nov 2023 14:28:32 -0500
X-MC-Unique: 53bNpbOaNAquApJ5L-YpBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1848E811E7D
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 19:28:32 +0000 (UTC)
Received: from localhost (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 813041C060B9;
 Mon, 13 Nov 2023 19:28:31 +0000 (UTC)
Date: Mon, 13 Nov 2023 14:27:17 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 0/2] -Wshadow=local patches for 2023-11-13
Message-ID: <20231113192717.GA241545@fedora>
References: <20231113093621.750115-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="URKiF3RFyxCjZcTD"
Content-Disposition: inline
In-Reply-To: <20231113093621.750115-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--URKiF3RFyxCjZcTD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--URKiF3RFyxCjZcTD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVSeJUACgkQnKSrs4Gr
c8iXoQgAi7xiHb/pxhqo3kA3Dbky5fKjn36RnWc9FVgqrhmMY7XSEE/uUH1EMT6j
WIfUZQFFW546x88ARJzxWHnyT7b2mKEHtIjTG5/m/ey6uPxsWUjHme/Dj6ZAljix
2X0lhHE3y3fZIOMwAHREePHeIHz2KYaOVVN16DNJ5OeDFSr+TWty1nCK+0KT4929
Wb/2UtRrP8XdyU0Y9ttfvqkw54SN4qwMFqoYS1c50/aTSTzeF7h3TH5kq2poMLW4
7gsonc+q9f7SvXFgprLgCsFcGrwW7haqnjrhgSu8hWDKaEP4YjLWenpAv//qe/8i
cTOAuNArI2jlK8+8CS1DpwsAFG1ifA==
=cXiE
-----END PGP SIGNATURE-----

--URKiF3RFyxCjZcTD--



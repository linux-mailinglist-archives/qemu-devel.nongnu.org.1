Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A267D4501
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 03:30:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv6EP-000314-BB; Mon, 23 Oct 2023 21:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qv6EL-0002za-AH
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 21:29:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qv6EH-0006oN-HB
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 21:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698110947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cOTj3wk2I5RFcIqVSxmwNWJdZoCHUUzCjFoATmqQvzY=;
 b=NycOC4ZP3F+Or5fx041UUFUJNB6zFoNB4tnGZxOTYZdaI5a1Ix4toTZ2gWqlEnQz6QHCKq
 jh+U2wGp8Co5EY9XOYIoidcRz1nrA0KE3n3fQPm1f6OugWTf9FvZd8HPhM0Xk3rPjV0yNq
 38htVy5NUoWGYPy/olT+vsG8Y3PEUbA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-tp63UQrzP1OjImfCpKI30g-1; Mon, 23 Oct 2023 21:29:00 -0400
X-MC-Unique: tp63UQrzP1OjImfCpKI30g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F66580F8F5;
 Tue, 24 Oct 2023 01:29:00 +0000 (UTC)
Received: from localhost (unknown [10.39.192.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D232B2166B26;
 Tue, 24 Oct 2023 01:28:58 +0000 (UTC)
Date: Tue, 24 Oct 2023 09:15:23 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-trivial@nongnu.org
Subject: Re: [PULL 00/17] Trivial patches for 2023-10-21
Message-ID: <20231024011523.GA499224@fedora>
References: <20231021120519.220720-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fv0Vd539fxm1yCtZ"
Content-Disposition: inline
In-Reply-To: <20231021120519.220720-1-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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


--fv0Vd539fxm1yCtZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--fv0Vd539fxm1yCtZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmU3GqsACgkQnKSrs4Gr
c8gkYwgArJjK1T5JpRIAlMU7o2XDoETO8zfH2TLJF3IkupwR3MNWnFxoRyi58lT3
zRceV9ENBezlfsHwIHx3gd7985k8qYU5e+AAywinBtAonmrgs2uApx8DaQemGX4v
yZ0tYQe3N/THd73PpmMiwkG9yD2ksfcjf/NYGhlbjTax2WTtNhRkS7ckVLv5yIyP
xXh9dUUO5Ca9p4ZEMWhp+Yzg0/OdHSfxj02lMZ0/Kbf987HGNxwRhJ4kBQ8/aUJ6
csu2iHm811OtFYR6Bb73fC1wa1nulISzwemw4kolekddrkPUD+bZXaNEy/aXP34g
UIfLY3ywhEUqlqhhv3bsKC5a6i0xFg==
=NNym
-----END PGP SIGNATURE-----

--fv0Vd539fxm1yCtZ--



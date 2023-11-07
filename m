Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8842D7E402F
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:41:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0MK2-0005XH-2J; Tue, 07 Nov 2023 08:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0MJk-0005PZ-0b
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:40:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0MJi-0005FE-4S
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699364429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ovSg04GsXZzjSiMaPoKdJ3buqsPCX1AawenhgVhHDAw=;
 b=KjXaMxPjj/3Km2Nc4lSHFU2RKoSifA7QogHmAZdqk3znCISW9Ddx5CgKi7PF5ShkNC6CS/
 czPV+mxnbHNahErOzq7kNzV+nrASbJIRHq8/WyaTwor3x/FOvm1/Wc1E0udIONgXlNY+Kp
 +Ve+BqNJVxKYYs6NTYHDYQFoR7PAlmg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-p00doChpOGCLllhvxneW-g-1; Tue, 07 Nov 2023 08:40:20 -0500
X-MC-Unique: p00doChpOGCLllhvxneW-g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 285FA101B067;
 Tue,  7 Nov 2023 13:40:07 +0000 (UTC)
Received: from localhost (unknown [10.39.194.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57C4D492BFC;
 Tue,  7 Nov 2023 13:40:05 +0000 (UTC)
Date: Tue, 7 Nov 2023 21:40:02 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, stefanha@gmail.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL v3 00/25] Pixman patches
Message-ID: <20231107134002.GA1010612@fedora>
References: <20231107101524.2993389-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IWrcT4UdMVYgK6wj"
Content-Disposition: inline
In-Reply-To: <20231107101524.2993389-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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


--IWrcT4UdMVYgK6wj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--IWrcT4UdMVYgK6wj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVKPjIACgkQnKSrs4Gr
c8j9Igf/ZuUtL3dBlErs5kZgnNf6jPlWiT8nC4ag4qBvnGdyaWiKo4sW8KMt+bWt
IkGpdGRN/8TyNpRmO5NaYYjHinFiY1ZwsO7HDSUmM+ayV8ZJ0JBIDjJdcpahwxUN
X0hR6bCQhm7sxZN9QzaBejt1lUXAcdSH+33ZEUbMDsNbLaUMKE7i4TocEXjCu+8U
lX/SZdQMxRvlgjc0IwBVixeJBHcektyhKCZgusF0AO0xtMfVVhmDaZdcxI7GTWXJ
B9EPqWleMrPngTRQibdWikWJ0rjF3vQ6lCiikYOkoo6lUZFjLfX3C6+q3S25/DXk
YJb+JoLMqex83G20Gz9urCUOrzW+vw==
=Q4Wu
-----END PGP SIGNATURE-----

--IWrcT4UdMVYgK6wj--



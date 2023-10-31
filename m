Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE927DD96C
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 01:02:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxyfV-0003Xj-6Q; Tue, 31 Oct 2023 20:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qxyfG-0003X9-Rc
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 20:00:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qxyfF-0007sf-6r
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 20:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698796852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bdDBoNLKkIqHEWvcrAezDPJoftcy7JA2YROWkgSNsfg=;
 b=OS7sNv5goqq0jVx2BXO6Hb5eqWTfOLdqcrm8RWC/d2/NtL6P8XEQt+uByIUQRYGuSWFEkA
 mOazNpO7TyBIvIHncwy7T5Yy9NduGVCTh0dWmOIbJQIMSAO7t6zvlU0XL+tynxqwmkyNFS
 N3WCovLfd9DSzJBgKpvxk4jHN7xCQrw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-gfyiIupxMYGeIDcpxW62RQ-1; Tue,
 31 Oct 2023 20:00:30 -0400
X-MC-Unique: gfyiIupxMYGeIDcpxW62RQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81AAD3857B66;
 Wed,  1 Nov 2023 00:00:30 +0000 (UTC)
Received: from localhost (unknown [10.39.192.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2800C12911;
 Wed,  1 Nov 2023 00:00:29 +0000 (UTC)
Date: Wed, 1 Nov 2023 08:31:44 +0900
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL 00/19] Updates for testing, gitlab, gdbstub, plugins and
 semihosting
Message-ID: <20231031233144.GA673980@fedora>
References: <20231031144401.1238210-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LERahkeRQdQpjEqa"
Content-Disposition: inline
In-Reply-To: <20231031144401.1238210-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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


--LERahkeRQdQpjEqa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--LERahkeRQdQpjEqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVBjl8ACgkQnKSrs4Gr
c8jv/wf7BZHv0FOP8GyXWEiw6yyg20NWO6ygq+RLKs9TTmF9elxItCK3Rh+6K61P
unBogfl+tzNnnCt0zqH/bKzkQb+lfRHxJ7oxMz4uUydsOlnk+LN5mhZgV69RtoLP
uRjvvdHnUH7jADeMUIwl9uIQtxnCLDWhp03PrsYM3/Z22dQWCtfANnLrnJ7NnBus
zBrCBpRZff6B+3Ldr+JA5ScwBnb/cKHJvkS/kRklJMOs/CjwBzNUcOR+3b48Fy32
RWRllARHK+Gj1ijKeZ+o19UvESIS6+wB1eszly/+ZyUHJlMRwC381wWFONGGSp1S
v1jnJm2H1I4KNWNCbE4n2w5yCdBW+A==
=X5LX
-----END PGP SIGNATURE-----

--LERahkeRQdQpjEqa--



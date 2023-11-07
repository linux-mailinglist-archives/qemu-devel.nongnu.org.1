Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FE47E3367
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:02:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CLv-0000Bj-12; Mon, 06 Nov 2023 22:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0CLt-00009C-4B
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:02:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0CLq-0008PY-Kz
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699326121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DSIlKvf5OuuXPVBYiCsA6JLSscJjSI6dcUsxBZ2/Tcs=;
 b=KsaoCR8U0dZPFUYHwwvy4hmSlmKM276abaUUjO+pWO0PK95cbzjOUUzZ+Drzc5ekDC/vxH
 p+4BZQi0XHzrokNucf90vAxdDYN2YIKQCVesK4KJviay8AsPLyELNasyWtFZ9xZyV6n7OO
 LF4wlrFts6UCMhgedNjddvEeJOxGfgE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-ppq2lrHTPLmGqJDArlkKpA-1; Mon, 06 Nov 2023 22:01:50 -0500
X-MC-Unique: ppq2lrHTPLmGqJDArlkKpA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB4EF80F90C;
 Tue,  7 Nov 2023 03:01:49 +0000 (UTC)
Received: from localhost (unknown [10.39.192.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 030D540C6EBA;
 Tue,  7 Nov 2023 03:01:48 +0000 (UTC)
Date: Tue, 7 Nov 2023 11:01:46 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PULL 0/4] Q800 for 8.2 patches
Message-ID: <20231107030146.GA952606@fedora>
References: <20231106081541.53688-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6BhzffBBSC2OPHkj"
Content-Disposition: inline
In-Reply-To: <20231106081541.53688-1-laurent@vivier.eu>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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


--6BhzffBBSC2OPHkj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--6BhzffBBSC2OPHkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVJqJoACgkQnKSrs4Gr
c8jmRgf+KXuUkotnasaQCFI2sfSP24oTGJSfgfsNofU2FtN5AFAEmFNz3uY0sD+6
dV9EYrxvEee8CweNqBMZpqSJ8hwR2LX6kIA9HFzjY4X5yz+ZyvnsbLBwhkZUwQtN
codRgiBea3SimFHzRYHIcnjZTOvzEZ5h+iXwfXub9NzG6YNQPXSOrcw1lg/viSa0
5pxjI9/04pH2JCP/AdZqnbiKI9IRgsYrBBSE+G2FxRCjuQfnaWqmAlNWL8o0Fs9+
wy7Qsn21SD1ObLV2sZA4XaGWATH/EuNTYiD00WtQRr84nRLP+gLrpxCovUCxvyM9
sf/w6ohHdprSz33oRcUqm26k6OVM2A==
=so0U
-----END PGP SIGNATURE-----

--6BhzffBBSC2OPHkj--



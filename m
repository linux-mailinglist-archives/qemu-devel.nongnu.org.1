Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 518A87EA3C1
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 20:29:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2cc0-0006Xt-O5; Mon, 13 Nov 2023 14:28:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r2cby-0006XZ-Vh
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:28:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r2cbx-0004H1-Gp
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699903720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7YnvvVGIe9lsYFodbwCFdPFSn/WGZVUqudUkNdTurLA=;
 b=BmZxpp80603itQ8gQJbRq2q8sw4V+IilJX7tJYL+UldwkbWad3q1oPkijTy3eSuwG1cg9v
 sgoOLIHWP9c1d5PVSEoUoKfWm232+r4b/Puppc3RLvv902rCwMVpAL0DL9eTGRqqQWa+uw
 jmsXwJbjVPUHxN/zwhwED9EijHuV+bQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-9K6DSRzkNkW6vb11BnKOCQ-1; Mon,
 13 Nov 2023 14:28:38 -0500
X-MC-Unique: 9K6DSRzkNkW6vb11BnKOCQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACC291C04327
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 19:28:38 +0000 (UTC)
Received: from localhost (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BC3F2026D66;
 Mon, 13 Nov 2023 19:28:37 +0000 (UTC)
Date: Mon, 13 Nov 2023 14:27:42 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 00/12] Misc patches for 8.2-rc0
Message-ID: <20231113192742.GA241626@fedora>
References: <20231113110740.38270-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="w1tHSLYEHC7szxgX"
Content-Disposition: inline
In-Reply-To: <20231113110740.38270-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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


--w1tHSLYEHC7szxgX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--w1tHSLYEHC7szxgX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVSeK4ACgkQnKSrs4Gr
c8iT6Qf+Pq5RNcx9mdgerPpTsPOo7iFwli16gVkqW+03mSrZhSsrMuygXho0ViNf
Yz37DJpDOTpC00WlSAFPDlHNkzc066VKjRw1X4jNqAP8JqSp0XRl5e4EYlzTRoml
F/NqMm1S064WvOl6o8ZTWLw8XAlm2hdAH/qgoeDpfiKGNlR1lTU2OuFmEAM9CEcP
YFriu6DE5h0S0Lg5bL9EEw+c49xGklSmTHG73Gl24FFSDsjxPI7HfEBc9YtuJBFs
Zu2B+7R2NB2td73NEFCI8CrDtsrMFTQFLWq5Oj/346RM60vEutlhtKxmXR/4jk4P
X5toQ/EYUZ+uQgySUbGPzF/531PwLA==
=APzp
-----END PGP SIGNATURE-----

--w1tHSLYEHC7szxgX--



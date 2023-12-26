Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EB381E893
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 18:00:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIAmD-0000UX-3b; Tue, 26 Dec 2023 11:59:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rIAmB-0000Tr-Kd
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 11:59:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rIAmA-0007V4-6f
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 11:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703609968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dvQ4qX56fyLLe7e1KineMbAG2h5U8oVC6sKQJXhtxeo=;
 b=LHQ3ATRx8/KLu8Y0BZiOyd5XhvPzX9+QslsKoqjatkKARC0MBOrk0cOqHzLPAkvxFdpehu
 HUhs2eRHXEc7Dtv2zAwOfoqoOuWVyicsQiM7cuDXbAp3I6jhGVBE6HvphuDJ06ZlpUdb4k
 bN8N5jmhfyjPbUJLiHK6vQg417olbP8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-p5hdEEZgM-atq_KcVSfq3A-1; Tue, 26 Dec 2023 11:59:24 -0500
X-MC-Unique: p5hdEEZgM-atq_KcVSfq3A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BBBA185A780;
 Tue, 26 Dec 2023 16:59:24 +0000 (UTC)
Received: from localhost (unknown [10.39.192.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25309C15968;
 Tue, 26 Dec 2023 16:59:23 +0000 (UTC)
Date: Tue, 26 Dec 2023 09:14:58 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-trivial@nongnu.org
Subject: Re: [PULL 0/7] Trivial patches for 2023-12-25
Message-ID: <20231226141458.GA103337@fedora>
References: <20231225081007.78141-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zOGVMzVRlCT2WN6n"
Content-Disposition: inline
In-Reply-To: <20231225081007.78141-1-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.851,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--zOGVMzVRlCT2WN6n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0 for any user-visible changes.

--zOGVMzVRlCT2WN6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWK3+IACgkQnKSrs4Gr
c8imGAgArO3CunEULHkNOXuK+9jyoXkJMMfOoM74y+JgoT3yXe0t6TQkOsWx2Tx2
cWbe4wj7E24gLnRthFNqgvOjWqEqidHq3sQ2ouguoEXyoRCxwaY0frB9LL+zdbf+
s/WVQVqQBkWXVbSXx7IgNCWfA2zPtxuE/T+ff2i67ND1cUW3hbsv7uVlnEYLHkcs
+dLwA71VUGi8Ivvnki0vJG/349ONc2ZFmbL5lBUMMp5rRLwCw0EhGRWmVRWrb+Vu
66tPSM+Usn6ySBVxLp/nJvMwk+lH2BbFceXKT9L/QjHpkF7/nFJke95ARNySRVo2
3TqyA/U7JGdyXk8CiIIR574AX3/0jw==
=NTlk
-----END PGP SIGNATURE-----

--zOGVMzVRlCT2WN6n--



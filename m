Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BDC81E899
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 18:03:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIAmD-0000Uu-P3; Tue, 26 Dec 2023 11:59:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rIAmC-0000U7-0K
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 11:59:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rIAmA-0007Va-Dv
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 11:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703609969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lWxgdUY+3RfsrTTAtyB57yi2iH5VsK2iQioWlUglUdY=;
 b=h+2bChZOQnuEIb4b0IWAi/dTTOLu4YKK2VzBGsP4Z8Me94To68tGC7PyC+15emc6v8DuFU
 egRrxrPRjyX6oIYxUCyhgeFEYLGpNOoVRI8UxOu1SQNuTIXV0uAKKDXBhPVx6TNB8nmECC
 khhGw5Np/hUxS4paCVzeloMk7t85fhw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-7mf1tZt8Po688rGtB3ql6A-1; Tue, 26 Dec 2023 11:59:26 -0500
X-MC-Unique: 7mf1tZt8Po688rGtB3ql6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA606803915;
 Tue, 26 Dec 2023 16:59:25 +0000 (UTC)
Received: from localhost (unknown [10.39.192.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9072F2026D66;
 Tue, 26 Dec 2023 16:59:25 +0000 (UTC)
Date: Tue, 26 Dec 2023 09:15:09 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, yong.huang@smartx.com
Subject: Re: [PULL 0/1] Dirty page rate and dirty page limit 20231225 patch
Message-ID: <20231226141509.GA103366@fedora>
References: <cover.1703499705.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="krUdDfw1PFkjZbxF"
Content-Disposition: inline
In-Reply-To: <cover.1703499705.git.yong.huang@smartx.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.851,
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


--krUdDfw1PFkjZbxF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0 for any user-visible changes.

--krUdDfw1PFkjZbxF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWK3+0ACgkQnKSrs4Gr
c8gaCQgAhV4/by68OBSsDahX7X6UsqIO8gYuVKgGKPZGwxfScwmkugN7MpyPaXm1
wDIRpy8S2JJ0efrCqaHaxGSFNJy5OEGkofbB1dpqByDQg36AloUYkpmhOziD1a1Y
Y4s47kK0JchQsVlBXK93vLpFUwofx3ya+CXwgTEWLIZ1cFXBDILLGY6pSqjjAnJP
viPMwf0j2uDRbb+PrgF8bwCzb7w8Jj5K8LGZAbU7M5bfz2z6T31bVB0g5Dau+EW+
pU7R2oIZNC7dA4lL0eXeUjIk55qR0xp5mo05BRCmXM/lIyp90pCY86vTsq2EIkXQ
6UHoqaQ0QuhTpJcDk/raJYiZYemWYg==
=yp4p
-----END PGP SIGNATURE-----

--krUdDfw1PFkjZbxF--



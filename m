Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BEF7974EE
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 17:45:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeHAh-0004PW-Sx; Thu, 07 Sep 2023 11:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeHAe-0004PD-MV
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 11:43:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeHAb-0003P5-Jy
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 11:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694101428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d2e9xipuj0Unr3wVd3v7OQIAUn1oYQn5hpAnqoC96Bw=;
 b=XUa+LSwLQ65MP8wgUAO+gi6troUmkcaX+XjoOokd/0uL3DoI+aFGqebvB2FD0opYnwPQdz
 NqUru28ZOHtkBOSaGdrUl3TKD/gPu6P4TnjMLzBThmfWlDuMyPLq5S9wEJ4mVb0/UP+mWP
 Gb7bp3gtQwS3ZjNKAiWZ3GnLGGDr0TY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-CCMf9bXnNFmvHjowOw8J9Q-1; Thu, 07 Sep 2023 11:43:45 -0400
X-MC-Unique: CCMf9bXnNFmvHjowOw8J9Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02339800888;
 Thu,  7 Sep 2023 15:43:45 +0000 (UTC)
Received: from localhost (unknown [10.39.193.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D9BC1460FE5;
 Thu,  7 Sep 2023 15:43:44 +0000 (UTC)
Date: Thu, 7 Sep 2023 11:43:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@gmail.com,
 "Denis V. Lunev" <den@openvz.org>
Subject: Re: [PULL 00/18] Parallels format driver
Message-ID: <20230907154343.GA1550648@fedora>
References: <20230906154942.656537-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZcWejcq2tfqZNsEP"
Content-Disposition: inline
In-Reply-To: <20230906154942.656537-1-den@openvz.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--ZcWejcq2tfqZNsEP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--ZcWejcq2tfqZNsEP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT5768ACgkQnKSrs4Gr
c8gmXAf+JbCuCMj5Ml3L+fA1T4eT9ljgVq2e+qQQmwFI8640kwq7FemRA9PPMJXe
gqGJKWI/bTmYXFpEIQ8F9/4BWUZWPXUr3muez2k5QSXSKmGAgwE39v+ToPT4DCme
mFHZft0oF3y7D8slN4cj55aGOWdYgMe0P5+h1yecPMLGhkVPR4+wP1eNYIakeP+j
DCwkgr/YsMGUoWxisHm1SAqOCmVQgSMJFfu69yd2FwvuksfZje0+dUQAJMGGHNO2
lRCGEy5dygEChkA7ubz2CV7mR5QeM3KMrIp3+54Ge+oLEB3+qULVwzeGDmfud5NV
dr+eL8XsgYixkMT2XXG7RxbHpfJ+ag==
=kI+Y
-----END PGP SIGNATURE-----

--ZcWejcq2tfqZNsEP--



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC918802630
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 19:18:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9r1x-00084q-Vi; Sun, 03 Dec 2023 13:17:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r9r1w-00084g-6D
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 13:17:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r9r1u-0002jE-IE
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 13:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701627441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zdnSfwK9/yRy1VFpwYxcEye41VToRS3u0C1fSyunqfM=;
 b=i3ddgdDeKN7RcqJD7GY/EnuY9D9WNXQIkgXdQJ1RNb+38dQ2To+VRbcik6FZAhZ5RXQWIn
 kiTrYG+s4uOj8HYcukXtT8OtKBOdaDIf5iUe7qCrPXj0cPBwWfVPtwFcwM885GCMwDRS2I
 zihwCtr1kfz0Dgb8XXo5pKN0TefFyuI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-zmI1emp6OXquSL31FPrscw-1; Sun,
 03 Dec 2023 13:17:17 -0500
X-MC-Unique: zmI1emp6OXquSL31FPrscw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11A043806708;
 Sun,  3 Dec 2023 18:17:17 +0000 (UTC)
Received: from localhost (unknown [10.39.192.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 780001121306;
 Sun,  3 Dec 2023 18:17:16 +0000 (UTC)
Date: Fri, 1 Dec 2023 14:58:03 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 0/2] Migration 20231130 patches
Message-ID: <20231201195803.GA1269750@fedora>
References: <20231130104103.28672-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bt4d3mMFwJ8cfQ6D"
Content-Disposition: inline
In-Reply-To: <20231130104103.28672-1-quintela@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--bt4d3mMFwJ8cfQ6D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--bt4d3mMFwJ8cfQ6D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVqOsoACgkQnKSrs4Gr
c8jGHgf/elRkEr2T+8SgS1ztBgev5bb/1pGKl25gCOg/LYS1INW9eZeNX4RtmMXy
HfsJXTe2ex19lJ2EHBeceuFmxLBNlZ6WBezjBnRPCTQ3pXh0P5E89P95pedGa2F6
DelFIcw5Ud/as1EUhPWX9m7QxchQOR5ba5ui39xN2N7vpvwWP6dYLDO/8+xWemFS
YaYU/VfvAmHR8XfsBCFT7PKOzTd6ajXLIFb/VeFIbgxkeKZ5acfmZQGTIjFDorLG
Ha3s+7YkvIktjLr5iAvC7chl39VzA7xea2TPdg5yFpcDRv748MDokHYrKtHZN4sz
EIIFAEsn8T7M7062ssj8Klm4ZgkmJg==
=Z1iX
-----END PGP SIGNATURE-----

--bt4d3mMFwJ8cfQ6D--



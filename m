Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4D67FCAA0
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 00:15:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r87Gh-0001Cy-SZ; Tue, 28 Nov 2023 18:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r87Ge-0001Ce-Cq
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 18:13:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r87Gc-0006CZ-JG
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 18:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701213200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2UZZkf0xQu1ver7VCsIuEQuZZcwJRcTIVLrqqKYP3hA=;
 b=UeQ/81COH+RCzOudXo2506C4F4p+7cblNFfLi+Rh+lUMGwsWdeI9iSFZgOAJWcxnTwptK2
 jUSbTLMiwTNojnJC8+qVEseqDCRTtBYGHMuIjFxCKWHFNtXCVGgfVYBlPh37t1h3Z7T8ic
 HsorzjaWThZMpor0guKFC3zU586LxcU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-A8gkK6MYP2WnMHoG6Cq9tQ-1; Tue,
 28 Nov 2023 18:13:16 -0500
X-MC-Unique: A8gkK6MYP2WnMHoG6Cq9tQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 990C438041C4;
 Tue, 28 Nov 2023 23:13:16 +0000 (UTC)
Received: from localhost (unknown [10.39.195.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00495492BFA;
 Tue, 28 Nov 2023 23:13:15 +0000 (UTC)
Date: Tue, 28 Nov 2023 18:13:14 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/13] target-arm queue
Message-ID: <20231128231314.GA741752@fedora>
References: <20231127170823.589863-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hJorK+89+/TjuHqk"
Content-Disposition: inline
In-Reply-To: <20231127170823.589863-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--hJorK+89+/TjuHqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--hJorK+89+/TjuHqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVmdAoACgkQnKSrs4Gr
c8h67Qf+MbcJjRUY47d8pETNkczzhwAsdh9UemnRKiYAAzUxUQUGuo06EkYol1Ud
nysfZuWMZVW8uocSv885iJI00eJYZy4URlZiut3+NTW4/nlT8bwTysCJFHUheUNS
Ker/5eHpGHhP+6sdnuKDnTdrSRpUNBtHoR7jm8QcmCNKtj237MydNScb8rmKiFgA
PVKbGwxAT9KU1xkHBUQ4F4pRCssLqhMZWGMRoEm/M9KIPHU1o5dl3bJ5/AhT0Ws2
8s03BbfY4Ps5+KEwnuxtcsez6osEy7y625ZRo4GwkgNy726sjIpYoqm2FWz/XMFb
iB22fHna4s2JwMQ4YTJM0tT0gcxnEQ==
=Ddn/
-----END PGP SIGNATURE-----

--hJorK+89+/TjuHqk--



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 446117EB592
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:35:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2xIT-0002lH-CB; Tue, 14 Nov 2023 12:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r2xIR-0002ko-1g
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:33:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r2xIP-0003WY-2I
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699983232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KpdT6iGeXE4g5DQXkDI9k+EaPyPRnCH0BTly+8DR41o=;
 b=fs242sdCgdDkaNRM4ve7aKzBNUR9uquoox2voOmFO8LmZbbNq12GFng66Y3Tx7J28oqDZ3
 zNoqLxs5aXX88Ca6GFLVDapAD/V+A+QIFkVWeHjJbTSTPzLsVyeaaKxPOOpuXw6bpgrUWv
 i2ELNbVnbOmNIq7xFwMUiBDZVNI5KZI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-s6u6GfHDMbq6A61omH_vyA-1; Tue,
 14 Nov 2023 12:33:47 -0500
X-MC-Unique: s6u6GfHDMbq6A61omH_vyA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACA453813BF2;
 Tue, 14 Nov 2023 17:33:45 +0000 (UTC)
Received: from localhost (unknown [10.39.192.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D95240C6EBA;
 Tue, 14 Nov 2023 17:33:44 +0000 (UTC)
Date: Tue, 14 Nov 2023 12:31:35 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/4] target-arm queue
Message-ID: <20231114173135.GA273962@fedora>
References: <20231113174635.2540484-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jJ9/N/GRWeQXDEfk"
Content-Disposition: inline
In-Reply-To: <20231113174635.2540484-1-peter.maydell@linaro.org>
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


--jJ9/N/GRWeQXDEfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--jJ9/N/GRWeQXDEfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVTrvcACgkQnKSrs4Gr
c8gqtAgAxftVqs10En0C6FwrdUQb3ETMKKFWZXKpYx6uagz6idYygXsE5L+AQCZL
uVanyEUa4KxI9FSgiBv0wOx9cuJPH4GnRta9E4xcw1yhuWCC0DmODkQjuUk4TnKC
6qxcngBbjyQK/EjUsHBic10vkEo21yFMkyN4WcsWbm8s2NoWWG4U1byykVwDFwPb
fi+mLrhcvoi7SrVz7QuEV5kB70eVkk7cpSQpQ7+QLaZwSonbkHpEcdd0hum6yJPo
lKEnup/I0fIviVlheYz+K/lOcccELkBGW1VEBcWfv+RGkvTY77YcsJF8125aTG9v
5c1eKzqkoyUCRkCj9fb2yRcSWRRs6g==
=tsSs
-----END PGP SIGNATURE-----

--jJ9/N/GRWeQXDEfk--



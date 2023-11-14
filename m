Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D42517EB590
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:35:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2xIl-0002pH-J1; Tue, 14 Nov 2023 12:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r2xIh-0002oV-Bs
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:34:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r2xIS-0003XX-KP
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699983235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c4QPIKJbIpoo0Yu28vGmtcXSNzpbrcDsPBCTsNLVpJ0=;
 b=XcAhvLDA0R7UtASxIlN8Yp02eyUoXlToq6kIPI6BJKPhYMyoKZfljldtterve8lSuEOfAw
 gkkz7VWjzfF+jeItVy+tTwVtS30i0JKN3t5PQiiqB7Grgfp/UrWscngwqWkqDDE10+Z5w3
 QX/DdPToOpoQ1aRLGW535pG4l+2v9K4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-4ATRtNiYOQafbHPqxU1ysQ-1; Tue, 14 Nov 2023 12:33:53 -0500
X-MC-Unique: 4ATRtNiYOQafbHPqxU1ysQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DDFE185A7A3;
 Tue, 14 Nov 2023 17:33:48 +0000 (UTC)
Received: from localhost (unknown [10.39.192.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94F872166B27;
 Tue, 14 Nov 2023 17:33:47 +0000 (UTC)
Date: Tue, 14 Nov 2023 12:31:56 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 0/5] Misc fixes for 2023-11-13
Message-ID: <20231114173156.GA273987@fedora>
References: <20231113181744.49537-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="D2VIW3fIYvBywv/G"
Content-Disposition: inline
In-Reply-To: <20231113181744.49537-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--D2VIW3fIYvBywv/G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--D2VIW3fIYvBywv/G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVTrwsACgkQnKSrs4Gr
c8iyMwgApRWwS2eqeM2jSIcTUGx4VTYJTSD4wbrvwT2Cu4ZJNWk9x2k4A50ajh9/
ijiBPWMiqeKeInQJniy805jeyRKM52+VliINNo0mhuz5DouyGCgeJraiyHDEJNvr
w+Kbh5CDOkimfAuc755I8CK89gycqkvbJcI9LI7MqR+fzuHNqPYEeG/1J4CRH1JM
AZEh83xRabX06CsoC12TKH5XUDGgjMBxpzrcnpWO/HCUHcwxCl73HZzPsKnDIK1b
ougYw7fg19UIYZQYJwpUGO00bIXFBSzxvnrmY80UQumkVXytWhxaIie4IS08Rpxy
6hVVgVriuwdo5PJmyvw2PebGOa82AA==
=jta4
-----END PGP SIGNATURE-----

--D2VIW3fIYvBywv/G--



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B30B803761
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 15:47:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAADL-0004py-Ul; Mon, 04 Dec 2023 09:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAAD6-0004md-Q3
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:46:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAAD1-0003wE-Vt
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701701167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D5cnT2ks9JlfnMRi+RqMlBTuHtLTeo1+7ewMwhghnTQ=;
 b=QdrBOFTUy6HjG3LND7XvsqEypsJsQPowP+TUNaMUdcqvOqt11R+sxjNT7ij2iaaS/xaKUj
 vHxmG0jFbdptqfc5PNo9bnX+w84Wl8kdDECymLMTMBJRMRDkhGIRnottaID4BDbgAaQQ/e
 gAoTDeHtmuOIozGSNHf8uNc6Tvdsgow=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-xXpq6RiXOoCyWlECw-GRKA-1; Mon,
 04 Dec 2023 09:46:04 -0500
X-MC-Unique: xXpq6RiXOoCyWlECw-GRKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 367303C025D8;
 Mon,  4 Dec 2023 14:46:04 +0000 (UTC)
Received: from localhost (unknown [10.39.192.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C04232166B26;
 Mon,  4 Dec 2023 14:46:03 +0000 (UTC)
Date: Mon, 4 Dec 2023 09:46:02 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL v2 0/5] gdbstub, avocado and gitlab updates
Message-ID: <20231204144602.GA1491668@fedora>
References: <20231201174942.2668112-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Rsh1bV5fckdPHnnE"
Content-Disposition: inline
In-Reply-To: <20231201174942.2668112-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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


--Rsh1bV5fckdPHnnE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--Rsh1bV5fckdPHnnE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVt5ioACgkQnKSrs4Gr
c8gJngf/WR5SQT7ai/XpSaBB9DqsNh4pHDKg/Q3S9qWv4pntKAmd684Ve5+RzW3q
grXGxCMVNrZPed7Q4utMcmYZQR0CU+mbRVqhSzmG3RYNOLTVlKHn5cfqoBhA9SbP
sIgeSL241DzAD8HYEC4XUsiflRCb09+T/eQ+sFdLYB36puK6vxO8CSVpbffUAPM0
kUSAxD26p0Jg3lZMVU86IiJmHQBC1eeH0qdhZE1gg0EnOPOXCXP1FSMe25wHIkS7
jkKajzaYHzauFS93HEUXznV2vDBX14mucXUl+rXNsO6AsCmDKfCEz9IAEJqEuEnI
AEef6Xe97RnFmGNbLDwBDvsltRshdA==
=RFeA
-----END PGP SIGNATURE-----

--Rsh1bV5fckdPHnnE--



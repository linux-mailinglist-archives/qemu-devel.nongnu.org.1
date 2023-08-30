Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2C278D795
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 18:23:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNyF-0007BK-1K; Wed, 30 Aug 2023 12:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbNyA-00076l-Q4
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbNy7-0005zz-Sn
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693412579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=laffVVaHD5m9/GORSgDuNZg/PYuWV2uhWFJ/O2ZOIdM=;
 b=bZUzmvKaaBrg6qHfhGx/qtBcHtxSWoaWoN+Hrq4LWTPS71+FBsOGrG+arwUy6mBSF28VvB
 uzvddx8S2pSLCLATERINKkQE+y/FgcSkAdl0I95BXvi2pq/YBtH8l2HSO6arET67QddYfp
 7qATKVMd83J9nYOuWhDsPVi1fX8G+Wk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-29IZMWBZPbijkz0zVaswBA-1; Wed, 30 Aug 2023 12:22:55 -0400
X-MC-Unique: 29IZMWBZPbijkz0zVaswBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E517C85CBE7;
 Wed, 30 Aug 2023 16:22:54 +0000 (UTC)
Received: from localhost (unknown [10.39.193.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BFC7140E96E;
 Wed, 30 Aug 2023 16:22:54 +0000 (UTC)
Date: Wed, 30 Aug 2023 12:22:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Hyman Huang <yong.huang@smartx.com>
Subject: Re: [PULL 0/3] Dirty page rate and dirty page limit 20230829 patches
Message-ID: <20230830162253.GA474706@fedora>
References: <cover.1693322363.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8EQcL+ogG1E3MxZu"
Content-Disposition: inline
In-Reply-To: <cover.1693322363.git.yong.huang@smartx.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--8EQcL+ogG1E3MxZu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--8EQcL+ogG1E3MxZu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTvbNwACgkQnKSrs4Gr
c8jruAf+JRq3Bm6SKuMdU2R+wchYV2g69f3Epjt+cZ/m08Wv6DOArQvf9QUDRugk
44JHKxj1nXjHPxTKMFs9r8+pwQfgXWONKkV8Az8sgA0f1jMPzOeTbga3VgvbMVM1
KmRLXb46qVteu81HTD9DDe8ktG/Zhd4QCF7EnTgGMao1ucPnlN/t25ki8pALCVVd
J7uO6Vqm2ZMGA8Yedg3bmrPlefQKwU6Ruz5Bkfrin4IbGUHsVnMIlwpbFUWn2+Xu
aux1caMP75YRIZrFu1qNClZ5UumpY5i7wx/uwNGNenqq8T5WtQI1f3Nq55y6LELg
75I3n3I3RUyiN4tqnYF0/jMRglRrmg==
=oGPN
-----END PGP SIGNATURE-----

--8EQcL+ogG1E3MxZu--



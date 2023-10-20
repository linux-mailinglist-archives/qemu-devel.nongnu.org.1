Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9839B7D13B4
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 18:08:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qts2Z-0007Ek-U0; Fri, 20 Oct 2023 12:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qts2E-00073j-CI
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:07:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qts2C-0001c1-R3
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697818055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cq+etduv7qOzxvFdmfoSrscLSR41IfXQ+wypbO81FwY=;
 b=Lpqd8aC9/b4zutVYoBJkagjh6b1HJr66a8rOzekrKSFDwNuIBMGtzu9OIRmQ24cf6xMvM3
 42iM7lHmoQ8qYUizr+vvKr8wfQV+3XdV1Ey2VmwEl6XpWqoy8LFf69FhDHEq/vl9Fpfbap
 fhW4JPaZShtkbosX469cIY/3tTMIVAI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-12EQnv9UOGygAvqUNBjejA-1; Fri, 20 Oct 2023 12:07:27 -0400
X-MC-Unique: 12EQnv9UOGygAvqUNBjejA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4567488B78C;
 Fri, 20 Oct 2023 16:07:26 +0000 (UTC)
Received: from localhost (unknown [10.39.192.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C09D8CEF;
 Fri, 20 Oct 2023 16:07:25 +0000 (UTC)
Date: Fri, 20 Oct 2023 09:07:23 -0700
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PULL v2 00/24] s390x patches
Message-ID: <20231020160723.GA472157@fedora>
References: <20231020052055.519460-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zqZOFDvcNc30uU2w"
Content-Disposition: inline
In-Reply-To: <20231020052055.519460-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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


--zqZOFDvcNc30uU2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--zqZOFDvcNc30uU2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUypbsACgkQnKSrs4Gr
c8hI7gf9HosuqQu17f/EfyjiVvKMOkc1b47RCG2ZKKM1lQObImdUOUaE0239r3Ye
9mhgYSV2/tUMk53LEc2LHofS282m6c/fzufQW6lFWvJUYK46Yb5TpUmiczcuaOVM
yUpvfDqwh9q0YHeQP5a4xyQhZushSZUDXaiJL0GDuK/ky30UTGD2nx16hYd0DYIY
6+FqzNWKGKH3Z0GSSXWEglAAtc2newN4gIkhk5fvXtlLUzD/z/E7D1sG24N50jht
BWpkQvyGX/7VtHWwaDuwyxhiIP7T4u4z4Cs6nZDcfoX6yOv1aCX77CWC4+Rh9ccj
mwaE6Nu0za0ms9PVXL28ku9wnSKYAA==
=86Mm
-----END PGP SIGNATURE-----

--zqZOFDvcNc30uU2w--



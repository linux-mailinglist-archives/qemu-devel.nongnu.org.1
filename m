Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BAFB096E6
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Jul 2025 00:28:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucX4L-0005ZL-84; Thu, 17 Jul 2025 18:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ucVgi-0008B6-CF
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 16:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ucVgd-0005cm-Rq
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 16:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752785917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ltimkiser5mJFlAsacTOOJgL+c8gPfRzSi3KTmZlL8=;
 b=BP+NVyl7w80pXN/Tj0wSVzDgIIAFUV5GfU6pxHxpUJjyP1nRblneVjm9kcdtZAGIsYa+Bt
 e5LHOKRda2upJ40tHrhQOo9l4pxFGbdnw1mRB21v1Gq453FgZM6MB274vk+NRosuKblpZ6
 i+VHj0eJYwQIQ6gT2wNkaij1p6lJPAc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-zs_In8lFNxmTZAoISNVvHg-1; Thu,
 17 Jul 2025 16:58:33 -0400
X-MC-Unique: zs_In8lFNxmTZAoISNVvHg-1
X-Mimecast-MFC-AGG-ID: zs_In8lFNxmTZAoISNVvHg_1752785912
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59DFF1800371; Thu, 17 Jul 2025 20:58:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 84A56195609D; Thu, 17 Jul 2025 20:58:31 +0000 (UTC)
Date: Thu, 17 Jul 2025 16:56:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Sean Wei <me@sean.taipei>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 0/2] 9p queue 2025-07-16
Message-ID: <20250717205624.GA378711@fedora>
References: <cover.1752669861.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dd/JgcuAwCuFLClB"
Content-Disposition: inline
In-Reply-To: <cover.1752669861.git.qemu_oss@crudebyte.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--dd/JgcuAwCuFLClB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--dd/JgcuAwCuFLClB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh5Y3gACgkQnKSrs4Gr
c8j0awf/fscQ0hzMnBS/5XoaCKmuSnwbTbl4sjO9hjA0v/v2upvdcRjs641YbH0G
A03A6KrIgPKL3YBJvmWJ5dNVycCAMA/KJ3coZcYGLdto0d2MY+0tv66/pCNSjXj9
YzkCHRu+MsboQALr8qyJzQpCj2UEblSXtPpXcs30tpYcd+hqXgr9kQza/aUuR4Lj
3d13ic8ciiVMRsfboQVwMxDfrqGmAiaooTZ7frDFEZ8WERWvUv+4ZhFc6M5GTMsu
qiJ6PNBa/eEcC7gal9CF0CxJfrQO7F3+QrMTorORejeUs1Di+0ZcsesqX6sLuzEa
sHD3LqGmbxtY0/1x5k3gHUCdaa7OrQ==
=nX7V
-----END PGP SIGNATURE-----

--dd/JgcuAwCuFLClB--



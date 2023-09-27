Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B14D7B0D34
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 22:15:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlavY-0006Jy-9J; Wed, 27 Sep 2023 16:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlavV-0006JX-7K
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 16:14:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlavS-0003Id-SX
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 16:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695845664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XwoFfLquFpBigwRagr43frn2FxrLXYLCnE44M5RAVSI=;
 b=WFq2h+O8p63ADlC8az4tgazugeq12CLj/xHgbkL0Yi93efVOz/XwrqW5C9PvE7mCtMYdeX
 ye2dh/ecD4TY2WSmhcYE7SsE4y1U9kO8fBjHTjDim/Dk5Mt9i28Q/+Fg+lx414Hn+uMsln
 PVw2qQud+r2QH/yMAbdjuk5coQ7xbEQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-47A4LSzRNsCwNMSpvs5k0A-1; Wed, 27 Sep 2023 16:14:21 -0400
X-MC-Unique: 47A4LSzRNsCwNMSpvs5k0A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A48DB3C0D19E;
 Wed, 27 Sep 2023 20:14:20 +0000 (UTC)
Received: from localhost (unknown [10.39.193.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2762BC15BB8;
 Wed, 27 Sep 2023 20:14:19 +0000 (UTC)
Date: Wed, 27 Sep 2023 16:14:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 0/8] migration fixes
Message-ID: <20230927201418.GA532574@fedora>
References: <20230918172822.19052-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="s579qQI349SG3QpG"
Content-Disposition: inline
In-Reply-To: <20230918172822.19052-1-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--s579qQI349SG3QpG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--s579qQI349SG3QpG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUUjRoACgkQnKSrs4Gr
c8itxAf/UrurLFzSJsSBuYuFp4dbhn7AhxbLbN3IfEJSVo4fvDkx5Wxx0WMTMaRi
1F3fEMf+/VN3wFvd36l9VFBotxww8ZPN83pFBqWLK+hzhdaZjMd9MbDsBghBtXci
oeODGLL1iAO7NUQHgvepXw8vARTEFsIrSVXoqULwgCQ5JgbQBVPlHTiDcevheKac
OKx8Vaw/V0qqaAoJtzXlSG0Xo9zTbrF7+BaWajNWI3rPueyDnPBml6xnxsqiQ8SY
V/GMSlLS/JeWgA6ve3S91zxkhH5m4p82luSEwYPI3VxS6fc9cS10uVOdmQveAkoq
HnOYLAyM+xOJhKFZRCJt+gNljBzX8A==
=LZ+2
-----END PGP SIGNATURE-----

--s579qQI349SG3QpG--



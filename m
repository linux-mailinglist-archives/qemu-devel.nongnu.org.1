Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 729B581EF68
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 15:26:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIUps-0006rH-Hb; Wed, 27 Dec 2023 09:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rIUpq-0006qk-58
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 09:24:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rIUpo-0005yD-BB
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 09:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703687074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QjrDkMpu9rRn6LTvdt466+ww4pFK8j8UJd2UIGBbMLU=;
 b=ThjkBWqOSdcauL4PeFTl2VGlBcxGzOAt8Hqxe8e+Amb5sf3z5Gn+OUk8sg5jawUodTf2kf
 NkN+6UVaixTq/qKnPC0SHKTLY4F5DWB3VmdvG5q5zwfDKWx1mFwjeGzffolOK8WoiiS13z
 uxe61BKFmUXEwEQwWJxbC7xgLJYO+fk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-4OEjy7nzNk-BFmGxjZR79Q-1; Wed, 27 Dec 2023 09:24:31 -0500
X-MC-Unique: 4OEjy7nzNk-BFmGxjZR79Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEF108030BE;
 Wed, 27 Dec 2023 14:24:30 +0000 (UTC)
Received: from localhost (unknown [10.39.192.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 49DEA492BE6;
 Wed, 27 Dec 2023 14:24:30 +0000 (UTC)
Date: Wed, 27 Dec 2023 09:24:29 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Carlos Santos <casantos@redhat.com>
Subject: Re: [PULL 1/1] tracing: install trace events file only if necessary
Message-ID: <20231227142429.GA135385@fedora>
References: <20231227100258.130317-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kApj7LDk14S5cUry"
Content-Disposition: inline
In-Reply-To: <20231227100258.130317-2-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.755,
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


--kApj7LDk14S5cUry
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0 for any user-visible changes.

--kApj7LDk14S5cUry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWMM5wACgkQnKSrs4Gr
c8hDIgf/Zi3l3Fo4qXMtxU01Rgj1bkDbvF4ptVYR3F11wSjQBelwUS402IBw84/x
Z+SMpku2oAqjX+iP9HTy4rdENf0qgLnmvPS4rIezkuiIAfUw3eeAsrVXUgR8cEHY
4rqw84uykRU8Mc/q76M6x9SeSQD0BXBoAOr/otLeNdCLDM1KE5TH0UtdCM/KZy4Z
8MdX9q7B6PoBamWlSkJ7/o1teMRVHWjWw05RhEKKTl0s/QboifOqISoriUrv71zb
gmrmEbu5Iso3zsviucNou8GB4LcJ3SIEcCth8/G2SExcpeBj+JiKmmCCAetgtUIl
rGgi2pdnpMPOiYdFZZ44hJO7uZnMiA==
=g/Je
-----END PGP SIGNATURE-----

--kApj7LDk14S5cUry--



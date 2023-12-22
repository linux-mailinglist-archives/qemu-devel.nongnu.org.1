Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA6581CCAC
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 17:20:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGiEj-0006qB-Vx; Fri, 22 Dec 2023 11:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rGiEi-0006pm-EH
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 11:18:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rGiEg-0007x3-Sl
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 11:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703261934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6cNtkiutUkEgQIK2CkM9QNH8cZWzwo8eymmi2dxVxQE=;
 b=HLZRksLBccc3BwcI+QbAsxt8vuFae88Hx2+7ZzBcJN4VOiXkRmPLqpsCik5OFo50K+veAP
 +Dp6Y6JyhKOmzgSZPrGQGaldVGRFQQ1+BXy4M2Oos+8IRjrugeXK8uUVgl4dg1Wxdi0IwL
 7k8fc+vQr4CF8+yozvz2JKzUyLj99tg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-trrktmVAOi-rBKpIrQjOnw-1; Fri, 22 Dec 2023 11:18:50 -0500
X-MC-Unique: trrktmVAOi-rBKpIrQjOnw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F04D803915;
 Fri, 22 Dec 2023 16:18:50 +0000 (UTC)
Received: from localhost (unknown [10.39.192.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31F792026D66;
 Fri, 22 Dec 2023 16:18:49 +0000 (UTC)
Date: Fri, 22 Dec 2023 11:17:46 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/33] Block layer patches
Message-ID: <20231222161746.GA13929@fedora>
References: <20231221230634.269118-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FZEA3Dn3rf+VsWkn"
Content-Disposition: inline
In-Reply-To: <20231221230634.269118-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--FZEA3Dn3rf+VsWkn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0 for any user-visible changes.

--FZEA3Dn3rf+VsWkn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWFtqoACgkQnKSrs4Gr
c8gk9AgAj152lQKFaCb9Fw/vxODIxFaveKFNQ6hTZ60xcydYQrxBN9TPcc4pNrqW
EQmT9tchFWpysT7u/1qbWlQ47uOFYqOqQALR8av2zNQGe1hMmOS0ywa8hKhZnOyb
40LlMyQFdgYgGfa0LdKCelL0aQcNy5LVikCOR/k9JjvsbbTz2na5lUM5x2/xBoSI
bHrKVjDt3Ul+V+fvUk/trDCYhSLrgKRBBcgUVMBzWHUwAbGRQx5nbC5rRqB4+Miy
WmDvbcjSjOi9rbCccyX2QX8aBbnfapW3DoOgtstafbaUraYT02nM+wMdKTqE2YaI
wuqHjKIs8IwDu7PzaOpXsyVUSJMUhg==
=lNnR
-----END PGP SIGNATURE-----

--FZEA3Dn3rf+VsWkn--



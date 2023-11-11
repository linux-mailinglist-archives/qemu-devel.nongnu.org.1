Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7FC7E8A19
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 10:54:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1kgH-000652-4l; Sat, 11 Nov 2023 04:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r1kgD-00064q-Sn
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 04:53:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r1kg4-00076Y-Jg
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 04:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699696397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GoX6J3pA+xZFZ45k9r6rpvuZ1WSIHoMc0w0Sb7Ui0mQ=;
 b=GWVzCemdMw2wzSayYc0q9yRQYgp6ts0WYAhpsuFcPLfBAk2dEl7N/SbTZIX92Rpr3bgl5e
 +hBL+yeWekll3IADDiPth28xcm3BaODQfykBWfvbq/lYHGjUSF6RKmph5yjZI5iT3bpNFV
 Swo948OJptQuEo0Mo/zBXjCe7+lQWKE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-3Ja42YToNzebIFJcZE2Sog-1; Sat,
 11 Nov 2023 04:53:15 -0500
X-MC-Unique: 3Ja42YToNzebIFJcZE2Sog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B010E3C23645
 for <qemu-devel@nongnu.org>; Sat, 11 Nov 2023 09:53:15 +0000 (UTC)
Received: from localhost (unknown [10.39.192.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E564F40C6EB9;
 Sat, 11 Nov 2023 09:53:14 +0000 (UTC)
Date: Sat, 11 Nov 2023 17:53:11 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com
Subject: Re: [PULL v2 00/11] qdev: Make array properties user accessible again
Message-ID: <20231111095311.GA171435@fedora>
References: <20231110172305.29107-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4oiSqewj99Q4otq6"
Content-Disposition: inline
In-Reply-To: <20231110172305.29107-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


--4oiSqewj99Q4otq6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--4oiSqewj99Q4otq6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVPTwcACgkQnKSrs4Gr
c8gfXAf/V3u/rHTMDI9mTrjS6/crcPpTZ50lKXIkBYtmsr65UjdJ84y1cxy3EWul
/OylmrhjkLnPddYzl4Hy22iok3e5ZrAFAcO3NIZiO/X/xWuEBBfuH8iUeXkEs+UR
fUXKo7xacaucpR/2CPDUXqET3wvde8rBR6O7cbYq8uc1g6ni06XjM5haFGSA6wOH
NlQ8H6vcmjNNV06Vk4Mz0jS2DSHlM8JOdZbDM3IdFER7XNZpK7wVHhRWpQx4DIm3
9IjJclVXP171ZOfw7wuNrwIMV5OBCgJ+KgsBm1WgF81fk19bc38Jm3xGCfiL1OHt
nKLIT1rCQuo6g86QzslkswnVNcrN/g==
=x9L4
-----END PGP SIGNATURE-----

--4oiSqewj99Q4otq6--



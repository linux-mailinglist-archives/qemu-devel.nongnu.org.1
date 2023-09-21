Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B507A957B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 17:17:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjLQP-0003nB-Iv; Thu, 21 Sep 2023 11:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qjLPz-0003lk-FP
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 11:16:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qjLPx-00069V-Qz
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 11:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695309397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GM+3MxWj44XtupaWaCgZhgy1/41aKwHaEZk4TOyQisE=;
 b=GOVeuEfz1tbpRWwvvNRBpSL1g72SEz2k4oRwXeM1MTtolYNqTD/I5uju4c6WF35JH0Hpnn
 k2iRohsxhdoHqV5js+iRK381/fxS2SJgFGVYbFZQrJK8XmzIm1dGjzTWAC9xDRom7W6EN/
 md4YaOquizd6yzwGmM1BvuL3tO/VK9I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-LHPsCKDVMkKblRYBB7Sofg-1; Thu, 21 Sep 2023 11:16:33 -0400
X-MC-Unique: LHPsCKDVMkKblRYBB7Sofg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29BB0185A78E;
 Thu, 21 Sep 2023 15:16:32 +0000 (UTC)
Received: from localhost (unknown [10.39.195.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A75D40C6EBF;
 Thu, 21 Sep 2023 15:16:31 +0000 (UTC)
Date: Thu, 21 Sep 2023 11:16:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Denis V. Lunev via" <qemu-devel@nongnu.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "Denis V. Lunev" <den@openvz.org>
Subject: Re: [PULL v2 00/22] implement discard operation for Parallels images
Message-ID: <20230921151630.GA1117891@fedora>
References: <20230921075500.694585-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bWWtnUlfbE5MTvHm"
Content-Disposition: inline
In-Reply-To: <20230921075500.694585-1-den@openvz.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--bWWtnUlfbE5MTvHm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--bWWtnUlfbE5MTvHm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUMXk0ACgkQnKSrs4Gr
c8hz8QgArtWvwX9x7ati1UNpUskj/kkILzu5zC5hVw6zfMpSC5q3+hJzVSvyQOz8
uL/EsK8T7g5QKR0svC0MBd5z4nF01JPv6SJOgLLbNowgDsWecRrtI1BTh8NzWtz/
ClJXgNmDVW+FaQRXyuTzWnmehHp4t9N+3fctltt6dn+UTMQvAEZEx/KCoqxiOsu3
Audsf1aKsGKoHZtpPXnvICNcSJO6S7JbiEZv6Xf5jvwwi3AMagXuwW0LgOpN6Ekb
EchPNxDICD9fPQgNwUv7Tabc2k8TUiDb4YvJ35as6VBngxFL8WnWYGwZ8m67k9ib
WdTK5P+7gUGt1dyXMZgiVX9CoPiNIw==
=8N3t
-----END PGP SIGNATURE-----

--bWWtnUlfbE5MTvHm--



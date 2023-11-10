Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6147E77B9
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 03:50:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Ha2-0003Jt-UV; Thu, 09 Nov 2023 21:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r1HZz-0003JL-CC
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 21:49:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r1HZx-0004RS-Nd
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 21:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699584538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cG7Icl6abn2eLhjYPCqm+5wb8Gs32qwcVrN0e4PKlUc=;
 b=BuVBwsWFLBG+jcPT2YTJ/TdgTlrWD8gOikSRNJmDECA56Uh2CTq33Hk55MvyeP8pdwNsJy
 H6K6ycV/hlpHV9QiRMFACl5J1yQ+o211+RconBSNX/KLIorINlMabc62qaupdmMt7EwCTe
 /u1mr9kuWmIqRXt3Qj78e6Pv3txH2CM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-7SC7-W2-MDiBzfHDkw3aUA-1; Thu,
 09 Nov 2023 21:48:56 -0500
X-MC-Unique: 7SC7-W2-MDiBzfHDkw3aUA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA5773C025B2;
 Fri, 10 Nov 2023 02:48:55 +0000 (UTC)
Received: from localhost (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FF9E2026D68;
 Fri, 10 Nov 2023 02:48:54 +0000 (UTC)
Date: Fri, 10 Nov 2023 10:25:39 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, sstabellini@kernel.org,
 peter.maydell@linaro.org
Subject: Re: [PULL 0/1] xen-virtio-fix-1-tag
Message-ID: <20231110022539.GA101613@fedora>
References: <alpine.DEB.2.22.394.2311071310190.3478774@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rlxST1MGvrf7ELHb"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2311071310190.3478774@ubuntu-linux-20-04-desktop>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--rlxST1MGvrf7ELHb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--rlxST1MGvrf7ELHb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVNlKMACgkQnKSrs4Gr
c8gOKwf/bw3xgdkjKrOjjFIgOWOqAt74/BSpWgQEt5osX7JSHaQlKKfwzhRvB9dp
1F2g1eo1CH8dXAvJgrhckPdsnUjc/OzKBF3AbG5IwhRwfqdozJG9VMoCyiN9FCLb
m4jdhrTR6aE37d1p/Hv7y2aR1ogMydHi+a5F3GbiqZdtbn5mR2Qil7/vwmNz++dZ
dYzqjMKB3Z120pvN5BenydHs8vhvY1F1OcPpCefP4I9mfxNOJ/p9ICkY55tVAlGZ
6hlBZhZS4yyjl5wyUwQO7aeciiwDRbPKPFmnVhGfTXWWT8RKIwPMq7rpPt1NSFz6
RRS0jRcN2vOm9uwxptRXk5G44GqyzQ==
=ke7h
-----END PGP SIGNATURE-----

--rlxST1MGvrf7ELHb--



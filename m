Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0841681A39F
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:04:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFz3E-0002u9-0U; Wed, 20 Dec 2023 11:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFz3C-0002s9-50
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:04:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFz3A-00029O-J7
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703088240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0a3EpSox7VL+nLRGE5lB1jRFZBuGhpyrjT3e6ACj2nA=;
 b=BmeTpLOBNPurC60I5u0VmJyyVsPrg+e7e2J5BU6B8VuCJGjvqbsM+6/WRfgQ7VyKEK2j7b
 0EYEIJwwyGz20+pBVXASvI+LTiQl4sZjq3K/IB9m3V4xezkjChTVda4tQx80ZtcPdjNgtb
 GqMHXHC5fGirrJ2OfC0NpkKjddG5fC0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-Y-lA-85_MY2wzlqGq6DpBw-1; Wed, 20 Dec 2023 11:03:51 -0500
X-MC-Unique: Y-lA-85_MY2wzlqGq6DpBw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D21B85A589;
 Wed, 20 Dec 2023 16:03:51 +0000 (UTC)
Received: from localhost (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0E15C15968;
 Wed, 20 Dec 2023 16:03:50 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:03:49 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/19] First batch of misc patches for QEMU 9.0
Message-ID: <20231220160349.GA843298@fedora>
References: <20231220094105.6588-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eaeS2ttDk2qpCfzG"
Content-Disposition: inline
In-Reply-To: <20231220094105.6588-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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


--eaeS2ttDk2qpCfzG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--eaeS2ttDk2qpCfzG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWDEGUACgkQnKSrs4Gr
c8hifwf7B6dg/i4wuFoxjiWGAthmguvYgJK+DkkJV0oG+wZV+RDYpA/UqIpfToTW
Klok5v6uInIqmnO1LIQLzbe9y/DsnfLjMPdj5KWAiPUgLsPsG4Ji5cf6rT6s5xEd
QFv0IMboJARGhuCGLN3O2u0ND9oecpDM0xv0uf4ESRKz7lmc9Bn0tKBYVA4XOChe
ItSW/eGcd+BD/ZxLW8qITSb4QfLyvztgviqQI0wiTiLY+Qg2pnMDPP07ogUoMtlY
522PHRZe095j7EjmjDbzOtb/5gIiA53VpYCJVQnCDsVeFT+W12ePlyBICRELo9xa
gTZHChxDVpP2lfwS6tQmjzGeElLbcA==
=NHqx
-----END PGP SIGNATURE-----

--eaeS2ttDk2qpCfzG--



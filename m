Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 736FC7F3210
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 16:15:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5SSl-0002Va-Kc; Tue, 21 Nov 2023 10:14:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r5SSj-0002Uu-EX
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:14:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r5SSh-0008Kj-Vt
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700579691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=avaDCfszHaqrLXsXRl6cX9GOa77qWN8mF5sbYLpnB9U=;
 b=WENizKV5Q1oba5jKceMukWcSw4zVz7OY9nePCBUngcRbptD9A97ngl4qSyi217VbWjLVIz
 TfeRD/7tepU97DoeILTeSqiSBZVdypgeQZsvZAmBU8RxdO+wM334WpOwFWwTMM1yOYmFVr
 SPwHfN3IZMj68uH/tBGSp+e8Gh5sOf8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-L9ERbDRGMPGgpVM0lI2wQg-1; Tue, 21 Nov 2023 10:14:47 -0500
X-MC-Unique: L9ERbDRGMPGgpVM0lI2wQg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EA69101A52D;
 Tue, 21 Nov 2023 15:14:47 +0000 (UTC)
Received: from localhost (unknown [10.39.192.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFE5C40C6EB9;
 Tue, 21 Nov 2023 15:14:46 +0000 (UTC)
Date: Tue, 21 Nov 2023 10:14:45 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH] Revert "tests/avocado: Enable reverse_debugging.py tests
 in gitlab CI"
Message-ID: <20231121151445.GA3480567@fedora>
References: <20231121100842.677363-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0d7UbReEsh93ilBQ"
Content-Disposition: inline
In-Reply-To: <20231121100842.677363-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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


--0d7UbReEsh93ilBQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--0d7UbReEsh93ilBQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVcyWUACgkQnKSrs4Gr
c8gLCwgAvC83qlovgayD1bpg4Mlw65Oo/zFqZ5+CzTA061vF3bQ5lQUkS5JVDTfj
kRmqFXXxAEl9bvlIFugzBIn5EkuYnXjPQqBjUhUg7BdLdIaChupALJK9HA8sAyCV
VcLCG+AQrFEc4CWjPHlBqdWIT45UtAvEwu/mvZGN4xjwQnRqhjfLw3niMe2HYmOM
va9PwL15bJPs4h5gqjKlJu4xb8L615GS5pHMlaY5c8BTx9XLs1XbTrCZptWPnoqJ
LDf6/bagt2n+fC0b05Vcy0ROIW20DJfarzVkV6L3v6jFHSmAqINj3NxM5d4zAU+B
zD+vHhi4l4BUr3che2xIbOGsbtTt2w==
=PG9W
-----END PGP SIGNATURE-----

--0d7UbReEsh93ilBQ--



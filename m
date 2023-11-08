Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C8D7E589E
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 15:23:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0jSB-0002gI-Sp; Wed, 08 Nov 2023 09:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0jS9-0002cd-Cx
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 09:22:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0jS7-0003jr-2w
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 09:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699453361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZcNoByzY665squFkHTDBBj6Vn3aMJAjdoLB6CEQ9E0M=;
 b=aE1LyzeLIInrfRElS1ywwdVg5/ROvP2IQvUTTDRE32XyOqpj+TOb8CNzwew6jnxXZwu0Lg
 hqDnYyOSYpEIarz/3VQgscBvp0e4l8oXQOXCjfvaqQHw/ey0uoXw6MHE+8Xm++eijWUa/0
 dr9+UR+lVgFmCsNKDNxZ9q20la/XO3c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-QBN3RgQ1MC6pCUwi5mWW4A-1; Wed,
 08 Nov 2023 09:22:38 -0500
X-MC-Unique: QBN3RgQ1MC6pCUwi5mWW4A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3578280AA25;
 Wed,  8 Nov 2023 14:22:37 +0000 (UTC)
Received: from localhost (unknown [10.39.192.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E56D492BE7;
 Wed,  8 Nov 2023 14:22:36 +0000 (UTC)
Date: Wed, 8 Nov 2023 22:20:23 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, danielhb413@gmail.com,
 peter.maydell@linaro.org
Subject: Re: [PULL 0/9] ppc queue
Message-ID: <20231108142023.GA1062279@fedora>
References: <20231107204806.8507-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="POtJg2KUwDyY/P+S"
Content-Disposition: inline
In-Reply-To: <20231107204806.8507-1-danielhb413@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--POtJg2KUwDyY/P+S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--POtJg2KUwDyY/P+S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVLmScACgkQnKSrs4Gr
c8hcMAf8C+9ekvLaIABmoaJriAgEl0HriZaZwJQxjH7qJdL3JX/UyF7Hjpnnfv5f
KYTfmbyXh4zMevrGXY0lJklFalzTh+g1CIDHVIWsLbzM9FGhCV3bpi4oTV3AhDlm
h1d5W+VKC9ijvgClIkky0XDn8kQsb+h46IeeiM4fgH/MoWiV5Sh333xB9629zx0G
J+3mejz4DvPs6fnkNywTngp/Qt7CT847/G8jHvGbIq4zJfY1NkbBWuwDYcBuo+pF
8Yeb/jVqwn3TzFDaCX/EKl1b2y4DN95VNUCR5owRMCXbLcv+WrRUqMoGVIQc6LkH
9PnMcPldpqEOB7O7RA1bQNqmn8weCg==
=wcAW
-----END PGP SIGNATURE-----

--POtJg2KUwDyY/P+S--



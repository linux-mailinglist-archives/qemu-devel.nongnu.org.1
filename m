Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2A37ADB9F
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:36:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkndS-0005Uf-6Y; Mon, 25 Sep 2023 11:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qkndQ-0005N6-BJ
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qkndO-0001QC-S0
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695656190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nUJFQ53k4Wn/9EENrMZA0Bpi/8rm+DMwkf26SEd9yuw=;
 b=ILwsAdlcoHSL8jUiR7/jB6UvQv20UMufiFzOyo/r3nrahed1ql+/JcZsXRNg8/favebbIh
 OCApQbDbleOl5PS07AK9j3BfiKdALq4tFU7u2vlWv7ndDjQAZAQxKGPBBbx2EGFo51Sg/T
 cOqVY7nspx2ENgGVoGBcRGuiPzXbrFc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-86VJhKmZPZK1dgcu_2svNQ-1; Mon, 25 Sep 2023 11:36:26 -0400
X-MC-Unique: 86VJhKmZPZK1dgcu_2svNQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55A373822E81
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 15:36:26 +0000 (UTC)
Received: from localhost (unknown [10.39.194.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D786740C6EA8;
 Mon, 25 Sep 2023 15:36:25 +0000 (UTC)
Date: Mon, 25 Sep 2023 11:36:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/7] qtest and misc patches
Message-ID: <20230925153624.GA309847@fedora>
References: <20230925090100.45632-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AK38pwsaBJ4T8TuO"
Content-Disposition: inline
In-Reply-To: <20230925090100.45632-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--AK38pwsaBJ4T8TuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--AK38pwsaBJ4T8TuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmURqPgACgkQnKSrs4Gr
c8gY8wgAiaLa5gzfEB6A2WgaPvaRzD452ReJPLDDUVIr1/QskAd/+KsP8H69xq/L
1scmFawa1uIORX+7KF/0V0kc09u22BWMP+c9jLiIP4+d2dPrXFIK51o2XFZIqZMu
6ePytWyZbkJHjjykgsGvucxpSBa5UpyGZqfmMD0IIH+zpNfbxYfQG8L5faUcyobj
OQzoqFgml8zZZwZDSDlP4bA+eOGcc5l/ZVtkr7e6jpvEhJSOxoB64tVLNZ58G3C5
r4ZWNhm9UrqGzPP6ryGQVy8/8wcKtn8UEBfUkxalMMNSnSD1i2XqXkEG8dM1MY8U
rbibZSkusy7mPebIWgZ0AB2MbSvkNQ==
=u9Hs
-----END PGP SIGNATURE-----

--AK38pwsaBJ4T8TuO--



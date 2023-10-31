Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 133AD7DC7BB
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 08:56:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxjbp-0004jQ-5a; Tue, 31 Oct 2023 03:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qxjbm-0004im-Ib
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 03:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qxjbk-00031A-JP
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 03:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698738974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5tOS7bRsYUD6wRB2KYk79Y4xiCwLuy63OeWqGzlH09M=;
 b=BYyxPOQQr6vFc/FYahhYbsj+inbSCKrXoYiUxApuPosebA6VHnG8UrcrYhtVqUSKm+Za+a
 TJ1Q7Ft3gfrQPq9z3mymZF/bO1eSVDKbZmdkFkblZaT0aRwQlXz7mGvn0oKE7kgVlTlAHt
 xUJM+agAfy3xWe60GY8NHWJ4efBe7+I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-weyF7kOJPM-HPy0Sum6d4A-1; Tue,
 31 Oct 2023 03:56:10 -0400
X-MC-Unique: weyF7kOJPM-HPy0Sum6d4A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 849C61C113E8;
 Tue, 31 Oct 2023 07:56:10 +0000 (UTC)
Received: from localhost (unknown [10.39.193.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 709A72166B26;
 Tue, 31 Oct 2023 07:56:09 +0000 (UTC)
Date: Tue, 31 Oct 2023 16:50:50 +0900
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, jeuk20.kim@samsung.com,
 pbonzini@redhat.com, fam@euphon.net, qemu-block@nongnu.org
Subject: Re: [PULL 0/1] ufs queue
Message-ID: <20231031075050.GA644043@fedora>
References: <cover.1698631179.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="37hZVJFxlTknIOGY"
Content-Disposition: inline
In-Reply-To: <cover.1698631179.git.jeuk20.kim@samsung.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--37hZVJFxlTknIOGY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--37hZVJFxlTknIOGY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVAsdoACgkQnKSrs4Gr
c8iZ0wgAtPYUDCMvGpMQGlx2hAxJw4cbXE3tPe50zNth0LhgyaRi+8In9wI+3xAl
YWZ2eD3MLXvQZrgIcviTFapXaH9r3g6yDxOmBUQJDchq4jn87UePZ1DwR5zYAWcn
N/hS0fNjXT8TPdYCp08Rh6TMjv5/hIVFQzXrs9tLnfHg1njEgSVrAcgp//avF3fr
w6eJntGmcUQxrF4sUlZIg5ffeoa/fTtvoY95kxMztNRdt4RBAAQU73sut09KwqPt
7tba4VUWX7y2QThktoSIZGeoVZjoJbG6fcJFNt4Hv2YXzBWHCKPnf97hChl8RVmZ
yIRF2XOyKlxzAS2KFkiMr8uBUkK2jg==
=lxBM
-----END PGP SIGNATURE-----

--37hZVJFxlTknIOGY--



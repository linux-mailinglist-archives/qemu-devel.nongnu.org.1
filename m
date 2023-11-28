Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E21F7FBB4D
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 14:19:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7xzl-0005QA-EU; Tue, 28 Nov 2023 08:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r7xzX-0005Nh-Nf
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:19:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r7xzW-0003oq-5f
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701177545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QAddVZvu9R8XyInuM8ZC/FddPxEhSiHeltE/Q1Y5Wy0=;
 b=cZ7/C7t+oF30ineJhqK30Z6u1PucRAUWD+lpfIYiWQE0OMGhnzNlTinhGLEjEebAH3wCAQ
 GI60FmCfZ4RYKKmqGbRA8lz4ivhRY4Cg4KX+Pdp+eKjI4juhRZ5OgitwhPvp6jWThyylEq
 Cv2g4ZVtSZEmdedJ3RCtlGup4dIZNc0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-4er-D2RsO3GLeY0z8Zd2KQ-1; Tue, 28 Nov 2023 08:19:03 -0500
X-MC-Unique: 4er-D2RsO3GLeY0z8Zd2KQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 353AC185A7A4;
 Tue, 28 Nov 2023 13:19:03 +0000 (UTC)
Received: from localhost (unknown [10.39.195.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90158492BE7;
 Tue, 28 Nov 2023 13:19:02 +0000 (UTC)
Date: Tue, 28 Nov 2023 08:01:47 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/1] QGA build bug fixes for QEMU 8.2.0-rc2
Message-ID: <20231128130147.GA483853@fedora>
References: <20231125173011.374840-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pNv1IjktR/T7Z3lO"
Content-Disposition: inline
In-Reply-To: <20231125173011.374840-1-kkostiuk@redhat.com>
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


--pNv1IjktR/T7Z3lO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--pNv1IjktR/T7Z3lO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVl5LsACgkQnKSrs4Gr
c8iVUggAx42ZyZuT71+fiFCTEBjMKNpVKRlC3gD0EwI0tbuO+Q4zHRwtRyXVLA4Z
NvZIPaKbI/R3i65+VDioEtY94//WvpZhdUvOcDMW5GY+BgdAxV7t7TBeQ+Bl3PPV
K6XGfYZyt1ehQpRR4c0tIMesD9PcuWKEUBOBQAr79u0s3nLFySk4/QrFQNMh2+Ly
NkE4tdfcbEg3lIEsS6RGdf4NBjNQLPWom9a6QB3wUUnEZQcyNUFdvSATiJ9Ku9CV
9KjOGmxoVu/sNCTswNKeivPOyATS4boVY5Reqnwf1NETkQikhihWnNrWrLVj0RNt
5JFPERLKCnWajFws8lBcK7khT6S8pQ==
=QSYK
-----END PGP SIGNATURE-----

--pNv1IjktR/T7Z3lO--



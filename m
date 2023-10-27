Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E9C7DA446
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 02:13:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwWvi-0007Fz-CR; Fri, 27 Oct 2023 20:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qwWvV-0007Ef-Gs
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 20:11:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qwWvS-0001RX-8T
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 20:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698451897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RrkCoXcSa0rUzKD6G+a85ER2YAsUV7EnXd8AG0vhhow=;
 b=Q/FafoZgszJsjnUtLi8xJOIg8TFVeg/pXmf4K90uJcQ/XqjZqIGNdZkKo8XvyALWzRMUp2
 OKwH3uhCY1g2w5s9X5y1jKsudfyxkiu3PP6AeZlIEIVQDxu7wXmkFOw/xPLRegHvo1uCqh
 EUYPVwa5ycp1HDjpED95wVRKquBsqdY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-d2ToBfd8NsqsXaZDrT6ZvQ-1; Fri, 27 Oct 2023 20:11:35 -0400
X-MC-Unique: d2ToBfd8NsqsXaZDrT6ZvQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD438101A529;
 Sat, 28 Oct 2023 00:11:34 +0000 (UTC)
Received: from localhost (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27C5C1C060AE;
 Sat, 28 Oct 2023 00:11:33 +0000 (UTC)
Date: Fri, 27 Oct 2023 19:08:39 +0900
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/94] target/sparc: Convert to decodetree
Message-ID: <20231027100839.GA554424@172-11-0-127.lightspeed.jcvlfl.sbcglobal.net>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="154KQpKJhtKECim5"
Content-Disposition: inline
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


--154KQpKJhtKECim5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--154KQpKJhtKECim5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmU7jCcACgkQnKSrs4Gr
c8hm/Af+JDkt/t8czeRjXzoQgnFj1TfabG+Ir4UQfVZiki4gPE+tW8tBqVbeRERj
GfCdl0m3i5xtKZpePAJSy7rUubghZmNvcoBebWaN83Kt5/cunmRTUS59z9FcDvei
FKRvELjazKKVGXmDFFkUrENDnfNiXbRLFHn6vr4LskBNudkz4W4ONl/6ZgL/tD+d
sJAgq14fQdDItFM46ggx3R1oh4vrC+MKARW52xKhpAkWPJh1riNhQmgfoOi4jJgm
YI61p5+LYvr1S65yNgEsuT39fFWkwLYHsyp/L8J5pn7cI4ZDUVOpDUQSdU8hPXUa
jXCdq1AM7gYyxNjiSzIFIkVz6J9vHg==
=ZC2f
-----END PGP SIGNATURE-----

--154KQpKJhtKECim5--



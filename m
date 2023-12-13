Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 020D2811ADC
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 18:23:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDSx7-0007m9-SQ; Wed, 13 Dec 2023 12:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDSwy-0007hP-Ao
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:23:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDSww-0001EK-PI
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702488189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yOB8rG32FWTBYNacCr9VTHEDH315HmqV1sNKMkxNzLE=;
 b=Nxa3VW848Cyycww9UIR+X/p+uURhFkXLiOvbWIDbdjGhj+AsUsjWD5ybZetmCfjN5i/24Z
 TtaLND4LRztcE3w1N8k06C5iJviBqCQl9a1/ZpIZODe7xk60K7GCL8rcOVQfZWitTReTuh
 /VX0UpoEYnc2sJ24RdLKLx3WrEJ6u0A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-rSoUawaPNiiuYIuOKs3GgQ-1; Wed, 13 Dec 2023 12:23:03 -0500
X-MC-Unique: rSoUawaPNiiuYIuOKs3GgQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02658185A793;
 Wed, 13 Dec 2023 17:22:58 +0000 (UTC)
Received: from localhost (unknown [10.39.195.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CFC2492BF0;
 Wed, 13 Dec 2023 17:22:57 +0000 (UTC)
Date: Wed, 13 Dec 2023 12:22:55 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/2] late fixes for rc4
Message-ID: <20231213172255.GA1490715@fedora>
References: <20231212214648.300959-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d+ADT724tz8yKNqW"
Content-Disposition: inline
In-Reply-To: <20231212214648.300959-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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


--d+ADT724tz8yKNqW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--d+ADT724tz8yKNqW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmV56G8ACgkQnKSrs4Gr
c8gZawgAx/DUYx9duFCF323+nGWv5Lf9fHcPYDTW22d545iM/h665QnZoMtScLwC
XsW8ynYdTFS7zdmkGty+U1UokKgVdtLvgyA9mF4r0jFxCKfVvrq7gZ5tyrrUC1dv
/O2zUrpfz62t2IJEgm5gud0fy/0nVxVXeOlrnBn36eTuAZQPEPIRZkbMxvlNTEJJ
YvORACjejV7/0Xy8rJpTdKOYnYNNblGzPHjvt5nU8N7UHG5mzld/IFmce5b3s4nM
fymgc20uds1Hb1T8kKCAsNFMk9jJPtcH5XMf2/HsVV92t95rY1FbtLGT3QaJqDtc
lzBon4E27chJibVwstOJ94LW4QIvJQ==
=dXVx
-----END PGP SIGNATURE-----

--d+ADT724tz8yKNqW--



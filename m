Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 923A57E77BA
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 03:50:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Ha2-0003Jd-55; Thu, 09 Nov 2023 21:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r1HZz-0003JM-Da
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 21:49:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r1HZx-0004Rm-NL
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 21:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699584544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tjhdElVxtmkKREkubgz2OeW3p24fJVAyXmLdklgoMN0=;
 b=URF3MLhnfcTY4l0vCyFkbLY/pa9eL3HekRsQaWQf9B522wV99JDIGONhs2thiCb49XMyb9
 HEvCQSL3hi1BouevvQqTK9Lcc5DiLzd9WK7e06UlZNNy116RoC+15COXNDiHbwyVxOoHHM
 AV6heCkKSQaEs6SzPXeYmqdlXfimgds=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-IgL1wVTMN8aWV-vUL4fktA-1; Thu, 09 Nov 2023 21:49:00 -0500
X-MC-Unique: IgL1wVTMN8aWV-vUL4fktA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBA1E811E92;
 Fri, 10 Nov 2023 02:48:59 +0000 (UTC)
Received: from localhost (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D742502A;
 Fri, 10 Nov 2023 02:48:58 +0000 (UTC)
Date: Fri, 10 Nov 2023 10:25:49 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/1] Tracing patches
Message-ID: <20231110022549.GA101638@fedora>
References: <20231109070409.46365-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JO1bh/WaQ5hFe1XF"
Content-Disposition: inline
In-Reply-To: <20231109070409.46365-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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


--JO1bh/WaQ5hFe1XF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--JO1bh/WaQ5hFe1XF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVNlK0ACgkQnKSrs4Gr
c8irbQf/eWjEB99Mncj/BxFlEseb2b3Mfi7DxAvJJEzjUVTv62TMCatzyXCNbbpV
fNDHXdVjq9DEsiqKUUQ+E6i030NE7JcknQUKgknAatJ27v4ZgM+rmxEKWFF2UQAn
2PGM3g9ssMsa3iD3gxwyrWDpvlRc/IOjN0FauqHIQwG6mHomqAT6DorvwIlFivfG
PVs7bE6L5wM/d0bBqnDoXwaL0b2vQdDXZQBlyJcjmCFA3luWlRHSRHH228iVYLHF
GAUTQoFCOu0OU42DHXdWsnJktYGIZkBj4BQpNkVJk6h+riNOeVE6iVqjLmNowtI6
qfZ+Ac5ft2zBk8E86Wnn1nLgtSbLXA==
=WEhx
-----END PGP SIGNATURE-----

--JO1bh/WaQ5hFe1XF--



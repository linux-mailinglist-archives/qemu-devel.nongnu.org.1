Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E48B7DFE5E
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 04:25:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyknC-0003Zu-VK; Thu, 02 Nov 2023 23:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qyknA-0003ZA-VW
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 23:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qykn9-0006CO-KR
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 23:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698981855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KiMbbKBjeo9fXiL8tIYK0j6oW538HuwzUErNedwnq04=;
 b=SsMxKywkaVaEVcHoOiR86PQ6Iz3oOD7uyWws17YCvXqEi9PGFRA1DQr6xUGBT7QPmNc3a9
 ZodNPF7hyV8FD3T9/oJdDcO6r7iVt7Aw3Ty6G4CtrJNNJcfSYFXfx9cLiHiEvvKliKafdr
 rXnZ+aE/wThAau0D9oofBLQ+y0boBm8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-9nEI0zQvN3iA42Xx7rP_mw-1; Thu,
 02 Nov 2023 23:24:13 -0400
X-MC-Unique: 9nEI0zQvN3iA42Xx7rP_mw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE90338130A3;
 Fri,  3 Nov 2023 03:24:12 +0000 (UTC)
Received: from localhost (unknown [10.39.192.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35340492BE0;
 Fri,  3 Nov 2023 03:24:11 +0000 (UTC)
Date: Fri, 3 Nov 2023 09:31:49 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 00/10] m68k patches
Message-ID: <20231103013149.GA760075@fedora>
References: <20231102100543.4875-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NI0uvH3Zis54NRdw"
Content-Disposition: inline
In-Reply-To: <20231102100543.4875-1-huth@tuxfamily.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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


--NI0uvH3Zis54NRdw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--NI0uvH3Zis54NRdw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVETYUACgkQnKSrs4Gr
c8hfYAf9FBSQgraUTnBDxdtvtWQSN3ZU1udFe3YpdwzSkQAyhf+1Cv6wsfZVvBHK
apiFEdJBzRt7k9SV0koBpmj3l2L/sK6VbIFvMwGoRI6VPkwGLhXjwP4YcPRiROF/
pOUV7LoBYoO2rUY2MkftgjTWwtqkEcYexiFS7mFzq4JhGJ7fNMtlvOrCr3RWDl60
5/Ih9yR/dtX0r42qksktKdl34W6mOCzqB7dEBiZy5IrpiJGaw1OhcSCFhkVtp9Ow
Y2wq/11YKoTyn+P5LC3BI/wh/JgT+hUnjF30shzysQfiJWWYz7YEYufP92IjkMsg
Neh/k91f7zt/y50IqL3XYQHgKJNO7g==
=kmZD
-----END PGP SIGNATURE-----

--NI0uvH3Zis54NRdw--



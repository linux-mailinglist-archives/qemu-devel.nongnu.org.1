Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F0E7F15E7
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 15:41:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55Rp-0003gd-Vj; Mon, 20 Nov 2023 09:40:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r55RZ-0003EP-K1
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 09:40:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r55RX-0004fw-NR
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 09:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700491206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j1EFNgoiYpxVYheFC0IeG0uxk2mogTZTeWqdX9hHFMk=;
 b=DPT5Rr4Q7car3akU7IuCi/5Qi3l6jIO+2m2WBzJdrv9LXm8i/5Tjl+IP9Eik0BfJxHVXYE
 Lk9Cjnr6Uu19DzqjS1ttvCL2WdPpShJRrW+3TqEboLLoarddRpMWKfzpVCbKsFiio33uic
 Dt9P+OlOAvTSYNEHedyddWqqYpladR0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-juVE_48xP5mFASmwyfCDIA-1; Mon,
 20 Nov 2023 09:40:01 -0500
X-MC-Unique: juVE_48xP5mFASmwyfCDIA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F36EB28040B6;
 Mon, 20 Nov 2023 14:40:00 +0000 (UTC)
Received: from localhost (unknown [10.39.195.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 732C81121306;
 Mon, 20 Nov 2023 14:40:00 +0000 (UTC)
Date: Mon, 20 Nov 2023 09:39:58 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: deller@kernel.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>
Subject: Re: [PULL 0/2] hppa64 fixes
Message-ID: <20231120143958.GA568883@fedora>
References: <20231117200521.417330-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2R71wWlpT2L6guWx"
Content-Disposition: inline
In-Reply-To: <20231117200521.417330-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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


--2R71wWlpT2L6guWx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--2R71wWlpT2L6guWx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVbb74ACgkQnKSrs4Gr
c8gHKAgAmmCgvVi8A23A1a3nZIp7HvdEm9JuTr4r+Q53u5Bx9vyK7PPepQdcjGlE
fZNkaoz4eNXM4enCTlr4gStGxQjIfjxottCLdw3R8wakm10UeaVoKErUYJFn0Iok
ZPLqIXqLFO4P4T3qYNiMggVjVo5xDqTMJJ0DE6jnJzqq2nlEcvUmGpGXiQby5KWe
vlPhpDg3krSL9qmslRlcStM5YUgQnJTjD86zBcp1BxybqPMeYOPqO1swv2aCpcYN
I7pVxIh05FoIt2hTBh/7htsBMqV3Kyvf1AOVxVTyv9kBla4ovMlrHFRhf6KYp7nG
TfShp8cu4TDxwaG3midGN+B4HCscGQ==
=kIvV
-----END PGP SIGNATURE-----

--2R71wWlpT2L6guWx--



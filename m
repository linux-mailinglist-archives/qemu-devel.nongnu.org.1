Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C63B779F1D6
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 21:18:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgVMt-00038u-Mo; Wed, 13 Sep 2023 15:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgVMm-00038O-8M
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:17:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgVMk-0001Ed-3t
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694632651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cC3sxvyxy1H0gQ6On/dVCYYAF1jiBTf+0KO6x/VsN30=;
 b=Ee4vkVjr2npVDKiSGZB6aWTNbedgc2z4jn7qgeN1SQv3Dwk+rM97fR5Mp8zPxkn1AK9MGb
 48acFLJ18rx09hHGPEjgIZ3ZRL3DAVSLhVpWCbKsh5Gf7RfvWo/s+DxceyuBS1jjE0d1OT
 TNVMDllaYE6ustvzTlbSJ7jpPtHoiik=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-wrJl0Ch8OqKRdppLyDjw5Q-1; Wed, 13 Sep 2023 15:17:29 -0400
X-MC-Unique: wrJl0Ch8OqKRdppLyDjw5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55CD7185A78E
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 19:17:29 +0000 (UTC)
Received: from localhost (unknown [10.39.192.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFFD12026D4B;
 Wed, 13 Sep 2023 19:17:28 +0000 (UTC)
Date: Wed, 13 Sep 2023 15:17:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/4] Build fix patches for 2023-09-13
Message-ID: <20230913191727.GA916808@fedora>
References: <20230913120820.969262-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uEt0CzvdiN2nd1EM"
Content-Disposition: inline
In-Reply-To: <20230913120820.969262-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--uEt0CzvdiN2nd1EM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--uEt0CzvdiN2nd1EM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUCCscACgkQnKSrs4Gr
c8hoKAf+PIuEh4CQqv7owe/kaT5C7JIembe7Dla1QQI2lX4s4hUuvPVnhvdMoC5n
m8Tekk3vr49nO4ZhL8+wWnReLdOJzVWIl1nPiVDjMy0ffEx9xDI5ZpI3nJ38vpQo
eWtczmlDTWQfO/MJFaJiqQPRsufY/b1lHOs5EIMs8T6iXyvzjndVvdjr4vZMtYtX
DF7oZrMM/afszoHqpvSQEBiq0waiaF9iev1SDOtxY/nWZB6mgSYPLBAnjLJnSVMZ
RocHZ9o71TM9pAwKXln9KKxHiR7e1IxiJ3fxvAU0WKSxMJxna7Vj/uvpZTzCIlxP
eJIJejkyWy0zhe7mbbD6H39mEmpDYA==
=9tTX
-----END PGP SIGNATURE-----

--uEt0CzvdiN2nd1EM--



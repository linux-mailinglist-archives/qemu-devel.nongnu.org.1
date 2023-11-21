Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B09C27F320E
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 16:14:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5SSb-0002AS-29; Tue, 21 Nov 2023 10:14:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r5SSZ-0002AJ-B2
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:14:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r5SSX-0008Jf-Jt
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700579681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DOql6jpQgnFDc8hTS6M0/ubShSFFItzrPEGJSwFpntA=;
 b=ane+Ar+Wcs+VRxcc22tT3TFU9S/xHHfs/A3JLPcn8f7qIQEzwfFojL4V36fBY7ldgtuiPd
 1F+OlUyYPo9ZopBjEPEz1nZzVqbi8RI47oht/YotuZvAfTm4I6baWx7LO9fx0KpPh+zcvz
 Exmxa+nHHtXgLtZ7eEAKS8rusA4C9QU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-BPJAbhVuPleUY3zvBFOlPQ-1; Tue, 21 Nov 2023 10:14:37 -0500
X-MC-Unique: BPJAbhVuPleUY3zvBFOlPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDF25101A529;
 Tue, 21 Nov 2023 15:14:36 +0000 (UTC)
Received: from localhost (unknown [10.39.192.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D3571121306;
 Tue, 21 Nov 2023 15:14:36 +0000 (UTC)
Date: Tue, 21 Nov 2023 10:14:34 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 peter.maydell@linaro.org, dwmw@amazon.co.uk
Subject: Re: [PULL 0/5] Ui patches
Message-ID: <20231121151434.GA3480531@fedora>
References: <20231121104020.2209345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bJEa1Mf9hHkFWW1J"
Content-Disposition: inline
In-Reply-To: <20231121104020.2209345-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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


--bJEa1Mf9hHkFWW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--bJEa1Mf9hHkFWW1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVcyVoACgkQnKSrs4Gr
c8jUXggAnonxPU9n8Pi0e8XbvzO9lrlnqCk48mfcC2be1Y6j1QY2viHIExIP5q3Q
lktd5l/NlCcNKI6z3gvh7A6XDlKaUM1xPCdvYiyfaOjiA/3JhrHNnHdt0RriTb4n
rqTeC2ohXV3AbA+6kQ/I62plVhME1FRUWYu5NpaMzeqZqzB44g4NwQY5rgFswrt9
ZXr531CdMR0oNvMgTJjM6bzw1+yWUT6pVY9Z3sjq9j7Ld981s4p9RePOowvSeE3M
zXqxCmhEiyBgZy89naqxSENFRvex/dGBxjJrB3PmPkytB6QfQ4oArHKljPviJTIW
rW6isry8/l+TD12PwFr8YwdVR7rz3w==
=mFdC
-----END PGP SIGNATURE-----

--bJEa1Mf9hHkFWW1J--



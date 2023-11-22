Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C56C7F4D5C
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 17:52:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5qR6-0003Wg-Ay; Wed, 22 Nov 2023 11:50:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r5qR4-0003UX-Ds
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 11:50:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r5qR2-0001Bf-Tu
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 11:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700671843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WmkVsqb8/DGdtr08cVd46F2SUw7//xtNi0lffqmxRag=;
 b=f7/0by2q0JmznlRdpeIrF4l+GHdgbSkmg6n5JcN3okZC8yTNEZOiMRyXmq9qcPjvTM4sXg
 jtg9jWz3FE2zKkAD4aetU47SYYxSwiHSEN2TCOA2hg+nSUvDiyNNy5IehsxsYsh7heYNZN
 Ftg62JJZC0NN10bdXH8XyyJVSPVOuyo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-6p7Hc2UpPnK_KkO6jErLXg-1; Wed, 22 Nov 2023 11:50:41 -0500
X-MC-Unique: 6p7Hc2UpPnK_KkO6jErLXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33E0E85C1A6;
 Wed, 22 Nov 2023 16:50:41 +0000 (UTC)
Received: from localhost (unknown [10.39.195.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A693740C6EB9;
 Wed, 22 Nov 2023 16:50:40 +0000 (UTC)
Date: Wed, 22 Nov 2023 11:50:39 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PULL 0/6] riscv-to-apply queue
Message-ID: <20231122165039.GA72896@fedora>
References: <20231122053800.1531799-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1jigLDNtb7vv3367"
Content-Disposition: inline
In-Reply-To: <20231122053800.1531799-1-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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


--1jigLDNtb7vv3367
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--1jigLDNtb7vv3367
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVeMV8ACgkQnKSrs4Gr
c8iE9Qf7BRq30kvK8NQlSkIEVGijsDps0CqOkEV8lc1SoP3f/iBPpqb1sMhrb0c1
N0W07xVf2Juqz1oV19lDFLmfWj3uhM1i6tVMeCnvNqggEFt1nuO/7t2rznk6mRsR
qttU1ZjX1ql5Wl7jMQ+JB53/bJPokqqt7t+GnbC817YiBIIzarbKIzvqTTfMd56k
aTSZnWrIXWhrU9CAGvbfc1vdmdSwaSoVPQ+pK6nnSJDhpmOg7qz73a8NJZf3mtUR
KsX4HQHbX9NTNMfAtYJbaJFq0rcYYc9C3RQ/cBpHKt7GQhGHil7Z69DzbHGxFlkb
blYIIERGlY7WHxQ50yTi2btp/AA3Hw==
=Qpct
-----END PGP SIGNATURE-----

--1jigLDNtb7vv3367--



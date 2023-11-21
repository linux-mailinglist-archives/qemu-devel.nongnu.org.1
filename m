Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ECB7F344D
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 17:55:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5U1S-0000yC-99; Tue, 21 Nov 2023 11:54:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r5U1Q-0000xL-JW
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:54:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r5U1P-0007ba-52
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700585686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=230jSoP0O7DAeJciQV87GnNxL1nMPnDZkm29UsvPA1w=;
 b=XmK2XhiniaL5aFRy3Uhx7zSysEbsf92cT071F5/0LInKoKR3pziT//Ib+G2l82XURTEd/w
 hniSqaBejFhmjNdZbCNwz0q7OYe4nE6Xgktu+8tf6ZU00b44M4GeYwvi2WKscZIvwamFsh
 uCjmojLzHvR3CCGcCUbvbB1OSh84QtU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-0NH3GelXO1OJSGJngQuoVg-1; Tue, 21 Nov 2023 11:54:43 -0500
X-MC-Unique: 0NH3GelXO1OJSGJngQuoVg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF864811E98;
 Tue, 21 Nov 2023 16:54:42 +0000 (UTC)
Received: from localhost (unknown [10.39.192.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 561091C060AE;
 Tue, 21 Nov 2023 16:54:42 +0000 (UTC)
Date: Tue, 21 Nov 2023 11:54:41 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 Paul Durrant <paul@xen.org>
Subject: Re: [PULL for-8.2 0/2] xenfv queue
Message-ID: <20231121165441.GA3769149@fedora>
References: <20231121115957.1351656-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XmHU7bUfubIqA/6N"
Content-Disposition: inline
In-Reply-To: <20231121115957.1351656-1-dwmw2@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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


--XmHU7bUfubIqA/6N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--XmHU7bUfubIqA/6N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVc4NEACgkQnKSrs4Gr
c8gWUggAxygAvwhYWHqvrGZId+o86jPRn12AYTUjkNvcdl3JhRPvjc2Bnmkf/mOL
phCojCwJchift6VlkOF5M3JhTr7JM4G//zV6BgVdijI+7FN/ph1h6rErWaDXbGst
bvlGy70RxYs5g73LmH1mnVz7DFf4S2CRpfD8419VmDYzReFJxx+KyLxNw5Ger/1o
RhISmHxIqM3fyfjezqTx7Jx+eofO8dt99gxKACGBDT7akJqmQAmxex6eYAhbwKgr
/Iswe3o2dKF0kS6zLXrAAp0yhKJ6dSeYseKj3PpVNxs96RNa3QmLN/6ef9ECWoFG
9DODjuEeAlxmAwq5HHOfTvGkysaBCA==
=YCfM
-----END PGP SIGNATURE-----

--XmHU7bUfubIqA/6N--



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99668A7C21E
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Apr 2025 19:09:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0kWZ-0007dP-24; Fri, 04 Apr 2025 13:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u0kWW-0007cn-E2
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:08:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u0kWU-0005DQ-A2
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743786485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jd7EcQUdD8O6AwIhGmKzctsgvLSe64pSGA7GDY5LcrM=;
 b=TEkOWPL8XLSlxn38eYxiFlC8ynSmD3hYxmo24vxcFgE5qBe4ETGYWCHF4mpLPfKU85iR7P
 6jLGHJqbJkU2/CCpDYpUxGGQQ9I4P8/evdUJIUaD+OYpfxV2tYMTNUnGe3EbgEZCzWKKMP
 p4gJa549EplIvZUfsTPAs+trX8sxoA8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-9gkYri1HNeureoKdqum9Aw-1; Fri,
 04 Apr 2025 13:08:04 -0400
X-MC-Unique: 9gkYri1HNeureoKdqum9Aw-1
X-Mimecast-MFC-AGG-ID: 9gkYri1HNeureoKdqum9Aw_1743786483
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38FED195609F
 for <qemu-devel@nongnu.org>; Fri,  4 Apr 2025 17:08:03 +0000 (UTC)
Received: from localhost (unknown [10.2.16.156])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8FB80180B487; Fri,  4 Apr 2025 17:08:02 +0000 (UTC)
Date: Fri, 4 Apr 2025 13:08:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL -rce 0/1] NBD patches for 2025-04-03
Message-ID: <20250404170801.GA378951@fedora>
References: <20250403222139.1317475-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pymrPHYXy0knCfWo"
Content-Disposition: inline
In-Reply-To: <20250403222139.1317475-3-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--pymrPHYXy0knCfWo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--pymrPHYXy0knCfWo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfwEfEACgkQnKSrs4Gr
c8j8BQf/emKOTjrM7UsWK2ClXIOwlffHWS4v9zmYdW+h6xUE9LADxW44owj6vdrl
fa5vbFHwcHmpqFbh150U1kUakYBrHQyPk8BBhXFHfuAGTYi7jwKCB74Gbe6JNp7D
WYY7Xly7jDeaP1/HdezSla2GsM4XF7b0EWYuTPq/90tHNXM8Aw4U3aAdJ+mal2bE
fJa5873MyG84k+01jsDUwqlMy4Igi+h0KoD+Mlz9pAAb3BQyYKe3zYpis3Fr4R/y
C6iiJRtkrM2zRlVqvxeKfWpHByCvOW8mQm+JrSXngJtM+atPOwlmWeHkUqkt9n2b
Xt+dTHkgrma/n8+iImgUfWAGIDtCfA==
=cIrh
-----END PGP SIGNATURE-----

--pymrPHYXy0knCfWo--



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87711A76C58
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Mar 2025 19:00:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzIT5-0003jV-1b; Mon, 31 Mar 2025 12:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzIT2-0003iY-1c
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 12:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzISz-0005Bs-SC
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 12:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743440309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pX4zwjTbKaffbNwZjGhSgwrKM3cAqd54dDhMYQKgGoU=;
 b=RgmW8z7ELN51r/PDAiQicy4cwsvZKvTkWAsuFKwMwiZmx6dYPmhbeQTEnvq5+pwv6YUczc
 jPlJD2RqrSObCsXnl7UfX1rryi1Gf5KLaSIb470LdQmqDXPceqZeVbhkoEHwNFwfSup1Ak
 VhN5SemfYUWg3SSZq6i5OduzLXugp00=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-cJ2nXptLOvGUiVQ8p-sQcw-1; Mon,
 31 Mar 2025 12:58:24 -0400
X-MC-Unique: cJ2nXptLOvGUiVQ8p-sQcw-1
X-Mimecast-MFC-AGG-ID: cJ2nXptLOvGUiVQ8p-sQcw_1743440303
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 760E21954232; Mon, 31 Mar 2025 16:58:22 +0000 (UTC)
Received: from localhost (unknown [10.2.16.29])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5D621955BEF; Mon, 31 Mar 2025 16:58:19 +0000 (UTC)
Date: Mon, 31 Mar 2025 12:58:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: qemu-devel@nongnu.org, mjrosato@linux.ibm.com, schnelle@linux.ibm.com,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, fam@euphon.net,
 philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com
Subject: Re: [PATCH v2 3/3] block/nvme: Use QEMU PCI MMIO API
Message-ID: <20250331165818.GD190936@fedora>
References: <20250328190627.3025-1-alifm@linux.ibm.com>
 <20250328190627.3025-4-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nO0Opxt5Cwfpc2MN"
Content-Disposition: inline
In-Reply-To: <20250328190627.3025-4-alifm@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.198,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--nO0Opxt5Cwfpc2MN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 12:06:27PM -0700, Farhan Ali wrote:
> Use the QEMU PCI MMIO functions to read/write
> to NVMe registers, rather than directly accessing
> them.
>=20
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  block/nvme.c | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--nO0Opxt5Cwfpc2MN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfqyaoACgkQnKSrs4Gr
c8ii8AgAlKFZn1iQTNo2HVGZ0vow3c4Xgyabwmx4yaN3YnkjVtgnoJqKGCHmF9Fb
WBoJTLTW2EppiIjcA7P9QlEkAJjPWQZ4h7Ftr1NX/ddS7xfDoHtCi1aGEhmoX0Np
yIgv4UM/69jEgYq+iJhjuOjq8dlCYVQ+VRbL+fFUIGz6VXqr85yiGNy+L3sCaS5L
ntngyqZ0oO3HGu7q0txCDs3fPYyu+wG5p4FiXCTkdAhJRFTW2/rBnDF62zAbDuWv
nt4A0oCHlXxh9aYhZuntE/igeQemiHjpLNnucygpVP6qRIoIfmujWhdn2pYHnR0U
hywxK6/vFgZx5M4JMG6uFXkEe3mblw==
=pXO1
-----END PGP SIGNATURE-----

--nO0Opxt5Cwfpc2MN--



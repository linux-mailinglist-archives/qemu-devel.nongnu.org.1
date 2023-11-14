Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1C57EB58F
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:35:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2xIW-0002nI-PY; Tue, 14 Nov 2023 12:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r2xIT-0002lW-Mn
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:33:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r2xIS-0003XN-4E
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699983235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XfcCoJmqU4olGnLfFwqJneNta1zQ39Wd+S91LpZCcrM=;
 b=YxDZnk2sgasS6CcDrCUCMx/y7y9FWTvCJYnrJYBodI+H9G18oSxZ+/Dz5whMDhygAZ1DT7
 QBJ10vnAMjWMh/W0vK0zdSFbStVXvfOisbffarKyVA5UEZuiOgZx9EKO+tWqwTmHWRqB5B
 Q1/LtzcMv4ZaAD0PFoCbVgGILXXSYxo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-dUj_vo6hOASI-41To_8Vqg-1; Tue, 14 Nov 2023 12:33:53 -0500
X-MC-Unique: dUj_vo6hOASI-41To_8Vqg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FFD1833B4E
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 17:33:53 +0000 (UTC)
Received: from localhost (unknown [10.39.192.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFE5A2027047;
 Tue, 14 Nov 2023 17:33:52 +0000 (UTC)
Date: Tue, 14 Nov 2023 12:32:19 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/3] Fix s390x PV dumps in case of errors
Message-ID: <20231114173219.GA274066@fedora>
References: <20231114114318.158226-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aIOme1cTbc9t/0dF"
Content-Disposition: inline
In-Reply-To: <20231114114318.158226-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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


--aIOme1cTbc9t/0dF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--aIOme1cTbc9t/0dF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVTryMACgkQnKSrs4Gr
c8gBZwgAs9+GfWGgYKYipU+l1GtnyO2sAC9CrGsIAamwJcbWmxecLGhIH0sJ/imL
24g3uxGIJE0uAt8sg2YvFMbVgpPLsaPJN0nXyD4tAwe/rTpkOOZNQmwsA38rUioK
TvIpPL3hVBqw1vn54S3UzbDna/4FUQKtr3VXrUTkKxTkkDb1osRnNO1hkLwvfBZn
P5bxhEm0PpiUbQ4eduEchFLAa45jB/SJJEkac7Du3YrBduq4yqY7K8OFXk//XCkp
/iLHJTX2ELM2u1RHF1+llIQWTqTl+o6FnibfcEZw0DY3lerJ6k1YAZSsBRMuwWVD
A2+lNYSvsIbC39o9d8GNJBZFYrx8ig==
=XAcS
-----END PGP SIGNATURE-----

--aIOme1cTbc9t/0dF--



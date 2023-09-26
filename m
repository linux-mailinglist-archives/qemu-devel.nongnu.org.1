Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D117AF071
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:16:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAig-00012v-UH; Tue, 26 Sep 2023 12:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlAiW-00011a-TL
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:15:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlAiV-0003by-5w
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695744917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mvgqcjBcnfemgiDRI5uMm/RMWt1TvIcf9ZHXVOw18ZI=;
 b=gF0D0PGHFti+lXrqT+ieMiuku6uAmRkyTtZ+J5JrlAuhYnKa/Agwih/LJMxpwhZRuSCDS7
 FYBF+OZNI0+FwkCFSNRjpcwv5lT0WdvP5bf92FUIAIVzeVJxZR59jl1O8jmRanTBLtI6ND
 IlnvYS9japqK8WyX/Y2VQLdayTphWo8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-HvYYKPLINwmbVsJPeH2FLA-1; Tue, 26 Sep 2023 12:15:15 -0400
X-MC-Unique: HvYYKPLINwmbVsJPeH2FLA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FB458002B2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 16:15:15 +0000 (UTC)
Received: from localhost (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05A5940C2064;
 Tue, 26 Sep 2023 16:15:14 +0000 (UTC)
Date: Tue, 26 Sep 2023 12:15:13 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/7] NBD patches through 2023-09-25
Message-ID: <20230926161513.GA392111@fedora>
References: <20230925190114.3163545-9-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="scHYHYY6QEUe4gw5"
Content-Disposition: inline
In-Reply-To: <20230925190114.3163545-9-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--scHYHYY6QEUe4gw5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--scHYHYY6QEUe4gw5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUTA5EACgkQnKSrs4Gr
c8gobQgAmsCJN9jLAYSsHLGTz3wiXY946NOVROP6Af5X1I+zl5chYZJqT1XyO+m1
TSZgwn04kquLpZehZOb1InmDuQG6+6NC0XEz8vlDzXQcLhyz67wTYy9ikfExRMPY
jZ1sUPVECkTgL5ceT41e41ddVw7xInOJP7+Tkmr7ZPAnUSlQ5yMpzrCYuI9dmNk6
5tBdIDtiIMQRHiohEbHEfK9oQqV4sQcnwfhmftLbDX4HbWUzZuxk8XPn56UR12z5
nkmF6fbDdL1P6iHQQatKzUb8VdMrHdHTwcM5NiMpQwrLyq63HXX3y9IQ9dE6UewL
9+4tGovPRvQx5i/v3v0JO43jpeZZxg==
=yJWZ
-----END PGP SIGNATURE-----

--scHYHYY6QEUe4gw5--



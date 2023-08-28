Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D248778BA0D
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 23:15:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qajZg-0001h1-Hw; Mon, 28 Aug 2023 17:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qajZc-0001dM-V2
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 17:15:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qajZa-0002BQ-MZ
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 17:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693257297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kTSGVQK1MN1xr8YAlWXI0svKS1b4AyefsN/umjFMWSI=;
 b=Whtu9BBne03HmZBUgh/UTl6ClXjvxd4VitHQ0FNcfBaSYElII5win9+tIK5godqcM3owxU
 hjDVU8bscpYifnb2F1SXquW97qEfcLhtOrE6Tf3bFANuU4/qj/za12MyigxYD917lxf15g
 cl5tNR8bt/7hnn/Wb4/NXjz4hQ3hjZA=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-y9wdRVgPPxqr26MjMKBw_w-1; Mon, 28 Aug 2023 17:14:55 -0400
X-MC-Unique: y9wdRVgPPxqr26MjMKBw_w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26E19381BE82
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 21:14:55 +0000 (UTC)
Received: from localhost (unknown [10.39.192.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1FFB401051;
 Mon, 28 Aug 2023 21:14:54 +0000 (UTC)
Date: Mon, 28 Aug 2023 17:14:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/14] Python, i386 changes for 2023-08-28
Message-ID: <20230828211453.GA70619@fedora>
References: <20230828103856.46031-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3FfJAj/pRlxDQIe+"
Content-Disposition: inline
In-Reply-To: <20230828103856.46031-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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


--3FfJAj/pRlxDQIe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--3FfJAj/pRlxDQIe+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTtDk0ACgkQnKSrs4Gr
c8gy/wgAmoMYfGvWxqesZ1WJ6SJVf04lyLreDZ+JSauub3GW1naINJQtCllSzMTd
85di5TgkAmo0qnGZJn3Aj/HWog6MwJY60tLrB+1ECc11z3xjqn+tKTnEcUQ4zhrP
rr5AYdDFU/WoQ96ZS2uBEY1BUHwjmEyywQXLLOGTAEoN9rsYb3L8geB3mNhhoq/i
sTxRKt+MRORpdCoe+PnzWXXfv7Fz+hhvXW4UvPLCWLSkgwIkp6ATtVWGw2MAiGxW
KzO14SnsnGBEqEGosH+gBYeYDnYfBG9TdUTa5kC5pPDpHuOmVdgYLiTaz0aAYXRd
yFbNtwasJ8sCSSdYFRDJrz3Zz/vj6g==
=39PM
-----END PGP SIGNATURE-----

--3FfJAj/pRlxDQIe+--



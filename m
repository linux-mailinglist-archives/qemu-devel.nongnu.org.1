Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CC47F15DF
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 15:40:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55R9-0002v3-N6; Mon, 20 Nov 2023 09:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r55R7-0002sF-Ai
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 09:39:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r55R5-0004N7-Dc
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 09:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700491178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H4KyHPNSxoREmrXhGRxcvMF9gW/NrbADTHnCGz++ENE=;
 b=RUbIUcS7LBCCsk+wtzoB1BMLLP11U+fcJ3S2d4OMJtHaV4ZvOM5mODgWEeDQKYtyydDb//
 xrQ6GI6I5O8rXdK5enZOGsCOKvfEYzJ4tEGLb+A4AhlWozC2dYwKdD36JdbRRyvZGEYcg+
 FWLN9QOx5i37hx4jmYKxZHM8c0euWBA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-eqCOmvGfPbmCk7jYZIUepw-1; Mon,
 20 Nov 2023 09:39:36 -0500
X-MC-Unique: eqCOmvGfPbmCk7jYZIUepw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64B6A3C000A2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 14:39:36 +0000 (UTC)
Received: from localhost (unknown [10.39.195.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1861492BE0;
 Mon, 20 Nov 2023 14:39:35 +0000 (UTC)
Date: Mon, 20 Nov 2023 09:39:34 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 00/10] Avocado test fixes
Message-ID: <20231120143934.GA568811@fedora>
References: <20231116180534.566469-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="v13GqDdLTDOCtBSx"
Content-Disposition: inline
In-Reply-To: <20231116180534.566469-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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


--v13GqDdLTDOCtBSx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--v13GqDdLTDOCtBSx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVbb6YACgkQnKSrs4Gr
c8hyewf/Tw3cOztMXNnkPQcb1J9Zy483CafBQT1sD+hG5XPU5U1+IIBd6rz5N9vN
yX2P2/Y0hOD/F1ljvVYpnDq1gky46po/MHIn+0TbgNUcWdHJJqWWkx6Aut4mZtAJ
XLD5IQX1XbXtUsfLkgJEjp5ejKraW8JUDiZAqXXhJVvDUfi4y6L0wfefyjwhVW+C
rFgGsi/EDqLEAYX66WQ4dGlq5O5pp1o3A5zD5gDMrYMS5aoHLgJ6DNFd7hWWxSK4
MzR7uKoDxbn94ODDiWUD39ko4pZ24IbEJ/LIij+sslODeAFVxpD4ugz3TmX/wknr
I0B2tAOB4dMvlntXThBIinG+OhiWog==
=4SXt
-----END PGP SIGNATURE-----

--v13GqDdLTDOCtBSx--



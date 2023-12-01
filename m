Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC05802631
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 19:18:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9r1y-00085T-RP; Sun, 03 Dec 2023 13:17:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r9r1x-00084p-Cl
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 13:17:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r9r1v-0002jS-K9
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 13:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701627443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CQwOmKSDHqSbYqJbyrVCw2BKBdmrc0ljEREdqrlWUdc=;
 b=a6U0D/9U/HwQOVzUdq9oMtyRO3rpNQcIaYRT0W3IpE1fZOpgC3UQdWPk95nNyOULW/QqAa
 GSVsnWkMc3IPkHWLdmBxv2g3Wtu4hEpHK0//M+SG7/t1A1X3mriHBvZDOOfs0XgjnMUFYl
 uze4m/fG46KnHgp1tUILBXh/j9qT7PI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-6p5OeGSTOpi-Ad4ORLSVKQ-1; Sun,
 03 Dec 2023 13:17:19 -0500
X-MC-Unique: 6p5OeGSTOpi-Ad4ORLSVKQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31EF63C0E202;
 Sun,  3 Dec 2023 18:17:19 +0000 (UTC)
Received: from localhost (unknown [10.39.192.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0D3910E46;
 Sun,  3 Dec 2023 18:17:18 +0000 (UTC)
Date: Fri, 1 Dec 2023 14:58:13 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PULL 0/2] ppc-for-8.2 queue
Message-ID: <20231201195813.GA1269774@fedora>
References: <20231130124111.109602-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LvpEIKQqw63mZu8k"
Content-Disposition: inline
In-Reply-To: <20231130124111.109602-1-npiggin@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--LvpEIKQqw63mZu8k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--LvpEIKQqw63mZu8k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVqOtUACgkQnKSrs4Gr
c8jXjggArtZHU8u1cRqoP0xqc3blVve4HnOpzPsfqCPthnPzVnIxIcTXfCOq2Dan
KHcP8eUaFZCLklp0bEEiu7Nhpcmj8VNjMfM5dwWWLc/NdyEXG49ObL4HWZX6mWsR
55VeJAIqA9L0qEKfCdnjbCd+w7BpjXwfBWi670bxjgYVSI41VXOo2y5UhZvBXhlv
XNOcbbVtl524EjYKk0GB8dQzfQLLgrpP5VqOLVDpbh8gjKHK6NcLUchLxaxXSU7O
8GN3EuQUUFZoT8FjjTmdp4eGjCD68202gbKNKSFtrgWf5GTRtsSMhecUWscYvCNL
lUxNr3C2irpNxUnF2WLXUW11Kx+OYQ==
=kTEs
-----END PGP SIGNATURE-----

--LvpEIKQqw63mZu8k--



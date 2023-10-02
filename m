Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1DC7B5CAC
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 23:57:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnQuB-0008Rg-5N; Mon, 02 Oct 2023 17:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qnQu8-0008RH-Qv
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 17:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qnQu7-0000mY-HP
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 17:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696283797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eowbZoH8AmHoAgOp8X4I/FOmbAg7roXVr+9McpfM004=;
 b=Oe964DBVPpkzXZ2gT1z/LDipwzL3Ybx3k+yuTFDNtF5B46BaRC1EJyVS3vIiR3io4O30Ll
 i3Gnw0JoYuH7EOQihjJbU7m5nRsKGMwvnjXBasOikpUoAfEhMUruX4yk4PkYlEpFMSaZko
 +LaizF8SJ32ggHym35kXkACioXao5hc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-V8-r_K2SMI2bwqeiuG95mQ-1; Mon, 02 Oct 2023 17:56:35 -0400
X-MC-Unique: V8-r_K2SMI2bwqeiuG95mQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 981853C0DF69;
 Mon,  2 Oct 2023 21:56:35 +0000 (UTC)
Received: from localhost (unknown [10.39.192.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A14651E3;
 Mon,  2 Oct 2023 21:56:34 +0000 (UTC)
Date: Mon, 2 Oct 2023 17:56:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 00/14] Tracing patches
Message-ID: <20231002215633.GA1077489@fedora>
References: <20230928134407.568453-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6hfyeAaT4J+PMyuP"
Content-Disposition: inline
In-Reply-To: <20230928134407.568453-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--6hfyeAaT4J+PMyuP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--6hfyeAaT4J+PMyuP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUbPJEACgkQnKSrs4Gr
c8gu7Qf/dZe2mZ6Q1JfMh0iRwVuZzEPuSY0qi4zw459R/WWLMQFV1ZWJbDtChTPp
XZaZeiWKCOb9GldNHhrQRzgCqr4yv5zc1ZZqAw7GYF+280LOJtR9GMhr8oozLHVu
iYN4MKfjBF/wX7A0lDRlvrRhlS8Mq9EdkszhDJOsLHEfr9Uky34+vaeHKQLgEVkq
mT/cRa0sIsBW4ymN8sU08dRYVojVdY01a8gSKTGadCaGPneytLkVV9yWlM6gQ4Cs
gVKYvyI+A9N2UY1OUajV8exzXQHiVTf8Amp3/pFo9fqZTNIvwahcMdShU+SQqzGl
OCQGYXme0OR2jN+sc2OEfJ66YgXvlA==
=uxLQ
-----END PGP SIGNATURE-----

--6hfyeAaT4J+PMyuP--



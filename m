Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D587C5A45
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 19:34:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqd4T-0007XG-IN; Wed, 11 Oct 2023 13:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qqd4Q-0007WR-2Y
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 13:32:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qqd4O-00011K-K1
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 13:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697045547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5nktvBWpS4cJASwS64lXIYzgRdko7Iw20GfQyLCY5TE=;
 b=GgjYKwFknisPoaxB4pUMhImqCUp8EPbMS0Tw8HRK+ZK9HHW9ZOPh+nvoBMYwi2nPiQeoWS
 BGO3hlBAHLegAfdxmC5xxR3gLjCz+TW1UaHjzvyQGeyReQKKKkrbsvTz+25SNMZ510qOdl
 h7rPE/3LtmhJuKsjs4FuWl2ynmKJ/Ec=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-mjsTyvv0OB6k9j8Kz98u6g-1; Wed, 11 Oct 2023 13:32:23 -0400
X-MC-Unique: mjsTyvv0OB6k9j8Kz98u6g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79A32811E92;
 Wed, 11 Oct 2023 17:32:23 +0000 (UTC)
Received: from localhost (unknown [10.39.192.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8F981B94;
 Wed, 11 Oct 2023 17:32:22 +0000 (UTC)
Date: Wed, 11 Oct 2023 13:04:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, stefanha@redhat.com,
 vr_qemu@t-online.de,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL 0/8] Audio patches
Message-ID: <20231011170416.GA13280@fedora>
References: <20231011063101.258955-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BcyxpoWB09x1cMvA"
Content-Disposition: inline
In-Reply-To: <20231011063101.258955-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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


--BcyxpoWB09x1cMvA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--BcyxpoWB09x1cMvA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUm1Y8ACgkQnKSrs4Gr
c8gO3Qf/Wek9iAxPkwNGT2qLzeJ0opDhvVRiT5tpdQuwgql7mi5QOkjfxPxdHJbv
R2Yca6Mcu7CWhxW/34q2ySyUrNxUWg/1YEOvWvzVGKrQ1hNJ2s4jh1fd6pF5i3+z
rGk8KabKUGfsqjYBdponZBkZf4J1ptWC3mTx0/XuwVHYAKG6bAx2/PzLtYoo7LIE
NZl4hgZS3jCEJiEaogphiRTrq5hB7SKRQf0Pe7MzLhaKVmL6ahhw+RGVYGzhsI4r
3JEgqeP5Hsg0zYiVWL9h4yGLJVVIh68beprEWOU3fwMnXluAZsFFnS0FltM1BVQt
Cp7KR5DDsC7aLS966Yaugzj6I3L4uA==
=67eP
-----END PGP SIGNATURE-----

--BcyxpoWB09x1cMvA--



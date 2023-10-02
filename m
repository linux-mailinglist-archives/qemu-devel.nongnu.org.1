Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD9A7B5CAE
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 23:58:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnQux-0000uI-Ft; Mon, 02 Oct 2023 17:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qnQuv-0000lL-CK
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 17:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qnQus-0000w7-ED
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 17:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696283845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xDycW7eiSuBGdrxgOgXAhS9xRl/AZerAWj20tigifvM=;
 b=hdNNxv0mkxLuQ2Rti0IR4LVVTOqeWmlVE/zOcRscCOh0ArIZbrQKHV8+00jzpk9r970joY
 d38V76gQoDsf/gVn//XKTK1+3JkxvD34M3um7VsoVytWhqeuRPtr0Nb73Ib98FBJlCuPxa
 IKzLQ5u2EpWqlokUQmaKlUGEu+EZPtc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-4kWRg6s4N3qDuv2mAL2Qfw-1; Mon, 02 Oct 2023 17:57:23 -0400
X-MC-Unique: 4kWRg6s4N3qDuv2mAL2Qfw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80166101A53B;
 Mon,  2 Oct 2023 21:57:23 +0000 (UTC)
Received: from localhost (unknown [10.39.192.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6B9D51E3;
 Mon,  2 Oct 2023 21:57:22 +0000 (UTC)
Date: Mon, 2 Oct 2023 17:57:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 00/13] Migration 20231002 patches
Message-ID: <20231002215721.GA1077685@fedora>
References: <20231002122021.231959-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Pq8zcwJ1rSX7Bb1o"
Content-Disposition: inline
In-Reply-To: <20231002122021.231959-1-quintela@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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


--Pq8zcwJ1rSX7Bb1o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--Pq8zcwJ1rSX7Bb1o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUbPMEACgkQnKSrs4Gr
c8i6HQf+LuM/6cERYUP4VOWlV2OPQnoRHWL9pLGPFJEHYI6mJMgruBCrZLJLTlc+
ZaZaFoUCglYiZge8WRJ9DeqOTh4y3TOuJMEtdFfoQBLjs6KG3dAQHHYzUsbCEVFZ
32E94KTwlVwo896AJ1yDZq0BrSvbC2vEGM0sC3+BMwgJPAV/INDYGA2uYAC40sx4
DY3UEWXkyh0vm7zk38BmGq1K6vKJ7WaeE4MbXpHCgB1v5XCl1EvSYw4De+kmMzyb
APL+ytrJJIoyw+xkvhPgl9vr0ZU91qnspjCuGXY8OqRLRnFlaeaemcqabAabCRxO
ogef0SVRLasIQAPioKhtckFwZt5RMw==
=DPPJ
-----END PGP SIGNATURE-----

--Pq8zcwJ1rSX7Bb1o--



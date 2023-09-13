Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B9379F1D5
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 21:18:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgVMe-00037O-LG; Wed, 13 Sep 2023 15:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgVMb-000369-57
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgVMY-00011U-RR
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694632641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oErGKquxoF83dQ8j85SaOODkqW7g1/8xPkbJzGxI6pQ=;
 b=Je5+lLUCUEue6oNUyFEb/W1meSiSP8iCoZD9FruTMp5N5q91E5R+XnLEVmn0dCvwpJpuEb
 8yB/SDj6kaFhsbY3YxC5o640NaZUqCHP6Cpm8TOTEH460wPO1UotDzMm/rfEdKMnCdTASR
 5lSHrPjrzdvUGQerLJvsZWXwMjAWiXk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-6cmCpDyIPAq6E1mbhgsDaA-1; Wed, 13 Sep 2023 15:17:18 -0400
X-MC-Unique: 6cmCpDyIPAq6E1mbhgsDaA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6ADA7800159;
 Wed, 13 Sep 2023 19:17:17 +0000 (UTC)
Received: from localhost (unknown [10.39.192.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDFD2422E0;
 Wed, 13 Sep 2023 19:17:16 +0000 (UTC)
Date: Wed, 13 Sep 2023 15:17:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PULL 0/2] hw/nvme: updates
Message-ID: <20230913191715.GA916778@fedora>
References: <20230912142649.11002-4-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sUmmj/iElKgjvqh+"
Content-Disposition: inline
In-Reply-To: <20230912142649.11002-4-its@irrelevant.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--sUmmj/iElKgjvqh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--sUmmj/iElKgjvqh+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUCCrsACgkQnKSrs4Gr
c8jIowgAosXf8tL1603RzxALv7iFxkQP0tq4YPsOzsA9W6Ex7tF2YhQNEU3GyTFS
iwOXzngXZyUd+uMz2Kop1YA74qxNo0VzpSYnvclvZSGUCWCOVZWyQujk67mLPehN
rFTEADtIn4/DOszBhRvo8saphJKR28XDrzl1H8uDs+Hx3QQuJGMn6ugQR1oIKhrp
3POd7iBffmiqmbnC9SKAVby3JmS5F+qVJ0KYCrf9o7GKOV4vCuRXKrhLY8km9H3P
dxDSvbniML7rP4+e96/+h5tBjFDRBg50XjK62YHNIrId0CVvTpipF3tNxASWCGsU
lSa9Ks/aeCqEXwLfVFkFyN8WpuXuww==
=jrB0
-----END PGP SIGNATURE-----

--sUmmj/iElKgjvqh+--



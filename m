Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 667FE763FE5
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 21:43:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOkIQ-0001yc-PY; Wed, 26 Jul 2023 15:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOkIO-0001xz-KN
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 15:35:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOkIM-0002eU-L8
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 15:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690400137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EueTcgHbq2KBrOBOoY7GYyqAfL+eKBS4G8p/BX1i7dE=;
 b=G9hb3RMX60oXZycsf6BbpIcoHpwBatRRbv+kis4fd1RjcGNFDxock71hFYXkLt7A1W374W
 BRwPMtA8vbMeQ9NJiNbDD8PvDTB26rmGwcJ4s4tz2NWlIA85jh7q23rLc/t2IH3aGQFPIg
 aj8iyN2AX2GHja+vyqZgFzUVtm2X0Iw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-1RW3FR51PdWn89nOXNicYg-1; Wed, 26 Jul 2023 15:35:34 -0400
X-MC-Unique: 1RW3FR51PdWn89nOXNicYg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21A8280269A;
 Wed, 26 Jul 2023 19:35:33 +0000 (UTC)
Received: from localhost (unknown [10.39.195.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A361C2C7D3;
 Wed, 26 Jul 2023 19:35:31 +0000 (UTC)
Date: Wed, 26 Jul 2023 15:35:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, hreitz@redhat.com,
 k.jensen@samsung.com, kwolf@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 mst@redhat.com, philmd@linaro.org, thuth@redhat.com,
 lvivier@redhat.com, jeuk20.kim@samsung.com
Subject: Re: [PATCH v7 4/4] tests/qtest: Introduce tests for UFS
Message-ID: <20230726193530.GC822884@fedora>
References: <cover.1690348453.git.jeuk20.kim@samsung.com>
 <ebc4e4c699a43724319fda275a71db3ab6b6c0f7.1690348453.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/KMVMkH9DbKz2AVS"
Content-Disposition: inline
In-Reply-To: <ebc4e4c699a43724319fda275a71db3ab6b6c0f7.1690348453.git.jeuk20.kim@samsung.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--/KMVMkH9DbKz2AVS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 26, 2023 at 02:30:53PM +0900, Jeuk Kim wrote:
> +static void *ufs_blk_test_setup(GString *cmd_line, void *arg)
> +{
> +    char *tmp_path = drive_create();
> +
> +    g_string_append_printf(cmd_line,
> +                           " -drive if=none,id=drv1,file=%s,"
> +                           "format=raw,auto-read-only=off "

The newer -blockdev syntax can be used:

-blockdev file,filename=%s,node-name=drv1

> +static void ufs_register_nodes(void)
> +{
> +    QOSGraphEdgeOptions edge_opts = {
> +        .before_cmd_line = "-drive id=drv0,if=none,file=null-co://,"
> +                           "file.read-zeroes=on,format=raw",

-blockdev null-co,node-name=drv0,read-zeroes=on

--/KMVMkH9DbKz2AVS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTBdYIACgkQnKSrs4Gr
c8hUawgAkz0B6UkfRaxedIOXdc4sNa1thr78ExlgWyjIWIK4Pmhh2JDkYT8YUq3O
1S1NvqSXV+avQ7B3FsC4jwhqUpkBU0pFmyOoOrQ5GSrq+UNCotjHUlNUE9CJ2fQF
EqSGZiWSfahjcDrBWmLjCzaWQx6t1R/OCDbrhSiz++a0iFPSgGAJxk/dzvgAOVc1
97aXstJ0k/BmNm8j3iwM+RwHVXz8uGu12RLQxgvz3lrtwNFN0IRITOYTQ4lmBAmz
Q2gRaxRiy7seuqRIe6QC/KGoBUxRLUrTPamcTByNnz1BK1R6anFcVvk4pBEtZUU3
pf1ydpEXNIZltgch3bhPL5eTamBBeg==
=sqDx
-----END PGP SIGNATURE-----

--/KMVMkH9DbKz2AVS--



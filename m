Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BECB7CB345
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 21:20:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsT8R-0005xE-6W; Mon, 16 Oct 2023 15:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qsT8M-0005vq-VE
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 15:20:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qsT8K-0005RN-1k
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 15:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697484006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6CIzGPn6swpsu62Z3K+yCjI97p5XBvqBUyIDMPLGJRI=;
 b=SYxDBpsXYfvXVV4XQoptBQnwtWIhahxWXbm2RWbeJYaCRWNlXz9Gbv8I/naShIrvSt+d2d
 gJkSD2WDLeTrJuYNOlcDzYECJP9K4rqIhXmPty6BD8/vs5V13ifqgC7MitqcMr60Xt47mf
 aRCFzrIdLFgTIdZzE/JInHam6YEw7vs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-We5iG1g6Mn6sWnvj1e72nQ-1; Mon, 16 Oct 2023 15:19:54 -0400
X-MC-Unique: We5iG1g6Mn6sWnvj1e72nQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 367C1862F1D
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 19:19:53 +0000 (UTC)
Received: from localhost (unknown [10.39.195.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE35663F45;
 Mon, 16 Oct 2023 19:19:52 +0000 (UTC)
Date: Mon, 16 Oct 2023 15:19:51 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Subject: Re: [GIT PULL 00/18] Host Memory Backends and Memory devices queue
 2023-10-12
Message-ID: <20231016191951.GA161146@fedora>
References: <20231012143655.114631-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mOR7/bbLR3Z8I647"
Content-Disposition: inline
In-Reply-To: <20231012143655.114631-1-david@redhat.com>
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


--mOR7/bbLR3Z8I647
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--mOR7/bbLR3Z8I647
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUtjNcACgkQnKSrs4Gr
c8jvsgf/dAvRq25QDCz34LIwSZthiTrMsUQ17UZzA5PZDh5bmOaIkuVhd7rSd9wT
IcFXgZlpcVciJgnXMBl2HyJbXXS2JUIVYHMCgYwBs3Axlh/jZXhSBi/XbWejC0bV
IWjst/rcTxE4WuP0RS9hp8VSSrUv+lnPMoMTiG4cVqYskp8/jBrZRO5b5UyK09dM
YyFw2KI8MU42WdPo8miUsXm+4OZr55CslDOLgW2AwiU6zUC8AGNgZ9RxdZi+LQX+
AJVrIz4Va3hqasOVV14WD+P5VEJD/XTStDNgGi4tYDV0VyiDVB9hk+O7Re/DGSuX
9QUSjyww8W1Zdaly8MU//wJ+kK5udA==
=V5fq
-----END PGP SIGNATURE-----

--mOR7/bbLR3Z8I647--



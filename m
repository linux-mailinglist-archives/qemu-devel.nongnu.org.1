Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5547B9D16
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 14:54:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoNqk-00029W-JQ; Thu, 05 Oct 2023 08:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoNqi-00028R-Rk
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:53:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoNqh-0005hA-Ah
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696510382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uvxf8aSruumOJxmIl8bC/sjD/bexuZ5gfLymUlNUHIE=;
 b=jEhmeF0Fse2pj4sUYhafZHKX4Q3SdVhQ7MWYLKXn9IUMLTCPx6BhIEGDX5nQ7mZcUMkSRK
 J5YIDxbxRAuLkvpJ6DAxEP8uWlzZs49FGduCdpiMVlENXLXx06aH2q8rTmPyLoqDUn9FUv
 8jhq7IXsJU6cgTcbrTKSsp5OcjVr160=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-AXgfTZB4OlyT_vmaSl9H4A-1; Thu, 05 Oct 2023 08:52:49 -0400
X-MC-Unique: AXgfTZB4OlyT_vmaSl9H4A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3285F101B048;
 Thu,  5 Oct 2023 12:52:49 +0000 (UTC)
Received: from localhost (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A59BF215670B;
 Thu,  5 Oct 2023 12:52:48 +0000 (UTC)
Date: Wed, 4 Oct 2023 14:33:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org
Subject: Re: [PULL 00/11] Migration 20231004 patches
Message-ID: <20231004183341.GA1287848@fedora>
References: <20231004124038.16002-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Xja7rYUnP0ajOW3x"
Content-Disposition: inline
In-Reply-To: <20231004124038.16002-1-quintela@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


--Xja7rYUnP0ajOW3x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--Xja7rYUnP0ajOW3x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUdsAUACgkQnKSrs4Gr
c8hxnwf9FiXwvBlbFU0Uawt1ilUcW9paFXY7PSq07D59LrKc5qmVlJPbeXt8zSKQ
ZrUxEnjX66HBaFdEFRA5joT9Y2XjIDDJLmk/ezfBMq2Ri32XsYQv4wj8K7d06xhF
IWDAW4ZrVJb4538gHlaub9271Jf0s0XhLN1VEsqxbLtiUCyuqEkk3dR1OJ5BSjKn
qkl/VnvcbthCWYSwkStscjLzHOn1v3gKDSVq97JFBZWUjnJ1WT+CgwbgD4I5SWTQ
BF4DRCFIqmaM3h3rkxxxOl3HVNNVWHf0VrPT1MgtpAxuHUCyGYuP01gFu13YWwFP
rVFDIRswX2qNBrkSmP5m/Zf9lyrPqQ==
=khb3
-----END PGP SIGNATURE-----

--Xja7rYUnP0ajOW3x--



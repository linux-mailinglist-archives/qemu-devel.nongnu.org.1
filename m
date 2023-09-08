Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76973799E94
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 15:59:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfKwd-0000ae-Sx; Sun, 10 Sep 2023 09:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qfKwZ-0000YK-MJ
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 09:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qfKwW-000564-OS
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 09:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694354259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iM/Vf5QtpYjt99TDxu42IqcTFGcsXfEv/uW7B6QpOgA=;
 b=M+nx1l8KsxEjOHdwjnclqVj/f6pocfKGgUGoOlxPjCi15hIYOLZoUM2aQClmX0tkOsVmGq
 t/yllgtJYOrITkGl5gNKYYtsz0vYev6f2+SpJfhy7S7ycCbPC+s1IixBvOTkeEiPi6iV2/
 463Erll0FiuTBr5oN7AhQ67ZPS+u0kI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-1WBampKmN6WFjpwnlPvPUg-1; Sun, 10 Sep 2023 09:57:34 -0400
X-MC-Unique: 1WBampKmN6WFjpwnlPvPUg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7352D816521;
 Sun, 10 Sep 2023 13:57:34 +0000 (UTC)
Received: from localhost (unknown [10.39.192.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B74B2017E87;
 Sun, 10 Sep 2023 13:57:32 +0000 (UTC)
Date: Fri, 8 Sep 2023 11:55:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Jeuk Kim <jeuk20.kim@samsung.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/5] Block patches
Message-ID: <20230908155512.GA3575110@fedora>
References: <20230907181628.1594401-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CSdkUvysbeOhsn8F"
Content-Disposition: inline
In-Reply-To: <20230907181628.1594401-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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


--CSdkUvysbeOhsn8F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--CSdkUvysbeOhsn8F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT7Q+AACgkQnKSrs4Gr
c8hleAgArKhLEwlDOvjQX4WwCGontaT6IMjghzoyMqPNjuQlAu+Hn8lRFQBvwOG4
JcbWDV0NlbZEk9HtwuZaghVSRS4CY6puN32h6/VLZoQE/cVpVXZ0nCqKRrz3K3dI
OcBHy+eP4amzy9JnDaOCscvKhRs+SWDYZ4R4av2xSHp0v8Iy+hO6pr7VOIK6BI9H
IuVufP0vr8O4KpdPZh4vvGzagN3pBL71UxyrwZ/B9173cGUbqgRyh4lm7FROSxK+
QZELLW9IAPSyB1yt+6YYoO5zUTZWUVcxrM/RPlKXU7oNJquABQH96kHGLEnuP+kw
xLs8MgA/27FIg88LxMF4Y2L1Wo53Wg==
=gf8G
-----END PGP SIGNATURE-----

--CSdkUvysbeOhsn8F--



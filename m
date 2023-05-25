Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90434711399
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:21:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FZr-0002gD-C6; Thu, 25 May 2023 14:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2FZp-0002ev-8m
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2FZn-0000T9-RQ
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685038839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JG/Tzio0TA6sof9Ms9wVzivAbTmZ7sd8afw77Cggp3w=;
 b=C4qd4EoH6PgQFG9Yn5Q8S+4vEEiyNmpSzR9eNW5PdosQHUeIGcteSYfN2TfEsC0wmiOrQj
 Zry1q4lWztgb0Koy7X7WLLqoRTcwf0u1+5jQ7QOBMArxg4aU1omzq3bNA+mRvBgCGRNKLr
 zVutXGPF6JeVKIE6Yx8Vk91em5PFQZY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-MNp46OTcO8Szjsq-BmN_kw-1; Thu, 25 May 2023 14:20:35 -0400
X-MC-Unique: MNp46OTcO8Szjsq-BmN_kw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E386B80331C;
 Thu, 25 May 2023 18:20:34 +0000 (UTC)
Received: from localhost (unknown [10.39.192.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 736D340C6CDD;
 Thu, 25 May 2023 18:20:34 +0000 (UTC)
Date: Thu, 25 May 2023 14:20:32 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 03/12] block: Take main AioContext lock when calling
 bdrv_open()
Message-ID: <20230525182032.GE132697@fedora>
References: <20230525124713.401149-1-kwolf@redhat.com>
 <20230525124713.401149-4-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+q18cXZmenuX6Q9/"
Content-Disposition: inline
In-Reply-To: <20230525124713.401149-4-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--+q18cXZmenuX6Q9/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 25, 2023 at 02:47:04PM +0200, Kevin Wolf wrote:
> The function documentation already says that all callers must hold the
> main AioContext lock, but not all of them do. This can cause assertion
> failures when functions called by bdrv_open() try to drop the lock. Fix
> a few more callers to take the lock before calling bdrv_open().

Did you audit the code to check that there are no cases where
aio_context_acquire() is now called twice, leading to aio_poll() hangs?

Otherwise:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+q18cXZmenuX6Q9/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRvpvAACgkQnKSrs4Gr
c8gPRggAlSTrUgERtst4xV9HH4ZHpZAjINGHIYKUYbUPa4aW5zaujM80YoLKKKo+
XxExgkSs/lFSuweebh6FNramgYgpHB+idi8K78IOKP+6i0HxzOTwT4XOSlEF9BhM
vxckHqyYz2QtF86o0FreFs1+X+Hnflw1vr2Ku8trBrJbRN0uotPNPWMovXrCW1ZG
SvJ08R4jpAWbUwuM2gON4tRX1X20rSSS5xtpMEUtCC3bBZB24iBbbIMcskpt8WBn
dYIQqqMz3o+4vj7O+4937tzC+J8YwCaE82oAigZFoK+KiBKNM//PlNsdfw4IcxRp
K4rbIAym0ZCF0ABZ8D65flr95CYa0Q==
=KbT+
-----END PGP SIGNATURE-----

--+q18cXZmenuX6Q9/--



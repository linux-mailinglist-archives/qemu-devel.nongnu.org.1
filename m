Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6D87871BA
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 16:37:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZBP1-00082w-Le; Thu, 24 Aug 2023 10:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZBOq-00081X-Pz
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 10:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZBOn-0001A1-8T
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 10:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692887603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=185vevJbQfjJITDM/pguKzBdTC3zOWC/NWL1ro1JUf4=;
 b=e8YyhLwWuusYXKG/6KU4/CsDXCKQ5FVzrOONjHKOxgH5ggB4d2JH2rfcTV8o//TI/6p1uk
 mbUWLyBymaRhgf0Ib8AbbuCB1+6TaXWKef6y+JUaKrZiELRnF8gTc/yPj3ms9YMZnwkjyE
 QpmnH6b2WwzKZT3+GXe8mYlh2MYkM5c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-E6p1PcrLNA6dknovZPLzaA-1; Thu, 24 Aug 2023 10:33:20 -0400
X-MC-Unique: E6p1PcrLNA6dknovZPLzaA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 495E085CCEE;
 Thu, 24 Aug 2023 14:33:19 +0000 (UTC)
Received: from localhost (unknown [10.39.194.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B45DC1602B;
 Thu, 24 Aug 2023 14:33:18 +0000 (UTC)
Date: Thu, 24 Aug 2023 10:33:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>
Subject: Re: [PATCH] .gitlab-ci.d/cirrus.yml: Update FreeBSD to v13.2
Message-ID: <20230824143317.GA1430203@fedora>
References: <20230823144533.230477-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="b5ywIkFz32uab6au"
Content-Disposition: inline
In-Reply-To: <20230823144533.230477-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--b5ywIkFz32uab6au
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--b5ywIkFz32uab6au
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTnaiwACgkQnKSrs4Gr
c8giowf+OyKfbxPh0hzWv15RyiyraixeZAWEEcmWXwjOrhatxhDdc7+KWsFj45s1
C2UBg0gMHDt2IQyRx3/eEakIUOMWFtcD4W8uDlqfMrCHq6S6TmbNOvDlBEHYEWuz
hv3SrTbusy8XCZ7lfHoxYjD0XxQovtDyDqDVQCEz+UmO7LLCCLual5EJZ1rkZ/EC
T9XkRvGdfJe0xJ1MF70GsRT7joOgo99OYkkQyyZnC/Q/onmWrpu1HQ64mVlgQLTR
TWVGQihOdhM5W64vrUWbYNb4sAV6Qz+XgV0FcLuhkfRdPNOOrARZGzfg8Hil4fxf
m0eXF0nwBUpMQV6PT9vErQEkck8nLg==
=/QUj
-----END PGP SIGNATURE-----

--b5ywIkFz32uab6au--



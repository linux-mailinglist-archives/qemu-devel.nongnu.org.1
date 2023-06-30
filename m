Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E154A7442A4
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 21:16:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFJa2-0005Hz-Q4; Fri, 30 Jun 2023 15:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1qFJa1-0005GJ-5V
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 15:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1qFJZy-00057Q-N8
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 15:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688152488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IshQJvqtUpOEaT45XW+pSHeC2Un0xDtmRxHhqjFlVgo=;
 b=bpJwn4aqhoVwLhowQefmU44yjZVysHFgKws4OaCZTDl0sxCs2LKSkrhrq+PTF5+fFlV0e4
 zBM53wtf5+SPIh+/o154AIpA2z8bCr/qqSClGctgtGv16D78pzIzCYBCH3hpczpUprftD4
 Mh10LuhMQswFQn7HQVfPJtoz95Izge8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-9FX0z-ALP-yQH_i9gjYRrw-1; Fri, 30 Jun 2023 15:14:45 -0400
X-MC-Unique: 9FX0z-ALP-yQH_i9gjYRrw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5020101A54E;
 Fri, 30 Jun 2023 19:14:44 +0000 (UTC)
Received: from fedora (unknown [10.45.224.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C4722166B2D;
 Fri, 30 Jun 2023 19:14:43 +0000 (UTC)
Date: Fri, 30 Jun 2023 21:14:34 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 libvir-list@redhat.com, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] os-posix: Allow 'chroot' via '-run-with' and deprecate
 the old '-chroot' option
Message-ID: <ZJ8pV92XaS970L81@fedora>
References: <20230630150112.435874-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gjESumEScnDSpwIB"
Content-Disposition: inline
In-Reply-To: <20230630150112.435874-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jtomko@redhat.com;
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


--gjESumEScnDSpwIB
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On a Friday in 2023, Thomas Huth wrote:
>We recently introduced "-run-with" for options that influence the
>runtime behavior of QEMU. This option has the big advantage that it
>can group related options (so that it is easier for the users to spot
>them) and that the options become introspectable via QMP this way.
>So let's start moving more switches into this option group, starting
>with "-chroot" now.
>
>Signed-off-by: Thomas Huth <thuth@redhat.com>
>---
> docs/about/deprecated.rst |  5 +++++
> os-posix.c                | 35 ++++++++++++++++++++++++++++++++++-
> util/async-teardown.c     | 21 ---------------------
> qemu-options.hx           | 18 +++++++++++++-----
> 4 files changed, 52 insertions(+), 27 deletions(-)
>

For libvirt:

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--gjESumEScnDSpwIB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQT+Rn5j0qdK2hQgnuAU0rOr/y4PvAUCZJ8pmgAKCRAU0rOr/y4P
vACWAPoCkbRESjyId/yo+0lM+VCOcQwqRV1csJu0mgiaTXxUvwD8DwQrbskUAQks
BXc2RzV0bFz6ZXlFMTdaXrL01nXVfQw=
=3EJm
-----END PGP SIGNATURE-----

--gjESumEScnDSpwIB--



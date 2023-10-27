Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C7F7DA447
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 02:13:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwWva-0007Ee-2N; Fri, 27 Oct 2023 20:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qwWvU-0007EN-7m
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 20:11:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qwWvO-0001QP-Ka
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 20:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698451890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kjelHCaJCVfS2ipKEjzoTwd/0+VyMoE+Oyic4qIOab0=;
 b=J4zP6roUtM/WPLW2t6my0AYuASejm8EkvpRx07zCb7pn/93mX6JB+dawgIv9RxmSH6qEkA
 FA4uKzv2ZUHNydWT612psdgUwMknv721qTGYAhMWtbyFieIExPeKhH4GVwU2xgm4icDWio
 fGFIteW3D5UstmgDcXfwm2qmmx45S9k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-IfkVIe4eOj2gaKfFkvFEOQ-1; Fri,
 27 Oct 2023 20:11:27 -0400
X-MC-Unique: IfkVIe4eOj2gaKfFkvFEOQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E2B63C027A4;
 Sat, 28 Oct 2023 00:11:27 +0000 (UTC)
Received: from localhost (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2EE22026D4C;
 Sat, 28 Oct 2023 00:11:26 +0000 (UTC)
Date: Fri, 27 Oct 2023 19:08:13 +0900
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PULL 00/12] aspeed queue
Message-ID: <20231027100813.GA554327@172-11-0-127.lightspeed.jcvlfl.sbcglobal.net>
References: <20231025085921.733686-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YALSdC9M03GKEHt5"
Content-Disposition: inline
In-Reply-To: <20231025085921.733686-1-clg@kaod.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
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


--YALSdC9M03GKEHt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--YALSdC9M03GKEHt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmU7jA0ACgkQnKSrs4Gr
c8jUDggArwsmJaLmt+gJGVZI2G8jwW9ez+S49f9L9uoKXBGwho2AsIlMUexnYfpL
HSBV35nosQFnsRrHCQcdlbII80k5wQc+bhX1ZVD0HmQSi7H/J3VTmW0UoiFD20B9
IUKm7zFp6DKXpjUytipcOZ47oi72Db0R+jkUYGmBMjLkOykfo5SY+Ep341f08Web
RXAFdQaTOidgidkUqscRx6Uunqwt0fxUMAo4z65EAQXSaZDw4n9mvNhvpQX0CfJH
0w56qao5VcTB/uiSN7OPDlS24ObNKNn98NW0/9Xr4JHlSbFiiNc4Wx5M8rPk4DAp
ftTk1KyK6gyJ+Z0GzLhOPaY2u8SbmA==
=3Tl9
-----END PGP SIGNATURE-----

--YALSdC9M03GKEHt5--



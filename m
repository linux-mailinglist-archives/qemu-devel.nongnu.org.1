Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E51C37A9579
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 17:17:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjLPx-0003hE-40; Thu, 21 Sep 2023 11:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qjLPl-0003dy-1B
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 11:16:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qjLPj-00068a-Hc
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 11:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695309381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jnFtWBVB27Yvr6ia575y4KIT8hLPWXXd4eawi8e4tUc=;
 b=DQTmn6O26fFyzNNfWGcIJraFtUiJcBJ9I5UYZ8QKCRvO/apNshiMZKambvePH1ZzMOnV6j
 FTw0T7DWAzTriQPYRUGBoLf6QZ4VLcwS6EE3qwPj595UqixlgoYesP+Comrss5OpaYkN5o
 rwQBris+FOOVa2Cx6H/fasiQene+Spo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-u-owzJRhM2eUtsWPGZZwxA-1; Thu, 21 Sep 2023 11:16:19 -0400
X-MC-Unique: u-owzJRhM2eUtsWPGZZwxA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D5EB101A53B;
 Thu, 21 Sep 2023 15:16:18 +0000 (UTC)
Received: from localhost (unknown [10.39.195.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9164711282;
 Thu, 21 Sep 2023 15:16:17 +0000 (UTC)
Date: Thu, 21 Sep 2023 11:16:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/28] Block layer patches
Message-ID: <20230921151615.GA1111405@fedora>
References: <20230920163235.66983-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VlWC7+9Qt7hMe3MU"
Content-Disposition: inline
In-Reply-To: <20230920163235.66983-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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


--VlWC7+9Qt7hMe3MU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--VlWC7+9Qt7hMe3MU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUMXj4ACgkQnKSrs4Gr
c8g9hAgAkHx8nZmJDeQQnwBlAcZvhrAcjS1gHix3HDoWlPlHDySPmGJh397QU8cS
HBLReQgBgcukEEuXYBf7bCJNH40jqi+t6mWauiaPWGBKmEMH8+oV/jo+6WZJWg+I
htG+NEVeC+T7wzCXyp0CLvZpO2K4ebuWP9lSPkxa/Mf6xIobMD4BuGRJZwqazbID
PKuJXTJIXG6go+UoEmSWVzVwPDE9Bkv/j6nV5OpOJ+DobSAcPhLZlLj43wBWuXmf
9EloQ5btsK4WD6hCNVAkRZdPti61uJFMkLf9GDykQSZvUPi2lKKmXen6kmsV9HYK
6kb91dmUvK3PSCpIjSmq+wf52uCdfA==
=1F00
-----END PGP SIGNATURE-----

--VlWC7+9Qt7hMe3MU--



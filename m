Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 579B07974F0
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 17:45:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeHAq-0004UM-LY; Thu, 07 Sep 2023 11:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeHAm-0004TS-QS
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 11:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeHAk-0003RA-It
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 11:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694101437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WY1d4gmZnd9wA/7NqCaE0r+MmZrwbAGpxtEZdRhqIlQ=;
 b=Dbi69IktXBXHlqI4cNtH6b4aga1/CcG5xlhO2JwDLOP0P6VDvy4Kq+G9wRGULoMlh/ia+i
 wjZgCdjxIztOUtU5LuoVopKZA80a8ESk7hCoIN+zvYJNpatrQ/nU9sQYNuWOobzU3wrLzw
 rJYt0JQeRvY4uaoKdwnidLNqfEkxb8o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-s_r6xWWTNyWh-jOqT3IS8w-1; Thu, 07 Sep 2023 11:43:56 -0400
X-MC-Unique: s_r6xWWTNyWh-jOqT3IS8w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DEE493806721;
 Thu,  7 Sep 2023 15:43:55 +0000 (UTC)
Received: from localhost (unknown [10.39.193.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70B291460FE5;
 Thu,  7 Sep 2023 15:43:55 +0000 (UTC)
Date: Thu, 7 Sep 2023 11:43:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL for-6.2 0/7] Ide patches
Message-ID: <20230907154354.GA1550676@fedora>
References: <20230907034228.4054839-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="R7ED6ceqqzgJC7pF"
Content-Disposition: inline
In-Reply-To: <20230907034228.4054839-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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


--R7ED6ceqqzgJC7pF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--R7ED6ceqqzgJC7pF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT577oACgkQnKSrs4Gr
c8gUvAgAxMxX2gzEdnT44b/+CK3gLqQR226cexbg5a882sPJI/Q9FS1mO/Mt91fW
P/7diMqgWMC/G1IZGxPr6hZWez64nuqDidQZzNUw6mOvTej4LKx+ue2DRXBqi+S5
bt+zkWR6z/kTERGqlMi/pR5KaqkX/i9mKeDLdZ+ijhe2hKwHWnDLQFTLkg4xKwup
o+SJvXZ2iGZXr/S6gqAs8CPJ/HUOltarEsEnagvB1shVnHJR7hP5cwA7GYU81C9Z
JMgKO0o21H7P9lpzo0KWUdxXXtXZIWV9+Rnuqp014tx3tj4FoGjRKT2z1E5GRmUR
uw55pa2LXWGkae7Un+Sf8/SWt4sfbw==
=+2CW
-----END PGP SIGNATURE-----

--R7ED6ceqqzgJC7pF--



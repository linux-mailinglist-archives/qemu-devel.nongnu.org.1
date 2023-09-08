Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AED0D799E93
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 15:59:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfKwd-0000Zr-0A; Sun, 10 Sep 2023 09:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qfKwZ-0000YO-ST
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 09:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qfKwX-00057d-6T
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 09:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694354260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=adZD2a+bxZsjg1H6PIYNkcuK9+gAqL8cWzUZOFQVnXQ=;
 b=dS0FZSb7GL1nMdsxt/fRkSGCSZ7lEvkb9/pmGhYMqjYaLUfT9tVY+Pt9nZDLx/ShUuXTw9
 Kf0wySlzPIeMh4Y7db58aV6gwM6Ny8nbYQApD+/xbBJbuqRpu1EDqSxcWecWQsRATO/MGC
 wEatSE0NcRBQAxIk57+Km1CJNlRmlac=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-SBS0kjhoPdaQ76MppSRvMQ-1; Sun, 10 Sep 2023 09:57:36 -0400
X-MC-Unique: SBS0kjhoPdaQ76MppSRvMQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B60229AA3BE;
 Sun, 10 Sep 2023 13:57:36 +0000 (UTC)
Received: from localhost (unknown [10.39.192.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6A5D400F36F;
 Sun, 10 Sep 2023 13:57:35 +0000 (UTC)
Date: Fri, 8 Sep 2023 11:55:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-trivial@nongnu.org
Subject: Re: [PULL v2 00/22] Trivial patches for 2023-09-08
Message-ID: <20230908155524.GA3575166@fedora>
References: <20230908101109.276768-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JKfBEj2jyzRyFbxZ"
Content-Disposition: inline
In-Reply-To: <20230908101109.276768-1-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
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


--JKfBEj2jyzRyFbxZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--JKfBEj2jyzRyFbxZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT7Q+wACgkQnKSrs4Gr
c8gkfQf+MzIj3cq7baCbuBhsBZ++dNDvtVcufjNl8fR4ToClQerosoFMwXM8vW+3
KYzwM17KgRYE3n8GxD4BO0jZw9js9hq3av0v4ka6Jf8c3kItDshW2WYjBp7oHZs3
kUk0KL+DDREZAkRXWcG2BpkNdOr940sS/wXQ237gG2er820UUf5yR2ZGXpoyIL3K
rbJ/SqzCrofVlbQpOn2VcYTUAiuySumw0G2csOKVxG3qVhDqprtMnIafEltsUEJs
N1afuo/R6+3IoQQhe1K/DoN7I2oN3PMx5vksKCUxSQPqtlFVKUa24qLsXxtLD9yb
V/8mPFiFioQQit8bW4wILflzs1HB/Q==
=CiJO
-----END PGP SIGNATURE-----

--JKfBEj2jyzRyFbxZ--



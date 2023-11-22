Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EDE7F4D5B
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 17:52:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5qR3-0003U3-Lf; Wed, 22 Nov 2023 11:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r5qR0-0003Te-G1
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 11:50:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r5qQz-0001B3-17
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 11:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700671838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ygsIAQQKkqrJmQ8hN6ry8h9slwKGLiC7y5rLAAHoCUE=;
 b=KVbC2JUP73xy82tlc816/9UGD4yhcDvYi6oGAE+CWtEDppG+FOuWTx5wbmJuqzl/1SJ35J
 t7gxtMF1boj9T6TA12oGIXOnqRjdHjiSy1XwlefAb5LL7zG+vowx3bogOYigD8tZjv26+k
 XmqLFcBPKOdQqTJ+XFfeA7Ai/hVOkRg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-MSQTIJ3qOpWkVg8u85ymqw-1; Wed,
 22 Nov 2023 11:50:34 -0500
X-MC-Unique: MSQTIJ3qOpWkVg8u85ymqw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B06F3C027A8;
 Wed, 22 Nov 2023 16:50:34 +0000 (UTC)
Received: from localhost (unknown [10.39.195.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62C202026D4C;
 Wed, 22 Nov 2023 16:50:33 +0000 (UTC)
Date: Wed, 22 Nov 2023 11:50:26 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: deller@kernel.org
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: Re: [PULL 0/1] Seabios hppa v13 patches
Message-ID: <20231122165026.GA72837@fedora>
References: <20231121222625.131341-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fF0d8Y+B8ByDQEHn"
Content-Disposition: inline
In-Reply-To: <20231121222625.131341-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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


--fF0d8Y+B8ByDQEHn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--fF0d8Y+B8ByDQEHn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVeMVIACgkQnKSrs4Gr
c8gg2Qf/W2mNwlPcEVlry/syXIV5IQCXb/ua1zhUHgRxnoUNrZsYRjCZ7W2sm91f
NuUR8AusKAC5vKf9kb9RDSXrVwOrTqDENmT2YOCZN6eN87i51hYuv8w23VxoXydf
49wsV8dieOaA0jLCZSN3C/WpYm2z+NT3YDjxFaReAunW+R/uV8qUWdxX2CABGGOK
NsV5dLvDP6IvvIqI6gz3Xuuh20wnAZrHrenTMuhrauQi1PRNbZrfNEjTWhHvmj/z
5r1ymuDEWx4nQYymAmcxOMvq79EWeP8ctZ6qGkBQ0H4lV69CSId3KVU3X9Vup5p4
p0XicSVWhwV9PI4mlATEnA8d4oMD2Q==
=1JRu
-----END PGP SIGNATURE-----

--fF0d8Y+B8ByDQEHn--



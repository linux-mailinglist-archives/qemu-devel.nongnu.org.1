Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B68767E26B3
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:24:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00Wk-0007yZ-K8; Mon, 06 Nov 2023 09:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r00Wc-0007tV-4c
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:24:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r00WX-000605-Sc
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699280657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ZiK6jWVLKv2Y92Y332lNoHBjVZcVYXiiBeZKGtBloI=;
 b=Sqn5m845SO6PnvJiuSUJ4yrU7nWP7VuGca0cDwKtlgyWZ2vBZRGdk81hmrNL5YSRz3Qnkq
 o+ZOzYx0AnhVmUIGv7Hq1lJXCG2ZGF1GE3n7bu0Om7iWmY1dreuz0pdRfaMNL2szWLbaVY
 SKelelVCPMRBiIFxYLgQuJCgrHb7Uoc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-PTqu71h0OeqqkQXIgqL4jw-1; Mon,
 06 Nov 2023 09:24:14 -0500
X-MC-Unique: PTqu71h0OeqqkQXIgqL4jw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80F8738157A5;
 Mon,  6 Nov 2023 14:24:14 +0000 (UTC)
Received: from localhost (unknown [10.39.195.175])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 820D91121306;
 Mon,  6 Nov 2023 14:24:13 +0000 (UTC)
Date: Mon, 6 Nov 2023 22:23:05 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Hyman Huang <yong.huang@smartx.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PULL 0/7] Migration 20231103 patches
Message-ID: <20231106142305.GA929063@fedora>
References: <20231103120448.58428-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bRGS7ZtXefsMkJEa"
Content-Disposition: inline
In-Reply-To: <20231103120448.58428-1-quintela@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--bRGS7ZtXefsMkJEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--bRGS7ZtXefsMkJEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVI9skACgkQnKSrs4Gr
c8gyVggAhVvvIARTtEjAX+Efk1KVEspB8KLxCiZz2baiF8huFSpE1TlNoMYMEEiT
lrSrFrqGgyl+G0pv9o2/rEV4oGYbPh625htPMSPEqqfCXSezdnsZVFK7Ar5E3+Iv
Ac5HItSe40+K0EarCPc58rUrQAjarTJ0xc/Yt9mtp8JsBMvzBINVXLCYCgS+AK98
ohq7G6d/mF1atIDdYMFVLAUFgQAsCaebHtxLG4LMX55qdeTZxKRfG/437xaA6Gut
Wj9cZpBMg+rb8qJ1ENV//NzQzlTIJKy9r1yUuFuTEruwzTSRemi04mpeKLDxap+a
3fngMebjAKzcIXqsxwalBcT6NuWfew==
=FjB2
-----END PGP SIGNATURE-----

--bRGS7ZtXefsMkJEa--



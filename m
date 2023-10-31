Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 587DD7DD96D
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 01:02:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxyf1-0003Ux-Vr; Tue, 31 Oct 2023 20:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qxyez-0003Ua-01
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 20:00:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qxyeu-0007oj-FC
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 20:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698796830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YrPieCeV2mBeoLbxqtklSZQjv11Bs1zoUVJfmBinojY=;
 b=YIcuk4LVlr2W6UwoBqXrn9ULvZvnD+YHKavW9WR4U7QHHj+SS2dV6vz1taU6UXT+hgO3Hr
 Sj0VOKJ2rmRhecswuampRjwkc9boZtVA3emyECBS0VbJJnSTF2ATf0yDaGigCieSazpzWw
 zIv9h35jVmg70ram66rswbF6yB79Sog=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-rx5hKY9fPIq8xh1ZbktWgQ-1; Tue,
 31 Oct 2023 20:00:27 -0400
X-MC-Unique: rx5hKY9fPIq8xh1ZbktWgQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81C7E29AB3E8;
 Wed,  1 Nov 2023 00:00:26 +0000 (UTC)
Received: from localhost (unknown [10.39.192.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80241C1290F;
 Wed,  1 Nov 2023 00:00:25 +0000 (UTC)
Date: Wed, 1 Nov 2023 08:31:25 +0900
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 libvir-list@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PULL 00/38] Migration 20231031 patches
Message-ID: <20231031233125.GA673925@fedora>
References: <20231031090142.13122-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8V0kA69ZBDgMtCxO"
Content-Disposition: inline
In-Reply-To: <20231031090142.13122-1-quintela@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--8V0kA69ZBDgMtCxO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--8V0kA69ZBDgMtCxO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVBjk0ACgkQnKSrs4Gr
c8iPngf/YugBYHMMWU6ijvvOL10YA2HEoAycpz4ZQBfQXM7jl42mhy5WHOlFgO25
e9IhMN0KCNxaJ0MNUJ6kxsA4q4oUQD/p/K3kDwdnXaE7s8VA0iwc2MEfb9UHOad1
82CLd/c6NFCXvt28soc85ubJYgdrOqqxljmg9siVeMenEm+D9TZtM6bFrfJJqTEm
TP7pgFlTD+UZ9pUkaibqy8urFRFMbFC6EeL17cTl/95XXm2BNLwrz4ER3iELAtyY
A9T53R/3Dv6YDVcWRfoAZGDfcuJFVPvVUv3jBa8ycS0AD0Fh50eD74zOiTZH61Pd
APluWRECjRN7CX7r52r8Q5KPof8U4A==
=1KSz
-----END PGP SIGNATURE-----

--8V0kA69ZBDgMtCxO--



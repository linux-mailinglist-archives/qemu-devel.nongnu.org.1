Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C747D4500
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 03:30:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv6EP-00031M-HZ; Mon, 23 Oct 2023 21:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qv6EN-00030P-57
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 21:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qv6EK-0006oh-6b
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 21:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698110951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rGlXumYcN2MrXQEA0UF3B87ewh+51hfmgZo/6SHKcK8=;
 b=DJ5ul/mr2YsCM9ffai8VOMPA3DITyv3CfI6U3trytiAnM0ySn+++DHlM/60iBW6/O7PBAB
 KnUGxNx9U9mIgSTNLYr0KZN+4+haS/fzzma1jQ2E3D48ERYgy+NwxvAVA6l7FuO+b85eUT
 Lus5rIbOq3hpA/R2D4LR/RVLXtE18EE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-7Lxg-zYoNBC0YRQco_XRjA-1; Mon, 23 Oct 2023 21:29:07 -0400
X-MC-Unique: 7Lxg-zYoNBC0YRQco_XRjA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E05080F8F4;
 Tue, 24 Oct 2023 01:29:07 +0000 (UTC)
Received: from localhost (unknown [10.39.192.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF5071C060B9;
 Tue, 24 Oct 2023 01:29:06 +0000 (UTC)
Date: Tue, 24 Oct 2023 09:15:47 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v3 00/38] tcg patch queue
Message-ID: <20231024011547.GA499309@fedora>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4tjxp6BppACr3Xet"
Content-Disposition: inline
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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


--4tjxp6BppACr3Xet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--4tjxp6BppACr3Xet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmU3GsMACgkQnKSrs4Gr
c8hlVAgAqJlL2mHgANwOx1I3wiyI3r+KvvekqvzL1CQMDL4WlcKKfFitMBjpnq84
gaPvOmKuMRcSDZuZwe9R6d7CRMwE7sH1UK5eVUZR3LupaUtkQQmg4obWKt8KqRGQ
n1jfgIM2z8aZcwlG5Ca0o/pxjANQSKvWlsYqXV778a8UXg5xi4SXHfvaYZBKUFpW
3cbTYr59vfhAQnsqm90L3FSXT263t7xloNJLf29V/Ue09J/YY7+T5Qk8kMH/zeJr
wkZfr794wylP3VJKUzjDh0U5BcuV/BW9Txw2g54b32W03HrWBuGmghtwKM6ad6ik
k57zO3FTS9Dn8wQQoeh7fvjP7hMh4w==
=Wxd7
-----END PGP SIGNATURE-----

--4tjxp6BppACr3Xet--



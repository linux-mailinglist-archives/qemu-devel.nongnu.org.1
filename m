Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8398778BA16
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 23:15:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qajZd-0001dF-3s; Mon, 28 Aug 2023 17:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qajZb-0001aO-5B
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 17:14:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qajZY-0002BI-P1
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 17:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693257294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rq7PSbUr11gQTM/ENtvCiUm/1nWNc+sMGDEHxibfbrw=;
 b=GfddkUIOnrB880I7OiY3fHG1WYcYnv6nrkqX/ucC7xHqLjIpFTfrc1cIRB7YM/3Ff45mcC
 CyZw5PsbxzzHdqIMj198clkEcJoOSWZCjkstit+bOKleE1aSDfTWpaUtbdZuA+io1LhybM
 LaxUvNT8tDGdud1cecsTklJ+pJ0K7qY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-PNR54DtANkGLt5SCImevLQ-1; Mon, 28 Aug 2023 17:14:51 -0400
X-MC-Unique: PNR54DtANkGLt5SCImevLQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4F8685C70B;
 Mon, 28 Aug 2023 21:14:50 +0000 (UTC)
Received: from localhost (unknown [10.39.192.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38C56401051;
 Mon, 28 Aug 2023 21:14:50 +0000 (UTC)
Date: Mon, 28 Aug 2023 17:14:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: deller@kernel.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>
Subject: Re: [PULL 0/5] Devel hppa priv cleanup2 patches
Message-ID: <20230828211448.GA70599@fedora>
References: <20230827151747.290653-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jWE/T3KZDLyjc4Nm"
Content-Disposition: inline
In-Reply-To: <20230827151747.290653-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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


--jWE/T3KZDLyjc4Nm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--jWE/T3KZDLyjc4Nm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTtDkgACgkQnKSrs4Gr
c8gquwf/UqLwlCbF45jagy/jRzktaE+t/nVWG71EZOOR5HN5VBTu4iOW5ecqoEvv
lUf3bIipHvAywPsE7YVWXH6NPuSBoB6DFE3bN2v1HqC4coYSJv2yDNFr7F//1oNL
ZpN7dDxODTiJy0Cb4Dw4hOPEcy7yIhDY11QRzWgmImvSMqKi9jfsdMZnQ96knpkJ
Kc2/w+B3Ca6jc05erYIK2tVelg34IHdUqTBwN3kvB6CLIbLrKm8NgyHMBi7QVVyZ
g8RhLNGgUyRw4eBZ1B5/OyWFOvDWi0fNsF1B7B3gjvD642GVjoA9vD2JstFSpUDo
MA0Voyq+xPGYqQWQNhvCH8pys6tujg==
=dYMA
-----END PGP SIGNATURE-----

--jWE/T3KZDLyjc4Nm--



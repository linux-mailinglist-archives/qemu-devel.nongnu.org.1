Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CFF7DFE5D
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 04:24:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyknS-0003cy-Cn; Thu, 02 Nov 2023 23:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qyknG-0003ap-TW
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 23:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qyknF-0006Ed-HU
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 23:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698981861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3CbyVJiDYHJ6voWZheNaIUgF9YHWUlnF7/vU30a3jA4=;
 b=UUJBIXoVt8zYzNyrnXg0OQkjLMUBMvRXS7E+8Cq1gFPCY86epZZu+hfWruOtGBP9o4imvl
 rsGhZuPPeUzZovobw3Y0uuewSy0NuhAY/cBtj0LN+GBYzytTuFBm0yQ6FaZQkiKbiy6IiP
 4zG5cEXuvTTTzv6Jc5NEqwlZ6ykT/QU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-oLF6-qVQMAmyM-zN1c0uKw-1; Thu, 02 Nov 2023 23:24:16 -0400
X-MC-Unique: oLF6-qVQMAmyM-zN1c0uKw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45479185A780;
 Fri,  3 Nov 2023 03:24:16 +0000 (UTC)
Received: from localhost (unknown [10.39.192.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87CED2166B26;
 Fri,  3 Nov 2023 03:24:15 +0000 (UTC)
Date: Fri, 3 Nov 2023 11:24:05 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/33] target-arm queue
Message-ID: <20231103032405.GA772136@fedora>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2ELJ9jgMLyMkRWhE"
Content-Disposition: inline
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--2ELJ9jgMLyMkRWhE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--2ELJ9jgMLyMkRWhE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVEZ9UACgkQnKSrs4Gr
c8iaxAf/VkLe3eemTjxPHioPGzPzbWVWxuVbR7uz31UT/mVFVqWtzpwyF5SfajIE
ho7CcWf9aIReZI0XqpzgxygTQ6kAy3aT+LnLW3NJxh5yAb89lGkSjrvFC93axWHS
zhkmuR4FBxYglikN/rHFHW13Ffdp3TocLcsmLcahZcK8JNDRjfWhH6Nywawwm9V8
K3niRKdz5H+77A8+RQZt+agm+vsMdtUT+HPF3cbE6i8696fyJ7ZgFht00JfTPeLg
BFd6ZjQ4lerInAgg/NvcIAABEE0/sEdVodIjVW5Q0URjZdZci51R6y2gySy/Tup6
onrNhD71OzqV+Ez0Q7T48EH//oABgg==
=HcZ4
-----END PGP SIGNATURE-----

--2ELJ9jgMLyMkRWhE--



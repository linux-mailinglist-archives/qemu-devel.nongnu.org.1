Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5557974F1
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 17:45:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeHBA-0004YP-Ko; Thu, 07 Sep 2023 11:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeHB5-0004YA-9Q
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 11:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeHB3-0003To-0k
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 11:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694101456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lXte8go+EaPQpcC46g19LdyP+ndeRq4AfrCKb0GWk1U=;
 b=Jv24NQw/ePSGjamuavRM5O2wyIlEA0UeLoW+hau4qpSABWkQF05pPzHslmeHjKrKCMjasH
 lY1nAmZ4xx7WuLGfAXNtINm/TLpWYaxX92+WGfD5ahKHGwxsCWfouZQEUoWw4laGjhVjZt
 NxrevH0KgRGOwtLSmUaLI3LAcnR73Pw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-4nhyMyfdP6C4it695PvclA-1; Thu, 07 Sep 2023 11:44:14 -0400
X-MC-Unique: 4nhyMyfdP6C4it695PvclA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 494CF381AE43
 for <qemu-devel@nongnu.org>; Thu,  7 Sep 2023 15:44:14 +0000 (UTC)
Received: from localhost (unknown [10.39.193.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3F8A1460FE7;
 Thu,  7 Sep 2023 15:44:13 +0000 (UTC)
Date: Thu, 7 Sep 2023 11:44:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/51] Build system, i386 changes for 2023-09-07
Message-ID: <20230907154412.GA1550739@fedora>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fY6WyJBWa4T/2cBs"
Content-Disposition: inline
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
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


--fY6WyJBWa4T/2cBs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--fY6WyJBWa4T/2cBs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT578wACgkQnKSrs4Gr
c8g7VAf9EK8x1snyPXHaznNzHYUntzsOBWW5qicr9Imx7sR3rGxiqNtN0/wFaiYO
6agGl+s7AZX7IrYxpm/HibD0wCdZyi9Mnyjag7ds5TCwAxvhITNHG7XrkoLeaCwF
CgFIts+O2CVAjBqa4th5qaOQvL3pE++fefcKJsTh43I1BXoNTgkin29p71ERmap8
5N2r7tdvrURFyKKIokhVL+PYARj1tvKIHR36A1zfM7ED9YouCNjpbVOvOhhsWJ/+
z1U9dWxlxmzme5jchCVbASDs10R4oaYZQ+Jp5xFJQhrV7DKJX43qC9CMHME0JK4t
p4euZxKdnv3Pa6L9kudtc+ECy8sGfQ==
=dLl/
-----END PGP SIGNATURE-----

--fY6WyJBWa4T/2cBs--



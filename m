Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8965F7E3A9A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:57:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Jkp-0006UW-6Y; Tue, 07 Nov 2023 05:56:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0Jkn-0006UI-SH
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:56:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0Jkj-0003B1-7e
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699354571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=JrwN5tSaU4CnpG1FXdPfKN2Lrp1IGHtouKs+DCet51A=;
 b=O1sHwyw9lF5gWDXbBkJM/XqTUvVMIacaf8qEhmZp0Nj6kcl/d8rQ0PYO1EOhv6jyOe0sJ6
 i2IxEyXxdLUbIUmJyx/ojPjvHjGtutA9u8TGSkmX/kl7BHCL/9IX1Vgu+ankJzvR9DNo0f
 szL5I6lt/Za24lut1+T3afB1FZcHMpM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-f6sosHy0OnCbpKzD1bPOgA-1; Tue, 07 Nov 2023 05:56:09 -0500
X-MC-Unique: f6sosHy0OnCbpKzD1bPOgA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C2D485A58B
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 10:56:09 +0000 (UTC)
Received: from localhost (unknown [10.39.194.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDC0B1C060B0
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 10:56:08 +0000 (UTC)
Date: Tue, 7 Nov 2023 18:56:03 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: QEMU entering soft freeze for 8.2 release cycle
Message-ID: <20231107105603.GA993420@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Md6KSJwR5RHU8Y4Y"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--Md6KSJwR5RHU8Y4Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
QEMU is entering soft freeze for the 8.2 release cycle. After today's
pull requests, only bug fixes will be merged until the 8.2 release is
stablized around December 12th. New features can be merged into -next
trees by maintainers, but will not be merged into qemu.git/master.

The release schedule is here:
https://wiki.qemu.org/Planning/8.2

Please remember to update the changelog if your work has landed in 8.2:
https://wiki.qemu.org/ChangeLog/8.2

Let me know if you have any questions!

Thanks,
Stefan

--Md6KSJwR5RHU8Y4Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVKF8IACgkQnKSrs4Gr
c8ioFwf/VMGKL863ev8uMQPQMXC2xbrazT+SBmjvEUfW6+mA2cjBysdtcc4UwwJC
tl0HsZjIn1cfFEj8cmpBDGXgFWaL2TzPTiydXHVVhOQDiQLpDLZs32FyKv0ghj9U
UDrf6462n8sZpugHzUG20BGJiJIDiY9O1yGm7H8xnJZ7h+GhX2XHQ7jH/upxw1iL
mzaiSWxWQ1nnQk7Mjz/7dIb8wlfBgPARiY+ULizwBZ4JzIDMiT75AAqxPewq3hjw
cqpz8pMeDgDHthk1shwwmXaJ20imvfer1z3YR9AqRTURTU2Aoi2ji3deHjj7F0oq
Rgsz17PD0l48i0dAD71Cqaz+FTrLJw==
=pNnW
-----END PGP SIGNATURE-----

--Md6KSJwR5RHU8Y4Y--



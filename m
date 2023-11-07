Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCFA7E336C
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:03:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CMz-0002xz-8t; Mon, 06 Nov 2023 22:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0CMv-0002tc-Cr
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:03:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0CMt-0000Cq-Jy
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699326184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uqTUtmdbJIp/47bYrsu09xQ1c2e2ylBxM+la+Qa3RNU=;
 b=Sd9PzzXEj7B7RT2otrm4BpaehXxeqO5DUdf8TJTpqYmOMkT++rcagQ2/ev+skL99/I+4VU
 VqYC7r42tiIgG+ilF09IfSKtkVcUFBTIIzDO2dQ9qocI2NFg2LjKxKmnIJbYLfDC1QkONE
 /1sPCrqXcnY8h8TKOo4mtQArVY2aGjI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-RIqIC4IDNhqDa5cInMhMlw-1; Mon,
 06 Nov 2023 22:03:00 -0500
X-MC-Unique: RIqIC4IDNhqDa5cInMhMlw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 930FE3C23FD4;
 Tue,  7 Nov 2023 03:03:00 +0000 (UTC)
Received: from localhost (unknown [10.39.192.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCD3A492BFA;
 Tue,  7 Nov 2023 03:02:59 +0000 (UTC)
Date: Tue, 7 Nov 2023 11:02:57 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/12] target-arm queue
Message-ID: <20231107030257.GA952873@fedora>
References: <20231106153238.1426649-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kGevcoSfjVp+cPs3"
Content-Disposition: inline
In-Reply-To: <20231106153238.1426649-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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


--kGevcoSfjVp+cPs3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--kGevcoSfjVp+cPs3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVJqOEACgkQnKSrs4Gr
c8ijfwf9FRcPCTsRzc3WobNcRdbAaoRIztFay80zL9iUOJ8wUmYvmRSwZZMUyBLJ
b4BdjmyW0Qu5wy/A9jvZunj7/xZkCLXCq6CDesartRn+TNnq7pHqEmhkZYZ4gcLx
2AoKPaPe0kOvsW5YLWFuz9fZZdP0Z0luLRrG+jlFMQsmEEHKJTx2UZXlel95UUrf
tGMeBQxrOxyg/DUHaY7pVpCBQzMhcmsif9TRKMdGeW1o0Qp6q3UwD0ra+J0zhQbP
3atArP/XB3B3HXv8RQed7Y0cJQfdVnOCxo2mD8emZDdkUFf92ka7tipH8YawE6rh
ClJYTVslfbuRpK494TFpNAw59vTr1Q==
=riN0
-----END PGP SIGNATURE-----

--kGevcoSfjVp+cPs3--



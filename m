Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3317F320D
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 16:14:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5SSU-0001vQ-QQ; Tue, 21 Nov 2023 10:14:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r5SSP-0001oL-9G
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:14:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r5SSN-0008IF-27
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700579670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3USzWMFLW+R0mzHf7w4cGy1PyHEcy0DCUFSpoa63vis=;
 b=ffBVtJNuvHQBiiBh8iiJAuSWq5xd0LZP/YJwm5FvKyyPslufMTuxcJdaN9aJr7bcDTCAov
 oxcZfQui2UKshTAiIh7XsyiIxBkGUh8qK8WO1vRvboOJN+uKaSF+VT/nsCRaZq8qlrzFoU
 R2SyZFoR9R5Q49WkV5lTLuYYVbvjMNI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-HlfumPIoNnuV03QyAQtWLg-1; Tue,
 21 Nov 2023 10:14:26 -0500
X-MC-Unique: HlfumPIoNnuV03QyAQtWLg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 271693812586;
 Tue, 21 Nov 2023 15:14:26 +0000 (UTC)
Received: from localhost (unknown [10.39.192.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F712492BE0;
 Tue, 21 Nov 2023 15:14:25 +0000 (UTC)
Date: Tue, 21 Nov 2023 10:14:23 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/8] target-arm queue
Message-ID: <20231121151423.GA3480500@fedora>
References: <20231121102441.3872902-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KEUjDNz7IvHAdbiQ"
Content-Disposition: inline
In-Reply-To: <20231121102441.3872902-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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


--KEUjDNz7IvHAdbiQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--KEUjDNz7IvHAdbiQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVcyU8ACgkQnKSrs4Gr
c8iPqAf/X+MsfOxdZEU3e6zrcXkMVNpqY6iaovlCkpSeN93Jgfkhv5TWPHeouTzM
fmBx29Krf2FULgXDoHD0bPu9EcpTxh+UxvRUs0k8uIWmvofSKPoASwJSw5YAg4Gy
F9qyqA3cIRrh+VqwVSXuGzg/Q1/E+SDJ4z7IBjA9E0VjTP1sbMTaK6IJG+Z9WMQL
Vcn+dPuFtgpWt4d+o3Na3ndIFSngoE3uTQcKlLkJX/qXupH5x5+0UdLExcLTE9lH
OZhVkA+PNkEZkSaumbgskWoPEwX89wtXbKXg13SXJjumxLPFRTQrIVWEXZHdhJFj
YcQ+QVmV85LFV+yJxcqWHK5KUMfuag==
=h1F8
-----END PGP SIGNATURE-----

--KEUjDNz7IvHAdbiQ--



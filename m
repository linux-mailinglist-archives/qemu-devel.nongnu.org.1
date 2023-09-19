Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 724D27A6B3E
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 21:14:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qigA9-00029r-Qo; Tue, 19 Sep 2023 15:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qigA6-00029F-I3
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 15:13:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qigA4-0007LW-LQ
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 15:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695150808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9LimudV/ZCMi8FI21x2N89CgllIJVFgFD4JQvcVsUao=;
 b=hu/V4KCmCs3xWxwEHNpC9jTllOvQSrdhV3NJcEpYPjPBXtNN7j37MJJlpTGF0EkSFJTFZR
 zKdr4yjEIcbFsC6w+Q53aK2jFnvYc6Q7r9RIxaF/IKn0uqdDXNXtf/6QuDxpdq6Q0/7Cbl
 stPYHOyxWfkZzPKKLP5DHiajwMRMCLw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-esS9xN7ZPWuD8Ev9rWqsfA-1; Tue, 19 Sep 2023 15:13:24 -0400
X-MC-Unique: esS9xN7ZPWuD8Ev9rWqsfA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C886101A529;
 Tue, 19 Sep 2023 19:13:24 +0000 (UTC)
Received: from localhost (unknown [10.39.192.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5887F40C2064;
 Tue, 19 Sep 2023 19:13:23 +0000 (UTC)
Date: Tue, 19 Sep 2023 15:13:22 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PULL 0/8] Firmware/edk2 20230918 patches
Message-ID: <20230919191322.GA1843356@fedora>
References: <20230918133338.2399701-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XdBaO04Dtbe28OEk"
Content-Disposition: inline
In-Reply-To: <20230918133338.2399701-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--XdBaO04Dtbe28OEk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--XdBaO04Dtbe28OEk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUJ8tIACgkQnKSrs4Gr
c8jBkQf/Q4PuMm3I/bZQxTF+LjPyv/ZpeJss9jEbHEccyY25XHoFtOvl2BGxJpZA
C4Swy4+htU/+BMxgxmz0nMVjnVMgL8X3ti5kjbZP0JGhkmiKyuTkqP0mhwftiEBd
ZB5rzyQXTrmps35MupqB0Ija1cpDeBPHcuKbttWui5jExXksbS4NGHFx9Q7XeXvm
SXzTvIzYNlyvIMPEKK1GxZY5bUnm/hO4eLY3X0LUeRc8cd+ggEtHtmiTp+dToiWL
64zzkGilL5SIyuOS5aONhfxxDg+Dy26PVIgy2oKasnsKAHfHD1vUETmP/SoZZN9g
s+4O+TI7Rj2tOtFrqTTfvHA1eUi0xA==
=Ei1/
-----END PGP SIGNATURE-----

--XdBaO04Dtbe28OEk--



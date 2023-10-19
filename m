Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A2C7D13B3
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 18:08:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qts1d-0005zp-Q0; Fri, 20 Oct 2023 12:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qts1b-0005sM-MX
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qts1Z-0001Wb-VX
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697818017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2vkkC+Eo+AaRbwHH76pl/K1Se9UL0pUfPzjxqpvJ/+k=;
 b=RvqnyFGd3ineHYj6wRfX+vEd+XzYrebPlG8VuhROI0OOG/HcQYI+EPygaXyHY7TRRNDQb2
 QCwrOunO/7hDkIz5ArHP5vnvaT8TTM/dsqECyC1udNQufa+gmuCY3Hvb3fImkPz/qvPcIQ
 n2FeSTibjJBwfX8E5/ZKoXUnbSP2NR4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-8aGemrCKO-G36bSkAZ2SJg-1; Fri, 20 Oct 2023 12:06:30 -0400
X-MC-Unique: 8aGemrCKO-G36bSkAZ2SJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B35410201F4;
 Fri, 20 Oct 2023 16:06:30 +0000 (UTC)
Received: from localhost (unknown [10.39.192.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A30812026D66;
 Fri, 20 Oct 2023 16:06:29 +0000 (UTC)
Date: Thu, 19 Oct 2023 11:51:17 -0700
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/14] linux-user patch queue
Message-ID: <20231019185117.GA414291@fedora>
References: <20231018233134.1594292-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GC2fEEXV/WYEMTkw"
Content-Disposition: inline
In-Reply-To: <20231018233134.1594292-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--GC2fEEXV/WYEMTkw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--GC2fEEXV/WYEMTkw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUxeqUACgkQnKSrs4Gr
c8h9qQgAjdsMIleSG/lorHqj1VAk+3iq/LyJopbWf3OCiW2EULlN6SsRw2PKPO5m
mksNfjd5FWVssY2xCXoiTiachbXSqU/j0bB7ublCMpO4qhxRpHLxuOvCY1S1443i
o+9KQp8B3CQnvK8tdMXdViQi0EQIMi5SZm/EDnSD7CgbqJcGbq59W4sH8K7J738b
5e1cDXWAM6Z3lIIzSMlAzj6DaTXI5od4J8a5gCqDRZa4H1GbsAo34fZoP7h7PeWm
Nb3O5OmMWb8pUPcGAvhR+uevdSHKcpFySzb5r9xZ2B/P3FWYSshtV9Osh79myJ0y
mf2L9Gk15YEG7MvJ3VjFzreK72xw7A==
=6dho
-----END PGP SIGNATURE-----

--GC2fEEXV/WYEMTkw--



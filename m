Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0727C88C3
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 17:35:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrKBs-00057Z-RD; Fri, 13 Oct 2023 11:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qrKBY-0004yr-Pn
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:34:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qrKBW-0003V2-4b
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697211281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sj1e7sWJunAJXcJ0qQs6xh+UNdM+SJ0mD9Qd1sHhnJE=;
 b=MMOZocB16nBNV+WyZzwP+fgYkBBDRoerx5GMhxYVf+DWYIQwQ5SNPIp4zdpR2tt+XTF8e6
 CYfuy9e5AHKNOsqM9apXhQFzufBWQ0jqC3yflRav7BriijU3UxZl6Yo2E0avLY+/NKCHQM
 /KzqvYS5D8XU+bymUZDHSvEanRtX++U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-w87ZMFDGMoyER4FKz68idg-1; Fri, 13 Oct 2023 11:34:38 -0400
X-MC-Unique: w87ZMFDGMoyER4FKz68idg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 933951029F53;
 Fri, 13 Oct 2023 15:34:38 +0000 (UTC)
Received: from localhost (unknown [10.39.192.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 145FE492BD9;
 Fri, 13 Oct 2023 15:34:37 +0000 (UTC)
Date: Thu, 12 Oct 2023 14:51:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/3]  Misc QGA patches 2023-10-11
Message-ID: <20231012185115.GA370804@fedora>
References: <20231011142030.112018-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lAE5DDKPUENbluQ7"
Content-Disposition: inline
In-Reply-To: <20231011142030.112018-1-kkostiuk@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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


--lAE5DDKPUENbluQ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--lAE5DDKPUENbluQ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUoQCMACgkQnKSrs4Gr
c8gHbAf/V3jDtdMain6a7x7job49YhrzMFe1Joa8MCXCux1GSPeMKWS4S2+AvUEj
WqkF/+kXPn9YJNl2BLhDv/NL7hn8jbFND/j1lI271smiqd/Op5877edPoeOhstRm
XXGIf0qSKenl6oHm3z9uAcOP42Czzs2+7skkYZnR2lx0cWxWFNEBkyNYjvc6hMkT
hbUUEFEliI9gPVANUU1nOvMGfcGnMEIrQxhPKAw986U9yPCDNuvDbZ1geZY2u8Ah
5e1w/sNmdeE9rORN+4DyQQ+KNRm9/jHleKv5HbB9Enz14WphDiVeZefbqYf8j59n
MlR1T2P80+EZ6TEutKr2d96dIb0UwA==
=8nFO
-----END PGP SIGNATURE-----

--lAE5DDKPUENbluQ7--



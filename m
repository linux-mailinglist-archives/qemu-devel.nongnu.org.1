Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6A180570E
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 15:19:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAWGM-0007vn-5c; Tue, 05 Dec 2023 09:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAWGI-0007uo-2K
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 09:18:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAWGC-0000W3-QD
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 09:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701785931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bkdqwpsgVwsnaZ0dFWKeMC3aUfr/JkqESHBgUkKQasA=;
 b=XIAsXRY8nQyWNPciiiIU6QTPiDtrYMHijD+O+wB8glcib2GtbBycPnV4kiiG7edGqZeYTp
 F+ipifMDUTZqsOfyiPPuNRannvQk7iyixlTqDXCAKcOBy9is5NeXUxageE5LJTgdRQ7oJS
 nKv2so5bGtPtP5dl/I57e4FfgwiTQLM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-8uxB8YepORqZcltLz4FsHg-1; Tue, 05 Dec 2023 09:18:47 -0500
X-MC-Unique: 8uxB8YepORqZcltLz4FsHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 299DB832D28;
 Tue,  5 Dec 2023 14:18:47 +0000 (UTC)
Received: from localhost (unknown [10.39.195.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 859FA3C25;
 Tue,  5 Dec 2023 14:18:46 +0000 (UTC)
Date: Tue, 5 Dec 2023 07:33:24 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/1] target-arm queue
Message-ID: <20231205123324.GA1851004@fedora>
References: <20231204143322.837136-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vD0jFqLbz7R/875Z"
Content-Disposition: inline
In-Reply-To: <20231204143322.837136-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


--vD0jFqLbz7R/875Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--vD0jFqLbz7R/875Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVvGJQACgkQnKSrs4Gr
c8isjgf+Jq25v6+L6XMtnQmtOZ4YKSvPrhF0sPdoHNPHlrOOFCVGDxTWk2Yqkm6z
zr6+7wFddy/SWmHsT5Ev5MQrdh+bjRx900+vFMIi3nh7IDXmApCMILISRuYE4I4c
0JxMW1eN2k++IMzKW2jZdztUpGzrl86xG+1p62TAxl4bTnCbYTSBuQcaYxq9T1Sl
BqvaXy1D6+YHsPdolwmTK9aBWmxScCQaRn722wamy2Pbk6xYeB8ZyB7Zo7fyYzfx
rN/ydZJH6VMmpoPRl5W7/M8u9bIU2oBFDyMZ+Cbc3Jk2cp+aXUQTrekNKdG3giiN
DOe9v6GbT4De19JJMKV6uRMW0piNwQ==
=WkIZ
-----END PGP SIGNATURE-----

--vD0jFqLbz7R/875Z--



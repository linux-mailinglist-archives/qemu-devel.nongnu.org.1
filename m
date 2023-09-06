Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5FC794301
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 20:25:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdxCp-0001E7-LD; Wed, 06 Sep 2023 14:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qdxCj-0001DV-WA
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 14:24:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qdxCh-0008TN-S4
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 14:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694024678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HiGSN+vxCd29UWIXy0W7pGZav0q9WaaQRBZhN1Fd0/Y=;
 b=Y9Uhx5JDNmMnHo0wiHzZrCPEUC1s4QG7TTN/FVU3Y/mhTS2sv/c3kTFR7E/LxaMz4ZUkQH
 57wasmvVWN1vCa/8KxSGFDeyuGsIPTtdMlS2UcEnT9qtT8+6tlj5AXEuyMSrxxgY2yihzU
 CMxO8yJ25EakSV8QRlMk8HY4GbusoXM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-QTL-02kmP0G2or-gwWjpRA-1; Wed, 06 Sep 2023 14:24:35 -0400
X-MC-Unique: QTL-02kmP0G2or-gwWjpRA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D33A1C06927
 for <qemu-devel@nongnu.org>; Wed,  6 Sep 2023 18:24:33 +0000 (UTC)
Received: from localhost (unknown [10.39.193.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 008832012F37;
 Wed,  6 Sep 2023 18:24:32 +0000 (UTC)
Date: Wed, 6 Sep 2023 14:24:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL 00/52] UI patches
Message-ID: <20230906182431.GA1282731@fedora>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hFaz+QfzphkZIBnL"
Content-Disposition: inline
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--hFaz+QfzphkZIBnL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--hFaz+QfzphkZIBnL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT4w98ACgkQnKSrs4Gr
c8gcfAf/UqfEZuyJrntqb1JXSzff7GPOMG0095MvTWACMvv+4sA6j/tKPuvANzN3
W7N2RD+owG2d2gng4luPQEmws9uxMbWEwWBvnD+zIp4tzHdfZgCIhbKpQYmbOWun
Bc/upKp8SF5ETNUi7AD690+8ymO/3I/DBiX//k+hM2pn6GiWs5k8BoK/4Nyw/dWY
Tg8XAV+e+YFRlP7SX9a+xiT+LNrArBKiuhOiedCRQRtE1vuuXXs4SPwh3sD6ZE+a
vNAIC0XL8aFuaR+/oZcgALQG32BF15UDkrdGQylsCA7ctyObNT5wKlCwC0vM1gTx
XdRKQ/kZO9s5sega9FPVR/95ePGw8A==
=mYId
-----END PGP SIGNATURE-----

--hFaz+QfzphkZIBnL--



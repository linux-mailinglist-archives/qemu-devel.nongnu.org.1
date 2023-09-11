Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D3879A98D
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:20:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfihZ-0001mI-9c; Mon, 11 Sep 2023 11:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qfihX-0001ln-OL
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qfihV-0007Fo-Ij
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694445585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ECiAdV1h8WxKbivPce8Ry6CjavYzsrWTQr8iGGjna/Y=;
 b=AJ74ZCcmSorflD2EtruMRti5KRbKtXo6qGNdWUuCdptA+A9gcZTQaRGIEb7VuyPmwTW9tg
 Th8zYTIThxbUYS/TNJ4P4ooWdJoJjIn1Zft0U1qkf9OeeNWCiRjTtIQAjL1eHeKD/PR2pO
 1O7pvQQzAEEppRl8Ezr75Oc8h0c68eg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-wxrcKeI3PEK3yzqIn4648A-1; Mon, 11 Sep 2023 11:19:41 -0400
X-MC-Unique: wxrcKeI3PEK3yzqIn4648A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CFFB181A6E5;
 Mon, 11 Sep 2023 15:19:41 +0000 (UTC)
Received: from localhost (unknown [10.39.195.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88B8E40C2064;
 Mon, 11 Sep 2023 15:19:40 +0000 (UTC)
Date: Mon, 11 Sep 2023 11:19:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PULL v2 00/45] riscv-to-apply queue
Message-ID: <20230911151939.GA4101470@fedora>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/UfXw9lt1RhabQTC"
Content-Disposition: inline
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
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


--/UfXw9lt1RhabQTC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--/UfXw9lt1RhabQTC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT/MAsACgkQnKSrs4Gr
c8jGyAgAmHfpKcn/j0qdgLzAb7O3b7eM6ASGSl9atd6vn0ai1XYsfdrXOOTZtP2m
PUE2EiLrc7eHkGj1jNgoULLb05rAcxBhV6MyuYdVQnEm67LYqbB/uaiKugIT/GNf
P4jsFtpAx4eS7l/q/eI3UPrtjg36edo0A3Sf3Ym4ev7nY1fVil2jf+VTYVmYN1Us
6HR7dOssFlpc3hVMA91hB7yz2/K9INHcIGQh61QNR4Nruw8d4mKYkq37EyxjJPSO
kN4s4STzRQBiyBNovgBkpHOPrkqCHqfSCY9ckF5uG9zK5sLCrKm+oYigcBTtxVBw
tPS0nlxBnZyn1rwTPH79KlgFlU5OTQ==
=wO5M
-----END PGP SIGNATURE-----

--/UfXw9lt1RhabQTC--



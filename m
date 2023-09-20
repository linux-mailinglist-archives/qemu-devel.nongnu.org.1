Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B45E7A8D78
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 22:07:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj3Sj-0003rd-N2; Wed, 20 Sep 2023 16:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3Sh-0003rR-KL
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:06:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3Sg-0003NB-4B
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695240372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cp1IQiSJWBoRngv0mDS3WiXGpdwSOxr7euNvZarHcV8=;
 b=DGRwmsl1keA1/f8fSig8swGTHiLo8IlGkqlmed43BRHeYYmp/SWGZZAU+2E0L0eoTgqAzm
 1ohZB54XXQmXrOOu66T1IcJI8A6cBIzQ+Hf1Y0s8s//TV/pyY3g6dXhj5uT7++3v7bEVZ0
 Esmbq3uAd6YbJ8nbBWj+zWZ61ElmXqE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-lMYrK1FoOzSHnxQA10pAeQ-1; Wed, 20 Sep 2023 16:06:08 -0400
X-MC-Unique: lMYrK1FoOzSHnxQA10pAeQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54893811E86;
 Wed, 20 Sep 2023 20:06:08 +0000 (UTC)
Received: from localhost (unknown [10.39.193.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEFA8492B16;
 Wed, 20 Sep 2023 20:06:07 +0000 (UTC)
Date: Wed, 20 Sep 2023 16:06:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/57] loongarch-to-apply queue
Message-ID: <20230920200606.GA2591484@fedora>
References: <20230920065139.1403868-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qLyOuZ3LinRN6Orz"
Content-Disposition: inline
In-Reply-To: <20230920065139.1403868-1-gaosong@loongson.cn>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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


--qLyOuZ3LinRN6Orz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--qLyOuZ3LinRN6Orz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmULUK0ACgkQnKSrs4Gr
c8h1lwgAg5V69chdjPTAVgoJ9DEAOohIZAoZsn309eJegogmye/1GVuxT7R7wluR
DIJyOE636vsRjYoaNIs3XMvQZyLRd7uXINggd1Dp0xIUpXsF23bWGKHhIkT19M9I
7YBLUWgkhTbFxCdSxG0jmKzJ5M59yJz4zSyykXMsQvz/xKQADrLJCqsW/1YaeiSB
wfjmOVnYm4QaFOpUaO7gTUtrknl/2qsnVtMjlt0rYeLYUUdYsFgRlDBz92ca9Yd5
rr2jOj3Df1WvnQRm/npvf+gtUkJviCOQD2GiEvX97eCDaR046PPC0gAGk5yQeUyg
pPFOP1RB5m5TmSeKJlRjW1p8TrRvGg==
=M+vT
-----END PGP SIGNATURE-----

--qLyOuZ3LinRN6Orz--



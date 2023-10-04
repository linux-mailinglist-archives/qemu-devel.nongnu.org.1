Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C0E7B9D17
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 14:54:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoNql-00029j-4L; Thu, 05 Oct 2023 08:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoNqi-000288-Gq
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:53:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoNqh-0005gu-34
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696510382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QHqGCHXAyOzAn7gq9RQuyOFNeDToL+Y13wnxJ6JLPqk=;
 b=d21aCNuT3++y9rBJIylE6EAKCOKZFmejksi7LW+t8TFajpmeTpXo+yD+ahSPAcBRZqr9to
 KHxy/yeY2qDXMBlT/qxcR4xcKmuQNHtiwxpKkWUxEfbbj32njSRoSW059Ic99Kfsjczq/d
 EIx4dhbfBiNXo3mYbZPI8Qv0nl3E4CY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-xf6G0U6eMVOFtvqjZCe63w-1; Thu, 05 Oct 2023 08:52:45 -0400
X-MC-Unique: xf6G0U6eMVOFtvqjZCe63w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C8C018175B0
 for <qemu-devel@nongnu.org>; Thu,  5 Oct 2023 12:52:45 +0000 (UTC)
Received: from localhost (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BCF0F40C6EA8;
 Thu,  5 Oct 2023 12:52:44 +0000 (UTC)
Date: Wed, 4 Oct 2023 14:33:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL 00/13] Misc patches
Message-ID: <20231004183314.GA1287768@fedora>
References: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WXbzsL5AlXf13KHE"
Content-Disposition: inline
In-Reply-To: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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


--WXbzsL5AlXf13KHE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--WXbzsL5AlXf13KHE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUdr+oACgkQnKSrs4Gr
c8jyXgf7BSxDvQhyEks3SAyOCcT0RfhqiN4U1fBqXIavWMUgqvSDCoiAAqoq5GUx
sFuiHEIXi8DJAzx2RGk0duxE+NhI26P4q81C/bfG0kM5cShozkEKCeMeK8I+n8NB
tnJJcpfgCjzEMTgQ5rpxoIcNs1JMNQG1BMqsOU2GeB8bHqZs//DVqcFDGx1rXi/K
tSXOwv+nK5KC3wi/UYXATsvYW24ZtHMVuzdl3RU+4xA5YA7HfsfryVJpSaLyzf79
BCnzbV40QbKnYY2RPaqZIMarAhFmCTeAMttFAPOLyRqHU0gu0ldwY6NezYd2fTce
/g5xD20XgPoyAfQ4ECbHNkAIZjQObw==
=Rzq8
-----END PGP SIGNATURE-----

--WXbzsL5AlXf13KHE--



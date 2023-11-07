Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D747E4052
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:42:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0MK4-0005ZB-9N; Tue, 07 Nov 2023 08:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0MK1-0005X1-IA
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:40:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0MJz-0005Xq-Kf
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699364445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+fKlxev5EO6Wk+L7armS3K3bJrHDhnSw7W/0TOi8D6g=;
 b=HOgNqmkVA/fLyDMbJXWjzMrYo+wM270xoxyMt50lZsPm9rYoEShKL3JVOY0kdy6RLGaSW8
 XpafT33PjIr0VY4x4YaAuzLa9dlHauRjrn55cNrA5F6VuEhawHc+ELkdxVVnnNMA5ODZGS
 96Y3DltkxLob5sU0yxdtm/HLN8DmdSA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-SvQyflcCNqaI_H5-IlHTZQ-1; Tue, 07 Nov 2023 08:40:28 -0500
X-MC-Unique: SvQyflcCNqaI_H5-IlHTZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B99A812C2E;
 Tue,  7 Nov 2023 13:40:28 +0000 (UTC)
Received: from localhost (unknown [10.39.194.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5569502A;
 Tue,  7 Nov 2023 13:40:27 +0000 (UTC)
Date: Tue, 7 Nov 2023 21:40:25 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/5] Ui patches
Message-ID: <20231107134025.GA1010690@fedora>
References: <20231107093035.2746581-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MECdXS9l36guJH/2"
Content-Disposition: inline
In-Reply-To: <20231107093035.2746581-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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


--MECdXS9l36guJH/2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--MECdXS9l36guJH/2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVKPkkACgkQnKSrs4Gr
c8jw4gf7BMojUNoVxGh3MT0lnXm0YFokp+nuP9wr2ozGvAx9Mv+SBBHBNTnJWCW/
LymW07wiGs9fD/hhVNnkZoeYyJgdqwzYLQEuaJejlHDrRsxQ2LDSPeDBrhu5D608
g+LTiWY7u39h5WPP8kzi9tR/YQGhMpE2MdMXMh0NfAdEk6Ahwz9PP6yfGs4gyg1J
EV6QXr+QqsynO3Egtb47PuYbdv5BFL9IW+LQBF/mvnTTMmZPBD9eF2ufc7yDnFty
fO0aJH+SDt9XoeioPolgn7VPmzew47N2gkrBpFFgP5UENY3xvN1gAv/EsYV3fr3K
OI5aCfmvftlZvPxMu3Y18a0DavIynw==
=XVXK
-----END PGP SIGNATURE-----

--MECdXS9l36guJH/2--



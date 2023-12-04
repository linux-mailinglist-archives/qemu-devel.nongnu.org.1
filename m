Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FCA803762
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 15:47:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAADQ-0004z3-PR; Mon, 04 Dec 2023 09:46:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAADF-0004nb-CV
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:46:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAADD-0003x4-Qo
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701701178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ka5Hi7ijDZsI6V4uDXrFTo1ichiYBcln0r7bpQKhsd0=;
 b=ERPthHCL+TSIENXbNRVut4y4RHQEMX+nM2554H7O4oVg+/Hn1Y09TCzdApO+h5Ov60C5BH
 tCiLWVfTXNqNgx4wy8b2TZtKGGOghdTVrH3QQ2sTyCKYHgS1QjyEL0tE9OTu3+KG5OfMXp
 iOJJzqAcuHwiaupkMfK94riRjOzcJcM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-YJ3kAa9KM5eQiSPqzjCpmQ-1; Mon, 04 Dec 2023 09:46:15 -0500
X-MC-Unique: YJ3kAa9KM5eQiSPqzjCpmQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB261185A781;
 Mon,  4 Dec 2023 14:46:14 +0000 (UTC)
Received: from localhost (unknown [10.39.192.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 096031121306;
 Mon,  4 Dec 2023 14:46:13 +0000 (UTC)
Date: Mon, 4 Dec 2023 09:46:12 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, stefanha@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL 0/3] UI patches
Message-ID: <20231204144612.GA1491693@fedora>
References: <20231204080850.4068242-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="63JrG9Zg8w6F7smf"
Content-Disposition: inline
In-Reply-To: <20231204080850.4068242-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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


--63JrG9Zg8w6F7smf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--63JrG9Zg8w6F7smf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVt5jQACgkQnKSrs4Gr
c8jDgQf/Z7CnA2P/IZoQiarzBAEWYyy53jPZrk7LAEytpU2u5HpWme0NQ14KeduY
PjvjBMVmaZMt1EdEHASS8peIm97KhfDP1e4K6PZ+E75+dmDRqj+Jh2eRXh5OcGys
d56BRUvfC1euzkYf+4EqeI4IvdNsaJP8z+ozkENQhK6uTWyZhuvirTYV333eItBo
RpG/Tk4b7lYDAbzwSusj4tn/hBifLRmuOcj+WoGFQCKqoM8ueIUKf68o5G1pzjb4
7NWEbB1ZYL+jk7lZEHBTljnyUnqyfplkbbaDo70PVuDq2O5B7dAHZ3cSZoYYsMQ4
GRhBhlNYt/fdNXw2ChxYhv4JhEORZA==
=X+98
-----END PGP SIGNATURE-----

--63JrG9Zg8w6F7smf--



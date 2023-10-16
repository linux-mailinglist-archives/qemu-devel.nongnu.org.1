Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BCA7CB1DC
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 20:03:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsRuu-0001sT-VP; Mon, 16 Oct 2023 14:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qsRup-0001sB-ON
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 14:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qsRuj-0004Z8-TC
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 14:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697479320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1CaR2E+sbAx0QzaCbeHo7X0dBwd6cvMeXPZkA0s3BHY=;
 b=E+2yK1+j3WlIr0mmO/fCdjLvrJBDp6WiFGW2nJlGlp3+kDl5Hj958jMt7Cu3RTQX1XXx+r
 iktffz5z/ElQGIzWZ2Qqi4vUXdWQIvkA8D0RPohKT4Vsz8Z1ScwCl7cbFuib5QIqZ0WNAn
 +7AkzHLRuzpH2jeSqdlTGu9pO8SgnsU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-691-waaBGsrwN-ulX7McQ7_EoA-1; Mon, 16 Oct 2023 14:01:56 -0400
X-MC-Unique: waaBGsrwN-ulX7McQ7_EoA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12CFE3821350;
 Mon, 16 Oct 2023 18:01:55 +0000 (UTC)
Received: from localhost (unknown [10.39.195.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98AA51C060AE;
 Mon, 16 Oct 2023 18:01:54 +0000 (UTC)
Date: Mon, 16 Oct 2023 14:01:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, hare@suse.de, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, dlemoal@kernel.org,
 qemu-block@nongnu.org, dmitry.fomichev@wdc.com
Subject: Re: [PATCH v2] block/file-posix: fix update_zones_wp() caller
Message-ID: <20231016180153.GA154462@fedora>
References: <20230825040556.4217-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Rt4sQg6Qs0pw29de"
Content-Disposition: inline
In-Reply-To: <20230825040556.4217-1-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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


--Rt4sQg6Qs0pw29de
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 12:05:56PM +0800, Sam Li wrote:
> When the zoned request fail, it needs to update only the wp of
> the target zones for not disrupting the in-flight writes on
> these other zones. The wp is updated successfully after the
> request completes.
>=20
> Fixed the callers with right offset and nr_zones.
>=20
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/file-posix.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Rt4sQg6Qs0pw29de
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUtepEACgkQnKSrs4Gr
c8jj9wf/VANC36h+zZhS/7ClQpd3a8eSF6GZrhmjUi6OW2d/8OwYYSaHTDE3Ba4K
4LqLAZ+mwhn4tt6/PQD0Aza3+Uju7lqwS2LfuEGvrrCS6mQjlRJX7PmR4hqy+8n7
2weVsZMDZwwKe2b9xinhVh5SWLrnKK0fSZ++leStXD6oWfKEwkB6+cJGntMBqUzz
w4CHqCYGGlFSJuXbDzNu0TZCGsn0vrr7RQMhNkVfZo0ul/u6T2RpgRTG8dldvW/u
+Q10QQxSLoRKMCMGYEfHqHkWKyOsCEFBE7U2fBcR8adycBeJU0uRnCItWNnkcA2/
gTYjvvNfvAusMD53yG+0A+h/Ia1K7A==
=DbDy
-----END PGP SIGNATURE-----

--Rt4sQg6Qs0pw29de--



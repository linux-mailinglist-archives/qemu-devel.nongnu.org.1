Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E540C782A8E
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 15:33:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY50U-0005aj-Bv; Mon, 21 Aug 2023 09:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qY50Q-0005aL-GC
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qY50N-0007GL-Np
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692624698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KyBgValqMRA4L6Pf8AX6tHvoYwW5k0YPpRkqFY49xyU=;
 b=Zd/TT/djgAZlN7dfTx+S07w1hxLWqGIqlxFr3k4p0QClYO1M/PryXcLrB7gllpX4AgunKR
 ACNAnliKqyFw9taD8/adYw5T4Mg11G+kx1MOlh0BjfaUDKpW7fTTI38vw74gaYu5Khv934
 hJx/ADAINg2guFzIOSZDaYGFkZWsMN0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-Mu-iXQ51MvWxjBhuAve3RQ-1; Mon, 21 Aug 2023 09:31:34 -0400
X-MC-Unique: Mu-iXQ51MvWxjBhuAve3RQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4E8C101A52E;
 Mon, 21 Aug 2023 13:31:33 +0000 (UTC)
Received: from localhost (unknown [10.39.194.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29C6463F6C;
 Mon, 21 Aug 2023 13:31:32 +0000 (UTC)
Date: Mon, 21 Aug 2023 09:31:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, hare@suse.de, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, dlemoal@kernel.org
Subject: Re: [PATCH v2 2/4] qcow2: add configurations for zoned format
 extension
Message-ID: <20230821133131.GA37847@fedora>
References: <20230814085802.61459-1-faithilikerun@gmail.com>
 <20230814085802.61459-3-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iIwZa2KjqVKR4Uog"
Content-Disposition: inline
In-Reply-To: <20230814085802.61459-3-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--iIwZa2KjqVKR4Uog
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 04:58:00PM +0800, Sam Li wrote:
> diff --git a/block/qcow2.h b/block/qcow2.h
> index f789ce3ae0..3694c8d217 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -236,6 +236,20 @@ typedef struct Qcow2CryptoHeaderExtension {
>      uint64_t length;
>  } QEMU_PACKED Qcow2CryptoHeaderExtension;
> =20
> +typedef struct Qcow2ZonedHeaderExtension {
> +    /* Zoned device attributes */
> +    uint8_t zoned_profile;
> +    uint8_t zoned;
> +    uint16_t reserved16;
> +    uint32_t zone_size;
> +    uint32_t zone_capacity;

Should zone capacity be stored individually for each zone (alongside the
write pointer and other per zone metadata) instead of as a global value
for all zones? My understanding is that NVMe ZNS does not have a global
value and each zone could have a different zone capacity value.

> +    uint32_t nr_zones;

Is this field necessary since it can be derived from other image
options: nr_zones =3D DIV_ROUND_UP(total_length, zone_capacity)?

--iIwZa2KjqVKR4Uog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTjZzIACgkQnKSrs4Gr
c8jM0wgAxqAmH03rE2QkvfMP+b8WyV//A+IT/+EI5i02Wgj644/ozV+HCiaImNz1
vVJCgDxbO/KgB0tAyV8hbTpyhWZ6VefeylbJb7Wl/w+A1BAXzkwE5vUMCqsB6A1t
zo7fd8AKCgsz/kbqbRaz/sranObPlqlBOuz0P7fXddxKrp9/7l9LxrPb56OcXqS4
qT28RdwHdB4OjTGK2B/g7V8J2LN683DzLf0CHCQzTIo9dQ+b4+a1Z/RhhrddXRG2
7BOCK6zw6a7/uVWfOCMb26WNAK+Xgk+Z9sJkBK8tP3GndPvyXGoR5WbYhgzHHhEI
rb+g8I+z/mGDA04mE4/8dNZR/ma9rw==
=LA53
-----END PGP SIGNATURE-----

--iIwZa2KjqVKR4Uog--



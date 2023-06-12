Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F1972DA66
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 09:06:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8y54-0005xs-TB; Tue, 13 Jun 2023 03:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q8y52-0005xG-Tv
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 03:04:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q8y50-0003NI-W3
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 03:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686639878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NVWRoN9LCyMgvdfb7vW8I5G7oOE97+Hjd/nQcnjjVN0=;
 b=eSHEaQOu0RP0qmrTinE3i6qXzz5k6i9fVL/8/26Y8k9QDt8h5dY501Fv4lvsGdwMWheH+G
 HfzyTxOikYJEcktoED9DolSPeCZ+t8dvNOpNVH58v9g1xSiHZBK2e1UJ8hKuQL64RffyCM
 A5WdHVE9OOKAuFZ8lwq0wDHmISqw5RI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-voIjIbBhMyunRpibuoanOg-1; Tue, 13 Jun 2023 03:04:32 -0400
X-MC-Unique: voIjIbBhMyunRpibuoanOg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 605133C0F180;
 Tue, 13 Jun 2023 07:04:32 +0000 (UTC)
Received: from localhost (unknown [10.39.193.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8DB62166B25;
 Tue, 13 Jun 2023 07:04:31 +0000 (UTC)
Date: Mon, 12 Jun 2023 00:10:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, dlemoal@kernel.org, dmitry.fomichev@wdc.com,
 hare@suse.de, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [RFC 1/4] docs/qcow2: add the zoned format feature
Message-ID: <20230612041016.GA2446610@fedora>
References: <20230605104108.125270-1-faithilikerun@gmail.com>
 <20230605104108.125270-2-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TlKRIjRMDv4f7IB/"
Content-Disposition: inline
In-Reply-To: <20230605104108.125270-2-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--TlKRIjRMDv4f7IB/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2023 at 06:41:05PM +0800, Sam Li wrote:
> Add the specs for the zoned format feature of the qcow2 driver. Once
> the zoned_profile is set to `zbc`, then the qcow2 file can be taken
> as zoned devices and passed through by virtio-blk device to the guest.
>=20
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  docs/system/qemu-block-drivers.rst.inc | 31 ++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20
> diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-bl=
ock-drivers.rst.inc
> index 105cb9679c..fdcf343652 100644
> --- a/docs/system/qemu-block-drivers.rst.inc
> +++ b/docs/system/qemu-block-drivers.rst.inc
> @@ -172,6 +172,37 @@ This section describes each format and the options t=
hat are supported for it.
>      filename`` to check if the NOCOW flag is set or not (Capital 'C' is
>      NOCOW flag).
> =20
> +  .. option:: zoned_profile
> +
> +    The option configures the zoned format feature on the qcow2 driver. =
If
> +    this is set to ``zbc``, then it follows the basics of ZBC/ZAC protoc=
ol.

What about virtio-blk? NVMe ZNS? Please indicate what effect the profile
has and whether it works with all emulated storage controllers that
support zoned storage.

> +
> +  .. option:: zone_size
> +
> +    The size of a zone of the zoned device. The zoned device have the sa=
me

"in bytes"? Please document the units.

> +    size of zones with an optional smaller last zone.

"The device is divided into zones of this size with the exception of the
last zone, which may be smaller."

> +
> +  .. option:: zone_capacity
> +
> +    The capacity of a zone of the zoned device.

This can be expanded:

  The initial capacity value for all zones. The capacity must be less
  than or equal to zone size. If the last zone is smaller, then its
  capacity is capped.

> The zoned device follows the
> +    ZBC protocol tends to have the same size as its zone.
> +
> +  .. option:: zone_nr_conv
> +
> +    The number of conventional zones of the zoned device.
> +
> +  .. option:: max_open_zones
> +
> +    The maximal allowed open zones.
> +
> +  .. option:: max_active_zones
> +
> +    The limit of the zones with implicit open, explicit open or closed s=
tate.
> +
> +  .. option:: max_append_sectors
> +
> +    The maximal sectors that is allowed to append to zones while writing.

Does "sectors" mean 512B blocks or logical block size?

> +
>  .. program:: image-formats
>  .. option:: qed
> =20
> --=20
> 2.40.1
>=20

--TlKRIjRMDv4f7IB/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmSGmqgACgkQnKSrs4Gr
c8icYAf9H+k3Xw8SblCF9um7MdeU0WzMChS27CaDi9TPSNbfGC4k6Z0sdx1Di3lW
ZrO4P8ygJZ/vPV5AJg1+vWdwJGXAITi+xBWxTW8owhKmW0oyE+YWl7LtiS74/6Ip
V88m0dyPHD6H1HT99XehyogaxDM75XgGQXAyldm48zCwGwy/nafPt9Sfs3Hh0ixo
+l9NJl3z2Sbk8TXE15RI/QreshqIlRodpG7PxZzl9VWBdlrMangjdPQ04DCpmiEE
nJwGzJQ2hFlPBI9/oFvkiV0ROR8Jjmt2vDHo/uYwtePC8hYp1Wq+Spu3zV3f6OL+
Q3IOrDGwC5prSigK90R2/SKF7+MFHQ==
=50Vv
-----END PGP SIGNATURE-----

--TlKRIjRMDv4f7IB/--


